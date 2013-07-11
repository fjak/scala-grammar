object foo {
	def op_==(x: Int) = x
	// this should be parsed as an application of op_== to 42
	op_==(42)
}