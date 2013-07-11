object foo {
	_ match {
		case Empty | Failure(_, _, _) => false
	}
}