TestCase subclass: NettleCbcTest [
	testAesEncrypt [
		| ctx |

		ctx := NettleAes new.
		ctx set_encrypt_key: ('ABCDABCDABCDABCD' asByteArray).

		self should: [
  			| cbc |

			cbc := NettleAesCbc new.
			cbc iv: #[3 2 1 3 2 1 3 2 1 3 2 1 3 2 1 3].
			cbc context: ctx.

			(cbc encrypt: #[97 97 97 97 97 97 97 97 98 98 98 98 98 98 98 98 99 99 99 99 99 99 99 99 100 100 100 100 100 100 100 100]) =
			              #[111 210 65 185 81 80 57 84 238 54 184 29 55 104 107 63 112 167 165 175 245 189 211 42 71 110 242 50 40 28 120 147]
		]
	]

	testAesDecrypt [
		| ctx |

		ctx := NettleAes new.
		ctx set_decrypt_key: ('ABCDABCDABCDABCD' asByteArray).

		self should: [
  			| cbc |

			cbc := NettleAesCbc new.
			cbc iv: #[3 2 1 3 2 1 3 2 1 3 2 1 3 2 1 3].
			cbc context: ctx.

			(cbc decrypt: #[111 210 65 185 81 80 57 84 238 54 184 29 55 104 107 63 112 167 165 175 245 189 211 42 71 110 242 50 40 28 120 147]) =
				 		  #[97 97 97 97 97 97 97 97 98 98 98 98 98 98 98 98 99 99 99 99 99 99 99 99 100 100 100 100 100 100 100 100]
		]
	]

	testTwofishEncrypt [
		| ctx |

		ctx := NettleTwofish new.
		ctx set_key: ('ABCDABCDABCDABCD' asByteArray).

		self should: [
  			| cbc |

			cbc := NettleTwofishCbc new.
			cbc iv: #[3 2 1 3 2 1 3 2 1 3 2 1 3 2 1 3].
			cbc context: ctx.

			(cbc encrypt: #[97 97 97 97 97 97 97 97 98 98 98 98 98 98 98 98 99 99 99 99 99 99 99 99 100 100 100 100 100 100 100 100]) =
			              #[144 108 126 32 138 72 180 247 38 71 187 39 77 230 33 171 241 131 234 108 93 160 193 112 55 84 66 121 89 37 103 47]
		]
	]

	testTwofishEncryptZeros [
		| clear ctx |

		self should: [
			0 to: 10 do: [ :x |
  				| cbc |

				ctx := NettleTwofish new.
				ctx set_key: #[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0].


				cbc := NettleTwofishCbc new.
				cbc iv: #[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0].
				cbc context: ctx.

				clear := cbc encrypt: #[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0].
			].
			clear := #[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0].
			0 to: 10000 do: [:x |
  				| cbc |

				ctx := NettleTwofish new.
				ctx set_key: #[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0].


				cbc := NettleTwofishCbc new.
				cbc iv: #[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0].
				cbc context: ctx.

				clear := cbc encrypt: clear.
			].
			true.
		]
	]

	testTwofishDecrypt [
		| ctx |

		ctx := NettleTwofish new.
		ctx set_key: ('ABCDABCDABCDABCD' asByteArray).

		self should: [
  			| cbc |

			cbc := NettleTwofishCbc new.
			cbc iv: #[3 2 1 3 2 1 3 2 1 3 2 1 3 2 1 3].
			cbc context: ctx.

			(cbc decrypt: #[144 108 126 32 138 72 180 247 38 71 187 39 77 230 33 171 241 131 234 108 93 160 193 112 55 84 66 121 89 37 103 47]) =
				 		  #[97 97 97 97 97 97 97 97 98 98 98 98 98 98 98 98 99 99 99 99 99 99 99 99 100 100 100 100 100 100 100 100]
		]
	]

]
