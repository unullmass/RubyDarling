#!/usr/bin/ruby

primefile = ARGV[0] ? ARGV[0] : "myprimes.list"
primefactorsfile = ARGV[1] ? ARGV[1] : "myprimefactors.list"
numprimesreqd = ARGV[2] ? ARGV[2].to_i : 10000

primelist = []
primefactorslist = []


i = 0
if File.exist? primefile
	File.foreach( primefile ) do |primeline|
		primelist[i] = primeline.to_i
		i = i + 1
	end
else
	primelist = [1]
end

cur_prime = primelist[-1] + 1

primes_gen_so_far = 0

until primes_gen_so_far == numprimesreqd
	num_of_prime_factors = 0
	my_prime_factor = 1
	primelist.each do | myprime |
		if num_of_prime_factors == 2 or myprime > (cur_prime / 2)
			break			
		elsif cur_prime % myprime == 0
			num_of_prime_factors += 1
			my_prime_factor = myprime
		end
	end

	if num_of_prime_factors == 1
		primelist[primelist.length] = cur_prime
		puts cur_prime.to_s + " is prime"
		primes_gen_so_far += 1
	else
		if cur_prime % 2 != 0 
			primefactorslist[primefactorslist.length] = cur_prime.to_s + "," + my_prime_factor.to_s
		end
	end

	cur_prime += 1
end

File.open(primefile, "w") do |file|
	primelist.each do |myprime| 
		file.puts myprime
	end
end

File.open(primefactorsfile, "a") do |file|
	primefactorslist.each do |myprimefactor| 
		file.puts myprimefactor
	end
end

puts primes_gen_so_far.to_s + " primes generated"
