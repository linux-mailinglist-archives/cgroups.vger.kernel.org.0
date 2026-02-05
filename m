Return-Path: <cgroups+bounces-13688-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPdyA8RdhGnS2gMAu9opvQ
	(envelope-from <cgroups+bounces-13688-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 10:07:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECB3F04BF
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 10:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D9E23081826
	for <lists+cgroups@lfdr.de>; Thu,  5 Feb 2026 08:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25533A0EA4;
	Thu,  5 Feb 2026 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rLlYUxEO"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D62F39C636
	for <cgroups@vger.kernel.org>; Thu,  5 Feb 2026 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281819; cv=none; b=IgbXfSke132fTdVbT5Cse+/2Se801NJtZnR04MpwNUCC3XRTV5o2bGbAEdcMKm7TX5ewMqdzbMBnFQikCB2qg1Y75CoHlvqZAN33syDRYvs2Ie5ApfTX6w24QJcUANld5h1MOAyeh+etas4Ehu0HkC/Frmm0dxeKaZdAdXCU/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281819; c=relaxed/simple;
	bh=gb+BlsbmqoUFTzukJ1TbOhAoGI/WoOP8IpI2kzXOECw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzfjpaBrMPQF+PEjHZGbFNyroxxdNbsBMMJ3adQwnk5H1/c2cpJ8wKoZeSf5kj8pAJ6rtx4OZ0N3nkgbvx4iKXAbdlcbHG8VoXE7A9XHKphZi9HQGas7W6MDOPQAnhJx642pKPTE+ZCWRMGLJxNac/ELbNhV5j8X+NuhC8nQkaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rLlYUxEO; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770281817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xl55ZD/XpxuV+TwMC87ANkfW8PG21jVvZfSxHlx1S54=;
	b=rLlYUxEOw0iWYZ4PNnhDDiZpDRQmGWtNZYhMjkOs7ukos96vL4wekfsabjh5SBEnAHtCWs
	k2VFJrJk9OHsKvnamwLWa5fq/jxdbJPNANyWbDRKoABAV1YaM1cS7NwVW1F0Rxi48pw8c+
	n0BGRtlAaOs3GY95R4tzkHiB5eCxNFo=
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
	yosry.ahmed@linux.dev,
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
	lance.yang@linux.dev,
	bhe@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Chen Ridong <chenridong@huawei.com>
Subject: [PATCH v4 04/31] mm: vmscan: prepare for the refactoring the move_folios_to_lru()
Date: Thu,  5 Feb 2026 16:54:33 +0800
Message-ID: <2a61a9f46870a987ec4426cbf88177d9e2ddd628.1770279888.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1770279888.git.zhengqi.arch@bytedance.com>
References: <cover.1770279888.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-13688-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9ECB3F04BF
X-Rspamd-Action: no action

From: Qi Zheng <zhengqi.arch@bytedance.com>

Once we refactor move_folios_to_lru(), its callers will no longer have to
hold the lruvec lock; For shrink_inactive_list(), shrink_active_list() and
evict_folios(), IRQ disabling is only needed for __count_vm_events() and
__mod_node_page_state().

To avoid using local_irq_disable() on the PREEMPT_RT kernel, let's make
all callers of move_folios_to_lru() use IRQ-safed count_vm_events() and
mod_node_page_state().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Chen Ridong <chenridong@huawei.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
---
 mm/vmscan.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a4892f5e3d347..f595e063faeec 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2028,12 +2028,12 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 
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
@@ -2178,10 +2178,10 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	nr_activate = move_folios_to_lru(lruvec, &l_active);
 	nr_deactivate = move_folios_to_lru(lruvec, &l_inactive);
 
-	__count_vm_events(PGDEACTIVATE, nr_deactivate);
+	count_vm_events(PGDEACTIVATE, nr_deactivate);
 	count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
 
-	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
+	mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 
 	lru_note_cost_unlock_irq(lruvec, file, 0, nr_rotated);
 	trace_mm_vmscan_lru_shrink_active(pgdat->node_id, nr_taken, nr_activate,
@@ -4757,9 +4757,9 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 
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


