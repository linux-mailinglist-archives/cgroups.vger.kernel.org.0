Return-Path: <cgroups+bounces-14490-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OjFDcz5omkZ8gQAu9opvQ
	(envelope-from <cgroups+bounces-14490-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 28 Feb 2026 15:21:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 160201C388B
	for <lists+cgroups@lfdr.de>; Sat, 28 Feb 2026 15:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FD793034C52
	for <lists+cgroups@lfdr.de>; Sat, 28 Feb 2026 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B63B392811;
	Sat, 28 Feb 2026 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CoTmr6uO"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E536036E475
	for <cgroups@vger.kernel.org>; Sat, 28 Feb 2026 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772288458; cv=none; b=AtsW2tc4+0XCJF3bvFqYOvqfVqmBDl1Y4zocxK61NOwcIgpmvOD440q7+jfocXjuSAk6rMYEk3n8rOqD/J6DogqrYkcJEFhntcUz05cjOEkEmsPumnYnuot4BokuhSDZop2+W7G5E0P9ylnIYdBCZZrD8ieGzlxO+uIYKhoacww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772288458; c=relaxed/simple;
	bh=nBmlPo5O/CjJtH+LnUDf9peXd0tMjIrIR3KIGzfZdA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRaQ18lvdeAar73SZ/jp/dFJrvJnrJyZAkgmEhpz2Z74HYETLvnWV82I+EVe4jkSTvzuT9j9ORbGLY+HZEIaT21Uk9s9teKU5eEOn3OuCfCtUTyWkeKyUqvbHqBXeSUft/Cjf4dV1vzBMhyjiOJSagFfJmJNPgYdpq2tBtjcqJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CoTmr6uO; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772288445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBR7DSPv0SQTUni7LYAlRsXlj4uQvQDqYNhgjcl//5E=;
	b=CoTmr6uOZUtm/aSGvKdQHWKa+316V6kLKQ3lL9j/1AgwB07qO6ga1qSdBot1NMHwMCvzqI
	Nc8JlGKFJYpmR3QLBk0JvXCLav1konHLC2VKHKBodvXDu1asnQl0bmvbQawP4tOvijwRFz
	5XerhCSv6PraS2o22S9wCKt/q2MOwtE=
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
Subject: [PATCH 2/3] cgroup: add lockless fast-path checks to cgroup_file_notify()
Date: Sat, 28 Feb 2026 06:20:17 -0800
Message-ID: <20260228142018.3178529-3-shakeel.butt@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-14490-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 160201C388B
X-Rspamd-Action: no action

Add two lockless checks before acquiring the lock:

1. READ_ONCE(cfile->kn) NULL check to skip torn-down files.
2. READ_ONCE(cfile->notified_at) check to skip when within the
   rate-limit window (~10ms).

Both checks have safe error directions -- a stale read can only cause
unnecessary lock acquisition, never a missed notification.  Annotate
all write sites with WRITE_ONCE() to pair with the lockless readers.

The trade-off is that trailing timer_reduce() calls during bursts are
skipped, so the deferred notification that delivers the final state
may be lost.  This is acceptable for the primary callers like
__memcg_memory_event() where events keep arriving.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reported-by: Jakub Kicinski <kuba@kernel.org>
---
 kernel/cgroup/cgroup.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 33282c7d71e4..5473ebd0f6c1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1749,7 +1749,7 @@ static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
 		struct cgroup_file *cfile = (void *)css + cft->file_offset;
 
 		spin_lock_irq(&cgroup_file_kn_lock);
-		cfile->kn = NULL;
+		WRITE_ONCE(cfile->kn, NULL);
 		spin_unlock_irq(&cgroup_file_kn_lock);
 
 		timer_delete_sync(&cfile->notify_timer);
@@ -4430,7 +4430,7 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 		timer_setup(&cfile->notify_timer, cgroup_file_notify_timer, 0);
 
 		spin_lock_irq(&cgroup_file_kn_lock);
-		cfile->kn = kn;
+		WRITE_ONCE(cfile->kn, kn);
 		spin_unlock_irq(&cgroup_file_kn_lock);
 	}
 
@@ -4686,20 +4686,27 @@ int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
  */
 void cgroup_file_notify(struct cgroup_file *cfile)
 {
-	unsigned long flags;
+	unsigned long flags, last, next;
 	struct kernfs_node *kn = NULL;
 
+	if (!READ_ONCE(cfile->kn))
+		return;
+
+	last = READ_ONCE(cfile->notified_at);
+	if (time_before_eq(jiffies, last + CGROUP_FILE_NOTIFY_MIN_INTV))
+		return;
+
 	spin_lock_irqsave(&cgroup_file_kn_lock, flags);
 	if (cfile->kn) {
-		unsigned long last = cfile->notified_at;
-		unsigned long next = last + CGROUP_FILE_NOTIFY_MIN_INTV;
+		last = cfile->notified_at;
+		next = last + CGROUP_FILE_NOTIFY_MIN_INTV;
 
-		if (time_in_range(jiffies, last, next)) {
+		if (time_before_eq(jiffies, next)) {
 			timer_reduce(&cfile->notify_timer, next);
 		} else {
 			kn = cfile->kn;
 			kernfs_get(kn);
-			cfile->notified_at = jiffies;
+			WRITE_ONCE(cfile->notified_at, jiffies);
 		}
 	}
 	spin_unlock_irqrestore(&cgroup_file_kn_lock, flags);
-- 
2.47.3


