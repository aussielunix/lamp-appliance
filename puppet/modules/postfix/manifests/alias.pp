define postfix::alias( $recipient='mick@example.com', $ensure='present' ) {
  mailalias { $name:
    ensure    => $ensure,
    recipient => $recipient,
    notify    => Exec['newaliases']
  }
}

