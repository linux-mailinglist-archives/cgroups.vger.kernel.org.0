Return-Path: <cgroups+bounces-14746-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAk5M/q+sGm4mgIAu9opvQ
	(envelope-from <cgroups+bounces-14746-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 02:01:46 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4E725A39F
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 02:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C50F302D6BF
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 01:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0607036E497;
	Wed, 11 Mar 2026 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ccsx1/kW"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE7282F16;
	Wed, 11 Mar 2026 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190878; cv=none; b=jwEgXrn+R7+KsR1uyd0IB01XlCbbNNF6Hz6y3OU5MDB1QISPX6Pl1gPF1qVwe0a5r1hMSIWIvuzv/tq4/uEUoqWZM3wgKSVTVljwQj+caZ1JoxkkzKfIZvwYcp8qCqkz5XHws2eRU0JcNovAu6HcbM5Kz4heILOEgx/uvg5HWlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190878; c=relaxed/simple;
	bh=Cj6aYpBIjzHQp9dQbgNhURSsAIaiBqiBxPXxNoGgK5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6gl6Ib7KV07peNE/umqudvEApP7PdCJ2S4U2i278byD7IX4KQYvpVCGd6r3nyzw2A0JenoUqnVOYCm5xHLo/GFrQDVOWteTCbwGWin5DUdvN3sj7fnrJ8Ziucb5hFiXCgmDRwwwoVKuueOYLNnbLcqakkH7oDl4IjHsv8Z7koQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ccsx1/kW; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773190875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ql30l3PkbeNcbzr2KL87n3zGyPvc/RHjLKkGfbTuIH0=;
	b=Ccsx1/kWEQE637Iz9fq15VANKbX+Sc52j5gJqkyyS8WiTnvG1rt0Nq26WNuowFqsaeVz5e
	TVv7q7ZfgqfBPvuvsPAIWVAO0My4sYJy6kLqoP5o/4+GC0kpOqROj3vc/aHkuK1lY3OYYT
	wOsJX6uvUs1m9KF6WlfWhSG4VIhvuQI=
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
Subject: [PATCH v2 2/3] cgroup: add lockless fast-path checks to cgroup_file_notify()
Date: Tue, 10 Mar 2026 18:01:00 -0700
Message-ID: <20260311010101.3306366-3-shakeel.butt@linux.dev>
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
X-Rspamd-Queue-Id: DA4E725A39F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14746-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add lockless checks before acquiring cgroup_file_kn_lock:

1. READ_ONCE(cfile->kn) NULL check to skip torn-down files.
2. READ_ONCE(cfile->notified_at) rate-limit check to skip when
   within the notification interval.  If within the interval, arm
   the deferred timer via timer_reduce() and confirm it is pending
   before returning -- if the timer fired in between, fall through
   to the lock path so the notification is not lost.

Both checks have safe error directions -- a stale read can only
cause unnecessary lock acquisition, never a missed notification.

The critical section is simplified to just taking a kernfs_get()
reference and updating notified_at.

Annotate cfile->kn and cfile->notified_at write sites with
WRITE_ONCE() to pair with the lockless readers.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
Changes since v1:
- Moves the timer arming and rate limiting out of lock.

 kernel/cgroup/cgroup.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b3fbeadb2b5a..b00f4c3242e0 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1749,7 +1749,7 @@ static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
 		struct cgroup_file *cfile = (void *)css + cft->file_offset;
 
 		spin_lock_irq(&cgroup_file_kn_lock);
-		cfile->kn = NULL;
+		WRITE_ONCE(cfile->kn, NULL);
 		spin_unlock_irq(&cgroup_file_kn_lock);
 
 		timer_delete_sync(&cfile->notify_timer);
@@ -4429,7 +4429,7 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 		timer_setup(&cfile->notify_timer, cgroup_file_notify_timer, 0);
 
 		spin_lock_irq(&cgroup_file_kn_lock);
-		cfile->kn = kn;
+		WRITE_ONCE(cfile->kn, kn);
 		spin_unlock_irq(&cgroup_file_kn_lock);
 	}
 
@@ -4685,21 +4685,25 @@ int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
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
+	next = last + CGROUP_FILE_NOTIFY_MIN_INTV;
+	if (time_in_range(jiffies, last, next)) {
+		timer_reduce(&cfile->notify_timer, next);
+		if (timer_pending(&cfile->notify_timer))
+			return;
+	}
+
 	spin_lock_irqsave(&cgroup_file_kn_lock, flags);
 	if (cfile->kn) {
-		unsigned long last = cfile->notified_at;
-		unsigned long next = last + CGROUP_FILE_NOTIFY_MIN_INTV;
-
-		if (time_in_range(jiffies, last, next)) {
-			timer_reduce(&cfile->notify_timer, next);
-		} else {
-			kn = cfile->kn;
-			kernfs_get(kn);
-			cfile->notified_at = jiffies;
-		}
+		kn = cfile->kn;
+		kernfs_get(kn);
+		WRITE_ONCE(cfile->notified_at, jiffies);
 	}
 	spin_unlock_irqrestore(&cgroup_file_kn_lock, flags);
 
-- 
2.52.0


