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
      'Ubuntu': {
         $package_name  = 'odoo'
      }
      default: {
         fail ("Module ${module_name} is not supported on ${::operatingsystem}")
      }
   }

   include odoo::install

   if $admin_passwd =~ /^ENC\[/ {
      $admin_passwd_final = decrypt ($admin_passwd)
   }
   else {
      $admin_passwd_final = $admin_passwd
   }
   if $db_password =~ /^ENC\[/ {
      $db_password_final = decrypt ($db_password)
   }
   else {
      $db_password_final = $db_password
   }

   file { 'openerp-server.conf':
      path    => '/etc/odoo/openerp-server.conf',
      content => template("${module_name}/openerp-server.conf.erb"),
      owner   => 'odoo',
      group   => 'odoo',
      mode    => '0600',
      require => Class['::odoo::install'],
      notify  => Service['odoo-server'],
   }

   file {['/opt/odoo', '/opt/odoo/addons']:
      ensure  => directory,
      owner   => 'odoo',
      group   => 'odoo',
      mode    => '0640',
      notify  => Service['odoo-server'],
   }

   service {'odoo-server' :
      name    => 'odoo',
      ensure  => running,
   }

}
