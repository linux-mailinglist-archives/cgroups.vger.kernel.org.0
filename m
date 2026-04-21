Return-Path: <cgroups+bounces-15403-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO5RLAIR52nL3QEAu9opvQ
	(envelope-from <cgroups+bounces-15403-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 07:54:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA8C436992
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 07:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ACA4302307A
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BAC33B6C4;
	Tue, 21 Apr 2026 05:53:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE7336EC5
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776750819; cv=none; b=FJfdieKxmDCQdi5aPEch4vxtduOvP4ef8HMxVpG1xmkBcGFMAQZOU6qkbWg859FIlDRi9LuEh+yR4h5YKpM0vTVawUYX39WEp6CnQ7PPnPwM+nHLIuHGjccvdKW/8whHhbely2sVaePF+xhTAFIzzuMHKY3+JMK4a+s/iHJvzDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776750819; c=relaxed/simple;
	bh=59H4eAFmuyUkrVwqS+6ufik0+yDG1g7VpV6Tq2weuBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OgAILfDqXwwQT3g4I/GZoSFeA/kapF7IXeb2IfKvxEWvWb/9uXEzxjLYIjuSRHCSGp34QEge42YDn8YfRqsumJU3Omzw33tbjbX9Zj/KCs10LDynsDuSj8RkMgfEtWUov6PrjLTc+zk/1fjapE200+Nti+6aDqRHaR3T89z1yNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 21 Apr 2026 14:53:33 +0900
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
	bhe@redhat.com,
	baohua@kernel.org,
	gunho.lee@lge.com,
	taejoon.song@lge.com,
	hyungjun.cho@lge.com,
	mkoutny@suse.com,
	baver.bae@lge.com,
	matia.kim@lge.com
Subject: [PATCH v6 4/4] mm: swap: filter swap allocation by memcg tier mask
Date: Tue, 21 Apr 2026 14:53:23 +0900
Message-Id: <20260421055323.940344-5-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421055323.940344-1-youngjun.park@lge.com>
References: <20260421055323.940344-1-youngjun.park@lge.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15403-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2BA8C436992
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
 mm/swapfile.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index d5abc831cde7..8734e5d26b08 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1352,15 +1352,22 @@ static bool swap_alloc_fast(struct folio *folio)
 	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
 	unsigned int offset;
+	int mask = folio_tier_effective_mask(folio);
 
 	/*
 	 * Once allocated, swap_info_struct will never be completely freed,
 	 * so checking it's liveness by get_swap_device_info is enough.
 	 */
 	si = this_cpu_read(percpu_swap_cluster.si[order]);
+	if (!si || !swap_tiers_mask_test(si->tier_mask, mask) ||
+		!get_swap_device_info(si))
+		return false;
+
 	offset = this_cpu_read(percpu_swap_cluster.offset[order]);
-	if (!si || !offset || !get_swap_device_info(si))
+	if (!offset) {
+		put_swap_device(si);
 		return false;
+	}
 
 	ci = swap_cluster_lock(si, offset);
 	if (cluster_is_usable(ci, order)) {
@@ -1379,10 +1386,14 @@ static bool swap_alloc_fast(struct folio *folio)
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


