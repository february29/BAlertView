Pod::Spec.new do |spec|
    spec.name         = 'BAlertView'
    spec.version      = '1.0.9'
    spec.summary      = '1.show a toast 2.modle show a customview'
    spec.homepage     = 'https://github.com/february29/BAlertView'
    spec.license      = 'MIT'
    spec.authors      = {'february29' => 'pengyou_byh@163.com'}
    spec.platform     = :ios, '7.0'
    spec.source       = {:git => 'https://github.com/february29/BAlertView.git', :tag => spec.version}
    spec.source_files = 'BAlertView/*.{h,m}'
    spec.requires_arc = true
end
