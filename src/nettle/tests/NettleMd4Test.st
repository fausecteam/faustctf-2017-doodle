TestCase subclass: NettleMd4Test [
	testMd4Init [
		| ctx |

		self should: [
			ctx := NettleMd4 new.
			ctx init.
			true.
		]
	]

	testMd4EmptyDigest [
		| ctx |

		ctx := NettleMd4 new.
		ctx init.

		self should: [
			ctx digest = #[49 214 207 224 209 106 233 49 183 60 89 215 224 192 137 192]
		]
	]

	testMd4ShortInput [
		| ctx |

		ctx := NettleMd4 new.
		ctx init.

		self should: [
			ctx update: ('Hallo' asByteArray).
			ctx digest = #[77 110 7 25 238 168 96 77 98 162 230 43 182 63 30 189]
		]
	]

	testMd4LongInputOneUpdate [
		| ctx |

		ctx := NettleMd4 new.
		ctx init.

		self should: [
			ctx update: ('On 16 November 1797, Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[117 246 216 122 53 80 184 65 187 4 232 251 195 194 151 98]
		]
	]

	testMd4LongInputTwoUpdates [
		| ctx |

		ctx := NettleMd4 new.
		ctx init.

		self should: [
			ctx update: ('On 16 November 1797, ' asByteArray).
			ctx update: ('Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[117 246 216 122 53 80 184 65 187 4 232 251 195 194 151 98]
		]
	]
]