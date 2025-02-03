Return-Path: <cgroups+bounces-6417-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F894A25B5B
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2025 14:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30D3166C99
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2025 13:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E062063EF;
	Mon,  3 Feb 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="erMmRs5S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EKLUqv5I"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003DA205AB8;
	Mon,  3 Feb 2025 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590634; cv=none; b=kE/wiYZayUshmiHln0L6kG5rwWp3GcVcapBHvjUxGFdejkm4Qf8NMbFEhCK78SV7NukEJIaSVcM3L8pU2eWqHBntY/pIMojLx36z3mZk7UkgnN/B7jhqPu0Hmn2DqXwcd+wI/Hl0wBUUmcJRtyO0BlqkMSXnJ4oBnazOly1j8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590634; c=relaxed/simple;
	bh=+kwU2zFUMmyb0jS6OU6MFBxnBiiwKa4vGC/wQUaUfq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4r1Rkzp/pFsfbG+HBMd178HTCHauxvCsmo0UDED5F4VVA4Pwo3H1ILdPF0nyg66g8+aptL6zUD5VLUOPgDYukRO/dGi4jZkbs7BYicelSEMivTXivDYSfSnzdjPx85ue/8fv0UxWISVOV29UGqAMxkCgZ26uGqOihm5QC8CjQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=erMmRs5S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EKLUqv5I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738590631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQFaRwsMWqeRZCHTYyBsT4gxYaSSc81PYJjjcc6W9Sk=;
	b=erMmRs5S2OuceqmxziPo21AY0RG26sBi4tQDd4MjmM9aDZoUv/xH00CNhGqnsFWzNaMyh+
	eoDhtpbngOtrMrfsxSuteJSIFTR9F9MzhbCvNqNSgg9VMmr12I7XEgt5N4vRo28TaXuPTx
	fei8KSX6UW3wiyNB3NyxC72Jqc3b//Iz1uG5pibYc6cZnsOzS07TdmuBD5D8cvfAU/lsrf
	0oqtj5HhFXW6w139jDenNcII5qDVYU2XUaLwc5+PSxxO4A9W+fLzOeGJp6dLXklCc6PTwZ
	cUK7pvSwuZvgb590Uq2TikyCOaUH3b/Daqb+R+iEycJGE0HIPvfazafDOaNsVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738590631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQFaRwsMWqeRZCHTYyBsT4gxYaSSc81PYJjjcc6W9Sk=;
	b=EKLUqv5IPKKAyj/vogMF4bfc8BN8k7swlaBVGlm36/1M2Qj59eCNAEb81sFxVXaGPg2i0U
	Lduwbf5UhTyv0IAA==
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
Subject: [PATCH v7 3/6] kernfs: Acquire kernfs_rwsem in kernfs_node_dentry().
Date: Mon,  3 Feb 2025 14:50:20 +0100
Message-ID: <20250203135023.416828-4-bigeasy@linutronix.de>
In-Reply-To: <20250203135023.416828-1-bigeasy@linutronix.de>
References: <20250203135023.416828-1-bigeasy@linutronix.de>
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


