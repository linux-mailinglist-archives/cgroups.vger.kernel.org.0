Return-Path: <cgroups+bounces-6543-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31CCA34446
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 16:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FDC3AC28A
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 14:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D191AA782;
	Thu, 13 Feb 2025 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jD6wb4yJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZDwxIv2F"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AFD15689A;
	Thu, 13 Feb 2025 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458232; cv=none; b=DrT5oO+Mr2ET037jYy6naoNhHDk5y/A3DsMl9N/W7hlObpYTtTMmSGS1k5lFYU93lt27I7FnkeKh1oGLbgRAJ+Pw7iX+8hNl8xT7Hx7M42V6VRnU1cNlktIC4L8BcmDp65pbLIf3GywnzLi0ORMGP6sFHrSgkOB6z+0+551VV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458232; c=relaxed/simple;
	bh=+kwU2zFUMmyb0jS6OU6MFBxnBiiwKa4vGC/wQUaUfq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiEXeW+8nJV0Ur7IOdO9qavCLnZrbOBnwJ420DstHdanJ/A2HdkHLf61488lbqiNZg8vL7rJDm++0J7PHOufRYmciatapp+4H857MRwsXBYNFtQX8w8BJospsV6N2k1HFmD70SXQGRTyyHcjFJaDIey3atY6Z+nyHgR2zfGEzX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jD6wb4yJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZDwxIv2F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739458228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQFaRwsMWqeRZCHTYyBsT4gxYaSSc81PYJjjcc6W9Sk=;
	b=jD6wb4yJYr5PP6JxT8dH3Gkr4RwhUaKgDQootmD/AF/fXUKEYfRdoeqee1r2+62adLz0xv
	cAl93rFqvPMLxW6432uIx8uzx8gSwPGfkuvvFuDoXol+PPq2Jc0IKdZgaoQT7eWEb9P2ee
	7kSfUbKRqX0ou3NsGCOpr2X5V6vf9Dvl61uKOZlVhr4Ar/MqC7dEHqQV0Z4CoN4buOrc5a
	svOsaqkFb3B6sgKfHfQ/32oq6RpCfWcKczZEiwCWSMzsUBt1QUiXns3nXult5a3AFRD87Q
	M3ch4n+oO8Pk++lT+HNTl2COj/Ac14pUmkDd/tpb1KVKMYeMMjlSc4hevhodBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739458228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQFaRwsMWqeRZCHTYyBsT4gxYaSSc81PYJjjcc6W9Sk=;
	b=ZDwxIv2FO0vZf94P8TbVb5TQSjdLm5c2QBCH6BNRDgVzFVq8B1CD/N4VaTrZjpS3DBNs+R
	sjtdP9ZniLRnAkDw==
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
Subject: [PATCH v8 3/6] kernfs: Acquire kernfs_rwsem in kernfs_node_dentry().
Date: Thu, 13 Feb 2025 15:50:20 +0100
Message-ID: <20250213145023.2820193-4-bigeasy@linutronix.de>
In-Reply-To: <20250213145023.2820193-1-bigeasy@linutronix.de>
References: <20250213145023.2820193-1-bigeasy@linutronix.de>
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


