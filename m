Return-Path: <cgroups+bounces-6954-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6A0A5B9DF
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 08:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05FDB7A2703
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 07:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9882222CE;
	Tue, 11 Mar 2025 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="o4BOwYmF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED53B1E9B34;
	Tue, 11 Mar 2025 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678469; cv=none; b=h3ykOAaCWt0GASasYcxlXH1LHz4LGEXR56bbWDoxbmFi57X0rmdp3YRwEoBuwOyE+YFMuSiblxQoBwJWLdhIvI5CM+kW6JP6kYm6oiiCQ3KIM+wZVJw++Sq4uWM9kRkpmDz507bT88lzppEMDsnQ0RjRH2qBmFzbnfpm3loZQwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678469; c=relaxed/simple;
	bh=kVvrxY3JMeDPMJgRP7JSEynJw9qfMzi7iYOaRLKRS9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXSDG4lmU4/E69pBwQnEP364gEcioEyGMMQdv9I7PQlzYohDptCcqXaph15oU3a1LyFJ0sTXax4ih1HQuKcP9jNIvCTeBtQYIMIikpH08jhW9f4/SaE74IvoABMraW9rEg21oYWOSIVfSa2yYsJSwljszvrQl/vC7SwiqYcbEL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=o4BOwYmF; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741678468; x=1773214468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xlDClWHGShGxGM1y8gAW/SPX2EQ0Tt7MSneEYb8X5I0=;
  b=o4BOwYmFWzyQ1qYeBsx/1mRT08P69MBGOnYNuA96JJJCTdUXk2cCzHSZ
   RH1ZHGiuOMUaIQ1P60yJqefSn0QW600sL3EVuN9sBeqEAD+iwNoBZYYQg
   FMnmwZ2tIzBvjILTh9Nxq2GUMGwzvzurN7U7xoWdfxqAFDFgA7ZRblgYf
   g=;
X-IronPort-AV: E=Sophos;i="6.14,238,1736812800"; 
   d="scan'208";a="479315209"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 07:34:24 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:21378]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.90:2525] with esmtp (Farcaster)
 id 5162b928-32f7-4afa-b373-73148ef83c87; Tue, 11 Mar 2025 07:34:23 +0000 (UTC)
X-Farcaster-Flow-ID: 5162b928-32f7-4afa-b373-73148ef83c87
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Mar 2025 07:34:23 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.128.133) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Mar 2025 07:34:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <aleksandr.mikhalitsyn@canonical.com>
CC: <arnd@arndb.de>, <bluca@debian.org>, <brauner@kernel.org>,
	<cgroups@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<hannes@cmpxchg.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<leon@kernel.org>, <linux-kernel@vger.kernel.org>, <mkoutny@suse.com>,
	<mzxreary@0pointer.de>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <tj@kernel.org>, <willemb@google.com>
Subject: Re: [PATCH net-next 0/4] Add getsockopt(SO_PEERCGROUPID) and fdinfo API to retreive socket's peer cgroup id
Date: Tue, 11 Mar 2025 00:33:48 -0700
Message-ID: <20250311073411.4565-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Sun,  9 Mar 2025 14:28:11 +0100
> 1. Add socket cgroup id and socket's peer cgroup id in socket's fdinfo

Why do you want to add yet another racy interface ?


> 2. Add SO_PEERCGROUPID which allows to retrieve socket's peer cgroup id
> 3. Add SO_PEERCGROUPID kselftest
> 
> Generally speaking, this API allows race-free resolution of socket's peer cgroup id.
> Currently, to do that SCM_CREDENTIALS/SCM_PIDFD -> pid -> /proc/<pid>/cgroup sequence
> is used which is racy.

Few more words about the race (recycling pid ?) would be appreciated.

I somewhat assumed pid is not recycled until all of its pidfd are
close()d, but sounds like no ?


> 
> As we don't add any new state to the socket itself there is no potential locking issues
> or performance problems. We use already existing sk->sk_cgrp_data.
> 
> We already have analogical interfaces to retrieve this
> information:
> - inet_diag: INET_DIAG_CGROUP_ID
> - eBPF: bpf_sk_cgroup_id
> 
> Having getsockopt() interface makes sense for many applications, because using eBPF is
> not always an option, while inet_diag has obvious complexety and performance drawbacks
> if we only want to get this specific info for one specific socket.

If it's limited to the connect()ed peer, I'd add UNIX_DIAG_CGROUP_ID
and UNIX_DIAG_PEER_CGROUP_ID instead.  Then also ss can use that easily.

