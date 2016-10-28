Pod::Spec.new do |s|
    s.name         = 'BAlertView'
    s.version      = '1.0.5'
    s.summary      = '1.show a toast 2.modle show a customview'
    s.homepage     = 'https://github.com/february29/BAlertView'
    s.license      = 'MIT'
    s.authors      = {'february29' => 'pengyou_byh@163.com'}
    s.platform     = :ios, '7.0'
    s.source       = {:git => 'https://github.com/february29/BAlertView.git', :tag => s.version}
    s.source_files = 'BAlertView/*.{h,m}'
    s.requires_arc = true
end
