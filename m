Return-Path: <cgroups+bounces-6904-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A501AA58440
	for <lists+cgroups@lfdr.de>; Sun,  9 Mar 2025 14:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD0A16AC23
	for <lists+cgroups@lfdr.de>; Sun,  9 Mar 2025 13:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DFC1DA0E0;
	Sun,  9 Mar 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="H0VzkN6s"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112A1DFE8
	for <cgroups@vger.kernel.org>; Sun,  9 Mar 2025 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741526989; cv=none; b=qlibrt/XcqYSEjXHjm3i2KRjRiWxy0j5zfVQNQkAlchA0qALywDLgYIqSisrWoHDYefkS9o78y3u7LOhez5i4YcP5BhiU3YqFiac/fcQaIUNZhXCUQ2N9lsqPULv799Gv03qiHiqWW1mCWMwWHILAvBov2+GMsGA4aHicvjmPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741526989; c=relaxed/simple;
	bh=vnuWxUByDaK53vFXT9n7vqyzxlt2qtW+8f94W06a7gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWKJml+cGXeppSncaT0326zt0w8TyyVhzhYqBb2wEVyQt9ynN0ZqyFkvYgmR1Cqy0/vilTTq1dWZk7XXXqt9Tb46fAF+WNw9p5+kkm2HzEACJkQNJx6YDPkumNxb6zgPuNvq577B0Wh/jyemXZ0SH70HxrTvRvZsUz+uhCXp4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=H0VzkN6s; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 27DBF3FE2C
	for <cgroups@vger.kernel.org>; Sun,  9 Mar 2025 13:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741526982;
	bh=shYgV0qT/lqjUQTrvdmbHNW7lzUO23tYACdmBi90n70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=H0VzkN6sGHWgjqmuCE/jJLzf7z+Hsukx9CzPCt1BWMnInd8a6WmEjF2ZJLHVm730N
	 z6pTws4qkdm0Djg/24mVbbecLDolZ4spbGN43IZoUTo7pQH3ohqL6nF3ypzCYEvSEJ
	 RvVuPU/bXZxeSbcI43DHxbo5mRC18aR0xt5qr2eyk/JjviLK2CPGwKllgD3HYamXTn
	 4EptslktqAOekglwbBr1Dc8SmDQ/5scbCN/Vqd5fJaQutRumMvq89qis6hHjQrjzqW
	 rB2unfkiLp1yBDDGV35oAas4n+PIzthx+Qtww50MURL5/NdsyWG1tfpkT5rZjQy5z7
	 xBdpN4r69eDHg==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab39f65dc10so433921266b.1
        for <cgroups@vger.kernel.org>; Sun, 09 Mar 2025 06:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741526979; x=1742131779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shYgV0qT/lqjUQTrvdmbHNW7lzUO23tYACdmBi90n70=;
        b=kVfPPB4OygtDuzmXaPtD4lONyjS7AwlPyzHO//YXXbCJbX9pMmMXn86auUIVHwSs5z
         GP8z5vzpCJGzNXJOvvIXmbUTOoBlStOYtASFGJEGqo3BCWl7RLHSl3jcPKPCOrIGlAhm
         LdW9ux4VJsguJU2ahFcQ34LHZP3/Fdb/0dFDVPfKYeDsvxer3EckBUydaQKGedAqL5S8
         22KUN0StD+SxNGzIKBbUUuagM6XgVqZFo5WdZJTSqlaYrzzxwj5JWv0rYFA4sNHoR87m
         G/Sp1TMfzipvFJEUUTB/yXcckKvqkJbb/uTlogLhQYr+I62/v0Sw64gWQu0YBSXUTb6w
         bI+A==
X-Forwarded-Encrypted: i=1; AJvYcCUkvh5coRzB/aEms2Ob8Atxephhy2IBzbnmGt8hfEJpw2d1GhpoUgl7yY9k+0+skwJDRFFM8DN7@vger.kernel.org
X-Gm-Message-State: AOJu0YxygREbeyAPi5EaW6LXDEPMh7i7UDARZz/4mGh+eN2+0YkWX2dm
	yvvG1hHMrnJbqnyRVB0ACyzIWyy/2u+HGlPWxcxgT7WKSTPc3h23MbIrKn+ExePIJtpCS8qpxeP
	rokN6jGw5FLnANKiI3FZGgaorc7XLFu5awiESPoAhPWd1MJJ/PfQl4y029saG3b+yRILggu0=
X-Gm-Gg: ASbGnctkmZx9BcxtcwU+08LD8ke6Fu2uCvGdpiHJdmqpgemJyxR50k28q6riNmm4J8b
	6OiPZoktfj3PLzFojl8gUZLaD1XMreBcOeaHbGBCLC8/bEVrwXlmgPwiMHOCps9nK6HrHL4dVd4
	jnXJgYhAr30jn80A3Rjw5MKLFrKGcjZQGL5SCiSYc24oD+9z8JGAusiDKch+4Rc0i88Nxuh82AS
	Et9Zd3v2no7ST6Urp/p+fvm8y2WWe+r8azfje+OiItNMP3rchwyAGZLPGhizt+aiJZhDqjt04ie
	nBdj62cpudBhRtylI52VC3rDiTqy6Z0vkHtIJbX5P0uMTn9DLfiXjYkyT+HjWLqCcy28uxBrxjG
	9Yxlsdq5MalvNE36mgg==
X-Received: by 2002:a17:907:c302:b0:ac2:f93:b7c5 with SMTP id a640c23a62f3a-ac2526e1ba9mr1073987766b.31.1741526979548;
        Sun, 09 Mar 2025 06:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWS1LQrRdoibpiP6escIaOL/a7XzBpJqfiCaikM73Pa+IXdnzBUWE6E4F2v53XQL0h2fMQ5g==
X-Received: by 2002:a17:907:c302:b0:ac2:f93:b7c5 with SMTP id a640c23a62f3a-ac2526e1ba9mr1073984866b.31.1741526979165;
        Sun, 09 Mar 2025 06:29:39 -0700 (PDT)
Received: from localhost.localdomain (ipbcc0714d.dynamic.kabel-deutschland.de. [188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25943f55csm435897366b.137.2025.03.09.06.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:29:38 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH net-next 1/4] net: unix: print cgroup_id and peer_cgroup_id in fdinfo
Date: Sun,  9 Mar 2025 14:28:12 +0100
Message-ID: <20250309132821.103046-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutný" <mkoutny@suse.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 net/unix/af_unix.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 7f8f3859cdb3..2b2c0036efc9 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -117,6 +117,7 @@
 #include <linux/file.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf-cgroup.h>
+#include <linux/cgroup.h>
 
 static atomic_long_t unix_nr_socks;
 static struct hlist_head bsd_socket_buckets[UNIX_HASH_SIZE / 2];
@@ -861,6 +862,11 @@ static void unix_show_fdinfo(struct seq_file *m, struct socket *sock)
 	int nr_fds = 0;
 
 	if (sk) {
+#ifdef CONFIG_SOCK_CGROUP_DATA
+		struct sock *peer;
+		u64 sk_cgroup_id = 0;
+#endif
+
 		s_state = READ_ONCE(sk->sk_state);
 		u = unix_sk(sk);
 
@@ -874,6 +880,21 @@ static void unix_show_fdinfo(struct seq_file *m, struct socket *sock)
 			nr_fds = unix_count_nr_fds(sk);
 
 		seq_printf(m, "scm_fds: %u\n", nr_fds);
+
+#ifdef CONFIG_SOCK_CGROUP_DATA
+		sk_cgroup_id = cgroup_id(sock_cgroup_ptr(&sk->sk_cgrp_data));
+		seq_printf(m, "cgroup_id: %llu\n", sk_cgroup_id);
+
+		peer = unix_peer_get(sk);
+		if (peer) {
+			u64 peer_cgroup_id = 0;
+
+			peer_cgroup_id = cgroup_id(sock_cgroup_ptr(&peer->sk_cgrp_data));
+			sock_put(peer);
+
+			seq_printf(m, "peer_cgroup_id: %llu\n", peer_cgroup_id);
+		}
+#endif
 	}
 }
 #else
-- 
2.43.0


