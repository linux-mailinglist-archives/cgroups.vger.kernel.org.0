Return-Path: <cgroups+bounces-6274-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EB5A1BBA3
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 18:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B79116A166
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8FE1D5154;
	Fri, 24 Jan 2025 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LjhIY8va";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k01i2bGm"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6394B1AA783;
	Fri, 24 Jan 2025 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740783; cv=none; b=FVEX2VCoRVrNRbAm/76vnDDZ1aTbEkSTnt2ing3JPxYXV71cPw4cU8oIwpPojfIoIHiNFe8r/DumBKGedn0s8LWYy+D8CMYwDkOkEnsrgXt/usv6YdKDwxpTi3yc+ttw9lsDNJaVjeCIIi1UrVxiEhphoEPfFoJdiIXijvVevCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740783; c=relaxed/simple;
	bh=GepP28W9cyVD8WbDWXe/YZNICtsJls4kPV+lj7kQT8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7hY9MBNn7gHIPK0/09FlRNwkd37OTdS5AcYG/4ji8fz38vGxcU4wEWTO5na80wxKpap8kK1D9lM6ab9XEWp0n3jMG/YXDpdJ7fAXYG3NyVqpUlIQy2JI4b+Sixxtkl8uVBp/STJ8RltOKbLmDgLVKCk5WI4CG/VFANj+tq54I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LjhIY8va; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k01i2bGm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737740779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsYnIiRzwQW4pUiqIHZPl2wEkZ43XLUECQj8EV72lrY=;
	b=LjhIY8valzlSbr1brdgVK4PZ1SksWYsd1ga8m020baOT8BpNSSL+3lpeCfRRXcwj7NmwJw
	10MFvccn6kPKDES5WFpbUtH/WZxoOGgH96QG9bxd7zeYk/bW4fMZhZ6j4CU/HXj6n+T8R9
	PaVNId6Yj4B6TKPSj1y6TOFxMU5aOpLNp8qUqO6IE4rklC1WGdJ+3ATmc6+W8kASY8rF0H
	NyJ+nGMFls2wEdTFC/ARGSJvPwGyLGJXZFx315/eoKqhEK3Q09nkUSTujRG1RW+xwslv2o
	moRG0ea3fSIe4g8aeoRNhRvfXPQaCxeS98rwuIonxil6Tou4p52JYRdxOQn1Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737740779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsYnIiRzwQW4pUiqIHZPl2wEkZ43XLUECQj8EV72lrY=;
	b=k01i2bGm6dpXUDMPdqNx/O11Negj43GKcrOv6Tpk56rguIGaKLvkqt8cfJD2S99oJlHi9x
	7lqH881Ayv+u08AQ==
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
	Zefan Li <lizefan.x@bytedance.com>,
	tglx@linutronix.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 1/6] kernfs: Acquire kernfs_rwsem in kernfs_notify_workfn().
Date: Fri, 24 Jan 2025 18:46:09 +0100
Message-ID: <20250124174614.866884-2-bigeasy@linutronix.de>
In-Reply-To: <20250124174614.866884-1-bigeasy@linutronix.de>
References: <20250124174614.866884-1-bigeasy@linutronix.de>
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

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/kernfs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8502ef68459b9..38033caeaea51 100644
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
@@ -948,6 +949,7 @@ static void kernfs_notify_workfn(struct work_struct *wo=
rk)
 	}
=20
 	up_read(&root->kernfs_supers_rwsem);
+	up_read(&root->kernfs_rwsem);
 	kernfs_put(kn);
 	goto repeat;
 }
--=20
2.47.2


