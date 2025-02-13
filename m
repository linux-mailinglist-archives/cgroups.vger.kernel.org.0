Return-Path: <cgroups+bounces-6541-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC254A3441A
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 16:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E463E1897293
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A11189913;
	Thu, 13 Feb 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cbp2Qp/j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9kBDsie3"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA9C1662F1;
	Thu, 13 Feb 2025 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458231; cv=none; b=e0I6HLyWEIDpjwRug/w1NkVDm7Raap5sjW4L9ekPmNbPVRrLKswQQL3WLxUGg/PPbrRQJ0dvuJeIk1IVYp5mQLqbbw79K7bZXaDpS7X+1KvVkCUl/zlcY3yuOnrfwIrFBb2G5na/lhgJLC/nIrG3bRamca1C3qHvHEnFPAkM5yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458231; c=relaxed/simple;
	bh=ooG5yP6zVaxqY2K8LRqPqXXAG1fOpYsy6mj+ZEC+ewc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nv4L+fl6dsYMiusCFd6S9rb3jnNy9yIg13IkgfSpP2r+/ZUNJyL9DxB5O+Wijk69Y5DcaRu7R4vr3NvD+10F590XcK2bliVGvhXXTXbjtCKv0d0gK8dNd+C5+426CVwh+EL1fKbC9NrLfM/Y9vQAnCdhNgF/p6uc9hVWzgrmXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cbp2Qp/j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9kBDsie3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739458227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPLDklNtFE+iTPQIJ/xmrGTiOmYJUteN8bRbdDEb5X4=;
	b=cbp2Qp/jQDYpJaYiPJqp+0QBmIxhMPnuhQVm59aZSf5g/6hqeosrPmjOofv4ctB2xrqYgq
	UrdAsvdla/d7GXmFbl63pK9+eQFifVcPFZ3nhr92TxIB8GbwJGk2UqCzdnEI9DdMhhtD5O
	7AJbtowH3HW4g27QWK9WlfgBhngYHK1IbiA8iqEkxSVLc2/5tuO+LAbbJUN3BBV4ekqSGq
	3se17aW3da0Bu2ejiQkfxw7hlwUqjqQGIdPhreIjqxYJqGzv0AErGwFQ9GqEExWzbcswCg
	asvwYeOjuPWpvwGBctfVf8pQGJWiqKuDLsJNTNks8/4oqFI1SYh3KaMcF6mgNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739458227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPLDklNtFE+iTPQIJ/xmrGTiOmYJUteN8bRbdDEb5X4=;
	b=9kBDsie3W4k2vLLwiJBkeLQbL7B5dS2VuWstK5N6ba1iZtXf6Ukg+8cUHkB+9nWxID/OCD
	4+KisYgZ6k1ZuDCw==
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
Subject: [PATCH v8 1/6] kernfs: Acquire kernfs_rwsem in kernfs_notify_workfn().
Date: Thu, 13 Feb 2025 15:50:18 +0100
Message-ID: <20250213145023.2820193-2-bigeasy@linutronix.de>
In-Reply-To: <20250213145023.2820193-1-bigeasy@linutronix.de>
References: <20250213145023.2820193-1-bigeasy@linutronix.de>
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
index 0eb320617d7b1..c4ffa8dc89ebc 100644
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


