#
# Copyright (c) 2013 Eric Monti
#
# MIT License
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

require_relative 'spec_helper'

describe Idevice::RestoreClient do
  before :each do
    @rc = Idevice::RestoreClient.attach(idevice:shared_idevice)
  end

  before :each do
    @rc.goodbye rescue nil
  end

  it "should attach" do
    @rc.should be_a Idevice::RestoreClient
  end

  it "should set the client label" do
    @rc.set_label("idev-unit-tests")
  end

  it "should start a restore" 

  it "should get the query type of the service daemon" do
    pending "getting PLIST_ERROR on iOS 7.x"
    res = @rc.query_type
  end

  it "should 'query' a value from the device specified by a key" do
    pending "getting PLIST_ERROR on iOS 7.x"
    res = @rc.query_value "foo"
  end

  it "should 'get' a value from information plist based by a key" do
    pending "getting NOT_ENOUGH_DATA on iOS 7.x"
    res = @rc.get_value "foo"
  end

  it "should request a device reboot" do
    pending "don't actually reboot"
    pending "getting PLIST_ERROR on iOS 7.x"
    @rc.reboot.should be_true
  end

  it "should say goodbye" do
    pending "getting PLIST_ERROR on iOS 7.x"
    @rc.goodbye.should be_true
  end

  it "should send a plist"

  it "should receive a plist"

end
