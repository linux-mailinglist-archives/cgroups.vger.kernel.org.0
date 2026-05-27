Return-Path: <cgroups+bounces-16336-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEqWMWCPFmrHnQcAu9opvQ
	(envelope-from <cgroups+bounces-16336-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 08:29:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 261C85DFDA1
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 08:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D8430BF96B
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 06:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3563164B7;
	Wed, 27 May 2026 06:23:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94FA315D21
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 06:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863034; cv=none; b=FUnULoQBzju/yg9C585zFeHkpa6v4mrwRu71uP2+n2PvhswLgTAb3Zq1/L+QKZ4A5RFYsqgFlgSLZCT0iF1MgTqHykLLHMzkjVbJ9ZPp8vHqj9aQ0BqOq8jtgD307jUplQeCWQUOfKaQES0N/YWxOEiOIjCBLXmcoYfD0MdsbX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863034; c=relaxed/simple;
	bh=oay6c+jrn56hkFby6pQILUHzTTGLnQOfn55wjDbY36M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DFPVAk884qkxQJfwCs43rh16FPFO/jarYHzIFQZjHLtoYzbL8c4h2kmNEdF2NDTbKekzhmXlfUeQpBo5Sk54B/V3fFqC6jgNbvUFv+Ipg4xoYtVr6vlcEeTWeAEOSH9FPdRdYHgK1wZGd227cAbzxORS5Uo4pU/+WvL30tKoj9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 27 May 2026 15:23:50 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: akpm@linux-foundation.org
Cc: chrisl@kernel.org,
	youngjun.park@lge.com,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	gunho.lee@lge.com,
	taejoon.song@lge.com,
	hyungjun.cho@lge.com,
	mkoutny@suse.com,
	baver.bae@lge.com,
	matia.kim@lge.com
Subject: [PATCH v7 4/4] mm: swap: filter swap allocation by memcg tier mask
Date: Wed, 27 May 2026 15:22:47 +0900
Message-Id: <20260527062247.3440692-5-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527062247.3440692-1-youngjun.park@lge.com>
References: <20260527062247.3440692-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16336-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,suse.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.987];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lge.com:mid,lge.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 261C85DFDA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Apply memcg tier effective mask during swap slot allocation to
enforce per-cgroup swap tier restrictions.

In the fast path, check the percpu cached swap_info's tier_mask
against the folio's effective mask. If it does not match, fall
through to the slow path. In the slow path, skip swap devices
whose tier_mask is not covered by the folio's effective mask.

This works correctly when there is only one non-rotational
device in the system and no devices share the same priority.
However, there are known limitations:

 - When non-rotational devices are distributed across multiple
   tiers, and different memcgs are configured to use those
   distinct tiers, they may constantly overwrite the shared
   percpu swap cache. This cache thrashing leads to frequent
   fast path misses.

 - Combined with the above issue, if same-priority devices exist
   among them, a percpu cache miss (overwritten by another memcg)
   forces the allocator to round-robin to the next device
   prematurely, even if the current cluster is not fully
   exhausted.

These edge cases do not affect the primary use case of
directing swap traffic per cgroup. Further optimization is
planned for future work.

Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 mm/swapfile.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9a86ebe992f4..1a2d29735b71 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1365,14 +1365,18 @@ static bool swap_alloc_fast(struct folio *folio)
 	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
 	unsigned int offset;
+	int mask = folio_tier_effective_mask(folio);
 
 	/*
 	 * Once allocated, swap_info_struct will never be completely freed,
 	 * so checking it's liveness by get_swap_device_info is enough.
 	 */
 	si = this_cpu_read(percpu_swap_cluster.si[order]);
+	if (!si || !swap_tiers_mask_test(si->tier_mask, mask))
+		return false;
+
 	offset = this_cpu_read(percpu_swap_cluster.offset[order]);
-	if (!si || !offset || !get_swap_device_info(si))
+	if (!offset || !get_swap_device_info(si))
 		return false;
 
 	ci = swap_cluster_lock(si, offset);
@@ -1392,10 +1396,14 @@ static bool swap_alloc_fast(struct folio *folio)
 static void swap_alloc_slow(struct folio *folio)
 {
 	struct swap_info_struct *si, *next;
+	int mask = folio_tier_effective_mask(folio);
 
 	spin_lock(&swap_avail_lock);
 start_over:
 	plist_for_each_entry_safe(si, next, &swap_avail_head, avail_list) {
+		if (!swap_tiers_mask_test(si->tier_mask, mask))
+			continue;
+
 		/* Rotate the device and switch to a new cluster */
 		plist_requeue(&si->avail_list, &swap_avail_head);
 		spin_unlock(&swap_avail_lock);
-- 
2.34.1


