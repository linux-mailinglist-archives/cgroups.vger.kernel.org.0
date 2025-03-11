Return-Path: <cgroups+bounces-6956-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90958A5BA43
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 08:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392203AB4E2
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 07:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DAC223324;
	Tue, 11 Mar 2025 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="E9N/RSyC"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB3C1EE02A;
	Tue, 11 Mar 2025 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741679629; cv=none; b=DY18WaVbJehXoCDKR6xFN1mj16iA5jOlaq84vvSQ0refdckn+8DHr3dU16iSYbREFhLF+hjrNHpj5GpJAD1sjXbH31iBRhGTB4px8wPkEeHqjV0I/iMYCCX4RE1Jz+DSQGILsGPUu1OFdAxpDF5eEyA+cZGXH7Nrg8NpAXXbeRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741679629; c=relaxed/simple;
	bh=x9XDyVJn03Rql/R2rth/EfVSFW+l1AD/+rZGQBYPBhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAV4mQ5SAI51/a2Sc3CAW2YTBIiE5Au8KeRxksLh8DlW054wIiHGnI3RDGFvk0piwQmhB1NAPUX1PvClTYFFiwwGipZVK55BpnaM/NiTHn1mM7x/SOIwCyDBO4z3b8r8o7LV0NlEQzlTrAjfwk6QaXsbXPJKrncESVfx4E49ESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=E9N/RSyC; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741679628; x=1773215628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WkX7OsaTzQQg11cWksiDFddz5eBRnDnzqm29ot2J+FU=;
  b=E9N/RSyCDIvI7DgWlUiIIT7RY6jg3dJjqh5FNWHbzaCyGuTI0AwzFqw8
   6RKpfFLYZ+SYcdYLpZ8wxm3v0ypXhzXkr0Jo7NOj+Z62jize2mLWA99P1
   jhEbqnmgk34xhrMjXPTmBSa/zTM0MFfzLC9w1CyxE0Lqy8YG8Y42HOEiX
   I=;
X-IronPort-AV: E=Sophos;i="6.14,238,1736812800"; 
   d="scan'208";a="278289451"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 07:53:44 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:38004]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.40:2525] with esmtp (Farcaster)
 id 72aaa0b0-397f-4d35-add6-85388b07c89e; Tue, 11 Mar 2025 07:53:42 +0000 (UTC)
X-Farcaster-Flow-ID: 72aaa0b0-397f-4d35-add6-85388b07c89e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Mar 2025 07:53:42 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.128.133) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Mar 2025 07:53:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <aleksandr.mikhalitsyn@canonical.com>
CC: <arnd@arndb.de>, <bluca@debian.org>, <brauner@kernel.org>,
	<cgroups@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<hannes@cmpxchg.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<leon@kernel.org>, <linux-kernel@vger.kernel.org>, <mkoutny@suse.com>,
	<mzxreary@0pointer.de>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<tj@kernel.org>, <willemb@google.com>
Subject: Re: [PATCH net-next 2/4] net: core: add getsockopt SO_PEERCGROUPID
Date: Tue, 11 Mar 2025 00:52:58 -0700
Message-ID: <20250311075330.7189-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309132821.103046-3-aleksandr.mikhalitsyn@canonical.com>
References: <20250309132821.103046-3-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Sun,  9 Mar 2025 14:28:13 +0100
> Add SO_PEERCGROUPID which allows to get cgroup_id
> for a socket.

This looks useless for SOCK_DGRAM as the server can't have a
peer for clients to send() or connect() (see unix_may_send()).

Is there any reason to support only the connect()ed peer ?
It seems the uAPI group expects to retrieve data per message
as SCM_CGROUPID.


> 
> We already have analogical interfaces to retrieve this
> information:
> - inet_diag: INET_DIAG_CGROUP_ID
> - eBPF: bpf_sk_cgroup_id
> 
> Having getsockopt() interface makes sense for many
> applications, because using eBPF is not always an option,
> while inet_diag has obvious complexety and performance drawbacks
> if we only want to get this specific info for one specific socket.
[...]
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 2b2c0036efc9..3455f38f033d 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -901,6 +901,66 @@ static void unix_show_fdinfo(struct seq_file *m, struct socket *sock)
>  #define unix_show_fdinfo NULL
>  #endif
>  
> +static int unix_getsockopt(struct socket *sock, int level, int optname,
> +			   char __user *optval, int __user *optlen)
> +{
> +	struct sock *sk = sock->sk;
> +
> +	union {
> +		int val;
> +		u64 val64;

As Willem pointed out, simply use val64 only.


> +	} v;
> +
> +	int lv = sizeof(int);
> +	int len;
> +
> +	if (level != SOL_SOCKET)
> +		return -ENOPROTOOPT;
> +
> +	if (get_user(len, optlen))
> +		return -EFAULT;
> +
> +	if (len < 0)
> +		return -EINVAL;
> +
> +	memset(&v, 0, sizeof(v));
> +
> +	switch (optname) {
> +#ifdef CONFIG_SOCK_CGROUP_DATA
> +	case SO_PEERCGROUPID:
> +	{
> +		struct sock *peer;
> +		u64 peer_cgroup_id = 0;

Same remarks in patch 1, reverse xmas tree order, and no
initialisation needed.


> +
> +		lv = sizeof(u64);
> +		if (len < lv)
> +			return -EINVAL;
> +
> +		peer = unix_peer_get(sk);
> +		if (!peer)
> +			return -ENODATA;
> +
> +		peer_cgroup_id = cgroup_id(sock_cgroup_ptr(&peer->sk_cgrp_data));
> +		sock_put(peer);
> +
> +		v.val64 = peer_cgroup_id;
> +		break;
> +	}
> +#endif
> +	default:
> +		return -ENOPROTOOPT;
> +	}
> +
> +	if (len > lv)
> +		len = lv;
> +	if (copy_to_user(optval, &v, len))
> +		return -EFAULT;
> +	if (put_user(len, optlen))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +

