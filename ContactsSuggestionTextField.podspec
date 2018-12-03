
Pod::Spec.new do |s|

  s.name         = "ContactsSuggestionTextField"
  s.version      = "0.0.3"
  s.summary      = "Contact Picker UITextField"
  s.homepage     = "https://github.com/paulsumit1993/ContactsSuggestionTextField"
  s.description  = <<-DESC
  A simple and adaptive UITextField subclass which attaches a contact picker to the textfield's input accessory view for seamless contact access.
                   DESC

  s.license            = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Sumit Paul" => "paulsumit1993@gmail.com" }
  s.social_media_url   = "https://twitter.com/zen_prog"
  s.platform           = :ios, "10.0"
  s.source             = { :git => "https://github.com/paulsumit1993/ContactsSuggestionTextField.git", :tag => "#{s.version}" }
  s.source_files       = "ContactsSuggestionTextField/*.{swift,xib}"

end
