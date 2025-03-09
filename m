Return-Path: <cgroups+bounces-6906-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD8AA58447
	for <lists+cgroups@lfdr.de>; Sun,  9 Mar 2025 14:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D8816B4D7
	for <lists+cgroups@lfdr.de>; Sun,  9 Mar 2025 13:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EDA1DE3C2;
	Sun,  9 Mar 2025 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="l83+c0/A"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305FE1DE2B3
	for <cgroups@vger.kernel.org>; Sun,  9 Mar 2025 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527001; cv=none; b=P+veqPr/WXDZXIVOBJxfNvzOP/jZljHS1+RTHVftEDPRsCz7Y+Rs0WYBWAQdJhCoNG0f5hwH740RY44NFbWEHZSki+VOxPpgjpQyCNm9hKL16wGCV/wtY0XYwbSo01olT9yCBIbLIYC0Rnqo+lkybyvwzdrcSWgsMqCd9Sd1dwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527001; c=relaxed/simple;
	bh=h11slZywu67PPCzd8E5r1pZxOSwbTAwOByW1hwfHQ8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJC52q/5T9GVzqwLgMB/AVOMfU4Ruye99oQhdvSjOegMhIwp+zl5F4TLdN7qNGDEeqay0/4o77DNwnEMDCPK93v0hKSDXMRoEXSy5TUMBWwWfIgQrSiDFUiQRlpavegn8m6bEwiJXp5UM0/E9TRa4FDaa1ptGeFh/idTgYMZgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=l83+c0/A; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D86BC3FCE0
	for <cgroups@vger.kernel.org>; Sun,  9 Mar 2025 13:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741526985;
	bh=oUkDN9VrMm5b6Y+/DOvznDBPjXORLJgfeSeYgeNTS6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=l83+c0/A8M61p+9UQcsB+BkDsBldAvMMGtwwoYaK6ofRBnNLxuIMpapeU7OTgIQcq
	 WpHNEr9PvuB+YCYOuXm37uZ9A1nSZik8M1Q5+ygCk44Dfzm72Kt6nZFt8GhjkfkvFb
	 DURGKE6QGpgwI+SYmfJIZxtQ9yQiCOGi9QQHVcq/f3PcsjpxBHyGxC2febLzLWwmJm
	 PWlYuViMrHbcBZ/e0wM+rT2xkLb0qkMtfiPMIkwLUDIXLLanKQ8VgyH7Zk2iFC0M3p
	 yXXD8UD4LbzjcDO/dTAHKVA9CuNzc+0XNIS3/7sC91Ab8XrTGw6PAh2XrdB1QiZ0LG
	 EAwzdokDYTeoQ==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab39f65dc10so433922866b.1
        for <cgroups@vger.kernel.org>; Sun, 09 Mar 2025 06:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741526981; x=1742131781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUkDN9VrMm5b6Y+/DOvznDBPjXORLJgfeSeYgeNTS6Y=;
        b=t7drzxHsNJUIeTM2P+Dc3I4EzkEhdzv15ORVTFWMXhoql17T9DzLVC6quGTBLEBSu9
         enPQ4qpknfsoMLtP41YLbqw97YCquxbySg9R9K9NqTI8hyVYvLTKdXwqK2e7L/pOSF8Q
         pb4oE0WKbr3lhJt9j3F/LrAbDHsEAntD2bym/au+eEoerOU8GQs2l0rv38nl8zA4tGl2
         EQI3slWSUobQwUkHKQEd9vN4pwWIFr6AMRP2qn8luLHl85n16R6AbyFhfdwKNFwDRnI/
         TG7usw4S5OtpfcpcST6ciuNDOyMqgoVkwGhLoaS4K0jlmTH4OT2OYoR3aoc9wRYqGjj7
         sVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUumY69AvaJ+BctMM61U6DtIxLUcNa+PAN3c6XbIVc7caSRxuvMPUaRxWrjf6Oy6j71fDsvWc8v@vger.kernel.org
X-Gm-Message-State: AOJu0YxTVTROJsyPkWKNa/mhRalqIhxgAXWuKEC7MF8RuW+Ue/Go3VkT
	CS6bZRg17EKpKWzWUVCtJGXTXoqfa6iU+zEt9gXZIKRXo3nMqIyJUNsGftTJxaUMzbymJ7FPDGY
	Oi688Zv6AusbwmJ5pNjYDvmF/jnNIZBqViidY3aRErH+hyQsphKDT2kP5cogk/VxaEqYxMzU=
X-Gm-Gg: ASbGncuoE0nYGniPOFyWzYZzV5CQCS1AR2cfcaDP+Z2NbSPerOiRdux8+C4a4LoULg/
	gChDKuoG8y2zgekOar2Qf9dI/c5fSmsbigFoNULdb2MkroA2OLYFuKTbr6e2we9wvjfq7fB7Eu5
	anbvQSrW2/MstxxqCCzLLDyDuVtR8zKSopCXswHExzaSONFlbyh/3G3Rd6432Q0fIvB4MTh9pkM
	khnunj84lc3SAZftwNEGnOyTLnRh2baUcXH6S+igbbhcvna/2Sj/IrtPUAHx9T0t9tnJDFVrfT5
	oTHR2EJkjmdlFycDjJzhDs0NTcH+8USzy2O1FF1poyt+Ayc/rpSt2IY2FmlB1fxH8obKttduPef
	/FV7m1geG4yrIH1fXCg==
X-Received: by 2002:a17:907:9615:b0:ac2:9c7d:e129 with SMTP id a640c23a62f3a-ac29c7dee94mr115089766b.38.1741526981525;
        Sun, 09 Mar 2025 06:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnWyfFVWjU228SRznBeLkPmsqMd2onjEQ1MWjIegB/cFAZnvOBfloK324qPC2AGva8B49jNg==
X-Received: by 2002:a17:907:9615:b0:ac2:9c7d:e129 with SMTP id a640c23a62f3a-ac29c7dee94mr115085566b.38.1741526981136;
        Sun, 09 Mar 2025 06:29:41 -0700 (PDT)
Received: from localhost.localdomain (ipbcc0714d.dynamic.kabel-deutschland.de. [188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25943f55csm435897366b.137.2025.03.09.06.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:29:40 -0700 (PDT)
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
Subject: [PATCH net-next 2/4] net: core: add getsockopt SO_PEERCGROUPID
Date: Sun,  9 Mar 2025 14:28:13 +0100
Message-ID: <20250309132821.103046-3-aleksandr.mikhalitsyn@canonical.com>
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

Add SO_PEERCGROUPID which allows to get cgroup_id
for a socket.

We already have analogical interfaces to retrieve this
information:
- inet_diag: INET_DIAG_CGROUP_ID
- eBPF: bpf_sk_cgroup_id

Having getsockopt() interface makes sense for many
applications, because using eBPF is not always an option,
while inet_diag has obvious complexety and performance drawbacks
if we only want to get this specific info for one specific socket.

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
 arch/alpha/include/uapi/asm/socket.h    |  2 +
 arch/mips/include/uapi/asm/socket.h     |  2 +
 arch/parisc/include/uapi/asm/socket.h   |  2 +
 arch/sparc/include/uapi/asm/socket.h    |  2 +
 include/uapi/asm-generic/socket.h       |  2 +
 net/core/sock.c                         | 17 +++++++
 net/unix/af_unix.c                      | 63 +++++++++++++++++++++++++
 tools/include/uapi/asm-generic/socket.h |  2 +
 8 files changed, 92 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 3df5f2dd4c0f..58ce457b2c09 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -150,6 +150,8 @@
 
 #define SO_RCVPRIORITY		82
 
+#define SO_PEERCGROUPID		83
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 22fa8f19924a..823fa67f7d79 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -161,6 +161,8 @@
 
 #define SO_RCVPRIORITY		82
 
+#define SO_PEERCGROUPID		83
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index aa9cd4b951fe..1ee2e858d177 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -142,6 +142,8 @@
 
 #define SO_RCVPRIORITY		0x404D
 
+#define SO_PEERCGROUPID		0x404E
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 5b464a568664..2fe7d0c48a63 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -143,6 +143,8 @@
 
 #define SO_RCVPRIORITY           0x005b
 
+#define SO_PEERCGROUPID          0x005c
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index aa5016ff3d91..903904bb537c 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -145,6 +145,8 @@
 
 #define SO_RCVPRIORITY		82
 
+#define SO_PEERCGROUPID		83
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/core/sock.c b/net/core/sock.c
index a0598518ce89..6dc0b1a8367b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1946,6 +1946,23 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		goto lenout;
 	}
 
+#ifdef CONFIG_SOCK_CGROUP_DATA
+	case SO_PEERCGROUPID:
+	{
+		const struct proto_ops *ops;
+
+		if (sk->sk_family != AF_UNIX)
+			return -EOPNOTSUPP;
+
+		ops = READ_ONCE(sock->ops);
+		if (!ops->getsockopt)
+			return -EOPNOTSUPP;
+
+		return ops->getsockopt(sock, SOL_SOCKET, optname, optval.user,
+				       optlen.user);
+	}
+#endif
+
 	/* Dubious BSD thing... Probably nobody even uses it, but
 	 * the UNIX standard wants it for whatever reason... -DaveM
 	 */
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 2b2c0036efc9..3455f38f033d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -901,6 +901,66 @@ static void unix_show_fdinfo(struct seq_file *m, struct socket *sock)
 #define unix_show_fdinfo NULL
 #endif
 
+static int unix_getsockopt(struct socket *sock, int level, int optname,
+			   char __user *optval, int __user *optlen)
+{
+	struct sock *sk = sock->sk;
+
+	union {
+		int val;
+		u64 val64;
+	} v;
+
+	int lv = sizeof(int);
+	int len;
+
+	if (level != SOL_SOCKET)
+		return -ENOPROTOOPT;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	if (len < 0)
+		return -EINVAL;
+
+	memset(&v, 0, sizeof(v));
+
+	switch (optname) {
+#ifdef CONFIG_SOCK_CGROUP_DATA
+	case SO_PEERCGROUPID:
+	{
+		struct sock *peer;
+		u64 peer_cgroup_id = 0;
+
+		lv = sizeof(u64);
+		if (len < lv)
+			return -EINVAL;
+
+		peer = unix_peer_get(sk);
+		if (!peer)
+			return -ENODATA;
+
+		peer_cgroup_id = cgroup_id(sock_cgroup_ptr(&peer->sk_cgrp_data));
+		sock_put(peer);
+
+		v.val64 = peer_cgroup_id;
+		break;
+	}
+#endif
+	default:
+		return -ENOPROTOOPT;
+	}
+
+	if (len > lv)
+		len = lv;
+	if (copy_to_user(optval, &v, len))
+		return -EFAULT;
+	if (put_user(len, optlen))
+		return -EFAULT;
+
+	return 0;
+}
+
 static const struct proto_ops unix_stream_ops = {
 	.family =	PF_UNIX,
 	.owner =	THIS_MODULE,
@@ -910,6 +970,7 @@ static const struct proto_ops unix_stream_ops = {
 	.socketpair =	unix_socketpair,
 	.accept =	unix_accept,
 	.getname =	unix_getname,
+	.getsockopt =	unix_getsockopt,
 	.poll =		unix_poll,
 	.ioctl =	unix_ioctl,
 #ifdef CONFIG_COMPAT
@@ -935,6 +996,7 @@ static const struct proto_ops unix_dgram_ops = {
 	.socketpair =	unix_socketpair,
 	.accept =	sock_no_accept,
 	.getname =	unix_getname,
+	.getsockopt =	unix_getsockopt,
 	.poll =		unix_dgram_poll,
 	.ioctl =	unix_ioctl,
 #ifdef CONFIG_COMPAT
@@ -959,6 +1021,7 @@ static const struct proto_ops unix_seqpacket_ops = {
 	.socketpair =	unix_socketpair,
 	.accept =	unix_accept,
 	.getname =	unix_getname,
+	.getsockopt =	unix_getsockopt,
 	.poll =		unix_dgram_poll,
 	.ioctl =	unix_ioctl,
 #ifdef CONFIG_COMPAT
diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
index aa5016ff3d91..903904bb537c 100644
--- a/tools/include/uapi/asm-generic/socket.h
+++ b/tools/include/uapi/asm-generic/socket.h
@@ -145,6 +145,8 @@
 
 #define SO_RCVPRIORITY		82
 
+#define SO_PEERCGROUPID		83
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
-- 
2.43.0


