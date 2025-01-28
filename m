Return-Path: <cgroups+bounces-6351-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE2DA20651
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 09:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219B93A8E72
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3DB1DF745;
	Tue, 28 Jan 2025 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="THq9c1/z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQBTaN83"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373A11DE8B5;
	Tue, 28 Jan 2025 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053759; cv=none; b=GXo7Qo+FkppA7if7oI7uxdRd0WeLOyxqHnBPo2jg2ii/Zfga7ThkSVbGB6jNAtR36m45J6to9g/fw8bTDptxBty/nx1bmqfZmW4texkcxa9tzCV/3CVIYug29vHWqZjBFf97O+dYxyHTvsKftovsqUm6GN3OXBSUr2Vguh2eb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053759; c=relaxed/simple;
	bh=DGTpLamWHUkgj5xFOJwd0o2/wv8b1YO9QjSjYXScsrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSz8dou6ZtS1kXMvME4o2+iVzQB81aHEkvhbIc3dFOozO3e7TxygCl6B+YQAO09qzivq8KqQHyT2SjYo+w7FWruTMawtDq55gbYo7pU1JM1arqpFttzeyyIujsFSTXC1eQQobn4MWnrJkg7UMFk9nDdiMsZjfiXduLrN3xXzdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=THq9c1/z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oQBTaN83; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738053756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAwgdfGiuXTUsdwQtdHn2gNdWY/bb3vNi/5j2k4yIQY=;
	b=THq9c1/zt7lDVu4LlRpBM88yHwBjb0Z+y5sKmgJYr5Ft1ciKvqICKJEjohZ5IZr5bkclbv
	4qCrHsIYEPW2CFaWDch7kOFJN5O4IFF2aNsK4ZU7iFIOpd0cXJQZ/Bgne4jNmM/H9FJjmR
	hbwQvqUziFEIQmwqKuMCFNSeui0urf3yDelXGWAhoFb38C3fCO3xUr7yPrAxt0PYhIJxdF
	/XR45mXeCf1JeYgyt4PF2EkufpVAlXHCZuX3gjvnhnJ2tO8kM6wGPjBfVR7no8FR11g4wO
	V6Yd7kFMS6I+TwkLf1mrrXruDH29EebqTroQBR8DTNSF+lqW6+h8rsHCENYiDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738053756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAwgdfGiuXTUsdwQtdHn2gNdWY/bb3vNi/5j2k4yIQY=;
	b=oQBTaN83NWtdq87iKQQv1xQ11g+tCao10RcSfcTAiPmzXaVI0JY50T4tWdKMQHo74ou57U
	Y2WAy/FCWNuw4CAw==
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
Subject: [PATCH v5 2/6] kernfs: Acquire kernfs_rwsem in kernfs_get_parent_dentry().
Date: Tue, 28 Jan 2025 09:42:22 +0100
Message-ID: <20250128084226.1499291-3-bigeasy@linutronix.de>
In-Reply-To: <20250128084226.1499291-1-bigeasy@linutronix.de>
References: <20250128084226.1499291-1-bigeasy@linutronix.de>
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


