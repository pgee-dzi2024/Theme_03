from django.shortcuts import render, redirect, reverse
from . import forms, models
from django.http import HttpResponseRedirect, HttpResponse
from django.core.mail import send_mail
from django.contrib.auth.models import Group
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib import messages
from django.conf import settings


# Начален изглед при стартиране на приложението
def home_view(request):
    print('home_view')
    products = models.Product.objects.all()
    products_new = models.Product.objects.filter(is_new=True)
    products_sale = models.Product.objects.filter(for_sale=True)

    if 'product_ids' in request.COOKIES:
        product_ids = request.COOKIES['product_ids']
        counter = product_ids.split('|')
        product_count_in_cart = len(set(counter))
    else:
        product_count_in_cart = 0
    if request.user.is_authenticated:
        return HttpResponseRedirect('after_login')

    context = {'products': products,
               'products_new': products_new,
               'products_sale': products_sale,
               'product_count_in_cart': product_count_in_cart,
               }

    return render(request, 'main/index.html', context)


# показвне на логин бутона за админа
def admin_click_view(request):
    print('admin_click_view')
    if request.user.is_authenticated:
        return HttpResponseRedirect('after_login')
    return HttpResponseRedirect('admin_login')


def customer_signup_view(request):
    print('customer_signup_view')
    user_form = forms.CustomerUserForm()
    customer_form = forms.CustomerForm()
    mydict = {
        'userForm': user_form,
        'customerForm': customer_form,
        'form_title': 'Вход за потребители',
    }

    if request.method == 'POST':
        user_form = forms.CustomerUserForm(request.POST)
        customer_form = forms.CustomerForm(request.POST, request.FILES)
        if user_form.is_valid() and customer_form.is_valid():
            user = user_form.save()
            user.set_password(user.password)
            user.save()
            customer = customer_form.save(commit=False)
            customer.user = user
            customer.save()
            my_customer_group = Group.objects.get_or_create(name='CUSTOMER')
            my_customer_group[0].user_set.add(user)
        return HttpResponseRedirect('customer_login')
    return render(request, 'main/customer_signup.html', context=mydict)


# проверка дали е клиент
def is_customer(user):
    return user.groups.filter(name='CUSTOMER').exists()


# след влизане в система - проверка какъв е - админ или клиент
def after_login_view(request):
    print('after_login_view')
    if is_customer(request.user):
        return redirect('customer-home')
    else:
        return redirect('admin-dashboard')


# ---------------------------------------------------------------------------------
# ------------------------ НАЧАЛО ИЗГЛЕДИ ЗА АДМИН  ------------------------------
# ---------------------------------------------------------------------------------
@login_required(login_url='admin_login')
def admin_dashboard_view(request):
    print('admin_dashboard_view')
    # for cards on dashboard
    customer_count = models.Customer.objects.all().count()
    product_count = models.Product.objects.all().count()
    order_count = models.Orders.objects.all().count()

    # for recent order tables
    orders = models.Orders.objects.all()
    ordered_products = []
    ordered_bys = []
    for order in orders:
        ordered_product = models.Product.objects.all().filter(id=order.product.id)
        ordered_by = models.Customer.objects.all().filter(id=order.customer.id)
        ordered_products.append(ordered_product)
        ordered_bys.append(ordered_by)

    mydict = {
        'customercount': customer_count,
        'productcount': product_count,
        'ordercount': order_count,
        'data': zip(ordered_products, ordered_bys, orders),
    }
    return render(request, 'main/admin_dashboard.html', context=mydict)


# админ, таблица потребители
@login_required(login_url='admin_login')
def view_customer_view(request):
    print('view_customer_view')
    customers = models.Customer.objects.all()
    return render(request, 'main/view_customer.html', {'customers': customers})


# admin delete customer
@login_required(login_url='admin_login')
def delete_customer_view(request, pk):
    print('delete_customer_view')
    customer = models.Customer.objects.get(id=pk)
    user = models.User.objects.get(id=customer.user_id)
    user.delete()
    customer.delete()
    return redirect('view-customer')


@login_required(login_url='admin_login')
def update_customer_view(request, pk):
    print('update_customer_view')
    customer = models.Customer.objects.get(id=pk)
    user = models.User.objects.get(id=customer.user_id)
    userForm = forms.CustomerUserForm(instance=user)
    customerForm = forms.CustomerForm(request.FILES, instance=customer)
    mydict = {'userForm': userForm, 'customerForm': customerForm}
    if request.method == 'POST':
        userForm = forms.CustomerUserForm(request.POST, instance=user)
        customerForm = forms.CustomerForm(request.POST, instance=customer)
        if userForm.is_valid() and customerForm.is_valid():
            user = userForm.save()
            user.set_password(user.password)
            user.save()
            customerForm.save()
            return redirect('view-customer')
    return render(request, 'main/admin_update_customer.html', context=mydict)


# admin view the product
@login_required(login_url='admin_login')
def admin_products_view(request):
    print('admin_products_view')
    products = models.Product.objects.all()
    return render(request, 'main/admin_products.html', {'products': products})


# admin add product by clicking on floating button
@login_required(login_url='admin_login')
def admin_add_product_view(request):
    print('admin_add_product_view')
    productForm = forms.ProductForm()
    if request.method == 'POST':
        productForm = forms.ProductForm(request.POST, request.FILES)
        if productForm.is_valid():
            productForm.save()
        return HttpResponseRedirect('admin-products')
    return render(request, 'main/admin_add_products.html', {'productForm': productForm})


@login_required(login_url='admin_login')
def delete_product_view(request, pk):
    print('delete_product_view')
    product = models.Product.objects.get(id=pk)
    product.delete()
    return redirect('admin-products')


@login_required(login_url='admin_login')
def update_product_view(request, pk):
    print('update_product_view')
    product = models.Product.objects.get(id=pk)
    productForm = forms.ProductForm(instance=product)
    if request.method == 'POST':
        productForm = forms.ProductForm(request.POST, request.FILES, instance=product)
        if productForm.is_valid():
            productForm.save()
            return redirect('admin-products')
    return render(request, 'main/admin_update_product.html', {'productForm': productForm})


@login_required(login_url='admin_login')
def admin_view_booking_view(request):
    print('admin_view_booking_view')
    orders = models.Orders.objects.all()
    ordered_products = []
    ordered_bys = []
    for order in orders:
        ordered_product = models.Product.objects.all().filter(id=order.product.id)
        ordered_by = models.Customer.objects.all().filter(id=order.customer.id)
        ordered_products.append(ordered_product)
        ordered_bys.append(ordered_by)
    return render(request, 'main/admin_view_booking.html', {'data': zip(ordered_products, ordered_bys, orders)})


@login_required(login_url='admin_login')
def delete_order_view(request, pk):
    print('delete_order_view')
    order = models.Orders.objects.get(id=pk)
    order.delete()
    return redirect('admin-view-booking')


# for changing status of order (pending,delivered...)
@login_required(login_url='admin_login')
def update_order_view(request, pk):
    print('update_order_view')
    order = models.Orders.objects.get(id=pk)
    orderForm = forms.OrderForm(instance=order)
    if request.method == 'POST':
        orderForm = forms.OrderForm(request.POST, instance=order)
        if orderForm.is_valid():
            orderForm.save()
            return redirect('admin-view-booking')
    return render(request, 'main/update_order.html', {'orderForm': orderForm})


# admin view the feedback
@login_required(login_url='admin_login')
def view_feedback_view(request):
    print('view_feedback_view')
    feedbacks = models.Feedback.objects.all().order_by('-id')
    return render(request, 'main/view_feedback.html', {'feedbacks': feedbacks})


# ---------------------------------------------------------------------------------
# ------------------------ PUBLIC CUSTOMER RELATED VIEWS START ---------------------
# ---------------------------------------------------------------------------------
def search_view(request):
    print('search_view')
    # whatever user write in search box we get in query
    query = request.GET['query']
    products = models.Product.objects.all().filter(name__icontains=query)
    if 'product_ids' in request.COOKIES:
        product_ids = request.COOKIES['product_ids']
        counter = product_ids.split('|')
        product_count_in_cart = len(set(counter))
    else:
        product_count_in_cart = 0

    # word variable will be shown in html when user click on search button
    word = "Searched Result :"

#    if request.user.is_authenticated:
#        return render(request, 'main/customer_home.html',
#                      {'products': products, 'word': word, 'product_count_in_cart': product_count_in_cart})

    return render(request, 'main/index.html',
                  {'products': products, 'word': word, 'product_count_in_cart': product_count_in_cart})


# any one can add product to cart, no need of signin
def add_to_cart_view(request, pk):
    print('add_to_cart_view')
    products = models.Product.objects.all()
    products_new = models.Product.objects.filter(is_new=True)
    products_sale = models.Product.objects.filter(for_sale=True)

    # за брояча на избраните продукти, изваждам всички id, добавени от клиента, от cookies
    if 'product_ids' in request.COOKIES:
        product_ids = request.COOKIES['product_ids']
        counter = product_ids.split('|')
        product_count_in_cart = len(set(counter))
    else:
        product_count_in_cart = 1
    context = {
        'products': products,
        'products_new': products_new,
        'products_sale': products_sale,
        'product_count_in_cart': product_count_in_cart,
        }
    response = render(request, 'main/index.html', context)

    # добавяне на артикул към cookies
    if 'product_ids' in request.COOKIES:
        product_ids = request.COOKIES['product_ids']
        if product_ids == "":
            product_ids = str(pk)
        else:
            product_ids = product_ids + "|" + str(pk)
        response.set_cookie('product_ids', product_ids)
    else:
        response.set_cookie('product_ids', pk)

    product = models.Product.objects.get(id=pk)
    messages.info(request, product.name + ' added to cart successfully!')

    return response


# for checkout of cart
def cart_view(request):
    print('cart_view')
    # for cart counter
    if 'product_ids' in request.COOKIES:
        product_ids = request.COOKIES['product_ids']
        counter = product_ids.split('|')
        product_count_in_cart = len(set(counter))
    else:
        product_count_in_cart = 0

    # fetching product details from db whose id is present in cookie
    products = None
    total = 0
    if 'product_ids' in request.COOKIES:
        product_ids = request.COOKIES['product_ids']
        if product_ids != "":
            product_id_in_cart = product_ids.split('|')
            products = models.Product.objects.all().filter(id__in=product_id_in_cart)

            # for total price shown in cart
            for p in products:
                print(p.name)
                total = total + p.price
    return render(request, 'main/cart.html',
                  {'products': products, 'total': total, 'product_count_in_cart': product_count_in_cart})


def remove_from_cart_view(request, pk):
    print('remove_from_cart_view')
    # for counter in cart
    if 'product_ids' in request.COOKIES:
        product_ids = request.COOKIES['product_ids']
        counter = product_ids.split('|')
        product_count_in_cart = len(set(counter))
    else:
        product_count_in_cart = 0

    # removing product id from cookie
    total = 0
    if 'product_ids' in request.COOKIES:
        product_ids = request.COOKIES['product_ids']
        product_id_in_cart = product_ids.split('|')
        product_id_in_cart = list(set(product_id_in_cart))
        product_id_in_cart.remove(str(pk))
        products = models.Product.objects.all().filter(id__in=product_id_in_cart)
        # for total price shown in cart after removing product
        for p in products:
            total = total + p.price

        #  for update coookie value after removing product id in cart
        value = ""
        for i in range(len(product_id_in_cart)):
            if i == 0:
                value = value + product_id_in_cart[0]
            else:
                value = value + "|" + product_id_in_cart[i]
        response = render(request, 'main/cart.html',
                          {'products': products, 'total': total, 'product_count_in_cart': product_count_in_cart})
        if value == "":
            response.delete_cookie('product_ids')
        response.set_cookie('product_ids', value)
        return response


def send_feedback_view(request):
    print('send_feedback_view')
    feedbackForm = forms.FeedbackForm()
    if request.method == 'POST':
        feedbackForm = forms.FeedbackForm(request.POST)
        if feedbackForm.is_valid():
            feedbackForm.save()
            return render(request, 'main/feedback_sent.html')
    return render(request, 'main/send_feedback.html', {'feedbackForm': feedbackForm})


# ---------------------------------------------------------------------------------
# ------------------------ CUSTOMER RELATED VIEWS START ------------------------------
# ---------------------------------------------------------------------------------


@login_required(login_url='customer_login')
@user_passes_test(is_customer)
def customer_home_view(request):
    print('customer_home_view')
    products = models.Product.objects.all()
    if 'product_ids' in request.COOKIES:
        product_ids = request.COOKIES['product_ids']
        counter = product_ids.split('|')
        product_count_in_cart = len(set(counter))
    else:
        product_count_in_cart = 0
    return render(request, 'main/index.html',
                  {'products': products, 'product_count_in_cart': product_count_in_cart})
#    return render(request, 'main/customer_home.html',
#                  {'products': products, 'product_count_in_cart': product_count_in_cart})


# shipment address before placing order
@login_required(login_url='/customer_login')
def customer_address_view(request):
    print('customer_address_view')
    # this is for checking whether product is present in cart or not
    # if there is no product in cart we will not show address form
    product_in_cart = False
    if 'product_ids' in request.COOKIES:
        product_ids = request.COOKIES['product_ids']
        if product_ids != "":
            product_in_cart = True
    # for counter in cart
    if 'product_ids' in request.COOKIES:
        product_ids = request.COOKIES['product_ids']
        counter = product_ids.split('|')
        product_count_in_cart = len(set(counter))
    else:
        product_count_in_cart = 0

    addressForm = forms.AddressForm()
    if request.method == 'POST':
        addressForm = forms.AddressForm(request.POST)
        print('customer_address_view POST')
        if addressForm.is_valid():
            # here we are taking address, email, mobile at time of order placement
            # we are not taking it from customer account table because
            # these thing can be changes
            email = addressForm.cleaned_data['Email']
            mobile = addressForm.cleaned_data['Mobile']
            address = addressForm.cleaned_data['Address']
            print('customer_address_view', email, mobile, address)
            # for showing total price on payment page.....accessing id from cookies
            # then fetching  price of product from db
            total = 0
            if 'product_ids' in request.COOKIES:
                product_ids = request.COOKIES['product_ids']
                if product_ids != "":
                    product_id_in_cart = product_ids.split('|')
                    products = models.Product.objects.all().filter(id__in=product_id_in_cart)
                    for p in products:
                        total = total + p.price

            response = render(request, 'main/payment.html', {'total': total})
            response.set_cookie('email', email)
            response.set_cookie('mobile', mobile)
            response.set_cookie('address', address)
            return response
        else:
            print(addressForm.errors)
    return render(request, 'main/customer_address.html',
                  {'addressForm': addressForm, 'product_in_cart': product_in_cart,
                   'product_count_in_cart': product_count_in_cart})


# here we are just directing to this view...actually we have to check whether payment is successful or not
# then only this view should be accessed
@login_required(login_url='customer_login')
def payment_success_view(request):
    print("payment_success_view")
    # тука ще обработваме заявките. След успешно плащане ще вземаме данните на потребителя, данните за всеки продуктов id
    # от cookies и респективно съответните данни от БД, след което ще изтрием бисквитките, защото след завършване на
    # поръчката количката трябва да е празна

    customer = models.Customer.objects.get(user_id=request.user.id)
    products = None
    email = None
    mobile = None
    address = None
    if 'product_ids' in request.COOKIES:
        product_ids = request.COOKIES['product_ids']
        if product_ids != "":
            product_id_in_cart = product_ids.split('|')
            products = models.Product.objects.all().filter(id__in=product_id_in_cart)
            # Here we get products list that will be ordered by one customer at a time

    # these things can be change so accessing at the time of order...
    if 'email' in request.COOKIES:
        email = request.COOKIES['email']
    if 'mobile' in request.COOKIES:
        mobile = request.COOKIES['mobile']
    if 'address' in request.COOKIES:
        address = request.COOKIES['address']

    # here we are placing number of orders as much there is a products
    # suppose if we have 5 items in cart, and we place order....so 5 rows will be created in orders table
    # there will be a lot of redundant data in orders table...but its become more complicated if we normalize it

    for product in products:
        models.Orders.objects.get_or_create(customer=customer, product=product, status='Нова', email=email,
                                            mobile=mobile, address=address)

    # after order placed cookies should be deleted
    response = render(request, 'main/payment_success.html')
    response.delete_cookie('product_ids')
    response.delete_cookie('email')
    response.delete_cookie('mobile')
    response.delete_cookie('address')
    return response


@login_required(login_url='customer_login')
@user_passes_test(is_customer)
def my_order_view(request):
    print('my_order_view')
    customer = models.Customer.objects.get(user_id=request.user.id)
    orders = models.Orders.objects.all().filter(customer_id=customer)
    ordered_products = []
    for order in orders:
        ordered_product = models.Product.objects.all().filter(id=order.product.id)
        ordered_products.append(ordered_product)

    return render(request, 'main/my_order.html', {'data': zip(ordered_products, orders)})


# @login_required(login_url='customer_login')
# @user_passes_test(is_customer)
# def my_order_view2(request):

#     products=models.Product.objects.all()
#     if 'product_ids' in request.COOKIES:
#         product_ids = request.COOKIES['product_ids']
#         counter=product_ids.split('|')
#         product_count_in_cart=len(set(counter))
#     else:
#         product_count_in_cart=0
#     return render(request,'main/my_order.html',{'products':products,'product_count_in_cart':product_count_in_cart})


# --------------for discharge patient bill (pdf) download and printing
import io
from xhtml2pdf import pisa
from django.template.loader import get_template
from django.template import Context
from django.http import HttpResponse


def render_to_pdf(template_src, context_dict):
    print('render_to_pdf')
    template = get_template(template_src)
    html = template.render(context_dict)
    result = io.BytesIO()
    pdf = pisa.pisaDocument(io.BytesIO(html.encode("ISO-8951-1")), result)
    if not pdf.err:
        return HttpResponse(result.getvalue(), content_type='application/pdf')
    return


@login_required(login_url='customer_login')
@user_passes_test(is_customer)
def download_invoice_view(request, orderID, productID):
    print('download_invoice_view')
    order = models.Orders.objects.get(id=orderID)
    product = models.Product.objects.get(id=productID)
    mydict = {
        'orderDate': order.order_date,
        'customerName': request.user,
        'customerEmail': order.email,
        'customerMobile': order.mobile,
        'shipmentAddress': order.address,
        'orderStatus': order.status,

        'productName': product.name,
        'productImage': product.product_image,
        'productPrice': product.price,
        'productDescription': product.description,

    }
    return render_to_pdf('main/download_invoice.html', mydict)


@login_required(login_url='customer_login')
@user_passes_test(is_customer)
def my_profile_view(request):
    print('my_profile_view')
    customer = models.Customer.objects.get(user_id=request.user.id)
    return render(request, 'main/my_profile.html', {'customer': customer})


@login_required(login_url='customer_login')
@user_passes_test(is_customer)
def edit_profile_view(request):
    print('edit_profile_view')
    customer = models.Customer.objects.get(user_id=request.user.id)
    user = models.User.objects.get(id=customer.user_id)
    userForm = forms.CustomerUserForm(instance=user)
    customerForm = forms.CustomerForm(request.FILES, instance=customer)
    mydict = {'userForm': userForm, 'customerForm': customerForm}
    if request.method == 'POST':
        userForm = forms.CustomerUserForm(request.POST, instance=user)
        customerForm = forms.CustomerForm(request.POST, instance=customer)
        if userForm.is_valid() and customerForm.is_valid():
            user = userForm.save()
            user.set_password(user.password)
            user.save()
            customerForm.save()
            return HttpResponseRedirect('my-profile')
    return render(request, 'main/edit_profile.html', context=mydict)


# ---------------------------------------------------------------------------------
# ------------------------ ABOUT US AND CONTACT US VIEWS START --------------------
# ---------------------------------------------------------------------------------
def aboutus_view(request):
    print('aboutus_view')
    return render(request, 'main/about_us.html')


def contactus_view(request):
    print('contactus_view')
    sub = forms.ContactusForm()
    if request.method == 'POST':
        sub = forms.ContactusForm(request.POST)
        if sub.is_valid():
            email = sub.cleaned_data['Email']
            name = sub.cleaned_data['Name']
            message = sub.cleaned_data['Message']
            send_mail(str(name) + ' || ' + str(email), message, settings.EMAIL_HOST_USER, settings.EMAIL_RECEIVING_USER,
                      fail_silently=False)
            return render(request, 'main/contact_us_success.html')
    return render(request, 'main/contact_us.html', {'form': sub})
