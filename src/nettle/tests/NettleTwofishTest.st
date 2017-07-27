TestCase subclass: NettleTwofishTest [
	testTwofishInit [
		| ctx |

		self should: [
			ctx := NettleTwofish new.
			ctx set_key: ('ABCDABCDABCDABCD' asByteArray).

			true.
		]
	]

	testTwofishEncrypt [
		| ctx |

		ctx := NettleTwofish new.
		ctx set_key: ('ABCDABCDABCDABCD' asByteArray).

		self should: [
			| ciphertext cleartext |
			cleartext :=  'aaaaaaaabbbbbbbb' asByteArray.
			(ctx encrypt: cleartext) = #[199 114 249 212 137 3 140 18 87 80 147 142 32 29 211 33]
		]
	]

	testTwofishDecrypt [
		| ctx |
		ctx := NettleTwofish new.
		ctx set_key: ('ABCDABCDABCDABCD' asByteArray).

		self should: [
			| ciphertext cleartext |
			ciphertext := #[199 114 249 212 137 3 140 18 87 80 147 142 32 29 211 33].
			(ctx decrypt: ciphertext) = 'aaaaaaaabbbbbbbb' asByteArray
		]
	]
]