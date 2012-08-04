#! /usr/bin/env ruby
# doukaku online
# author: takano32 <tak@no32 dot tk>
# vim: set noet sts=4 sw=4 ts=4 fdm=marker :
#

class DoukakuOnline
	def initialize(addrs)
		@addrs = addrs
	end

	def resolve
		answer = []
		two_bits = @addrs.map do |addr|
			addr_to_bits(addr)
		end
		two_bits.each_slice(4) do |byte|
			ch = byte.map do |bits|
				sprintf '%02b', bits
			end.join
			answer << ch.to_i(2).chr
		end
		answer.join.strip
	end
	
	def addr_to_bits(addr)
		return 0b00 if mac? addr
		return 0b01 if v4? addr
		return 0b10 if v6? addr
		return 0b11
	end

	def mac?(addr)
		return false if addr.include?(':') and addr.include?('-')

		hexes = (addr.split %r![:-]!).map do |hex|
			hex.upcase
		end

		hexes.each do |hex|
			return false unless hex.length == 2
			return false unless hex =~ %r![0-9A-F]+!
		end

		return true
	end

	def v4?(addr)
		bytes = addr.split '.'
		bytes.each do |byte|
			valid = false
			valid = true if byte =~ %r!^[0-9]$!
			valid = true if byte =~ %r!^[1-9][0-9]$!
			valid = true if byte =~ %r!^1[0-9][0-9]$!
			valid = true if byte =~ %r!^2[0-4][0-9]$!
			valid = true if byte =~ %r!^25[0-5]$!
			return false unless valid
		end
		return true
	end

	def v6?(addr)
		hexes = (addr.split ':').map do |hex|
			hex.upcase
		end

		return false unless hexes.length == 8

		hexes.each do |hex|
			valid = false
			valid = true if hex =~ %r!^[0-9A-F]$!
			valid = true if hex =~ %r!^[1-9A-F][0-9A-F]{0,3}$!
			return false unless valid
		end

		return true
	end
end

if __FILE__ == $0 then
	addrs = []
	DATA.read.each_line do |line|
		addrs << line.chomp
	end
	douon = DoukakuOnline.new addrs
	url = douon.resolve

	require 'rubygems'
	require 'mechanize'
	agent = Mechanize.new
	res = agent.get(url)
	res = res.links.first.click
	form = res.forms.first
	form['user[name]']  = 'TAKANO Mitsuhiro'
	form['user[email]'] = 'tak@no32.tk'
	form['user[ids]']   = 'takano32'
	form['user[program]']  = (open $0).read
	form['user[language]'] = %x(ruby -v).chomp
	form['user[description]'] = <<-EOD
	This program will be post answer.
	EOD
	form['user[howto]'] = "ruby \n #{form['user[program]']} "
	form['user[comment]'] = "No Ruby, No Life."
	res = agent.submit form
	agent.submit res.forms.first
end

__END__
232.193.40.138
eaa9:ac9d:8214:7f05:c0c8:238:d1ea:488
aebf:9b94:15f1:7f74:44fb:9603:bcc:5aaa
c4-64-16-b8-d8-9c
178.168.142.4
f07d:a804:009f:8a61:2c32:b88c:ce01:a659
46.229.220.208
f0:29:5c:86:a3:4c
102.118.114.232
ko9t0:D;dz|n
83.207.69.194
24-b8-5a-bc-72-22
136.22.201.116
=P`pB45YjXYPuf^;HnY
84-f6-7f-37-b5-9c
9d-6a-c1-7f-98-3d
d3-dd-24-3f-97-9d
ou_kH_1c^HTh8<j?Ru
5e50:34f9:1324:5507:a8f8:cfd:bc96:280f
6901:45:cd15:2d75:c0da:b551:b248:a9bd
8c:3b:4c:b3:cc:02
919a:b80c:c256:618b:1085:a850:92d7:b009
S3ZFnviPdj`^;2{]6
nIo;mqY8aEL<AW04>?<43
e9-fc-32-7e-6d-a4
2245:6a9c:d67f:9c7f:fb99:b8a8:6af5:2657
\_7u]@D6Bb<
y7rzH8KID:3p]:
221.243.157.26
1k<Z\rr0aHloiMIYj=3lQGGa}i
99-ce-91-f6-82-23
219.171.250.241
6.234.187.2
034.254.205.219
47.87.76.196
238.213.64.125
212.9.246.88
ba59:88e:1e65:9171:88d8:9d76:37f7:79ce
a68f:8772:1a95:ce3d:3250:f207:ef1:9164
237.133.201.76
238.194.183.224
229.130.053.191
f853:9c38:f17b:45b8:bdc7:2cbc:9cad:b90f
afd8:a189:5b5f:3cd1:37c0:45f0:b215:b38a
b8-01-04-f9-3c-59
b7b:c5bc:2d08:a9b3:9338:b89b:752b:437d
IgrqlsG00W9g\w_B^Ej6[ILV_41VnZ}z
_;nBL<=^D;XXZg
57.96.188.242
5f3f:827b:6252:f775:4942:b16c:9a44:3ddc
23a0:4844:7827:0093:bb91:3e64:607c:cf1e
e1-4c-af-41-0a-e5
197.166.29.58
89f0:d2c3:95b5:517b:18a9:5166:26d2:6854
439d:da0b:0bc9:a463:340c:d5be:5fc9:80cf
46:ad:3b:7d:17:49
24.20.124.207
c890:225b:65e9:f5b2:11fa:ad16:d2ae:a530
157.196.12.81
9a:ec:13:93:02:2a
131.217.155.208
ab25:6060:39ba:e351:64a1:41c3:aaf0:e989
53.191.111.157
88.95.253.30
243.239.33.209
36b0:d9d8:5b5f:62bd:b722:1259:d1a6:8533
c3-ab-92-51-cf-47
b89e:6a02:c6ef:ea94:f37b:085c:5b01:ef8d
183.118.116.9
409b:f34a:9d26:c358:f58a:c79c:23ca:9e06
f0-f6-5e-97-4a-34
9.175.157.180
243.23.153.105
624f:d278:de2d:bd60:9e3:b0b0:3866:4fe5
36.107.60.140
9f-bc-91-df-c7-b8
39.87.217.3
acd7:4f0d:bcad:bb2f:9fbb:9b4:63ab:e972
240.59.200.250
248.109.238.184
07-9b-da-fb-f2-42
8d49:ed08:e790:c930:cecd:78e2:8ad3:5946
XwnMA>N>ElZTTtmO2_VtMlp
104.125.108.58
223.183.93.10
9e:35c7:4912:1f48:5b50:c221:b081:ba66
fe:bc:43:a9:12:24
008.016.065.149
6.240.202.132
41c3:1f2c:466e:8ab9:5177:3186:8:3230
Na\DAvJeF1q=0G=04bL}c8\91^>o
062.132.193.121
215.157.221.197
16ef:8cc0:9213:89ed:233f:1be0:db4c:2854
GW]jZ@GPlR8N7SmB};Hsyx8[w3
14bc:f200:72bd:4b97:8183:fbdb:55e7:d7a6
83.33.91.156
5998:99c:2689:93cd:aa9:4488:3eb7:3310
41.92.65.218
215.090.015.003
140.6.201.210
dGa;e8^w@p
06:6c:6b:48:59:20
7a8a:2e16:d5fc:ab33:4bf2:aafc:88b8:a0f8
234.6.94.203
222e:6e04:d08b:c6c6:a5fc:c83f:2623:497
a8:ee:cb:cd:1b:08
203.33.48.195
46.243.89.51
a4ae:08e3:3c1f:e33c:c46b:cd7f:8f9f:681b
152.175.25.39
cb-67-57-8c-f4-93
122.77.248.239
v;82eNcy51rX;l|@m|64D5
3b-de-35-ab-1a-af
a655:07ab:3258:44f5:33ee:17b1:4d4e:1bcc
d0:b5:46:05:1c:aa
f7df:6c4b:1eab:1810:488f:de22:d003:4585
0c23:d744:c5f2:302e:186e:9e57:ff88:bab8
a21f:91b4:4912:eb6d:5250:1c08:5c9a:bf8a
124.87.156.161
c0bf:6fe8:919f:e294:f80:5d0d:1a0d:afd3
810a:5f52:396d:be18:6e13:c470:2cf6:28e9
c4:69:a5:c6:e1:e2
30.99.20.134
SbA3
154.71.106.46
ab-1b-fb-2e-84-ec
231.7.238.127
570:6a18:1a28:dfb1:8d34:54bf:1d0f:923e
123.196.025.112
127.130.75.139
108.99.8.228
fcb9:fab7:86d2:3e50:855c:b4d2:e964:99
d661:aa1e:0d94:c264:cb38:7579:b289:e041
f8-96-8f-45-60-9b
b0-46-e9-16-06-b9
59dd:19c9:e95b:583d:7719:d566:535e:472b
ed-af-07-20-db-89
5a-00-b2-4f-6f-b8
