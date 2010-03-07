# The matchersystem is built around Jeremy McAnally's matchy
# -> http://github.com/jm/matchy
# Copyright (c) 2008 Jeremy McAnally
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'matcher_system/core/expectation_builder'
require 'matcher_system/core/modals'
require 'matcher_system/core/matcher_builder'
require 'matcher_system/core/def_matcher'
require 'matcher_system/core/exceptions'

require 'matcher_system/built_in/enumerable_expectations'
require 'matcher_system/built_in/error_expectations'
require 'matcher_system/built_in/truth_expectations'
require 'matcher_system/built_in/operator_expectations'
require 'matcher_system/built_in/change_expectations'

module MacSpec
  module MatcherSystem
    # todo doc
  end
end