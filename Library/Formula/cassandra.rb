require 'formula'

class Cassandra <Formula
  url 'http://apache.mirrors.redwire.net/cassandra/0.5.1/apache-cassandra-0.5.1-bin.tar.gz'
  homepage 'http://cassandra.apache.org'
  md5 '57ad909a90db7597ca91e2ec0ad5e507'

  def install
    (var+"lib/cassandra").mkpath
    (var+"log/cassandra").mkpath

    inreplace "conf/storage-conf.xml" do |s|
      s.gsub! "/var/lib/cassandra", "#{var}/lib/cassandra"
    end

    inreplace "conf/log4j.properties" do |s|
      s.gsub! "/var/log/cassandra", "#{var}/log/cassandra"
    end

    inreplace "bin/cassandra.in.sh" do |s|
      s.gsub! "cassandra_home=`dirname $0`/..", "cassandra_home=#{prefix}"
    end

    rm Dir["bin/*.bat"]
    prefix.install Dir["*.txt"] + Dir["{bin,conf,interface,javadoc}"]
    prefix.install Dir["lib/*.jar"]
  end
end
