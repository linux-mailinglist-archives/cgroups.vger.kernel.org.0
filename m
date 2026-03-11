Return-Path: <cgroups+bounces-14747-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKGoGjG/sGm4mgIAu9opvQ
	(envelope-from <cgroups+bounces-14747-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 02:02:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8EB25A3D2
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 02:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 215983091685
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 01:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A310136C0CF;
	Wed, 11 Mar 2026 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TAdFKhz4"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F64B371053
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190881; cv=none; b=STuoAs2i4+GsZAbP+kWhjZgTNLlM1Mf1uqEyWRduVch1ZvSdRkM+SmN+/l1glfgNBPBrTdktcz5gBwj2fRgHYPVzfz0Yt7elQ6/+CbfC40290eQhPJOFvu93j1TDbYuUHt3C/OVqh2a2fk/s1AHGpCDkvMD03R5NRzK7N79oid4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190881; c=relaxed/simple;
	bh=6uaML4bIG5BQHwy/29qZ13YY5ETzZT2ziuriWoIfeTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+n07SyYYaYZOIy5MO6zoT71elvSGNeIIFTXbdb7Ca2nzJLuOGziZz4GI5vcYe4BkiKmIlLaHD1QHNArMAVQCQ4pS4c5TxZLFT1uVsBB3sDUV0k1TuqP/eiRhgAa8bs6ks+Jwh4BwyrnnTUA0L7w/4mtQDS/xU/UdOvHTIthObk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TAdFKhz4; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773190878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9HsfOrfS+eqleG7h8cZbUZvSAAorR+E1jNWHkvLrQs=;
	b=TAdFKhz4AGLvyBz1IQjH0d3LhD1RTXPiZ2TQ7EZzlcgkFQvEF434gIsHRJvYntgR8tsGMw
	/waxpyhhsTwNuPUNoJhbqy1ptgdIJ350DJKpO8K6NcG2plAibuoiWLvOwomc2307tPzKWU
	F6v7NInwpaK1M5+TnPFoRUzVIuHdlwo=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] cgroup: replace global cgroup_file_kn_lock with per-cgroup_file lock
Date: Tue, 10 Mar 2026 18:01:01 -0700
Message-ID: <20260311010101.3306366-4-shakeel.butt@linux.dev>
In-Reply-To: <20260311010101.3306366-1-shakeel.butt@linux.dev>
References: <20260311010101.3306366-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: DE8EB25A3D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14747-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

Replace the global cgroup_file_kn_lock with a per-cgroup_file spinlock
to eliminate cross-cgroup contention as it is not really protecting
data shared between different cgroups.

The lock is initialized in cgroup_add_file() alongside timer_setup().
No lock acquisition is needed during initialization since the cgroup
directory is being populated under cgroup_mutex and no concurrent
accessors exist at that point.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
Changes since v1:
- N/A

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
index b00f4c3242e0..d899bb2aef2f 100644
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
@@ -4427,10 +4421,8 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
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
@@ -4699,13 +4691,13 @@ void cgroup_file_notify(struct cgroup_file *cfile)
 			return;
 	}
 
-	spin_lock_irqsave(&cgroup_file_kn_lock, flags);
+	spin_lock_irqsave(&cfile->lock, flags);
 	if (cfile->kn) {
 		kn = cfile->kn;
 		kernfs_get(kn);
 		WRITE_ONCE(cfile->notified_at, jiffies);
 	}
-	spin_unlock_irqrestore(&cgroup_file_kn_lock, flags);
+	spin_unlock_irqrestore(&cfile->lock, flags);
 
 	if (kn) {
 		kernfs_notify(kn);
@@ -4723,10 +4715,10 @@ void cgroup_file_show(struct cgroup_file *cfile, bool show)
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
2.52.0


