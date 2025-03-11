Return-Path: <cgroups+bounces-6955-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B27AA5BA15
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 08:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAAC169FD7
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 07:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70DF22258F;
	Tue, 11 Mar 2025 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="W9KLok0V"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A791E7C06;
	Tue, 11 Mar 2025 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678955; cv=none; b=AKPqqDEUpfiXXQDwTf9or1C/LbcktzG6ZZjtOLkS/e3KprfBLISOXS4bv81tKQMVofoaP5SgNEBIidtUjYTuNAFZr/4+KkFg9t0WEHO5y4PlPgasEPOoOmnckosSeP06+hxUEK0UpuN2qkGxquKxtvZZJEqQxBLYV+8iSj85Uis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678955; c=relaxed/simple;
	bh=L/NDgxw3YHKa+KVzRO3zkwKugc1tQexZX5ChQyB505s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSiJtxaM4dzMLsMicCBz2KQ6XyW7Vbpbixv0PMUymHtj4VzKKTRH92E1CzBg9cW+j/rl9bB7Wnsd2ylibyS/rDbZZEkrYU/BO0kOsbFSwucZu2sqx1w//rkyanCbk7QFq7T3chjKw6CF0OjW3yYB2dC+A7SrX4dFAXNBmgdDye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=W9KLok0V; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741678954; x=1773214954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KwD7hDAnu1A18zDbCEL7ul6iQjiTgi0DciwxyZLKzks=;
  b=W9KLok0VGfnBm3q7pMy7ZQi7G549vpGuqPUcqMsl8qDFG9ITDl+d0AQW
   t8ZwK/6OlmnmQu3Ax3Y4KIiBRH9YayCfmoF0laWVSRTlHc9Lko3pOQmjo
   Io6ycQzn3ULYBNSWJvt9MTp7qxeuIsFw7nr6zKiZsQWibij1VExLs3ZQc
   8=;
X-IronPort-AV: E=Sophos;i="6.14,238,1736812800"; 
   d="scan'208";a="385499441"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 07:42:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:12921]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.245:2525] with esmtp (Farcaster)
 id b43a4ebb-f7de-4780-ab81-2f1fd88f4d97; Tue, 11 Mar 2025 07:42:31 +0000 (UTC)
X-Farcaster-Flow-ID: b43a4ebb-f7de-4780-ab81-2f1fd88f4d97
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Mar 2025 07:42:31 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.128.133) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Mar 2025 07:42:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <aleksandr.mikhalitsyn@canonical.com>
CC: <arnd@arndb.de>, <bluca@debian.org>, <brauner@kernel.org>,
	<cgroups@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<hannes@cmpxchg.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<leon@kernel.org>, <linux-kernel@vger.kernel.org>, <mkoutny@suse.com>,
	<mzxreary@0pointer.de>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<tj@kernel.org>, <willemb@google.com>
Subject: Re: [PATCH net-next 1/4] net: unix: print cgroup_id and peer_cgroup_id in fdinfo
Date: Tue, 11 Mar 2025 00:41:54 -0700
Message-ID: <20250311074218.5629-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309132821.103046-2-aleksandr.mikhalitsyn@canonical.com>
References: <20250309132821.103046-2-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Sun,  9 Mar 2025 14:28:12 +0100

Please add few sentences here, why this interface is needed,
why accessing peer sk's sk_cgrp_data is not racy (e.g. sk_cgrp_data
never changes after creation (I'm not sure this is the case though)),
etc.

In case this interface is racy for the use case, please drop the patch.


> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: "Michal Koutný" <mkoutny@suse.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>  net/unix/af_unix.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 7f8f3859cdb3..2b2c0036efc9 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -117,6 +117,7 @@
>  #include <linux/file.h>
>  #include <linux/btf_ids.h>
>  #include <linux/bpf-cgroup.h>
> +#include <linux/cgroup.h>
>  
>  static atomic_long_t unix_nr_socks;
>  static struct hlist_head bsd_socket_buckets[UNIX_HASH_SIZE / 2];
> @@ -861,6 +862,11 @@ static void unix_show_fdinfo(struct seq_file *m, struct socket *sock)
>  	int nr_fds = 0;
>  
>  	if (sk) {
> +#ifdef CONFIG_SOCK_CGROUP_DATA
> +		struct sock *peer;
> +		u64 sk_cgroup_id = 0;

Please keep reverse xmas tree order for net patches.
https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

Also, no need to initialise sk_cgroup_id, so it should be:

	struct sock *peer;
	u64 sk_cgroup_id;


> +#endif
> +
>  		s_state = READ_ONCE(sk->sk_state);
>  		u = unix_sk(sk);
>  
> @@ -874,6 +880,21 @@ static void unix_show_fdinfo(struct seq_file *m, struct socket *sock)
>  			nr_fds = unix_count_nr_fds(sk);
>  
>  		seq_printf(m, "scm_fds: %u\n", nr_fds);
> +
> +#ifdef CONFIG_SOCK_CGROUP_DATA
> +		sk_cgroup_id = cgroup_id(sock_cgroup_ptr(&sk->sk_cgrp_data));
> +		seq_printf(m, "cgroup_id: %llu\n", sk_cgroup_id);
> +
> +		peer = unix_peer_get(sk);
> +		if (peer) {
> +			u64 peer_cgroup_id = 0;

Same here, no need to initialise peer_cgroup_id.


> +
> +			peer_cgroup_id = cgroup_id(sock_cgroup_ptr(&peer->sk_cgrp_data));
> +			sock_put(peer);
> +
> +			seq_printf(m, "peer_cgroup_id: %llu\n", peer_cgroup_id);
> +		}
> +#endif
>  	}
>  }
>  #else
> -- 
> 2.43.0

Thanks!

