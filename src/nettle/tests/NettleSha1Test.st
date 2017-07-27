TestCase subclass: NettleSha1Test [
	testSha1Init [
		| ctx |

		self should: [
			ctx := NettleSha1 new.
			ctx init.
			true.
		]
	]

	testSha1EmptyDigest [
		| ctx |

		ctx := NettleSha1 new.
		ctx init.

		self should: [
			 ctx digest = #[218 57 163 238 94 107 75 13 50 85 191 239 149 96 24 144 175 216 7 9]
		]
	]

	testSha1ShortInput [
		| ctx |

		ctx := NettleSha1 new.
		ctx init.

		self should: [
			ctx update: ('Hallo' asByteArray).
			ctx digest = #[89 217 166 223 6 185 246 16 247 219 142 3 104 150 237 3 102 45 22 143]
		]
	]

	testSha1LongInputOneUpdate [
		| ctx |

		ctx := NettleSha1 new.
		ctx init.

		self should: [
			ctx update: ('On 16 November 1797, Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[246 91 177 89 10 169 104 186 79 147 224 68 152 158 142 142 248 21 159 94]
		]
	]

	testSha1LongInputTwoUpdates [
		| ctx |

		ctx := NettleSha1 new.
		ctx init.

		self should: [
			ctx update: ('On 16 November 1797, ' asByteArray).
			ctx update: ('Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[246 91 177 89 10 169 104 186 79 147 224 68 152 158 142 142 248 21 159 94]
		]
	]
]