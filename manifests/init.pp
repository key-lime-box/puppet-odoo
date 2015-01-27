# Class: odoo

class odoo (
             $admin_passwd = '',
             $db_host      = 'localhost',
             $db_port      = '5432',
             $db_user      = 'odoo',
             $db_password  = 'odoo',
             $addons_path  = '/opt/odoo/addons'
            ) {

   case $::operatingsystem {
      /(Ubuntu)/: {
         $package_name  = 'odoo'
      }
      default: {
         fail ("Module ${module_name} is not supported on ${::operatingsystem}")
      }
   }

   include odoo::install

   if $admin_passwd.start_with?('ENC[') {
      $admin_passwd = decrypt ($admin_passwd)
   }
   if $db_password.start_with?('ENC[') {
      $db_password = decrypt ($db_password)
   }

   file { 'openerp-server.conf':
      path    => '/etc/odoo/openerp-server.conf',
      content => template("${module_name}/openerp-server.conf.erb"),
      owner   => 'odoo',
      group   => 'odoo',
      mode    => '0600',
   }

}
