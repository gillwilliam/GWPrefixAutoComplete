Pod::Spec.new do |s|
  s.name             = 'GWPrefixAutoComplete'
  s.version          = '0.2.2'
  s.summary          = 'Auto Complete Trie'

  s.description      = <<-DESC
An autocomplete feature that uses a trie as the underlying data structure.
                       DESC

  s.homepage         = 'https://github.com/gillwilliam/GWPrefixAutoComplete'
  s.author           = { 'William Gill' => 'gill.william@gmail.com' }
  s.license      = { :type => 'Apache License, Version 2.0', :text => <<-LICENSE
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    LICENSE
  }
  s.source           = { :git => 'https://github.com/gillwilliam/GWPrefixAutoComplete.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.source_files = 'PrefixAutoComplete/PrefixAutoComplete/Trie/*.swift', 'PrefixAutoComplete/PrefixAutoComplete/utils/*.swift'

end
