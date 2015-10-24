#!/usr/bin/ruby

primefile = ARGV[0] ? ARGV[0] : "myprimes.list"
numprimesreqd = ARGV[1] ? ARGV[1].to_i : 1000

primelist = []

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
	primelist.each do | myprime |
		if num_of_prime_factors > 2 and myprime > (cur_prime / 2)
			break			
		else
			if cur_prime % myprime == 0
				num_of_prime_factors += 1
			end
		end
	end

	if num_of_prime_factors == 1
		primelist[primelist.length] = cur_prime
		puts cur_prime.to_s + " is prime"
		primes_gen_so_far += 1
	end
	cur_prime += 1
end

File.open(primefile, "w") do |file|
	primelist.each do |myprime| 
		file.puts myprime
	end
end

puts primes_gen_so_far.to_s + " primes generated"
