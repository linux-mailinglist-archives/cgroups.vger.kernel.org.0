Return-Path: <cgroups+bounces-6275-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFBAA1BBA4
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 18:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1413AF1F7
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 17:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DA51D88D3;
	Fri, 24 Jan 2025 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kDYtqMDi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ni43ofM0"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3F31AF0DE;
	Fri, 24 Jan 2025 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740783; cv=none; b=G2646jzka1bHEcVNYM89aD7Ij7ZR206IvjCv9QOPlCFv0IvEY2HBYpp20mmlz8PmVXvqfoKiYLcAjLIQbglzHUruRCRJwbLR9k7it4ZA+mVOST9+MgOreMUx7hipBU9xVIvxUxj2U23pJvK7PmRZNk/HZlLrnMo+4ZDvQndAUkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740783; c=relaxed/simple;
	bh=ku42EoIv/AsyIaoNjw5sU2/jUpNA6Lc/Ve+R1j+yjyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gm/0Lc46/R64hc2BURdMeUqlEA8F9uxaGtQMsa5FY7QA4FfT8X7nXVeAqSHQzzgGwVi4b3tYkQ1vS48U8H/nMUlKM8rK0XqkULAqfXH0UyR38T73Mh+4sUrN1uIcagihMYxpbxIgIgrhCpiZneqf3hIRLD+X3mixPjApFCZqYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kDYtqMDi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ni43ofM0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737740780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdqxts0Ly384h227Zw0Y2lHPu+J1RSM2dHrUxtWsIDo=;
	b=kDYtqMDih82ANtMvQ8nNh3qnpgZjVzOhJ4CfKFhMZ8DN8zbTnCzpya4/CIGZxhK5872kqi
	0oUAQ2tpMICyTTbscmIWECzW1OXPka+JLUBOrfF5nnN0rwqhXtu8StAju+CQpZCb2iKKKw
	lfqLOBTjmRd0lZCzflCpk/Or7DC7QRYjn+XCOwOcdnFMjXLfo9uSw3AguCegTbBRk5vaKU
	TbyV2CdiMVc7N6vJGzKLUJR2Ivmt5EdqrvLUCbipQJeUnGtBzEccKCBhntsc5AUIZkHHIN
	ztpF4ESAiEPDa0ZAgWO7dkxge4hGhCQihv7trCfTX8xYDbrsh/n/29KoKzHaTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737740780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdqxts0Ly384h227Zw0Y2lHPu+J1RSM2dHrUxtWsIDo=;
	b=ni43ofM0jpyxZXOYR40SetIjoeAvzdicNqwTk7f4hEYk9ZJEOeBP70ZfFoYEIY3LbKMyzW
	/7dBYUjnfSh6BICw==
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	tglx@linutronix.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 3/6] kernfs: Acquire kernfs_rwsem in kernfs_node_dentry().
Date: Fri, 24 Jan 2025 18:46:11 +0100
Message-ID: <20250124174614.866884-4-bigeasy@linutronix.de>
In-Reply-To: <20250124174614.866884-1-bigeasy@linutronix.de>
References: <20250124174614.866884-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

kernfs_node_dentry() passes kernfs_node::name to
lookup_positive_unlocked().

Acquire kernfs_root::kernfs_rwsem to ensure the node is not renamed
during the operation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/kernfs/mount.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index b9b16e97bff18..4a0ff08d589ca 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -209,6 +209,7 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *k=
n,
 {
 	struct dentry *dentry;
 	struct kernfs_node *knparent;
+	struct kernfs_root *root;
=20
 	BUG_ON(sb->s_op !=3D &kernfs_sops);
=20
@@ -218,6 +219,9 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *k=
n,
 	if (!kn->parent)
 		return dentry;
=20
+	root =3D kernfs_root(kn);
+	guard(rwsem_read)(&root->kernfs_rwsem);
+
 	knparent =3D find_next_ancestor(kn, NULL);
 	if (WARN_ON(!knparent)) {
 		dput(dentry);
--=20
2.47.2


