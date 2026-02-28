Return-Path: <cgroups+bounces-14489-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAQdFMb5omkZ8gQAu9opvQ
	(envelope-from <cgroups+bounces-14489-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 28 Feb 2026 15:20:54 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E874D1C387D
	for <lists+cgroups@lfdr.de>; Sat, 28 Feb 2026 15:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2715B3026320
	for <lists+cgroups@lfdr.de>; Sat, 28 Feb 2026 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A9842884C;
	Sat, 28 Feb 2026 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JcI/7Imt"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BB5393DD6
	for <cgroups@vger.kernel.org>; Sat, 28 Feb 2026 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772288451; cv=none; b=jK/pxGmS74tdjiIkHTrjvwcmveiFAgEXN0BB0NbocEvq+g7PH5cA1Jeag+p3bgAEP2Irt2VZffDdrQP/1GalBdZAGwmJ0VzUukXvotXB6XEreMVq4FSCwf9Kbm0g4siJpgVqvxkT7Vs9LZpOjV/XRnR46nLz3NNMWsg8rXyH7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772288451; c=relaxed/simple;
	bh=Nt/BUPJSvd9WEDeocpmWi6aZzL7kRdJmd8JiUYGr7OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiY+o4qVOdlg5nlRX/C6k33OWsigIcmn/dn0hNuUJpDl3mCAbzcOdyUKdBb3mUAW6aZVvfM3b/AgqyIof/nzwIXHmUupuVGeDanIQHSfN1YPD7jEPSHjfECJayMkcwNBoTPyeYXbPFEYH31Ggk2mM7/Jvik7ks9IOguOHlqwpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JcI/7Imt; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772288448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cngsu4QC/s/LsygBwa0X1EgXCc0toiqGLgWGzEjWZ30=;
	b=JcI/7ImtJYPNViw4hRAStRxiuwGD/K2BPN2nAe3Qmvd6t5RC1XpXCbi6w+EM62Bo875+l4
	5tDwOAflDGo6MkCtOuMzbje/vhPK9w/h+fiw6v7rup3BxR94zCBkD1jBGwdz45EHLE8ITp
	x150gwG5DGtZHS+kNuAC8Jjzi8/vgj4=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Daniel Sedlak <daniel.sedlak@cdn77.com>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 3/3] cgroup: replace global cgroup_file_kn_lock with per-cgroup_file lock
Date: Sat, 28 Feb 2026 06:20:18 -0800
Message-ID: <20260228142018.3178529-4-shakeel.butt@linux.dev>
In-Reply-To: <20260228142018.3178529-1-shakeel.butt@linux.dev>
References: <20260228142018.3178529-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14489-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E874D1C387D
X-Rspamd-Action: no action

Replace the global cgroup_file_kn_lock with a per-cgroup_file spinlock
to eliminate cross-cgroup contention as it is not really protecting
data shared between different cgroups.

The lock is initialized in cgroup_add_file() alongside timer_setup().
No lock acquisition is needed during initialization since the cgroup
directory is being populated under cgroup_mutex and no concurrent
accessors exist at that point.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reported-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/cgroup-defs.h |  1 +
 kernel/cgroup/cgroup.c      | 24 ++++++++----------------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index bb92f5c169ca..ba26b5d05ce3 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -167,6 +167,7 @@ struct cgroup_file {
 	struct kernfs_node *kn;
 	unsigned long notified_at;
 	struct timer_list notify_timer;
+	spinlock_t lock;
 };
 
 /*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 5473ebd0f6c1..b502acad3c5c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -107,12 +107,6 @@ static bool cgroup_debug __read_mostly;
  */
 static DEFINE_SPINLOCK(cgroup_idr_lock);
 
-/*
- * Protects cgroup_file->kn for !self csses.  It synchronizes notifications
- * against file removal/re-creation across css hiding.
- */
-static DEFINE_SPINLOCK(cgroup_file_kn_lock);
-
 DEFINE_PERCPU_RWSEM(cgroup_threadgroup_rwsem);
 
 #define cgroup_assert_mutex_or_rcu_locked()				\
@@ -1748,9 +1742,9 @@ static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
 		struct cgroup_subsys_state *css = cgroup_css(cgrp, cft->ss);
 		struct cgroup_file *cfile = (void *)css + cft->file_offset;
 
-		spin_lock_irq(&cgroup_file_kn_lock);
+		spin_lock_irq(&cfile->lock);
 		WRITE_ONCE(cfile->kn, NULL);
-		spin_unlock_irq(&cgroup_file_kn_lock);
+		spin_unlock_irq(&cfile->lock);
 
 		timer_delete_sync(&cfile->notify_timer);
 	}
@@ -4428,10 +4422,8 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 		struct cgroup_file *cfile = (void *)css + cft->file_offset;
 
 		timer_setup(&cfile->notify_timer, cgroup_file_notify_timer, 0);
-
-		spin_lock_irq(&cgroup_file_kn_lock);
-		WRITE_ONCE(cfile->kn, kn);
-		spin_unlock_irq(&cgroup_file_kn_lock);
+		spin_lock_init(&cfile->lock);
+		cfile->kn = kn;
 	}
 
 	return 0;
@@ -4696,7 +4688,7 @@ void cgroup_file_notify(struct cgroup_file *cfile)
 	if (time_before_eq(jiffies, last + CGROUP_FILE_NOTIFY_MIN_INTV))
 		return;
 
-	spin_lock_irqsave(&cgroup_file_kn_lock, flags);
+	spin_lock_irqsave(&cfile->lock, flags);
 	if (cfile->kn) {
 		last = cfile->notified_at;
 		next = last + CGROUP_FILE_NOTIFY_MIN_INTV;
@@ -4709,7 +4701,7 @@ void cgroup_file_notify(struct cgroup_file *cfile)
 			WRITE_ONCE(cfile->notified_at, jiffies);
 		}
 	}
-	spin_unlock_irqrestore(&cgroup_file_kn_lock, flags);
+	spin_unlock_irqrestore(&cfile->lock, flags);
 
 	if (kn) {
 		kernfs_notify(kn);
@@ -4727,10 +4719,10 @@ void cgroup_file_show(struct cgroup_file *cfile, bool show)
 {
 	struct kernfs_node *kn;
 
-	spin_lock_irq(&cgroup_file_kn_lock);
+	spin_lock_irq(&cfile->lock);
 	kn = cfile->kn;
 	kernfs_get(kn);
-	spin_unlock_irq(&cgroup_file_kn_lock);
+	spin_unlock_irq(&cfile->lock);
 
 	if (kn)
 		kernfs_show(kn, show);
-- 
2.47.3


