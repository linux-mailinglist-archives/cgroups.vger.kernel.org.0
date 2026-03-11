Return-Path: <cgroups+bounces-14745-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH9WK+++sGm4mgIAu9opvQ
	(envelope-from <cgroups+bounces-14745-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 02:01:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2642325A382
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 02:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F02A3301945D
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 01:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F768367F4D;
	Wed, 11 Mar 2026 01:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mENMEn6+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00C35F8A8
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 01:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190876; cv=none; b=TAGEAHJSlJsZ8pEaC6Axw4zvgCsmbLy5JE/OcaJFkSfurA9jdUG1omo03ehwNQm+BryywuWEkEYZuybdHyM6gt7WlkRPyi+r3v4LJDSGTbScpKIr+szJhZA7niD3vIYJEF/bdGnBMba+5vlHxlQkB5HGBxTTrDx/8EKyTgrfJGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190876; c=relaxed/simple;
	bh=CeiVAzQ8H3v9HU5U+4twZa9/8jKcb88Q/jIDoZ8McoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTEegqa3cqs7U4tASjvR3U1baG8PofmrsSoZrS7hUhhYQtb6SLl1mgVKlghDMPti7izt8sHXuYbm+TOoXud/LE+lBt2tM6CkqOEo8UcdGDvXB+iCCX1/LEBmcRHnxdJ6yDwGzAWfg7bV4kjF92PN2d4uQPvSxu02MVgmHX3lqoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mENMEn6+; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773190872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qk+QKL+WWCN38YTC4yYy3ziupLEe6KfdX1avXXt55Pw=;
	b=mENMEn6+BnsiU6XV1NWHpmL1SS60MUkAa0TYha8EuJ+HcpgFsTh3g3+yZWm2JbmUzTk60x
	5ZI+gQXEPI0d31SneW9hVgYfrQqPcyApjeizbDMb/HcJg1y90MgywSWKPH3aOHmYtdIuOp
	KI7aT5tKCeWCb35clfum+yD1/0FaEio=
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
Subject: [PATCH v2 1/3] cgroup: reduce cgroup_file_kn_lock hold time in cgroup_file_notify()
Date: Tue, 10 Mar 2026 18:00:59 -0700
Message-ID: <20260311010101.3306366-2-shakeel.butt@linux.dev>
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
X-Rspamd-Queue-Id: 2642325A382
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
	TAGGED_FROM(0.00)[bounces-14745-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

cgroup_file_notify() calls kernfs_notify() while holding the global
cgroup_file_kn_lock.  kernfs_notify() does non-trivial work including
wake_up_interruptible() and acquisition of a second global spinlock
(kernfs_notify_lock), inflating the hold time.

Take a kernfs_get() reference under the lock and call kernfs_notify()
after dropping it, following the pattern from cgroup_file_show().

Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
Changes since v1:
- N/A

 kernel/cgroup/cgroup.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 7e99258e9090..b3fbeadb2b5a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4686,6 +4686,7 @@ int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
 void cgroup_file_notify(struct cgroup_file *cfile)
 {
 	unsigned long flags;
+	struct kernfs_node *kn = NULL;
 
 	spin_lock_irqsave(&cgroup_file_kn_lock, flags);
 	if (cfile->kn) {
@@ -4695,11 +4696,17 @@ void cgroup_file_notify(struct cgroup_file *cfile)
 		if (time_in_range(jiffies, last, next)) {
 			timer_reduce(&cfile->notify_timer, next);
 		} else {
-			kernfs_notify(cfile->kn);
+			kn = cfile->kn;
+			kernfs_get(kn);
 			cfile->notified_at = jiffies;
 		}
 	}
 	spin_unlock_irqrestore(&cgroup_file_kn_lock, flags);
+
+	if (kn) {
+		kernfs_notify(kn);
+		kernfs_put(kn);
+	}
 }
 EXPORT_SYMBOL_GPL(cgroup_file_notify);
 
-- 
2.52.0


