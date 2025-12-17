Return-Path: <cgroups+bounces-12394-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ACACC65CA
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 08:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7615305E21F
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 07:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB406326932;
	Wed, 17 Dec 2025 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TGrKrdr6"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B294521772A
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765956572; cv=none; b=bB/zXNhMOb/MPM8UibnFppckw5gsh1G5gLX+KQ2kKpEotBEKpjT2yJxD5oCHbypLjF9+qcevVE8lSo5x/dvpxM2wpoe+w4/ANjioqZIP5qB3zV9defjMQH6oEFKapzOto/sBjbd4HQbL3F5BFAO8S24LXbRgSUNtOWffDZi9Thw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765956572; c=relaxed/simple;
	bh=XElbJXTmKGRKcs6YyHuy5k2fGz3B4Sx4NWCQTaH8EoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8Chb7Pf4hP0BwcW7sOzxoQU03QNkgysMx4YzLJ8NO3CPm83Tb/q55/YnWGO4asQ2h1zJZCtQkbeAWn/dQsmEcS4levzmoYcNkV4PeC0Iuhj3AOrBiNNZXS5tIwQk2Bji0v2LISJtLPO/OdzjgWDp0KWBBgEul2buHWoDK89Br0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TGrKrdr6; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765956563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pE9uf1TLSHkLubOWIgm4VTvwh88IAohI6sYrjRqdOw=;
	b=TGrKrdr6WtZDtwmUq5jN9ccsCd7ukQJQBZZNWllJP0uWeb2+ozNTjHjwdyOUg/IzcxmjCl
	VxzTkWLpcvHPtjwoj2edd4HShUUS29/dYCI9/pLEjwSRZvJW2apkUhBi80y2FQbmJCmaGM
	BG4fA/ZZNwOv1UCSh3TzY6hIaNXKIyY=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	chenridong@huaweicloud.com,
	mkoutny@suse.com,
	akpm@linux-foundation.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	lance.yang@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 04/28] mm: vmscan: prepare for the refactoring the move_folios_to_lru()
Date: Wed, 17 Dec 2025 15:27:28 +0800
Message-ID: <4a7ca63e3d872b7e4d117cf4e2696486772facb6.1765956025.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1765956025.git.zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

After refactoring the move_folios_to_lru(), its caller no longer needs to
hold the lruvec lock, the disabling IRQ is only for __count_vm_events()
and __mod_node_page_state().

On the PREEMPT_RT kernel, the local_irq_disable() cannot be used. To
avoid using local_irq_disable() and reduce the critical section of
disabling IRQ, make all callers of move_folios_to_lru() use IRQ-safed
count_vm_events() and mod_node_page_state().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/vmscan.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 28d9b3af47130..49e5661746213 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2021,12 +2021,12 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 
 	mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),
 					stat.nr_demoted);
-	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
+	mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
 	if (!cgroup_reclaim(sc))
-		__count_vm_events(item, nr_reclaimed);
+		count_vm_events(item, nr_reclaimed);
 	count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
-	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
+	count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
 
 	lru_note_cost_unlock_irq(lruvec, file, stat.nr_pageout,
 					nr_scanned - nr_reclaimed);
@@ -2171,10 +2171,10 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	nr_activate = move_folios_to_lru(lruvec, &l_active);
 	nr_deactivate = move_folios_to_lru(lruvec, &l_inactive);
 
-	__count_vm_events(PGDEACTIVATE, nr_deactivate);
+	count_vm_events(PGDEACTIVATE, nr_deactivate);
 	count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
 
-	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
+	mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 
 	lru_note_cost_unlock_irq(lruvec, file, 0, nr_rotated);
 	trace_mm_vmscan_lru_shrink_active(pgdat->node_id, nr_taken, nr_activate,
@@ -4751,9 +4751,9 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 
 	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
 	if (!cgroup_reclaim(sc))
-		__count_vm_events(item, reclaimed);
+		count_vm_events(item, reclaimed);
 	count_memcg_events(memcg, item, reclaimed);
-	__count_vm_events(PGSTEAL_ANON + type, reclaimed);
+	count_vm_events(PGSTEAL_ANON + type, reclaimed);
 
 	spin_unlock_irq(&lruvec->lru_lock);
 
-- 
2.20.1


