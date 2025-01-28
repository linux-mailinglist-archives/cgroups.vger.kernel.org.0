Return-Path: <cgroups+bounces-6352-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3516AA20653
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 09:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F2F7A4168
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 08:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B66A1DF97E;
	Tue, 28 Jan 2025 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ewSz62oL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Px56zWbN"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC9A1DF276;
	Tue, 28 Jan 2025 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053760; cv=none; b=gpyW3TbTOnkX8LP5l4rt8osOol7e69F1v0SRAktE2OAs9OTBEsj7rPpv4INlbGfU86bz9V7LdqUPBL0Nr41jyIc8YrITPVOExqIIaHbnEHSWlGqH8WwTNQffKCYccOpNSNmDlmal2hs0wZnjW/DM/sndH02I895Phhu/KiBX6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053760; c=relaxed/simple;
	bh=+kwU2zFUMmyb0jS6OU6MFBxnBiiwKa4vGC/wQUaUfq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tj+VAz15gVq7D0vqWnYP2ogHARqzhu1KlovyRbrHhhAnwj0clN+G96Vcm9JKlXUna1Oqvqyib2AEyDjLCl+Nx1cHnQnIB4Oqan3jxHLKKjy8q7jePZ1jkGpOs3PGEm0j6SDC7tYbVPReklQ0Mga0h+svF/S/JuR4TD8Ga0wKKoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ewSz62oL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Px56zWbN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738053757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQFaRwsMWqeRZCHTYyBsT4gxYaSSc81PYJjjcc6W9Sk=;
	b=ewSz62oLj2/KMFS48hv7Y0XNGe0UJ6XG1CNtyxntwmZk7fYcMPj09tAbLZx0w460/mol9p
	RXuvG1C+BZhMc/xgevFnD9yRwI/m+vGZl/A2J2eIst9Tj/eiAYjgbjRyylonZyqQ1v9Yof
	XPn86EsWFfmyJNfbvuPS0+oZEW88xt6JKUA3oGQuxaECzXFDi/oarS57jw4Z8wo4uN4v4h
	QZSxjbSKawahhqQc4j//2dh77n0Rf3No9rWY/EScWa49o6zG/5gq780RS7iH+eN4zTWL7V
	zvJSZQxDhtx4A3Qpd3FVP0Q6+HgqjSBBse+hwMO2DE5SAUuRpqbQTGEnGCAR1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738053757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQFaRwsMWqeRZCHTYyBsT4gxYaSSc81PYJjjcc6W9Sk=;
	b=Px56zWbNjSZ0+OYjnW/jj4xKl9YoAVAYBr92oMtITr2Alv32/CjA/Pyjmvg35uKTlJBLWB
	866Sgjwpe6JOT6CA==
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
Subject: [PATCH v5 3/6] kernfs: Acquire kernfs_rwsem in kernfs_node_dentry().
Date: Tue, 28 Jan 2025 09:42:23 +0100
Message-ID: <20250128084226.1499291-4-bigeasy@linutronix.de>
In-Reply-To: <20250128084226.1499291-1-bigeasy@linutronix.de>
References: <20250128084226.1499291-1-bigeasy@linutronix.de>
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


