# Class: odoo
#
# Installs Odoo web server and dependencies but does not install
# a database server, assuming that this server will run on its own
# machine.
#
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

   file { 'openerp-server.conf':
      path    => '/etc/odoo/openerp-server.conf',
      content => template("${module_name}/openerp-server.conf.erb"),
      owner   => 'odoo',
      group   => 'odoo',
      mode    => '0600',
      show_diff => false,
      require => Class['::odoo::install'],
      notify  => Service['odoo-server'],
   }

   file {['/opt/odoo', '/opt/odoo/addons']:
      ensure  => directory,
      owner   => 'odoo',
      group   => 'odoo',
      mode    => '0640',
      require => Class['::odoo::install'],
      notify  => Service['odoo-server'],
   }

   service {'odoo-server' :
      name    => 'odoo',
      ensure  => running,
      require => Class['::odoo::install'],
   }

}
