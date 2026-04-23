Return-Path: <cgroups+bounces-15479-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDnHNniD6mn80AIAu9opvQ
	(envelope-from <cgroups+bounces-15479-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:39:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA3E45752A
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BF13306EF10
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 20:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAFA347536;
	Thu, 23 Apr 2026 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izpImXtv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2E83451A9
	for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776976505; cv=none; b=dLawZeU+ybeGhq9JXBR+4lvU+SKEqOptvNzIeZIDbOptheK5v7U2SjI5KDkH9pXWmPT52ndhRwmwqu2qiggeyA3O+xDi+QsI/UlyPItLif+pMsjETD6XqpatYdhhJ4ZrKV0FfyaUrP/X4xMHZrOKODFiSfx5i5nB3RUcnjjZXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776976505; c=relaxed/simple;
	bh=X0KVZocSB/kQAXbaJ8RFL/IxN+NQQ785g3daaat8ObI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmt19ORn6O06EswWU/FiwBSNN/1hr0swG7xF5YZkmOWx/YEw4Hhs1Mq8i60vea8vz2KvMCch92J9KWYhHOL6+db3QnlmXwTXSOVLtC7ukxnjgLG9G7UR4zFqdFQ+sZPVa4oQUB7XEXJ3a2z6l2kEfoPxafIL1StoRlRKGKsKDLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izpImXtv; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dcdd1b492eso3027675a34.1
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776976503; x=1777581303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxH+yk1exTjyfi+5qxKujuSUOSqkgCGj2Y+qVsczotM=;
        b=izpImXtv5c/k1MH8h6AcpMi0lGah9eHJckYknV6SrQteZwwI0YDdtr93A1M3dp6mjU
         y6EdOZSJrZXucQOEgl7BkK78JQiLYYuJRb2AoFikRoWXVfAxFqpfZciQIvR+C0XKGeoo
         7Ui/7dXslNfjrrSabZh70aHt3Rm3aYSRfU8rjFOW0uLoFSPQSW+yVulr8biOTooNca0Q
         YQA71K2aBscZIExoJfNvZxC6nWimpescpAsHD0QJo6gGF6XW832QBS6wAdnVnAyFK9ed
         Vwqsj84yR4uRuJD9c9dYoE+dAo6p3rvhoOf/t1qpfwJRZbx8b3qQx8STSgidxcwPfWRM
         aiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776976503; x=1777581303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IxH+yk1exTjyfi+5qxKujuSUOSqkgCGj2Y+qVsczotM=;
        b=WMNSa0GOEfsUCmim+Ddrf7PP6YOUhjce7UL7cylkwc5bYiwBnUlgWNJSuKyCIw0v1P
         bnon5/oso1AKGZT1OxeomZMO0lD5FpHxPXi2cMfLm0QhZBPbE4004NtG0jWgLiqjvE6Y
         HWNdEiRZDIdZizJl+h3Q2j4F++QMd/hsy+uKWRYeWE1U17TgjMH9aRqbnZp9Uoj0Ww5e
         iOiBZJxhxqMW+1hTHNJ9TrjWT4NGpZmnaHdklNq+VnI2UeejVvV4HPTB6lWM0F11ckCL
         KxPoJBWN3q5sVzcSaHLSGwLI/TMMU/2euFzI96Rr5EWJJecnAXA5U6P7E021MOs1EPX4
         +42A==
X-Forwarded-Encrypted: i=1; AFNElJ97N+06KH7F4kQb3hYYMKvR+yHoXlTTJ8Y+6Og/22eQkSKRWSPJ9In8/4fOtYRYkg38SgkvjpHB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/msUy/XgYoXRfhF/95/LL59O32ZTsCy4q6no46DR0EahXV3PL
	CK3e0DDhNmUFNe/ezyjpCc37EFNFHjrL7TNS6lZhO+2ADGo0UIxFNeaO
X-Gm-Gg: AeBDiessZl6hlJ4jbr+i9aJj9cEfExRKzvafqqYmGWO8SbO7fUy3W6kS8zA5tNSvEoi
	z5haXh7BxsPXo9y7+6iWS59uIyrjNym17FztvkBDkbK2Np6Bn7hKmOqZYKi7OTvbXgSE1b9eW53
	gDwOjyPKmb1uf5ixLcxPhVEuSWk98qJLG9gt9ZWcSJcZuiIqce/5vXGiYQv4E3oyeLKiaDuGN8z
	jmn5hMNw+VZEhIDkstgblKlBrVqnBHBPU2Y60GOcDUciP4kNsPzkR4DtYMV+IamqB5bEy2ZxUG6
	JCMaZuCgDevSqKhnDVn/XHC/24v/kEw2HPjwbG9RSWsUTPaAnFLEFvDQZoPNDllgw98hJ2In81/
	i0kp/0T2ijhIgX/di7UnA0Rs5MPH0Z6SZIch7un5rm8aSHb3xbRICOU0es4XFRNedzu+cuXvm02
	bbZHQNt67ZRmCoPDyZH0vRmJ1LkvBKRNOg
X-Received: by 2002:a9d:6044:0:b0:7dc:807:d1f3 with SMTP id 46e09a7af769-7dc9550d8e2mr10674183a34.7.1776976503071;
        Thu, 23 Apr 2026 13:35:03 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc892c515sm10877354a34.21.2026.04.23.13.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:35:02 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 9/9 v2] mm/memcontrol: Make memory.max tier-aware
Date: Thu, 23 Apr 2026 13:34:43 -0700
Message-ID: <20260423203445.2914963-10-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423203445.2914963-1-joshua.hahnjy@gmail.com>
References: <20260423203445.2914963-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-15479-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CA3E45752A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On machines serving multiple workloads whose memory is isolated via the
memory cgroup controller, it is currently impossible to enforce a fair
distribution of toptier memory among the workloads, as the limits only
enforce total memory footprint, but not where that memory resides.

This makes ensuring consistent baseline performance difficult, as each
workload's performance is heavily impacted by workload-external factors
such as which other workloads are co-located in the same host, and the
order in which the workloads are started.

Extend the existing memory.max protection to be tier-aware.

Depending on the combination of limit breaches, selectively reclaim on
toptier nodes: when memory.max is breached, perform reclaim on all
nodes.  When memory.max is safe but toptier.max is breached, perform
targeted reclaim on toptier nodes only.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 56 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e5f39830d250d..d8d67ada993ff 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1518,6 +1518,15 @@ static unsigned long mem_cgroup_margin(struct mem_cgroup *memcg)
 	if (count < limit)
 		margin = limit - count;
 
+	if (mem_cgroup_tiered_limits()) {
+		count = page_counter_read(&memcg->toptier);
+		limit = READ_ONCE(memcg->toptier.max);
+		if (count < limit)
+			margin = min(margin, limit - count);
+		else
+			margin = 0;
+	}
+
 	if (do_memsw_account()) {
 		count = page_counter_read(&memcg->memsw);
 		limit = READ_ONCE(memcg->memsw.max);
@@ -2424,11 +2433,12 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool raised_max_event = false;
 	unsigned long pflags;
 	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
-	bool toptier_charged;
+	nodemask_t toptier_nodes;
+	nodemask_t *reclaim_nodes;
 
 retry:
 	reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
-	toptier_charged = false;
+	reclaim_nodes = NULL;
 
 	if (do_memsw_account() &&
 	    !page_counter_try_charge(&memcg->memsw, nr_pages, &counter)) {
@@ -2438,13 +2448,20 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	}
 
 	if (toptier &&
-	    page_counter_try_charge(&memcg->toptier, nr_pages, &counter))
-		toptier_charged = true;
+	    !page_counter_try_charge(&memcg->toptier, nr_pages, &counter)) {
+		get_toptier_nodemask(&toptier_nodes);
+		reclaim_nodes = &toptier_nodes;
+		mem_over_limit = mem_cgroup_from_counter(counter, toptier);
+
+		if (do_memsw_account())
+			page_counter_uncharge(&memcg->memsw, nr_pages);
+		goto reclaim;
+	}
 
 	if (page_counter_try_charge(&memcg->memory, nr_pages, &counter))
 		goto done_restock;
 
-	if (toptier_charged)
+	if (toptier)
 		page_counter_uncharge(&memcg->toptier, nr_pages);
 	if (do_memsw_account())
 		page_counter_uncharge(&memcg->memsw, nr_pages);
@@ -2473,7 +2490,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	psi_memstall_enter(&pflags);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
 						    gfp_mask, reclaim_options,
-						    NULL, NULL);
+						    NULL, reclaim_nodes);
 	psi_memstall_leave(&pflags);
 
 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
@@ -4683,7 +4700,8 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
 	unsigned int nr_reclaims = MAX_RECLAIM_RETRIES;
 	bool drained = false;
-	unsigned long max;
+	unsigned long max, toptier_max = PAGE_COUNTER_MAX;
+	nodemask_t toptier_nodes;
 	int err;
 
 	buf = strstrip(buf);
@@ -4692,16 +4710,30 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 		return err;
 
 	xchg(&memcg->memory.max, max);
-	if (mem_cgroup_tiered_limits())
-		xchg(&memcg->toptier.max, page_counter_max_or_scale(max));
+	if (mem_cgroup_tiered_limits()) {
+		toptier_max = page_counter_max_or_scale(max);
+		xchg(&memcg->toptier.max, toptier_max);
+		get_toptier_nodemask(&toptier_nodes);
+	}
 
 	if (of->file->f_flags & O_NONBLOCK)
 		goto out;
 
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
+		unsigned long nr_toptier = page_counter_read(&memcg->toptier);
+		unsigned long to_reclaim = 0;
+		nodemask_t *reclaim_nodes = NULL;
+
+		if (nr_pages > max) {
+			to_reclaim = nr_pages - max;
+		} else if (mem_cgroup_tiered_limits() &&
+				nr_toptier > toptier_max) {
+			to_reclaim = nr_toptier - toptier_max;
+			reclaim_nodes = &toptier_nodes;
+		}
 
-		if (nr_pages <= max)
+		if (!to_reclaim)
 			break;
 
 		if (signal_pending(current))
@@ -4714,9 +4746,9 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 		}
 
 		if (nr_reclaims) {
-			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
+			if (!try_to_free_mem_cgroup_pages(memcg, to_reclaim,
 					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
-					NULL, NULL))
+					NULL, reclaim_nodes))
 				nr_reclaims--;
 			continue;
 		}
-- 
2.52.0


