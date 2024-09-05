Return-Path: <cgroups+bounces-4712-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC05396D68A
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 12:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA801C25184
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 10:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792601991BE;
	Thu,  5 Sep 2024 10:58:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1D41990CE;
	Thu,  5 Sep 2024 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533909; cv=none; b=M2VGrnrkZcbwtiAXPVF/0Y/QZW6WvxqrjZIpe1QRyMEV2bMc/CVlMuNRNf1bQzmPW3IKdWXo9GBGp3vrwHhw2xn2IQfrIrP2AmAb3y1OJxa9xmH+piI9sIwJ7RWubJUOmUzdyGss9qmDTXdNA7QGaSixTUfjMmFzooXlfztXx1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533909; c=relaxed/simple;
	bh=n23+GOvO5Q0WlXN7R9TrouvSW8U2vaCfSAZ4VnN4Psg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgKRYIOoGcZl/jjOR9BiuGsTenw+E6T3BoLxJi/ASnjcJOfBszpNM77cHS0fwewFjcaC6SBqkF5nEnWg9wd7PYo+YgPmsuyUi5RST9TUqhlCQFh8jVGL0chK413jxoDTPqDaJq/JJsPpL/5RQ+ieiCxG0hSUVGEbdnzCZvx+eQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1smAC0-0004tt-WD; Thu, 05 Sep 2024 12:58:25 +0200
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	cgroups@vger.kernel.org,
	Nadia Pinaeva <n.m.pinaeva@gmail.com>
Subject: [PATCH nf 2/2] netfilter: nft_socket: make cgroupsv2 matching work with namespaces
Date: Thu,  5 Sep 2024 12:54:47 +0200
Message-ID: <20240905105451.28857-2-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240905105451.28857-1-fw@strlen.de>
References: <20240905105451.28857-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running in container environmment, /sys/fs/cgroup/ might not be
the real root node of the sk-attached cgroup.

Example:

In container:
% stat /sys//fs/cgroup/
Device: 0,21    Inode: 2214  ..
% stat /sys/fs/cgroup/foo
Device: 0,21    Inode: 2264  ..

The expectation would be for:

  nft add rule .. socket cgroupv2 level 1 "foo" counter

to match traffic from a process that got added to "foo" via
"echo $pid > /sys/fs/cgroup/foo/cgroup.procs".

However, 'level 3' is needed to make this work.

Seen from initial namespace, the complete hierarchy is:

% stat /sys/fs/cgroup/system.slice/docker-.../foo
  Device: 0,21    Inode: 2264 ..

i.e. hierarchy is
0    1               2              3
/ -> system.slice -> docker-1... -> foo

... but the container doesn't know that its "/" is the "docker-1.."
cgroup.  Current code will retrieve the 'system.slice' cgroup node
and store its kn->id in the destination register, so compare with
2264 ("foo" cgroup id) will not match.

Fetch "/" cgroup from ->init() and add its level to the level we try to
extract.  cgroup root-level is 0 for the init-namespace or the level
of the ancestor that is exposed as the cgroup root inside the container.

In the above case, cgrp->level of "/" resolved in the container is 2
(docker-1...scope/) and request for 'level 1' will get adjusted
to fetch the actual level (3).

Cc: cgroups@vger.kernel.org
Fixes: e0bb96db96f8 ("netfilter: nft_socket: add support for cgroupsv2")
Reported-by: Nadia Pinaeva <n.m.pinaeva@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_socket.c | 39 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 765ffd6e06bc..0e8367c8f280 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -9,7 +9,8 @@
 
 struct nft_socket {
 	enum nft_socket_keys		key:8;
-	u8				level;
+	u8				level;		/* cgroupv2 level to extract */
+	u8				level_user;	/* cgroupv2 level provided by userspace */
 	u8				len;
 	union {
 		u8			dreg;
@@ -53,6 +54,28 @@ nft_sock_get_eval_cgroupv2(u32 *dest, struct sock *sk, const struct nft_pktinfo
 	memcpy(dest, &cgid, sizeof(u64));
 	return true;
 }
+
+/* process context only, uses current->nsproxy. */
+static noinline int nft_socket_cgroup_subtree_level(void)
+{
+	struct cgroup *cgrp = cgroup_get_from_path("/");
+	int level;
+
+	if (!cgrp)
+		return -ENOENT;
+
+	level = cgrp->level;
+
+	cgroup_put(cgrp);
+
+	if (WARN_ON_ONCE(level > 255))
+		return -ERANGE;
+
+	if (WARN_ON_ONCE(level < 0))
+		return -EINVAL;
+
+	return level;
+}
 #endif
 
 static struct sock *nft_socket_do_lookup(const struct nft_pktinfo *pkt)
@@ -177,6 +200,7 @@ static int nft_socket_init(const struct nft_ctx *ctx,
 #ifdef CONFIG_CGROUPS
 	case NFT_SOCKET_CGROUPV2: {
 		unsigned int level;
+		int err;
 
 		if (!tb[NFTA_SOCKET_LEVEL])
 			return -EINVAL;
@@ -185,6 +209,17 @@ static int nft_socket_init(const struct nft_ctx *ctx,
 		if (level > 255)
 			return -EOPNOTSUPP;
 
+		err = nft_socket_cgroup_subtree_level();
+		if (err < 0)
+			return err;
+
+		priv->level_user = level;
+
+		level += err;
+		/* Implies a giant cgroup tree */
+		if (WARN_ON_ONCE(level > 255))
+			return -EOPNOTSUPP;
+
 		priv->level = level;
 		len = sizeof(u64);
 		break;
@@ -209,7 +244,7 @@ static int nft_socket_dump(struct sk_buff *skb,
 	if (nft_dump_register(skb, NFTA_SOCKET_DREG, priv->dreg))
 		return -1;
 	if (priv->key == NFT_SOCKET_CGROUPV2 &&
-	    nla_put_be32(skb, NFTA_SOCKET_LEVEL, htonl(priv->level)))
+	    nla_put_be32(skb, NFTA_SOCKET_LEVEL, htonl(priv->level_user)))
 		return -1;
 	return 0;
 }
-- 
2.44.2


