TestCase subclass: NettleRipeMd160Test [
	testRipemd160Init [
		| ctx |

		self should: [
			ctx := NettleRipeMd160 new.
			ctx init.
			true.
		]
	]

	testRipeMd160EmptyDigest [
		| ctx |

		ctx := NettleRipeMd160 new.
		ctx init.

		self should: [
			ctx digest = #[156 17 133 165 197 233 252 84 97 40 8 151 126 232 245 72 178 37 141 49]
		]
	]

	testRipeMd160ShortInput [
		| ctx |

		ctx := NettleRipeMd160 new.
		ctx init.

		self should: [
			ctx update: ('Hallo' asByteArray).
			ctx digest = #[110 110 79 175 45 171 20 240 43 116 67 239 99 32 161 69 187 84 59 204]
		]
	]

	testRipeMd160LongInputOneUpdate [
		| ctx |

		ctx := NettleRipeMd160 new.
		ctx init.

		self should: [
			ctx update: ('On 16 November 1797, Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[185 221 179 112 26 0 227 211 70 81 5 137 156 54 50 212 235 34 244 3]
		]
	]

	testRipeMd160LongInputTwoUpdates [
		| ctx |

		ctx := NettleRipeMd160 new.
		ctx init.

		self should: [
			ctx update: ('On 16 November 1797, ' asByteArray).
			ctx update: ('Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[185 221 179 112 26 0 227 211 70 81 5 137 156 54 50 212 235 34 244 3]
		]
	]
]