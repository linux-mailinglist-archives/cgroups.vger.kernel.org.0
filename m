Return-Path: <cgroups+bounces-15480-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cByDLHuD6mn80AIAu9opvQ
	(envelope-from <cgroups+bounces-15480-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:39:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A09C457531
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E25A930712C1
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 20:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3C634EEE1;
	Thu, 23 Apr 2026 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up/P7GKv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42439346784
	for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776976506; cv=none; b=MHl1kU4AdjhtMm6pNbwp3dtsteN3LEHJWq0eIm7Kn9HHh5gF/G2D7TXH9W2rblPNrsy56FgOyQbLCqtDEyWiNAXzSebM1Yk0fyEv4EI0X5t/eWDj7aXiahu92cUb5ZHwKMakh5DbTYxOOPcf9qE9vHvg1J3latzTIQSvS/Bvq9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776976506; c=relaxed/simple;
	bh=RKwyc5ityashLjP4KmDsx4hUDeZ5424iiaAS5OUt9G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nw41gKFgaFCEVJbdQNRtSrjzBoVgCmg5Rpj1Lkzr2TkCMfLAMlbg05KmU5K5YR/C3d+626rmhQX/cEjAlVcNnJpPNdI2m3TS3jyovG7CWRaJgPAjzLUC6qaD5K7pEssViseFVdoH1xMer2rhrCq2RprvRGVhsRpiWX7tdRzlwzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Up/P7GKv; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-479ef2b7979so2353374b6e.3
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776976502; x=1777581302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIA1ATnBximdIVrwS2AHkBrrXRUA8+TS+BtXj7CLEVI=;
        b=Up/P7GKvUbF4l6R9eDD3e55iDJn4oMitWq3vVPJxmOnzScR0LE/skShKjaYFeckoX4
         45MoXfrADQ1hj7aLMtDm+Ho25yS4P6dMxAsK1eogvg7tuGnSt3N3u3G7ydHP/6K5eNkG
         JRnz7UUQCcAVuOhtkOs+vOhZl7UDzMSvm6nTmgJbZT6Z0Iz7TEQt5MYAyG3axP3kvHPF
         qTzGcaYQu+rgm6FlzeVcqiIlal/v5Wk/x41hWw3FzuvZG+uDWsw59SKPk56Tq0OoHwHg
         EPCQb7T1UXd+WJ7uZU9qcZ9j6VDT/LMEBmrNIA8Wb5jP4Oot6sKSiyh7ePLWftHZtDhJ
         bPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776976502; x=1777581302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VIA1ATnBximdIVrwS2AHkBrrXRUA8+TS+BtXj7CLEVI=;
        b=s3ybdQWcz4q2I/8bvtMjHh2Bchc37VAb2W1n8/Esn3p3uI4dnTnzGCM2tWrzXb4BHV
         kGJiTmGVcaxm89SJ9mJ4xMQtBJg/6FJJWPxgkxB6Ezt0PLKH0FCCJDv8U3j2qMp1fbtK
         n0si92Q8nBif+ole9L47Z/XJGlgSaYtW/z2oZb7A+ce4FJag/ElfDVIyuzsOnl8D/6JZ
         jBnITJ0uwFjF10+SWrxbX/qCtdnwS/HwtmrPcQn5qrQRRE/bDXbhsdFTz8inQTIfrvWE
         GjlmaOo37vMRTQbWTFnkonC59qm55kG97gYBZpiOK4vieLdoQBuy2O8PKzXARn+vrQCv
         bkwg==
X-Forwarded-Encrypted: i=1; AFNElJ+xAK+L5/3EMMFFwE0dVgXl3QdsFcfM86W1H33CjtpVF0tpii2E2yVep0ySNBXs1VKR7nLGzb1O@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc0pReoqNevCUPY2nJvDeCmNR/+YVF9FssFLZ75+E57QTD5AxU
	7QYYWD5jYjOSTzUXPXaNrDlIXyNJihhvCq3+OLCAekjAcKEdY2L9LnNHeAM5HA==
X-Gm-Gg: AeBDieuVTOZTjj2fiMRK/3iuCUjAu6fzTDnPpyQRIGuq/YTvBWOfPDTzuK2mOQclmpF
	WQxXiubw1nItckZPRL95KIiRjV38mnciS2t7HPW3wdMsZg5+9xiJke8tuPr8XulP+oThlDI3ACN
	ah83wod49HUBDyvGj4eAab/HOcyfBQbwpsmmPrN+eMSnIHjIACr9T10SdFyZLsBz0PIPzkkMd7D
	ZQ/wUFmL20AnKzlRm26g65t0iwUB08KY45zl9CAaCbsF8+biWgz7S6LAf1Fv2EDYs+UtkIplBCd
	d2+cYLos3UYz5A9gQ7AC+BKhKTIdr2yCcRv2nQgJ7NEhhZi2X7rIUpvqNMszo6FN940p6kEDoVj
	/h/Q6MLoZIZOzAFRMlhP3Ydg2+Bk6/LPIgdGuL96K/mqWukQBAywRX49ybxR+U2XQkxKCmgksQR
	sKjdmvWCgvF2IGGHcpvb7dtHaJVhmTrrc=
X-Received: by 2002:a05:6808:e642:b0:47a:ae7:b5f6 with SMTP id 5614622812f47-47a0ae7c548mr3040802b6e.43.1776976501368;
        Thu, 23 Apr 2026 13:35:01 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479f6705d7asm5629481b6e.10.2026.04.23.13.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:34:58 -0700 (PDT)
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
Subject: [RFC PATCH 8/9 v2] mm/memcontrol: Make memory.high tier-aware
Date: Thu, 23 Apr 2026 13:34:42 -0700
Message-ID: <20260423203445.2914963-9-joshua.hahnjy@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-15480-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 6A09C457531
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

Extend the existing memory.high protection to be tier-aware.

Depending on the combination of limit breaches, selectively reclaim on
toptier nodes: when memory.high is breached, perform reclaim on all
nodes. When memory.high is safe but toptier.high is breached, perform
targeted reclaim on toptier nodes only.

Also, throttle allocations when toptier is breached as well, making sure
not to double-penalize when both toptier and memory limits are met.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 82 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b115ff40e268d..e5f39830d250d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2112,10 +2112,25 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 
 	do {
 		unsigned long pflags;
+		nodemask_t toptier_nodes;
+		nodemask_t *reclaim_targets = NULL;
 
 		if (page_counter_read(&memcg->memory) <=
-		    READ_ONCE(memcg->memory.high))
-			continue;
+		    READ_ONCE(memcg->memory.high)) {
+			if (!mem_cgroup_tiered_limits())
+				continue;
+
+			/*
+			 * Even if the memcg is under the memory limit, toptier
+			 * may have breached the toptier limit. Engage
+			 * targeted reclaim on toptier nodes if so.
+			 */
+			if (page_counter_read(&memcg->toptier) <=
+			    READ_ONCE(memcg->toptier.high))
+				continue;
+			get_toptier_nodemask(&toptier_nodes);
+			reclaim_targets = &toptier_nodes;
+		}
 
 		memcg_memory_event(memcg, MEMCG_HIGH);
 
@@ -2123,7 +2138,7 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
 							gfp_mask,
 							MEMCG_RECLAIM_MAY_SWAP,
-							NULL, NULL);
+							NULL, reclaim_targets);
 		psi_memstall_leave(&pflags);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
@@ -2224,6 +2239,23 @@ static u64 mem_find_max_overage(struct mem_cgroup *memcg)
 	return max_overage;
 }
 
+static u64 toptier_find_max_overage(struct mem_cgroup *memcg)
+{
+	u64 overage, max_overage = 0;
+
+	if (!mem_cgroup_tiered_limits())
+		return 0;
+
+	do {
+		overage = calculate_overage(page_counter_read(&memcg->toptier),
+					    READ_ONCE(memcg->toptier.high));
+		max_overage = max(overage, max_overage);
+	} while ((memcg = parent_mem_cgroup(memcg)) &&
+		  !mem_cgroup_is_root(memcg));
+
+	return max_overage;
+}
+
 static u64 swap_find_max_overage(struct mem_cgroup *memcg)
 {
 	u64 overage, max_overage = 0;
@@ -2326,6 +2358,14 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
 	penalty_jiffies = calculate_high_delay(memcg, nr_pages,
 					       mem_find_max_overage(memcg));
 
+	/*
+	 * Don't double-penalize for toptier high overage if memory.high
+	 * overage penalization has already been accounted for.
+	 */
+	if (!penalty_jiffies)
+		penalty_jiffies += calculate_high_delay(memcg, nr_pages,
+					toptier_find_max_overage(memcg));
+
 	penalty_jiffies += calculate_high_delay(memcg, nr_pages,
 						swap_find_max_overage(memcg));
 
@@ -2522,22 +2562,26 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 */
 	do {
 		bool mem_high, swap_high;
+		bool toptier_high = false;
 
 		mem_high = page_counter_read(&memcg->memory) >
 			READ_ONCE(memcg->memory.high);
 		swap_high = page_counter_read(&memcg->swap) >
 			READ_ONCE(memcg->swap.high);
+		toptier_high = mem_cgroup_tiered_limits() &&
+			       page_counter_read(&memcg->toptier) >
+			       READ_ONCE(memcg->toptier.high);
 
 		/* Don't bother a random interrupted task */
 		if (!in_task()) {
-			if (mem_high) {
+			if (mem_high || toptier_high) {
 				schedule_work(&memcg->high_work);
 				break;
 			}
 			continue;
 		}
 
-		if (mem_high || swap_high) {
+		if (mem_high || swap_high || toptier_high) {
 			/*
 			 * The allocating tasks in this cgroup will need to do
 			 * reclaim or be throttled to prevent further growth
@@ -4577,10 +4621,28 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
-		unsigned long reclaimed;
+		unsigned long reclaimed, charge;
+		nodemask_t toptier_nodes;
+		nodemask_t *reclaim_targets = NULL;
 
-		if (nr_pages <= high)
-			break;
+		if (nr_pages <= high) {
+			unsigned long toptier_nr_pages, toptier_high;
+
+			if (!mem_cgroup_tiered_limits())
+				break;
+
+			toptier_nr_pages = page_counter_read(&memcg->toptier);
+			toptier_high = READ_ONCE(memcg->toptier.high);
+
+			if (toptier_nr_pages <= toptier_high)
+				break;
+
+			get_toptier_nodemask(&toptier_nodes);
+			reclaim_targets = &toptier_nodes;
+			charge = toptier_nr_pages - toptier_high;
+		} else {
+			charge = nr_pages - high;
+		}
 
 		if (signal_pending(current))
 			break;
@@ -4591,9 +4653,9 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 			continue;
 		}
 
-		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
+		reclaimed = try_to_free_mem_cgroup_pages(memcg, charge,
 					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
-					NULL, NULL);
+					NULL, reclaim_targets);
 
 		if (!reclaimed && !nr_retries--)
 			break;
-- 
2.52.0


