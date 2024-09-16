Return-Path: <cgroups+bounces-4893-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53A097A1DE
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 14:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141CC1C215F6
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 12:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E69155335;
	Mon, 16 Sep 2024 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sLYNvfuN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D14149C57;
	Mon, 16 Sep 2024 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488673; cv=none; b=IjqzL4N9IajvX+udPersw8F4ydt0BJyDApTY1UcxGsB6+44qutU5O7D++ANR+BOz99LGKLwdhGeyVlCCRny7yAxxRFqbT5DmxUK+q3dHbQ7DEh06Hn7zFuBWTjdD0oyaXNzvefAwgatlOVhTBP4ukdmSGzA8Fji06KdLiaFXOWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488673; c=relaxed/simple;
	bh=KF9V7WAKGEGo2sWoJRZr2rSfu6ylnZ/czmDbtV3+NuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1ki8RfssdIer3CmIIlgDo4tBa9cv+yT3O+cZrvCq2F5xlOJfOBrC6lmoKQ1QVN6/cJYfG3U5qDoeiZdxVYjx0TXHqsIrV/7kSQKJXhKdkzhTbSIAh237T1BZNgrbZ0fMJ5precGoufzS6+DCPmLHJBrn0Gsj0O+C0hpWtXjXtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sLYNvfuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70345C4CEC4;
	Mon, 16 Sep 2024 12:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726488672;
	bh=KF9V7WAKGEGo2sWoJRZr2rSfu6ylnZ/czmDbtV3+NuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLYNvfuNaX79BLvbx/w7aPIaJ3zn9U4ql1S6620qUF7fO+lK2+btvb59dFpmQqabc
	 h20zxoCCCiiHlffyv3i2A1QeMmxd3zd37vCdbsuhN5DfxbuakLrvMsc75hhbD9o6UU
	 0T5G1/8hfBYTAv2Eka3dmGo4w8aBB1GpBbrC0uZA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	cgroups@vger.kernel.org,
	Nadia Pinaeva <n.m.pinaeva@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 73/91] netfilter: nft_socket: make cgroupsv2 matching work with namespaces
Date: Mon, 16 Sep 2024 13:44:49 +0200
Message-ID: <20240916114226.881382740@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114224.509743970@linuxfoundation.org>
References: <20240916114224.509743970@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 7f3287db654395f9c5ddd246325ff7889f550286 ]

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

v2: use CONFIG_SOCK_CGROUP_DATA, eval function depends on it.
    (kernel test robot)

Cc: cgroups@vger.kernel.org
Fixes: e0bb96db96f8 ("netfilter: nft_socket: add support for cgroupsv2")
Reported-by: Nadia Pinaeva <n.m.pinaeva@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_socket.c | 41 +++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 765ffd6e06bc..12cdff640492 100644
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
@@ -174,9 +197,10 @@ static int nft_socket_init(const struct nft_ctx *ctx,
 	case NFT_SOCKET_MARK:
 		len = sizeof(u32);
 		break;
-#ifdef CONFIG_CGROUPS
+#ifdef CONFIG_SOCK_CGROUP_DATA
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
2.43.0




