Return-Path: <cgroups+bounces-6350-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE835A2064F
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 09:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455AE163088
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 08:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239051DF27F;
	Tue, 28 Jan 2025 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mk9aIm8p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V/1FyF1E"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DFD18B476;
	Tue, 28 Jan 2025 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053758; cv=none; b=M2ZOem6p6CSNAjMBmPAPI5KGGg4mK7U3ulywUsaiKCzkNV273qXYItUBNvRDlIhHPeG39Y4zQxAsqIabFejf/f6J04eTjI2FeW7iBUjnEsDHFtg8XRCnmDhxJmpZtitjgBZPedStYvYEgNVgvxMiFfHXvOIJvYwkF8V9yw+HB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053758; c=relaxed/simple;
	bh=O7QYnNqtfos+KX02uWpBSuTC6KY2eysR/3Ql446iBi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTJjppFsi+1hWjpKoHg4cufwSWwXjVQhGGF6c5Kjn9KJC1Jv/UEhycuNaAvW53ThglYJuugl70v3qbp07r08EToHtjyCQWIKftgIqCQcDt74xbs26ORZCKh1pCaI5XA08fIR8NN0P8czYd/JtGZ9iRIxMcUU6i3SZcVvgNgZ9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mk9aIm8p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V/1FyF1E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738053755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70ZpbL95PFOkiQLvqaDhiqcr9y/+An7eazJ7AAHJWk4=;
	b=mk9aIm8pvzmp8LFMYBvY2ouAaIONV2R98V5ypGvjssokmV4CmSViqD1uX6TsYt/AH87CA/
	HlhIwAbcH+j08SYW7gZR7cxvchH3k2toeyQBGV294S6hj+qo5TJoyPv3oFtPqXguROPu+f
	jWIr+lLLflfSiylQd9FJ8fxURAGexcbAHB6WnSadQFEIGP26GymDSu+GfYcv3P3tUGheDb
	EJrmF8OMBCN4C/JYDQgbnaXCBrSfdtbD+LM/ALtWm1GhRYfKURrVSgQWbby5Xbc9PlTyL9
	kdckCITEM5Q45U6hHHD3uN5pn400bSFh+cbu+nMlr4rQ5169UEh7B/hPgqQPTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738053755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70ZpbL95PFOkiQLvqaDhiqcr9y/+An7eazJ7AAHJWk4=;
	b=V/1FyF1E4oiv459EHmFtXZtVoOfZGCQiVU13YduLGk8YeH70i5yFkNHBKxOgOrNIsL3r5x
	N7bnVcJa4qM+ykBQ==
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
Subject: [PATCH v5 1/6] kernfs: Acquire kernfs_rwsem in kernfs_notify_workfn().
Date: Tue, 28 Jan 2025 09:42:21 +0100
Message-ID: <20250128084226.1499291-2-bigeasy@linutronix.de>
In-Reply-To: <20250128084226.1499291-1-bigeasy@linutronix.de>
References: <20250128084226.1499291-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

kernfs_notify_workfn() dereferences kernfs_node::name and passes it
later to fsnotify(). If the node is renamed then the previously observed
name pointer becomes invalid.

Acquire kernfs_root::kernfs_rwsem to block renames of the node.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/kernfs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8502ef68459b9..165d8e37976ba 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -911,6 +911,7 @@ static void kernfs_notify_workfn(struct work_struct *wo=
rk)
 	/* kick fsnotify */
=20
 	down_read(&root->kernfs_supers_rwsem);
+	down_read(&root->kernfs_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
 		struct inode *p_inode =3D NULL;
@@ -947,6 +948,7 @@ static void kernfs_notify_workfn(struct work_struct *wo=
rk)
 		iput(inode);
 	}
=20
+	up_read(&root->kernfs_rwsem);
 	up_read(&root->kernfs_supers_rwsem);
 	kernfs_put(kn);
 	goto repeat;
--=20
2.47.2


