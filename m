Return-Path: <cgroups+bounces-6388-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E52A22E99
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 15:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFD6188A72B
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 14:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5D11E9B05;
	Thu, 30 Jan 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SXGnefmM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZSgAretx"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F81E5018;
	Thu, 30 Jan 2025 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245745; cv=none; b=n0kmm7w5dYmQ4n1wkJG8I9hOAbQ8VihaQj0uYbxZNqsYhHNkRwDFYQ7pqMzXVWwIi8KCsNQz4oraCkuGwaGOzNubUNPvJGdYABK5ge5ZtIsfO7ZQ1+Px/6vnF5Gojj62gMiAorD/yKKnClmLwfhsOF4OKr0fitJSUR17B4ToyV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245745; c=relaxed/simple;
	bh=DGTpLamWHUkgj5xFOJwd0o2/wv8b1YO9QjSjYXScsrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjUJKGb0JESy34elLlKHKGxKqIroaljl8xBOWTrOHAr8iWqH82fyqsfzOJGsfETJePTVa9osXmqoRyFVBR+bUqkuYbwJDu3nJJjUY4eqqAgrzRlZ/68mv8wKVw9HwY2Kd2WliLGGIo7rO8tQ23TH8BFAgUnXS85B8SHf7rAk3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SXGnefmM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZSgAretx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738245741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAwgdfGiuXTUsdwQtdHn2gNdWY/bb3vNi/5j2k4yIQY=;
	b=SXGnefmMgESGOm30DzwBHGv2EZW0bV2PgPREtNOongoOVxqyUS99zBD8Si/hFjB0QIFyGo
	jwnpsinzxyQsLm2DVicGHg1T07t4RimxxJxDOCgfb9oqkoMTPl5wxFZNwfCCjD1dXVWXtU
	b5frPMzvgsDft3APlrJY2eG3F+WqExJht7SmecCZ+wKSZE0ozhByuiORVslYKVd6iegX7S
	kbAeaLLT7Z80a+sTzVYS2S9iX1qJf5hCt21pe8zuuDBwVqXMI6LHnPRYhD1g7haIK339Nl
	YNpV8BSB5//93yQoGeSUnN//IKsQaD57upG+MpJvaTnwbNK5BVdhqAMD/NLqYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738245741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAwgdfGiuXTUsdwQtdHn2gNdWY/bb3vNi/5j2k4yIQY=;
	b=ZSgAretxAisJDKpgZuUU/D4F3XJQkJGlv1k8KigMd8gju8rT2DnD2I2a7KqafIyyvH357n
	lN6Ql94sMDLhk3Ag==
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
Subject: [PATCH v6 2/6] kernfs: Acquire kernfs_rwsem in kernfs_get_parent_dentry().
Date: Thu, 30 Jan 2025 15:02:03 +0100
Message-ID: <20250130140207.1914339-3-bigeasy@linutronix.de>
In-Reply-To: <20250130140207.1914339-1-bigeasy@linutronix.de>
References: <20250130140207.1914339-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

kernfs_get_parent_dentry() passes kernfs_node::parent to
kernfs_get_inode().

Acquire kernfs_root::kernfs_rwsem to ensure kernfs_node::parent isn't
replaced during the operation.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/kernfs/mount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 1358c21837f1a..b9b16e97bff18 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -145,7 +145,9 @@ static struct dentry *kernfs_fh_to_parent(struct super_=
block *sb,
 static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
 {
 	struct kernfs_node *kn =3D kernfs_dentry_node(child);
+	struct kernfs_root *root =3D kernfs_root(kn);
=20
+	guard(rwsem_read)(&root->kernfs_rwsem);
 	return d_obtain_alias(kernfs_get_inode(child->d_sb, kn->parent));
 }
=20
--=20
2.47.2


