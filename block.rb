class Block
  attr_reader :index, :timestamp, :data, :previous_hash, :nonce, :hash, :creator 

  def initialize(index, timestamp, data, previous_hash, creator)
    @index = index
    @timestamp = timestamp
    @data = data
    @previous_hash = previous_hash
    @creator = creator
    @nonce = 0
    @hash = compute_hash_with_proof_of_work
  end
  

	def compute_hash_with_proof_of_work(difficulty="0000")
		nonce = 0
		loop do 
			hash = calc_hash_with_nonce(nonce)
			if hash.start_with?(difficulty)
        #modificado el retorno para que el hash no sea un array y no de error
				return hash
			else
				nonce +=1
			end
		end
	end
	
  def calc_hash_with_nonce(nonce=0)
    sha = Digest::SHA256.new
    sha.update( nonce.to_s + 
								@index.to_s + 
								@timestamp.to_s + 
								@transactions.to_s + 
								@transactions_count.to_s +	
								@previous_hash )
    sha.hexdigest 
  end

  def self.first( *transactions )    # Create genesis block
    ## Uses index zero (0) and arbitrary previous_hash ("0")
    Block.new(0, Time.now, "Genesis Block", "0", "Elam")
  end

  def self.next( previous, transactions )
    # Modificado para que funcione con los nuevos atributos del bloque
    Block.new( previous.index+1,Time.now, transactions, previous.hash, "Elam" )
  end
end  # class Block