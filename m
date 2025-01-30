Return-Path: <cgroups+bounces-6385-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC89BA22E96
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 15:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4C11889FB7
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 14:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A641E7C2B;
	Thu, 30 Jan 2025 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I2e+FBHn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MyH85p5r"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D771BBBEB;
	Thu, 30 Jan 2025 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245745; cv=none; b=OcKd66UZSAvdXE16ThKsBt6zr+ju1NMNHLHI4TFV4drTc6MAiEup0Ec8eIvyNUlpNf1arbgNUcakc05uJgBFobgD//hCaPF2FZvlhNMLeE8slGm/w1HvlvGQiKdsRtqbrfd/+5ABoFFtSD+v5jugqZkZDKVOiG9ixZoucICyjlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245745; c=relaxed/simple;
	bh=+kwU2zFUMmyb0jS6OU6MFBxnBiiwKa4vGC/wQUaUfq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mf+Ih5Ecx/PoMzqCmOFAwjKnYEZgng3e3YEKgoYpkj6RBuuPc9pF97BHZB11lBbcZQC+DSl6DLDk+NBlDNvU6A33F8r1eYD7w6xIroZ+IzBvWQVnBS8CP8yjXGZZmv7grmm634TS7HKtnMauSo9yM4grDQ3N/ZwuUoXuNBa9oJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I2e+FBHn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MyH85p5r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738245741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQFaRwsMWqeRZCHTYyBsT4gxYaSSc81PYJjjcc6W9Sk=;
	b=I2e+FBHnmYPaOh0gHDKKCqOyL69AnexN/7BYL7rKwjHbTlT+y93Cikj/tA9vTS0TOxkmqB
	YJUb+M0LfVHcItzWRpsxPPamB2iMV5CBQjGvM6lhU2nz+2/7D+zjjZYkeXJ++e85GRSHu0
	LovPyRc7N6dH8RT1jO4RScwueB2sVzpVvl34AUX9CIGos6dgeJlrkfzI3S4vS/ThfFXyoa
	7IaL+TX+cIH4PFC8w0SRYifvkxlF9LR9H4LOOGsCoD1JogidYsO/OKliQo8cbUQO9q6pNf
	EZhwzl5lRJDp8BHLU1+yaQVXHOM/ZTK8oDhEFdbroh/T7pMKHYL84G0BQV04gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738245741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQFaRwsMWqeRZCHTYyBsT4gxYaSSc81PYJjjcc6W9Sk=;
	b=MyH85p5rrXuaBBk67EWXn+ogaR+csmYik+gDL73HdPiDxipfSxNdakR8soVGLWXzHDG4wA
	LiIEBSPLFgmSOBCA==
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
	tglx@linutronix.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6 3/6] kernfs: Acquire kernfs_rwsem in kernfs_node_dentry().
Date: Thu, 30 Jan 2025 15:02:04 +0100
Message-ID: <20250130140207.1914339-4-bigeasy@linutronix.de>
In-Reply-To: <20250130140207.1914339-1-bigeasy@linutronix.de>
References: <20250130140207.1914339-1-bigeasy@linutronix.de>
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

Acked-by: Tejun Heo <tj@kernel.org>
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


