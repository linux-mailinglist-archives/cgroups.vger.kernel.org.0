Return-Path: <cgroups+bounces-6386-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEFEA22E95
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 15:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B3CE7A3C82
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 14:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DB81E98F3;
	Thu, 30 Jan 2025 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4MVxrfsV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W9TSPIjc"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094811E47A8;
	Thu, 30 Jan 2025 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245745; cv=none; b=jPrbAd0JZAubNEYUEiLQK4gaKlmR5aZxPyDP6SN9TIqIR5YgfyRnX02zYm+fHkdT9RyBnR08E/9YEVUKwXgFvCJiC2au8Wfo9k9Zfmr9VTjcR+1xLjsEgkFzM5g/xHU/jtcFWicDctlXKfPwMoR6URg87K5lomCi0Ummf3evdhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245745; c=relaxed/simple;
	bh=O7QYnNqtfos+KX02uWpBSuTC6KY2eysR/3Ql446iBi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/yeHB8scygmE60aRqrH7irOfXMbfU9vs65hSboYAWsxJwO8QGJNKIUVePesirTXqlDEySkn00S7cpe7AAz2kit0llgUBS5+4XTK1YomU02VNsZYM9xKAfPvpIFUXOuzF72DR3FtG1Zb1QMxSxajDtUHqzCWWLU7jkNcDabdexs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4MVxrfsV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W9TSPIjc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738245740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70ZpbL95PFOkiQLvqaDhiqcr9y/+An7eazJ7AAHJWk4=;
	b=4MVxrfsVb/ICLvfgYkKOYuniUttYeCBlLD3tTImyU1lf6qQ4R17AziiCaRm/01AVgOO2SD
	vp2FUVREWPuYEspdzRDuAUd11Da5lQUlAR5AwoJ5nrtw6KjcKvqrkkpvAboSMqysWdEuyM
	n7EfwdHLBpgrzRSSCMtUrjtfPQFGDB3+N3rCnFCzUWp4YUwA150xNT8VwP+0jFQkNBKXPk
	RfAJ4tHRp+IzU6nuGQ6vWQ1OiAi14GekNlv1nOdEXpSiH0z+uEVCVBSuIJ33dsUdUGLbRI
	bBBOa1eKkQ5xzj+JA7fJx0i6ZqNKQ59PbKoboTG2yXPzbiShELogl1NkOlY0Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738245740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70ZpbL95PFOkiQLvqaDhiqcr9y/+An7eazJ7AAHJWk4=;
	b=W9TSPIjcBLi9aETBv++4QlOLE8YvTahtIxwszNpSuGB+k8zoQHKvv/h+hjvrSDcQiedMgm
	SofkwFALJJX/K4Cg==
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
Subject: [PATCH v6 1/6] kernfs: Acquire kernfs_rwsem in kernfs_notify_workfn().
Date: Thu, 30 Jan 2025 15:02:02 +0100
Message-ID: <20250130140207.1914339-2-bigeasy@linutronix.de>
In-Reply-To: <20250130140207.1914339-1-bigeasy@linutronix.de>
References: <20250130140207.1914339-1-bigeasy@linutronix.de>
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


