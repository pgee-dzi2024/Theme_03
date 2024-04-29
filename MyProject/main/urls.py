from django.conf.urls.static import static
from django.urls import path
from .views import *
from django.contrib.auth.views import LoginView, LogoutView

urlpatterns = [
    path('', home_view, name='home'),
    path('after_login', after_login_view, name='after-login'),
    path('logout', LogoutView.as_view(template_name='main/logout.html')),
    path('about_us', aboutus_view, name='about-us'),
    path('contactus', contactus_view, name='contactus'),
    path('search', search_view, name='search'),
    path('send-feedback', send_feedback_view, name='send-feedback'),
    path('view-feedback', view_feedback_view, name='view-feedback'),

    path('admin_click', admin_click_view, name='admin-click'),
    path('admin_login', LoginView.as_view(template_name='main/admin_login.html', next_page='/after_login')),
    path('admin-dashboard', admin_dashboard_view, name='admin-dashboard'),

    path('view-customer', view_customer_view, name='view-customer'),
    path('delete-customer/<int:pk>', delete_customer_view, name='delete-customer'),
    path('update-customer/<int:pk>', update_customer_view, name='update-customer'),

    path('admin-products', admin_products_view, name='admin-products'),
    path('admin-add-product', admin_add_product_view, name='admin-add-product'),
    path('delete-product/<int:pk>', delete_product_view, name='delete-product'),
    path('update-product/<int:pk>', update_product_view, name='update-product'),

    path('admin-view-booking', admin_view_booking_view, name='admin-view-booking'),
    path('delete-order/<int:pk>', delete_order_view, name='delete-order'),
    path('update-order/<int:pk>', update_order_view, name='update-order'),


    path('customer_signup', customer_signup_view, name='customer-signup'),
    path('customer_login', LoginView.as_view(template_name='main/customer_login.html', next_page='/after_login')),
    path('customer-home', customer_home_view, name='customer-home'),
    path('my-order', my_order_view, name='my-order'),
    # path('my-order', my_order_view2,name='my-order'),
    path('my-profile', my_profile_view, name='my-profile'),
    path('edit-profile', edit_profile_view, name='edit-profile'),
    path('download-invoice/<int:orderID>/<int:productID>', download_invoice_view, name='download-invoice'),


    path('add-to-cart/<int:pk>', add_to_cart_view, name='add-to-cart'),
    path('cart', cart_view, name='cart'),
    path('remove-from-cart/<int:pk>', remove_from_cart_view, name='remove-from-cart'),
    path('customer-address', customer_address_view, name='customer-address'),
    path('payment-success', payment_success_view, name='payment-success'),

]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
