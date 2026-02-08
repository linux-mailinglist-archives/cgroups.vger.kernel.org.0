Return-Path: <cgroups+bounces-13792-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sObhIsIIiWnK1QQAu9opvQ
	(envelope-from <cgroups+bounces-13792-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 23:05:54 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F61C10A66C
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 23:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93210307E4CE
	for <lists+cgroups@lfdr.de>; Sun,  8 Feb 2026 22:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E946F378D89;
	Sun,  8 Feb 2026 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDXXA8RL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CADC378D70
	for <cgroups@vger.kernel.org>; Sun,  8 Feb 2026 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770587966; cv=none; b=nWHf2XV+j+a+oVbvWrdqVDsMEnhMFp0CshO/BMyXqQ4dQ7GDlgMLnxqvWZUPm88UfaHciQDKtsMeg/BuVlqOxHxtjcTggfu5HSw5OjTy8qpHRywIwxEVrveuy7mbQpkch8VlkP7eduGSbNNsitYFQnUEICUZXGDG5W6Tm9vKAA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770587966; c=relaxed/simple;
	bh=VEosGorbCN3vXTzEpm7A1BGYOplMIFk+kHkexBvQWFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wc6aTEipKkdHWRSNF4bN9TUd7H1FsCe4z1EltkJVy89XKlordKW0WXKwzvyXs0FvJimjm0x2VYAoo8mWc/8AJD8Gm0sfKqSehM7B3wf9XUu/M75vq9BPfwT6dMn4+rGAfUgNK2+IF/lrcZQxgxs4ciEKq5/BJlS5glQW85+biQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDXXA8RL; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d1890f5cafso810710a34.1
        for <cgroups@vger.kernel.org>; Sun, 08 Feb 2026 13:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587965; x=1771192765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c90iUpuT0uTrBpR1ziQiggNR562GhjEZFfLgw7gtP4Q=;
        b=dDXXA8RLnhOvLHRBEyN3N+J0sOH+ta9LNuqDprGnUFouUVmgUQj3NxdKS6uO2ZGxMj
         hrjVXCFNMW4g96g3RnnYUeWellgHeBbxa7LiO1HfoMy7zJxh60yvIAP//1rK6gWnnCXD
         e72QWQsjRJbRdFmKyxKtFbqdgFV1hG+SMOW5RB/3u2I1z55lFXK2qB86YyYa6v12s5V3
         gtSiPWeGIMvsH93TdEe6IijIZbQd83ZUFxqp8eXo6yAKTQYje5HAd+T8BMGSQ3P3Gb8m
         2kA1DunEe5KRYSxSKRuqsSgdimftZv1g7kQZHIL8oofd4S6zN9KuihZqaVKRB57NH74C
         L3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587965; x=1771192765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c90iUpuT0uTrBpR1ziQiggNR562GhjEZFfLgw7gtP4Q=;
        b=tcsi1nP8oftgsXntHBBQvQcRvCAQbxJ/5XgOmOLnxWREOha2DO91cGSRwYbxM3uQ9Z
         JvH8u39g2uHoWVfCVcaPA8zrFBjA7qJC8OJZBATxPWuK6DcmSnhdLAqufg/qPjVZeA+d
         4NCkp4OtlgpF2aPddubOldQ+W9+7oFxuyJQbG0C5dvW5AvllvbZtP3Ogy1N7h5X8YmII
         XOyJ8nPaSLPnczztWnCBmP2z6bAv80nu4SI2FtBvOrvmnd4Rer4yCr/evorMpKrVB/ZA
         ExNAXQ7u8R+heD95DWmtnjPKzZ66+4qPjKa86qbUlbmtokfe9/KvSICQWYZ0jvKI94Iy
         5icQ==
X-Forwarded-Encrypted: i=1; AJvYcCUonrDfHmVhRhAYBn1h8wX6mlifLPEKJrGnkc0kbLb4vAp/Z5JkTr45EGWqArP8ozxTh1GWzsoa@vger.kernel.org
X-Gm-Message-State: AOJu0YyFtRP8u/wCJw7w5CAZYsQ6cE+7ABfW6n0i+9wHLxz6862Dnq6P
	4OwVVlXm5hlfngis/JxTke+zNGFILBL4L1S52PJFnfztfHSxhavoIBXp
X-Gm-Gg: AZuq6aKaVh6LoVcDM6gJ1zLG3wea0Q1bW+64y83t/MsmxsOtp5ngYkEs1oQklBvpjI5
	MRTA0NkVc60oXdrxDHZ7CjbPWzYKoGLPLNyPVFRPb9AlreFxiZ46t3ozsdiPBI4zNk88zROUNkl
	dJiLXzpnC0xAh9vsrgj+CCVfIRvSs/klL09pQ1a+31vdFUpsVQyopEBeZeZN3GUnuR6Yjeh0Nz0
	/+MPLNjH42nrufWjnPFKWkM+l6R4eA4CvYgb8W0Li4EnmNbDnf/Rle6n33/Nnkr403ach4Y0zPt
	mRbbMFp/zzQPDF8fNJ4pb5WJ3W/rZVyzWjinhlqzAyne8ITp2mgkLlIiNQwF2NwqSm3cT53gfL3
	joILjakIJCSzAQX4P0ucIt2dt11I+wkWQpCKgMGhA4DjsZfLxTs4L7nAECX93S1rMolD1Gj+b6q
	J08w92ieRsXKfQ89nd3CphZoe+UI9ixJ3JVA==
X-Received: by 2002:a05:6830:6f47:b0:7d1:8ad3:ce7 with SMTP id 46e09a7af769-7d4643e7eb1mr4865896a34.1.1770587965213;
        Sun, 08 Feb 2026 13:59:25 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d46479954bsm6335454a34.21.2026.02.08.13.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:59:24 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	hughd@google.com,
	yosry.ahmed@linux.dev,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	len.brown@intel.com,
	chengming.zhou@linux.dev,
	kasong@tencent.com,
	chrisl@kernel.org,
	huang.ying.caritas@gmail.com,
	ryan.roberts@arm.com,
	shikemeng@huaweicloud.com,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	bhe@redhat.com,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	peterx@redhat.com,
	riel@surriel.com,
	joshua.hahnjy@gmail.com,
	npache@redhat.com,
	gourry@gourry.net,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	rafael@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	zhengqi.arch@bytedance.com
Subject: [PATCH v3 20/20] swapfile: replace the swap map with bitmaps
Date: Sun,  8 Feb 2026 13:58:33 -0800
Message-ID: <20260208215839.87595-21-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260208215839.87595-1-nphamcs@gmail.com>
References: <20260208215839.87595-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13792-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F61C10A66C
X-Rspamd-Action: no action

Now that we have moved the swap count state to virtual swap layer, each
swap map entry only has 3 possible states: free, allocated, and bad.
Replace the swap map with 2 bitmaps (one for allocated state and one for
bad state), saving 6 bits per swap entry.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h |  3 +-
 mm/swapfile.c        | 81 +++++++++++++++++++++++---------------------
 2 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a30d382fb5ee1..a02ce3fb2358b 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -259,7 +259,8 @@ struct swap_info_struct {
 	struct plist_node list;		/* entry in swap_active_head */
 	signed char	type;		/* strange name for an index */
 	unsigned int	max;		/* extent of the swap_map */
-	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
+	unsigned long *swap_map;	/* bitmap for allocated state */
+	unsigned long *bad_map;		/* bitmap for bad state */
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
 	struct list_head free_clusters; /* free clusters list */
 	struct list_head full_clusters; /* full clusters list */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9478707ce3ffa..b7661ffa312be 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -760,25 +760,19 @@ static bool cluster_reclaim_range(struct swap_info_struct *si,
 				  struct swap_cluster_info *ci,
 				  unsigned long start, unsigned long end)
 {
-	unsigned char *map = si->swap_map;
 	unsigned long offset = start;
 	int nr_reclaim;
 
 	spin_unlock(&ci->lock);
 	do {
-		switch (READ_ONCE(map[offset])) {
-		case 0:
+		if (!test_bit(offset, si->swap_map)) {
 			offset++;
-			break;
-		case SWAP_MAP_ALLOCATED:
+		} else {
 			nr_reclaim = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
 			if (nr_reclaim > 0)
 				offset += nr_reclaim;
 			else
 				goto out;
-			break;
-		default:
-			goto out;
 		}
 	} while (offset < end);
 out:
@@ -787,11 +781,7 @@ static bool cluster_reclaim_range(struct swap_info_struct *si,
 	 * Recheck the range no matter reclaim succeeded or not, the slot
 	 * could have been be freed while we are not holding the lock.
 	 */
-	for (offset = start; offset < end; offset++)
-		if (READ_ONCE(map[offset]))
-			return false;
-
-	return true;
+	return find_next_bit(si->swap_map, end, start) >= end;
 }
 
 static bool cluster_scan_range(struct swap_info_struct *si,
@@ -800,15 +790,16 @@ static bool cluster_scan_range(struct swap_info_struct *si,
 			       bool *need_reclaim)
 {
 	unsigned long offset, end = start + nr_pages;
-	unsigned char *map = si->swap_map;
-	unsigned char count;
 
 	if (cluster_is_empty(ci))
 		return true;
 
 	for (offset = start; offset < end; offset++) {
-		count = READ_ONCE(map[offset]);
-		if (!count)
+		/* Bad slots cannot be used for allocation */
+		if (test_bit(offset, si->bad_map))
+			return false;
+
+		if (!test_bit(offset, si->swap_map))
 			continue;
 
 		if (swap_cache_only(si, offset)) {
@@ -841,7 +832,7 @@ static bool cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster
 	if (cluster_is_empty(ci))
 		ci->order = order;
 
-	memset(si->swap_map + start, usage, nr_pages);
+	bitmap_set(si->swap_map, start, nr_pages);
 	swap_range_alloc(si, nr_pages);
 	ci->count += nr_pages;
 
@@ -1404,7 +1395,7 @@ static struct swap_info_struct *_swap_info_get(swp_slot_t slot)
 	offset = swp_slot_offset(slot);
 	if (offset >= si->max)
 		goto bad_offset;
-	if (data_race(!si->swap_map[swp_slot_offset(slot)]))
+	if (data_race(!test_bit(offset, si->swap_map)))
 		goto bad_free;
 	return si;
 
@@ -1518,8 +1509,7 @@ static void swap_slots_free(struct swap_info_struct *si,
 			      swp_slot_t slot, unsigned int nr_pages)
 {
 	unsigned long offset = swp_slot_offset(slot);
-	unsigned char *map = si->swap_map + offset;
-	unsigned char *map_end = map + nr_pages;
+	unsigned long end = offset + nr_pages;
 
 	/* It should never free entries across different clusters */
 	VM_BUG_ON(ci != __swap_offset_to_cluster(si, offset + nr_pages - 1));
@@ -1527,10 +1517,8 @@ static void swap_slots_free(struct swap_info_struct *si,
 	VM_BUG_ON(ci->count < nr_pages);
 
 	ci->count -= nr_pages;
-	do {
-		VM_BUG_ON(!swap_is_last_ref(*map));
-		*map = 0;
-	} while (++map < map_end);
+	VM_BUG_ON(find_next_zero_bit(si->swap_map, end, offset) < end);
+	bitmap_clear(si->swap_map, offset, nr_pages);
 
 	swap_range_free(si, offset, nr_pages);
 
@@ -1741,9 +1729,7 @@ unsigned int count_swap_pages(int type, int free)
 static bool swap_slot_allocated(struct swap_info_struct *si,
 		unsigned long offset)
 {
-	unsigned char count = READ_ONCE(si->swap_map[offset]);
-
-	return count && swap_count(count) != SWAP_MAP_BAD;
+	return test_bit(offset, si->swap_map);
 }
 
 /*
@@ -2064,7 +2050,7 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
 }
 
 static void setup_swap_info(struct swap_info_struct *si, int prio,
-			    unsigned char *swap_map,
+			    unsigned long *swap_map,
 			    struct swap_cluster_info *cluster_info)
 {
 	si->prio = prio;
@@ -2092,7 +2078,7 @@ static void _enable_swap_info(struct swap_info_struct *si)
 }
 
 static void enable_swap_info(struct swap_info_struct *si, int prio,
-				unsigned char *swap_map,
+				unsigned long *swap_map,
 				struct swap_cluster_info *cluster_info)
 {
 	spin_lock(&swap_lock);
@@ -2185,7 +2171,8 @@ static void flush_percpu_swap_cluster(struct swap_info_struct *si)
 SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
-	unsigned char *swap_map;
+	unsigned long *swap_map;
+	unsigned long *bad_map;
 	struct swap_cluster_info *cluster_info;
 	struct file *swap_file, *victim;
 	struct address_space *mapping;
@@ -2280,6 +2267,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	p->swap_file = NULL;
 	swap_map = p->swap_map;
 	p->swap_map = NULL;
+	bad_map = p->bad_map;
+	p->bad_map = NULL;
 	maxpages = p->max;
 	cluster_info = p->cluster_info;
 	p->max = 0;
@@ -2290,7 +2279,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	mutex_unlock(&swapon_mutex);
 	kfree(p->global_cluster);
 	p->global_cluster = NULL;
-	vfree(swap_map);
+	kvfree(swap_map);
+	kvfree(bad_map);
 	free_cluster_info(cluster_info, maxpages);
 
 	inode = mapping->host;
@@ -2638,18 +2628,20 @@ static unsigned long read_swap_header(struct swap_info_struct *si,
 
 static int setup_swap_map(struct swap_info_struct *si,
 			  union swap_header *swap_header,
-			  unsigned char *swap_map,
+			  unsigned long *swap_map,
+			  unsigned long *bad_map,
 			  unsigned long maxpages)
 {
 	unsigned long i;
 
-	swap_map[0] = SWAP_MAP_BAD; /* omit header page */
+	set_bit(0, bad_map); /* omit header page */
+
 	for (i = 0; i < swap_header->info.nr_badpages; i++) {
 		unsigned int page_nr = swap_header->info.badpages[i];
 		if (page_nr == 0 || page_nr > swap_header->info.last_page)
 			return -EINVAL;
 		if (page_nr < maxpages) {
-			swap_map[page_nr] = SWAP_MAP_BAD;
+			set_bit(page_nr, bad_map);
 			si->pages--;
 		}
 	}
@@ -2753,7 +2745,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	int nr_extents;
 	sector_t span;
 	unsigned long maxpages;
-	unsigned char *swap_map = NULL;
+	unsigned long *swap_map = NULL, *bad_map = NULL;
 	struct swap_cluster_info *cluster_info = NULL;
 	struct folio *folio = NULL;
 	struct inode *inode = NULL;
@@ -2849,16 +2841,24 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	maxpages = si->max;
 
 	/* OK, set up the swap map and apply the bad block list */
-	swap_map = vzalloc(maxpages);
+	swap_map = kvcalloc(BITS_TO_LONGS(maxpages), sizeof(long), GFP_KERNEL);
 	if (!swap_map) {
 		error = -ENOMEM;
 		goto bad_swap_unlock_inode;
 	}
 
-	error = setup_swap_map(si, swap_header, swap_map, maxpages);
+	bad_map = kvcalloc(BITS_TO_LONGS(maxpages), sizeof(long), GFP_KERNEL);
+	if (!bad_map) {
+		error = -ENOMEM;
+		goto bad_swap_unlock_inode;
+	}
+
+	error = setup_swap_map(si, swap_header, swap_map, bad_map, maxpages);
 	if (error)
 		goto bad_swap_unlock_inode;
 
+	si->bad_map = bad_map;
+
 	if (si->bdev && bdev_stable_writes(si->bdev))
 		si->flags |= SWP_STABLE_WRITES;
 
@@ -2952,7 +2952,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	si->swap_file = NULL;
 	si->flags = 0;
 	spin_unlock(&swap_lock);
-	vfree(swap_map);
+	if (swap_map)
+		kvfree(swap_map);
+	if (bad_map)
+		kvfree(bad_map);
 	if (cluster_info)
 		free_cluster_info(cluster_info, maxpages);
 	if (inced_nr_rotate_swap)
-- 
2.47.3


