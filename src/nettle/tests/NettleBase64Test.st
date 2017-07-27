TestCase subclass: NettleBase64Test [
	testBase64EncodeUpdate [
		| ctx buffer1 buffer2 bufferfin |

		ctx := NettleBase64Encode new.
		ctx init.

		buffer1 := ctx update: ('Hallo' asByteArray).
		buffer2 := ctx update: ('Welt' asByteArray).
		bufferfin := ctx finalize.
		
		self should: [ 'SGFsbG' = buffer1. ].
		self should: [ '9XZWx0' = buffer2. ].
		self should: [ '' = bufferfin. ].
	]

	testBase64EncodeRaw [
		| buffer |

		buffer := #[0 0 0 0 0 0 0 0 0 0 0 0 0 0].

		NettleBase64Encode base64_encode_raw: buffer length: 9 src: 'HalloWelt' asByteArray.

		self should: [ #[83 71 70 115 98 71 57 88 90 87 120 48 0 0] = buffer. ]
	]

	testBase64Decode [
		| ctx src dst dstlen |

		ctx := NettleBase64Decode new.
		ctx init.
		src := #[83 71 70 115 98 71 57 88 90 87 120 48].

		dst := ctx update: src.
		self should: [ dst asString = 'HalloWelt'. ].
		self should: [ ctx finalize = 1. ]
	]
]
