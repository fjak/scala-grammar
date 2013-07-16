object foo {
  _ match {
    case Empty | Failure(_, _, _) => false
  }

  blorg match {
    case a~lb~c => foo
  }

  def toBoolean(in: Any): Boolean = {
    in match {
      case null => false
      case b : Boolean => b
      case i: Int => i != 0
      case lo: Long => lo != 0
      case n : Number => n.intValue != 0
      case s : String => {
        val sl = s.toLowerCase
        if (sl.length == 0) false
        else {
          if (sl.charAt(0) == 't') true
          else if (sl == "yes") true
          else toInt(s) != 0
        }
      }
      case None => false
      case Empty | Failure(_, _, _) => false
      case Full(n) => toBoolean(n)
      case Some(n) => toBoolean(n)
      case x :: xs => toBoolean(x)
      case o => toBoolean(o.toString)
    }
  }
}
