TestCase subclass: NettleAesTest [
	testAesInit [
		| ctx_en ctx_de |

		self should: [
			ctx_en := NettleAes new.
			ctx_en set_encrypt_key: ('ABCDABCDABCDABCD' asByteArray).

			ctx_de := NettleAes new.
			ctx_de set_decrypt_key: ('ABCDABCDABCDABCD' asByteArray).

			true.
		]
	]

	testAesEncrypt [
		| ctx |

		ctx := NettleAes new.
		ctx set_encrypt_key: ('ABCDABCDABCDABCD' asByteArray).

		self should: [
			| cleartext |
			cleartext :=  'aaaaaaaabbbbbbbb' asByteArray.
			(ctx encrypt: cleartext) = #[16 5 42 86 30 91 206 232 105 155 194 50 56 82 65 252]
		]
	]

	testAesDecrypt [
		| ctx |
		ctx := NettleAes new.
		ctx set_decrypt_key: ('ABCDABCDABCDABCD' asByteArray).

		self should: [
			| ciphertext |
			ciphertext := #[16 5 42 86 30 91 206 232 105 155 194 50 56 82 65 252].
			(ctx decrypt: ciphertext) = 'aaaaaaaabbbbbbbb' asByteArray
		]
	]
]