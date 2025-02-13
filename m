Return-Path: <cgroups+bounces-6542-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C83DA34429
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 16:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E13E3B1A8C
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 14:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863FC18A6C4;
	Thu, 13 Feb 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OmvxL3gi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9UJ2jdOL"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA58156C71;
	Thu, 13 Feb 2025 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458231; cv=none; b=cIBKtv6HgBZdZf9DuyDoO/axd4Z6B9e0o/HW2u6QuU0l2DSdoIa3eMoIpCb66+fCb7WVKKtUcxg7fGmICWTV4jcvXolke8Nk/Cb+V7FkQXAd7g4+Xaq1xfLBng7VCYXAJjS6P8+xHPZECmk3dc9onSKoU2BYgu3fS2C4rxmBhR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458231; c=relaxed/simple;
	bh=DGTpLamWHUkgj5xFOJwd0o2/wv8b1YO9QjSjYXScsrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boK9DiG8qYX/AfPKx0JtPYXqxOuzD7N1eaI7c4db4n6FwPtD+Y5XqWdeHmB4RGxvoEMOv8BGJPmnM5amWOPw5HRxbSci4xZ9qJ6OP6RpfzMcqKsLOOOBaeYxDcELdhMQi2r3ZmQl6+aPBub1CwyjxQ8loz4dUsy6tXW7ssA6UFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OmvxL3gi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9UJ2jdOL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739458228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAwgdfGiuXTUsdwQtdHn2gNdWY/bb3vNi/5j2k4yIQY=;
	b=OmvxL3gitJUvtMNXFs88kHx2eJGqEIlJ3rVDVr/VCZmBEUUR9OZZ/EIK6K/uKLMcoQj4Ws
	L4w83/DMAXlIi7tGTHHyeaPEU4yN+citKOHW34fkksdCo9/5aE+jm4xEYVtLcrjghDB6ku
	AY63ZL8M7257mxoLywmybaStJQrJuBjuG4Gyq+Xbk1DQ9vR9V8CLNAWnEmPoNSlvXLLx4O
	4ZRqEQz78OxKuwoVO913a+YqCoL4/SsUTUfIZn294J0Zlry43WE5U6cMOY9uXDLYNKLVBj
	Bin2oy6YHJJTjX0I+C9LZ0ulcxLrQakZZRnj1sK4rKJXLIo86QGGUKGBvXVN2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739458228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAwgdfGiuXTUsdwQtdHn2gNdWY/bb3vNi/5j2k4yIQY=;
	b=9UJ2jdOLcLwZuC43NiBrjIC5ZLeaNd+zi04ZrvrXhvudLrgTy6UhkWcFucWBcPUxAcpwiY
	NI2W2/Bxo/aVTIAQ==
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
Subject: [PATCH v8 2/6] kernfs: Acquire kernfs_rwsem in kernfs_get_parent_dentry().
Date: Thu, 13 Feb 2025 15:50:19 +0100
Message-ID: <20250213145023.2820193-3-bigeasy@linutronix.de>
In-Reply-To: <20250213145023.2820193-1-bigeasy@linutronix.de>
References: <20250213145023.2820193-1-bigeasy@linutronix.de>
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


