require_relative 'spec_helper'

describe Idev::AFC do
  before :all do
    @idevice = Idev::Idevice.attach
  end

  before :each do
    @afc = Idev::AFC.attach(idevice:@idevice)
  end

  it "should return device info" do
    result = @afc.device_info
    result.should be_a Hash
    result.keys.sort.should == ["FSBlockSize", "FSFreeBytes", "FSTotalBytes", "Model"]
    result["FSBlockSize"].should =~ /^\d+$/
    result["FSFreeBytes"].should =~ /^\d+$/
    result["FSTotalBytes"].should =~ /^\d+$/
    result["FSTotalBytes"].to_i.should > result["FSFreeBytes"].to_i
  end

  it "should return device info for specific keys" do
    totbytes = @afc.device_info("FSTotalBytes")
    totbytes.should be_a String
    totbytes.should =~ /^\d+$/

    freebytes = @afc.device_info("FSFreeBytes")
    freebytes.should be_a String
    freebytes.should =~ /^\d+$/

    totbytes.to_i.should > freebytes.to_i
  end

  it "should list directory contents" do
    result = @afc.read_directory('/')
    result.should be_a Array
    result[0,2].should == ['.', '..']
  end

  it "should raise an error listing an invalid directory" do
    lambda{ @afc.read_directory('/TOTALLYNOTREALLYTHERE') }.should raise_error(Idev::AFCError)
  end

  it "should get file information" do
    result = @afc.file_info('/')
    result.should be_a Hash
    result.keys.sort.should == ["st_birthtime", "st_blocks", "st_ifmt", "st_mtime", "st_nlink", "st_size"]
    result["st_ifmt"].should == "S_IFDIR"
  end

  it "should raise an error getting info for an invalid path" do
    lambda{ @afc.file_info('/TOTALLYNOTREALLYTHERE') }.should raise_error(Idev::AFCError)
  end

  it "should remove a path" do
    @afc.make_directory('TOTALLYATESTDIRCREATEDTEST').should be_true
    @afc.remove_path('TOTALLYATESTDIRCREATEDTEST').should be_true
  end

  it "should rename a path" do
    begin
      @afc.make_directory('TOTALLYATESTDIRCREATEDTEST').should be_true
      @afc.rename_path('TOTALLYATESTDIRCREATEDTEST', 'TOTALLYATESTDIRCREATEDTEST2').should be_true
      result = @afc.file_info('TOTALLYATESTDIRCREATEDTEST2')
      result["st_ifmt"].should == "S_IFDIR"
    ensure
      @afc.remove_path('TOTALLYATESTDIRCREATEDTEST') rescue nil
      @afc.remove_path('TOTALLYATESTDIRCREATEDTEST2').should be_true
    end
  end


  it "should make a directory" do
    begin
      @afc.make_directory('TOTALLYATESTDIR').should be_true
      result = @afc.file_info('TOTALLYATESTDIR')
      result["st_ifmt"].should == "S_IFDIR"
    ensure
      @afc.remove_path('TOTALLYATESTDIR') rescue nil
    end
  end

  it "should make a symbolic link" do
    begin
      @afc.symlink('.', 'TOTALLYATESTSYMLINKTOCURRENTDIR').should be_true
      result = @afc.file_info('TOTALLYATESTSYMLINKTOCURRENTDIR')
      result["st_ifmt"].should == "S_IFLNK"
    ensure
      @afc.remove_path('TOTALLYATESTSYMLINKTOCURRENTDIR') rescue nil
    end
  end

  it "should make a hard link" do
    pending "figure out hardlinks?" # XXX TODO
    begin
      @afc.make_directory('TOTALLYATESTDIR').should be_true
      @afc.hardlink('./TOTALLYATESTDIR/', 'TOTALLYATESTHARDLINKTOCURRENTDIR').should be_true
      result = @afc.file_info('TOTALLYATESTHARDLINKTOCURRENTDIR')
      result["st_ifmt"].should == "S_IFDIR"
    ensure
      @afc.remove_path('TOTALLYATESTHARDLINKTOCURRENTDIR') rescue nil
      @afc.remove_path('TOTALLYATESTDIR') rescue nil
    end
  end

  it "should raise an error removing a non-existent path" do
    lambda{ @afc.remove_path('/TOTALLYNOTREALLYTHERE') }.should raise_error(Idev::AFCError)
  end

  it "should put a file"

  it "should get a file"

  it "should truncate a file path"

  it "should set file time"
end
