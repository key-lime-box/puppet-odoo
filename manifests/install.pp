# Class: odoo::install
#
# Installs all the packages necessary for Odoo on Ubuntu.
#
class odoo::install {
   if !defined(Class['odoo']) {
      fail ('You must include the odoo base class before using any odoo subclass')
   }

   ## Dependencies
   package {'python-dateutil':
      ensure   => present,
   }
   package {'python-feedparser':
      ensure   => present,
   }
   package {'python-gdata':
      ensure   => present,
   }
   package {'python-ldap':
      ensure   => present,
   }
   package {'python-libxslt1':
      ensure   => present,
   }
   package {'python-lxml':
      ensure   => present,
   }
   package {'python-mako':
      ensure   => present,
   }
   package {'python-openid':
      ensure   => present,
   }
   package {'python-psycopg2':
      ensure   => present,
   }
   package {'python-pybabel':
      ensure   => present,
   }
   package {'python-pychart':
      ensure   => present,
   }
   package {'python-pydot':
      ensure   => present,
   }
   package {'python-pyparsing':
      ensure   => present,
   }
   package {'python-reportlab':
      ensure   => present,
   }
   package {'python-simplejson':
      ensure   => present,
   }
   package {'python-tz':
      ensure   => present,
   }
   package {'python-vatnumber':
      ensure   => present,
   }
   package {'python-vobject':
      ensure   => present,
   }
   package {'python-webdav':
      ensure   => present,
   }
   package {'python-werkzeug':
      ensure   => present,
   }
   package {'python-xlwt':
      ensure   => present,
   }
   package {'python-yaml':
      ensure   => present,
   }
   package {'python-zsi':
      ensure   => present,
   }
   package {'postgresql-client':
      ensure   => present,
   }
   package {'python-decorator':
      ensure   => present,
   }
   package {'python-docutils':
      ensure   => present,
   }
   package {'python-imaging':
      ensure   => present,
   }
   package {'python-jinja2':
      ensure   => present,
   }
   package {'python-mock':
      ensure   => present,
   }
   package {'python-passlib':
      ensure   => present,
   }
   package {'python-psutil':
      ensure   => present,
   }
   package {'python-pypdf':
      ensure   => present,
   }
   package {'python-unittest2':
      ensure   => present,
   }
   package {'wkhtmltox':
      ensure => '0.12.1',
   }
   file {'/usr/bin/wkhtmltopdf':
      ensure   => link,
      target   => '/usr/local/bin/wkhtmltopdf'
      require  => Package['wkhtmltox']
   }

   ## Odoo itself
   package {'odoo':
      ensure   => '8.0.0',
   }

}
