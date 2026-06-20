Return-Path: <cgroups+bounces-17094-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CvirLnLZNmo/FgcAu9opvQ
	(envelope-from <cgroups+bounces-17094-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 20:18:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5606A975F
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 20:18:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BHdFa90z;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17094-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17094-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE7013035256
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 18:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9264345CAF;
	Sat, 20 Jun 2026 18:17:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AF130F7F7
	for <cgroups@vger.kernel.org>; Sat, 20 Jun 2026 18:17:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781979431; cv=none; b=WOeI1XjP6M5IdFq3IrbE/W9ePoaumpOoCFlq2O9kFKauNwcoq7XShrlE/MmO5Hfr3iEhMLCPz6sY2UZejpsJls6cHS2fS59rPVkmhgf2M/OZm+lPLCdIzt1n/cNL1DmHbsH3z4YXtLykU28m9RVRyvVYxxqHUGzcmFAzOTBX7wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781979431; c=relaxed/simple;
	bh=pNZz6I4aoMMaZf0YjkzTitFAZSWSIRpbW4EBzjpsk58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6jDGqfMGrQ4/vzivhayY73R+IM0OW3MZS/5ULuBraPxXtKRUpGVH8QmlfknDXfyeD3QUmN1kSHJqqkw0g3lxUS/ViPM2cpFcmPGWKB2eOq1TJPJm1cYo9MtI8hIHq6z5kqsZvWRPyEkoXIXVopuCQM0H0KZs5C3TtME87a+3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHdFa90z; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c6fcfcdb2bso22600115ad.1
        for <cgroups@vger.kernel.org>; Sat, 20 Jun 2026 11:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781979429; x=1782584229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYeylIml7s8sCOsaJDbGPnepJyRivCDRMtCf2+mDIaE=;
        b=BHdFa90zDBclBbApum0Qi05Ka1yzsIznYnkCXMELg67yXA3dKrAJH75SvJ4FwZM4P9
         gJMSPvN+8xS3UrJcx/8lb+iCyprUkcouX99i0BW/WGOjfv5lR9y6XKamXyi6CRLgj0Ci
         zVovixSVBIHdokoDPo1g36dF9KCoRfb34CNGDhOKxqEVkQn/X/cVnjUknibkYOHU7qYu
         0CR7CsArxbE7ns3DameBvR4W2HojLmt2S3vzdrX+WHIHVzzlTcjSae8Ea3H4GqpGel5N
         zCXncyp7bPofdiSNY5DzJu+z50JQBPVcfJR3cDTVmSt/6RcLgYXUDjHFeFHJYfs3frhy
         q4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781979429; x=1782584229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GYeylIml7s8sCOsaJDbGPnepJyRivCDRMtCf2+mDIaE=;
        b=XAoIGspud25GMcvI0+KPedchAGomTryuTcIRB46H9x6mO77hyRVHtY1w1uLlLkKgsX
         FvqSDRcyA0addBP0rNnKqKx8ie6dmqYrxn/FXzW0tNqSfFnaYRSveTkHdM3OGAUHZJUz
         eMgUVFXQzXWIphMG/lOZ8ThCt2pd2PJRPySSIixP2ke0Zju2IIrm9N373lVI6K7uKX29
         jJsT5fampmqw0QOD4C10/JXZ1muTdsz0I4ZRNWX4tuZUX2HZQ7sX+2nc5LpFHsFE8pPN
         NJLPhtXkg6YtD2G/KMsFomJEVNpVEBSWEUFEc+vm9Kt/eSrz0Z7cvmtEqoHOdSndKw6J
         7Tcw==
X-Forwarded-Encrypted: i=1; AHgh+RqorvcSCJlEKDDKx7z37xJ6n3NRqSqn93L62nVuNDzwNNcfHD6Zc39mJ7R5+bvEnVo2kUmKHr6L@vger.kernel.org
X-Gm-Message-State: AOJu0YzLLnUjzQpJaGNT6GuJ4/cNR5u49vnacVitmxVnuhhg5fMaH1nN
	FWZGQBFnnBHt6804UPmMWxqLZ24YSKKo7enYlzl6zGYZ5T4ARxirKZVs
X-Gm-Gg: AfdE7ckYj4pBMMaYoDE+JO6cmmhBVSa4ExMxXuDCkNPwCjVxAll3UrTwOfxystZs3kh
	Mz6ZNo5x37x9FkGVMEV7QBfN2pZdwFbi+PSymtYXrTQgNApUDkwFgmEKWk40pNU/LjqEoLGra/1
	4mPd8thMSHq+srhrbu0uhFoFHBNRVgPjt4fbVTbkn835l2BCgfj7ToleMAUJM77dk8KkvZqeI+Q
	FFa1o9gMIsDbV45LMDF+Lv5XjRH+ZsuHd3oetvv+kVMiUsFN9PMBTUvbODHF3ULhkRCElaaZvsV
	tH3mx1lKyU7kwbWHwalqojQBXe5++EfOnBK4VHfxwFOpwStARKPC5mJBPRfzoI61xg6mJ5LNqIN
	bGIfwt3EfFGix7gNjxJvxpQEeV81Zo7mjOuQo7jR3x2B09V6M7RL6b8gNixE3XWYV6cPNklsH59
	lK3tC9ekOGkFhrVySkAE8Q4TZOx2PzkauGZVzuEAxhuChR9fmR5osTrWskF+wWyKbInDcx83F50
	g==
X-Received: by 2002:a17:902:d586:b0:2c2:27be:39aa with SMTP id d9443c01a7336-2c725d7d58dmr82330625ad.17.1781979429395;
        Sat, 20 Jun 2026 11:17:09 -0700 (PDT)
Received: from localhost.localdomain ([220.85.166.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af6d9sm30339465ad.4.2026.06.20.11.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 11:17:08 -0700 (PDT)
From: Youngjun Park <her0gyugyu@gmail.com>
X-Google-Original-From: Youngjun Park <youngjun.park@lge.com>
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
	yosry@kernel.org,
	gunho.lee@lge.com,
	taejoon.song@lge.com,
	hyungjun.cho@lge.com,
	mkoutny@suse.com,
	baver.bae@lge.com,
	matia.kim@lge.com
Subject: [PATCH v9 4/6] mm: swap: filter swap allocation by memcg tier mask
Date: Sun, 21 Jun 2026 03:16:29 +0900
Message-ID: <20260620181635.299364-5-youngjun.park@lge.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260620181635.299364-1-youngjun.park@lge.com>
References: <20260620181635.299364-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:youngjun.park@lge.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:yosry@kernel.org,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:mkoutny@suse.com,m:baver.bae@lge.com,m:matia.kim@lge.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17094-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[her0gyugyu@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,suse.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[her0gyugyu@gmail.com,cgroups@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lge.com:mid,lge.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E5606A975F

Apply memcg tier effective mask during swap slot allocation to
enforce per-cgroup swap tier restrictions.

The folio's effective mask is computed once and passed to the fast,
slow and discard paths as a parameter, so all of them act on the same
mask even if the memcg's mask changes concurrently.

In the fast path, check the percpu cached swap_info's tier_mask
against the folio's effective mask. If it does not match, fall
through to the slow path. In the slow path, skip swap devices
whose tier_mask is not covered by the folio's effective mask.
The discard fallback honors the mask too: otherwise it would drain
the discard clusters of a device outside the folio's tiers and then
loop back to allocate from a tier the memcg is not allowed to use.

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
 mm/swapfile.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9a86ebe992f4..624d1ba93fd9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1359,7 +1359,7 @@ static bool get_swap_device_info(struct swap_info_struct *si)
  * Fast path try to get swap entries with specified order from current
  * CPU's swap entry pool (a cluster).
  */
-static bool swap_alloc_fast(struct folio *folio)
+static bool swap_alloc_fast(struct folio *folio, int mask)
 {
 	unsigned int order = folio_order(folio);
 	struct swap_cluster_info *ci;
@@ -1371,8 +1371,11 @@ static bool swap_alloc_fast(struct folio *folio)
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
@@ -1389,13 +1392,16 @@ static bool swap_alloc_fast(struct folio *folio)
 }
 
 /* Rotate the device and switch to a new cluster */
-static void swap_alloc_slow(struct folio *folio)
+static void swap_alloc_slow(struct folio *folio, int mask)
 {
 	struct swap_info_struct *si, *next;
 
 	spin_lock(&swap_avail_lock);
 start_over:
 	plist_for_each_entry_safe(si, next, &swap_avail_head, avail_list) {
+		if (!swap_tiers_mask_test(si->tier_mask, mask))
+			continue;
+
 		/* Rotate the device and switch to a new cluster */
 		plist_requeue(&si->avail_list, &swap_avail_head);
 		spin_unlock(&swap_avail_lock);
@@ -1429,7 +1435,7 @@ static void swap_alloc_slow(struct folio *folio)
  * Discard pending clusters in a synchronized way when under high pressure.
  * Return: true if any cluster is discarded.
  */
-static bool swap_sync_discard(void)
+static bool swap_sync_discard(int mask)
 {
 	bool ret = false;
 	struct swap_info_struct *si, *next;
@@ -1437,6 +1443,8 @@ static bool swap_sync_discard(void)
 	spin_lock(&swap_lock);
 start_over:
 	plist_for_each_entry_safe(si, next, &swap_active_head, list) {
+		if (!swap_tiers_mask_test(si->tier_mask, mask))
+			continue;
 		spin_unlock(&swap_lock);
 		if (get_swap_device_info(si)) {
 			if (si->flags & SWP_PAGE_DISCARD)
@@ -1736,6 +1744,7 @@ int folio_alloc_swap(struct folio *folio)
 {
 	unsigned int order = folio_order(folio);
 	unsigned int size = 1 << order;
+	int mask;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);
@@ -1759,13 +1768,14 @@ int folio_alloc_swap(struct folio *folio)
 	}
 
 again:
+	mask = folio_tier_effective_mask(folio);
 	local_lock(&percpu_swap_cluster.lock);
-	if (!swap_alloc_fast(folio))
-		swap_alloc_slow(folio);
+	if (!swap_alloc_fast(folio, mask))
+		swap_alloc_slow(folio, mask);
 	local_unlock(&percpu_swap_cluster.lock);
 
 	if (!order && unlikely(!folio_test_swapcache(folio))) {
-		if (swap_sync_discard())
+		if (swap_sync_discard(mask))
 			goto again;
 	}
 
-- 
2.48.1


