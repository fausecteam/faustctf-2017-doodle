TestCase subclass: NettleMd5Test [
	testMd5Init [
		| ctx |

		self should: [
			ctx := NettleMd5 new.
			ctx init.
			true.
		]
	]

	testMd5EmptyDigest [
		| ctx |

		ctx := NettleMd5 new.
		ctx init.

		self should: [
			ctx digest = #[212 29 140 217 143 0 178 4 233 128 9 152 236 248 66 126]
		]
	]

	testMd5ShortInput [
		| ctx |

		ctx := NettleMd5 new.
		ctx init.

		self should: [
			ctx update: ('Hallo' asByteArray).
			ctx digest = #[209 191 147 41 157 225 182 142 109 56 44 137 59 241 33 95]
		]
	]

	testMd5LongInputOneUpdate [
		| ctx |

		ctx := NettleMd5 new.
		ctx init.

		self should: [
			ctx update: ('On 16 November 1797, Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[13 106 30 108 39 236 75 210 44 100 102 129 228 122 59 207]
		]
	]

	testMd5LongInputTwoUpdates [
		| ctx |

		ctx := NettleMd5 new.
		ctx init.

		self should: [
			ctx update: ('On 16 November 1797, ' asByteArray).
			ctx update: ('Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[13 106 30 108 39 236 75 210 44 100 102 129 228 122 59 207]
		]
	]
]