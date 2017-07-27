TestCase subclass: NettleHmacTest [
	testSha1Init [
		| ctx |

		self should: [
			ctx := NettleHmacSha1 new.
			ctx set_key: ('some random key' asByteArray).
			true.
		]
	]

	testSha1EmptyDigest [
		| ctx |

		ctx := NettleHmacSha1 new.
		ctx set_key: ('some random key' asByteArray).

		self should: [
			 ctx digest = #[212 211 115 4 116 25 66 38 147 108 7 174 219 19 194 31 226 220 178 170]
		]
	]

	testSha1ShortInput [
		| ctx |

		ctx := NettleHmacSha1 new.
		ctx set_key: ('some random key' asByteArray).

		self should: [
			ctx update: ('Hallo' asByteArray).
			ctx digest = #[141 12 136 100 197 213 113 167 179 103 134 98 216 177 217 56 144 117 221 235]
		]
	]

	testSha1LongInputOneUpdate [
		| ctx |

		ctx := NettleHmacSha1 new.
		ctx set_key: ('some random key' asByteArray).

		self should: [
			ctx update: ('On 16 November 1797, Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[143 159 181 10 59 248 61 193 172 14 112 239 64 77 23 180 68 60 88 21]
		]
	]

	testSha1LongInputTwoUpdates [
		| ctx |

		ctx := NettleHmacSha1 new.
		ctx set_key: ('some random key' asByteArray).


		self should: [
			ctx update: ('On 16 November 1797, ' asByteArray).
			ctx update: ('Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[143 159 181 10 59 248 61 193 172 14 112 239 64 77 23 180 68 60 88 21]
		]
	]
]