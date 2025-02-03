Return-Path: <cgroups+bounces-6415-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EC6A25B55
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2025 14:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184283A3149
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2025 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0419C2063CC;
	Mon,  3 Feb 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nZWYsQvE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eowFQji8"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591A2205E01;
	Mon,  3 Feb 2025 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590633; cv=none; b=DFgHTfJap161fZzXx0PN4u7q4vxHJpMbmRatWQ/MPgYvvBlpxnuhORyw3MPZmISZ1STbKBzW0gZrU2EZlOZhaJM6OxKae+fM5L9ACKw5liRiukjRxpASJ7u7w9obPuGtsOkhqTXWnnmHOrmPIWg6tkG8z2NzRhlTBBajFxFPhHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590633; c=relaxed/simple;
	bh=ooG5yP6zVaxqY2K8LRqPqXXAG1fOpYsy6mj+ZEC+ewc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWgtNczF0kUXHyhaTnpBkYiOX+HhYyQZZOrfDe5jeL+lz5bxR1i23gLkf24nQxstKYbL8wxC0KYIebnIq4FmaKPd+2lyidyQJvLnQh18zOZ+0bIeFbnWOMfbX5BHulC4TD/A4Q7/A1JXnBHMEIO4qzP37ee7SIf1R6kpGurQnj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nZWYsQvE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eowFQji8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738590630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPLDklNtFE+iTPQIJ/xmrGTiOmYJUteN8bRbdDEb5X4=;
	b=nZWYsQvEqVJkfwucneZWlOzIpVeu/CNQuViPgYce5xE0oEMpEgmA9USxSlJdyv6VWmUJGv
	vcFK/QMKPGFgZ5nhiyHsPPOOsdljltz/eYCH5sqG3bPmCWeIr/yRKNXNyA0/UJ6Jxd2fHO
	aWHeiWwqJwUIwIu3g+lpj/upSlJvTVDrvOlR/gP6PHBp45huw/jW3udk7BgI3QKUcadOrj
	I+jOuhAZLFH4MMyI3f2DaH6R9KV1lzB8SiAVol/NudJQaEKQWFeKiQikD4/Dup3y05OitI
	9JtT43ZJL3Ha7DIadzC840bnxPqqFpT+7ASnM9iLWbRinwamlDf8QHOlAD4Kow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738590630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPLDklNtFE+iTPQIJ/xmrGTiOmYJUteN8bRbdDEb5X4=;
	b=eowFQji8tmK72KezwBF6N5affi2tHfk/CvuqRTOMjYfj9kwDX2NBjDwjAPSZQihDbfJ+nZ
	21DfXSldHlTqdECg==
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
Subject: [PATCH v7 1/6] kernfs: Acquire kernfs_rwsem in kernfs_notify_workfn().
Date: Mon,  3 Feb 2025 14:50:18 +0100
Message-ID: <20250203135023.416828-2-bigeasy@linutronix.de>
In-Reply-To: <20250203135023.416828-1-bigeasy@linutronix.de>
References: <20250203135023.416828-1-bigeasy@linutronix.de>
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


