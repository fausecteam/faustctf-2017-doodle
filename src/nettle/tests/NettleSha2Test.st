TestCase subclass: NettleSha2Test [
	testSha224Init [
		| ctx |

		self should: [
			ctx := NettleSha224 new.
			ctx init.
			true.
		]
	]

	testSha224EmptyDigest [
		| ctx |

		ctx := NettleSha224 new.
		ctx init.

		self should: [
			 ctx digest = #[209 74 2 140 42 58 43 201 71 97 2 187 40 130 52 196 21 162 176 31 130 142 166 42 197 179 228 47]
		]
	]

	testSha224ShortInput [
		| ctx |

		ctx := NettleSha224 new.
		ctx init.

		self should: [
			ctx update: ('Hallo' asByteArray).
			ctx digest = #[227 94 156 215 176 88 227 146 52 196 238 117 214 39 26 80 87 225 155 231 154 192 173 168 94 98 162 184]
		]
	]

	testSha224LongInputOneUpdate [
		| ctx |

		ctx := NettleSha224 new.
		ctx init.

		self should: [
			ctx update: ('On 16 November 1797, Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[38 108 184 77 71 236 95 51 14 216 36 157 157 147 235 55 125 20 56 74 234 115 152 186 242 134 97 44]
		]
	]

	testSha224LongInputTwoUpdates [
		| ctx |

		ctx := NettleSha224 new.
		ctx init.

		self should: [
			ctx update: ('On 16 November 1797, ' asByteArray).
			ctx update: ('Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[38 108 184 77 71 236 95 51 14 216 36 157 157 147 235 55 125 20 56 74 234 115 152 186 242 134 97 44]
		]
	]




	testSha256Init [
		| ctx |

		self should: [
			ctx := NettleSha256 new.
			ctx init.
			true.
		]
	]

	testSha256EmptyDigest [
		| ctx |

		ctx := NettleSha256 new.
		ctx init.

		self should: [
			 ctx digest = #[227 176 196 66 152 252 28 20 154 251 244 200 153 111 185 36 39 174 65 228 100 155 147 76 164 149 153 27 120 82 184 85]
		]
	]

	testSha256ShortInput [
		| ctx |

		ctx := NettleSha256 new.
		ctx init.

		self should: [
			ctx update: ('Hallo' asByteArray).
			ctx digest = #[117 54 146 236 54 173 180 199 148 201 115 148 94 178 169 156 22 73 112 62 166 247 107 242 89 171 180 251 131 142 1 62]
		]
	]

	testSha256LongInputOneUpdate [
		| ctx |

		ctx := NettleSha256 new.
		ctx init.

		self should: [
			ctx update: ('On 16 November 1797, Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[239 112 137 108 233 83 72 227 233 44 101 206 238 60 158 206 198 8 88 54 52 70 44 223 224 68 75 215 238 30 168 107]
		]
	]

	testSha256LongInputTwoUpdates [
		| ctx |

		ctx := NettleSha256 new.
		ctx init.

		self should: [
			ctx update: ('On 16 November 1797, ' asByteArray).
			ctx update: ('Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[239 112 137 108 233 83 72 227 233 44 101 206 238 60 158 206 198 8 88 54 52 70 44 223 224 68 75 215 238 30 168 107]
		]
	]





	testSha384Init [
		| ctx |

		self should: [
			ctx := NettleSha384 new.
			ctx init.
			true.
		]
	]

	testSha384EmptyDigest [
		| ctx |

		ctx := NettleSha384 new.
		ctx init.

		self should: [
			 ctx digest = #[56 176 96 167 81 172 150 56 76 217 50 126 177 177 227 106 33 253 183 17 20 190 7 67 76 12 199 191 99 246 225 218 39 78 222 191 231 111 101 251 213 26 210 241 72 152 185 91]
		]
	]

	testSha384ShortInput [
		| ctx |

		ctx := NettleSha384 new.
		ctx init.

		self should: [
			ctx update: ('Hallo' asByteArray).
			ctx digest = #[151 99 77 234 110 33 4 223 39 8 145 71 62 120 196 143 221 231 194 166 92 208 2 246 250 111 6 8 13 78 153 0 54 110 150 1 38 81 143 203 14 151 50 19 169 55 211 119]
		]
	]

	testSha384LongInputOneUpdate [
		| ctx |

		ctx := NettleSha384 new.
		ctx init.

		self should: [
			ctx update: ('On 16 November 1797, Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[162 221 215 30 143 5 109 235 177 146 195 25 37 58 32 3 149 185 104 64 27 95 231 81 232 122 79 151 11 24 115 63 115 1 178 159 190 94 128 137 115 46 100 103 104 199 122 243]
		]
	]

	testSha384LongInputTwoUpdates [
		| ctx |

		ctx := NettleSha384 new.
		ctx init.

		self should: [
			ctx update: ('On 16 November 1797, ' asByteArray).
			ctx update: ('Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[162 221 215 30 143 5 109 235 177 146 195 25 37 58 32 3 149 185 104 64 27 95 231 81 232 122 79 151 11 24 115 63 115 1 178 159 190 94 128 137 115 46 100 103 104 199 122 243]
		]
	]





	testSha512Init [
		| ctx |

		self should: [
			ctx := NettleSha512 new.
			ctx init.
			true.
		]
	]

	testSha512EmptyDigest [
		| ctx |

		ctx := NettleSha512 new.
		ctx init.

		self should: [
			 ctx digest = #[207 131 225 53 126 239 184 189 241 84 40 80 214 109 128 7 214 32 228 5 11 87 21 220 131 244 169 33 211 108 233 206 71 208 209 60 93 133 242 176 255 131 24 210 135 126 236 47 99 185 49 189 71 65 122 129 165 56 50 122 249 39 218 62]
		]
	]

	testSha512ShortInput [
		| ctx |

		ctx := NettleSha512 new.
		ctx init.

		self should: [
			ctx update: ('Hallo' asByteArray).
			ctx digest = #[45 14 74 66 210 96 194 64 114 129 151 83 34 131 126 97 193 54 42 59 24 190 56 183 30 182 244 223 211 228 249 146 217 100 193 186 198 238 196 83 32 100 246 151 121 182 1 75 55 112 137 28 246 12 116 249 118 229 117 136 166 201 118 201]
		]
	]

	testSha512LongInputOneUpdate [
		| ctx |

		ctx := NettleSha512 new.
		ctx init.

		self should: [
			ctx update: ('On 16 November 1797, Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[246 89 116 123 118 73 4 140 59 10 212 103 101 102 3 232 224 65 255 136 175 87 61 4 65 45 134 187 210 133 55 195 127 249 177 254 208 137 2 38 39 170 20 62 56 125 57 167 133 113 9 113 7 145 2 40 88 32 86 141 150 17 179 255]
		]
	]

	testSha512LongInputTwoUpdates [
		| ctx |

		ctx := NettleSha512 new.
		ctx init.

		self should: [
			ctx update: ('On 16 November 1797, ' asByteArray).
			ctx update: ('Goethe slept in Erlangen.' asByteArray).
			ctx digest = #[246 89 116 123 118 73 4 140 59 10 212 103 101 102 3 232 224 65 255 136 175 87 61 4 65 45 134 187 210 133 55 195 127 249 177 254 208 137 2 38 39 170 20 62 56 125 57 167 133 113 9 113 7 145 2 40 88 32 86 141 150 17 179 255]
		]
	]
]