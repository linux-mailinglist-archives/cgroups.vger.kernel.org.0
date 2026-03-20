Return-Path: <cgroups+bounces-14961-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P1CGjChvWkM/wIAu9opvQ
	(envelope-from <cgroups+bounces-14961-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:34:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DA92E00EF
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 911003067754
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 19:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F063F0AA0;
	Fri, 20 Mar 2026 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhIUErbB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624B93F211A
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034892; cv=none; b=jiinDFK0J7YWUmbxMcdGwQcitLK8IlVTVOGr8uqZmXVJhkiF094Cyaz7us+AAdNISkxj7/u4z+SfFyhyLhGFrqhk6QnLH6dFfCImYhdZuy5Dwly+xEfwZyfbv/JRgl+fRQhALiGef7OhmPPCiFArvR+W4nLF00iFDK+WiMWEPt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034892; c=relaxed/simple;
	bh=fLrqs/MUnUNB7tDySRKUurHQIx3PY5X8jg3B7iWPLHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4wU6pC8yo9cpFzd8UmrNnqr01TTjNZqCKONyV3K7Cur6x+M+w19Dke68xyyL7ZoX6fAKbwwdwZkWSWg3uNHCD4Mb+M5lHXi/uQdKJBPisGwd9MMOrAzehFqy256HwH+sQ/27VudZLaO1aBFTW6e4VCw9kWnRsAj8bbZgm5VCkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhIUErbB; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40f387a688dso1919194fac.0
        for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 12:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034887; x=1774639687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03afpDvtGuNWbxO8rXYZMIlB93FyoeHq7W5GxGEi1h8=;
        b=EhIUErbBg+AFHWS0U0U491e3xkKoMi21Qb45PHSr4FWG7KPKO9tlz7t+DJoF4t4eje
         a27LfUQVkd9jIoPyhzgAXvOj9bqfiltpWO6gKax8ACMIrXKW/FYa9z5D3dokcKiE1+36
         hr8C9u2JQeKj7WXJ4ambJsyhK+yoTcOU3HKxmRUe4tvDHqfItRNB57hg0fXwLg1aSzby
         aWNE9JF+ra2ejV+vY4Nza6ZSRscU0Ajg9v+hKZebXzjq67MjK0FJ1k8BL2UpI3mhG6hE
         KLb9f6UQkj4TA6zPdE2U2W/Iv33Dgc6G5rBfrXZpwJL9bdJRAAJwGJWHkTCoHLnaGt8e
         tzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034887; x=1774639687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=03afpDvtGuNWbxO8rXYZMIlB93FyoeHq7W5GxGEi1h8=;
        b=H63yycij6h6bXpluhDAUy5YrE0DWh2VtuASK/qnkMQBnztuWedKsqqhj71F8/X41r0
         006Meem9ricaKa0iD6gIoZphJ03Jbhs+ls4I8NpP+MwyWl0fxs4sh4c7Q1xzIQDoGcrB
         kSd3Z4cmaCIc/9TbpMCYXKj6XR0G/HD9KFssQPuMX71grSIQPm7v4Cf6nZdOtHcMdmuO
         6tCMIroGLvqJfacYbkeNsXemnMo/Rfr7ZNo9L1y6mwOD63hdvMRAnTSOIdr/Q+sCN73w
         kLat7+7FrScUCDKak6ls8I+JZd6SKAQg8Z0W3jj78DfQyDznUw6mGXfgHuYd1XsdlkR4
         oA5A==
X-Forwarded-Encrypted: i=1; AJvYcCVyTioebmrGlHkC4lAO1N/a0dHERXsAb8j5bR9f9Kj2V8M+3lFf5gDjUGvLdeTrNqcSdjme9bMr@vger.kernel.org
X-Gm-Message-State: AOJu0YzZAW5yMWqe92fH/6JTShHs5KLG4rNekljo+pB3bKKH0Ni4Q3ic
	CmPqBJ8a28mP7b9JApj7y+h2gCXqPF4mj7eN8lAz2Ud/xwmD+ECM1kLq
X-Gm-Gg: ATEYQzwQpRJ9UCNgBg67wzzauVL2I+mKS0WQ8ibTf9NVJ+VNjzpXzOd2jYBM1Org7BA
	p9fODTen0haFF9hc0DQ4pA8Hk3dBHENSIAkliF3L/OBrzncsg0CMcxRQq54xvNegbIkuE3JyE/b
	jzSxq17TDqZD3HTf4/glB07ZI6BNOD8M/r7oqGpSmJadiiPZFCccIZAifEwmqtaxh5hCMBT/yEN
	LJJXdCZ6ldwV3tm36Z5OmSIYke11mNj6NSggGnsltwkl77pi3xn+/G1SKjqjS3gJmY7+dEPCNnN
	b22RI8Xss6uY9q8PjkXzJaVCquFvk/ZTkbCRLYwW/PkUa8piDsmps9KofswquH0IYBqNRhhiDCK
	9jiUdejRZtz+vvaMONIv1jgV3okpMKodGo2fjUehM+OCX5Glg59L5F+/kMQF8iWrkYHNZit7QBj
	FaCFTT+zn8xUX4FGsS3uFAEdGIegrKA8cGGw/iPiaxrVfOYg==
X-Received: by 2002:a05:6871:1cf:b0:409:54ac:12ae with SMTP id 586e51a60fabf-41c10f6ae20mr2677223fac.8.1774034886900;
        Fri, 20 Mar 2026 12:28:06 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c148a5f99sm3030503fac.2.2026.03.20.12.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:28:06 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: kasong@tencent.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bhe@redhat.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	lance.yang@linux.dev,
	lenb@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	npache@redhat.com,
	nphamcs@gmail.com,
	pavel@kernel.org,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	rafael@kernel.org,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@suse.cz,
	weixugc@google.com,
	ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	ziy@nvidia.com,
	kernel-team@meta.com,
	riel@surriel.com
Subject: [PATCH v5 20/21] swapfile: replace the swap map with bitmaps
Date: Fri, 20 Mar 2026 12:27:34 -0700
Message-ID: <20260320192735.748051-21-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320192735.748051-1-nphamcs@gmail.com>
References: <20260320192735.748051-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14961-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 26DA92E00EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 21e528d8d3480..3c789149996c5 100644
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
index b553652125d11..3e2bfcf1aa789 100644
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
 
@@ -1407,7 +1398,7 @@ static struct swap_info_struct *_swap_info_get(swp_slot_t slot)
 	offset = swp_slot_offset(slot);
 	if (offset >= si->max)
 		goto bad_offset;
-	if (data_race(!si->swap_map[swp_slot_offset(slot)]))
+	if (data_race(!test_bit(offset, si->swap_map)))
 		goto bad_free;
 	return si;
 
@@ -1521,8 +1512,7 @@ static void swap_slots_free(struct swap_info_struct *si,
 			      swp_slot_t slot, unsigned int nr_pages)
 {
 	unsigned long offset = swp_slot_offset(slot);
-	unsigned char *map = si->swap_map + offset;
-	unsigned char *map_end = map + nr_pages;
+	unsigned long end = offset + nr_pages;
 
 	/* It should never free entries across different clusters */
 	VM_BUG_ON(ci != __swap_offset_to_cluster(si, offset + nr_pages - 1));
@@ -1530,10 +1520,8 @@ static void swap_slots_free(struct swap_info_struct *si,
 	VM_BUG_ON(ci->count < nr_pages);
 
 	ci->count -= nr_pages;
-	do {
-		VM_BUG_ON(!swap_is_last_ref(*map));
-		*map = 0;
-	} while (++map < map_end);
+	VM_BUG_ON(find_next_zero_bit(si->swap_map, end, offset) < end);
+	bitmap_clear(si->swap_map, offset, nr_pages);
 
 	swap_range_free(si, offset, nr_pages);
 
@@ -1744,9 +1732,7 @@ unsigned int count_swap_pages(int type, int free)
 static bool swap_slot_allocated(struct swap_info_struct *si,
 		unsigned long offset)
 {
-	unsigned char count = READ_ONCE(si->swap_map[offset]);
-
-	return count && swap_count(count) != SWAP_MAP_BAD;
+	return test_bit(offset, si->swap_map);
 }
 
 /*
@@ -2067,7 +2053,7 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
 }
 
 static void setup_swap_info(struct swap_info_struct *si, int prio,
-			    unsigned char *swap_map,
+			    unsigned long *swap_map,
 			    struct swap_cluster_info *cluster_info)
 {
 	si->prio = prio;
@@ -2095,7 +2081,7 @@ static void _enable_swap_info(struct swap_info_struct *si)
 }
 
 static void enable_swap_info(struct swap_info_struct *si, int prio,
-				unsigned char *swap_map,
+				unsigned long *swap_map,
 				struct swap_cluster_info *cluster_info)
 {
 	spin_lock(&swap_lock);
@@ -2188,7 +2174,8 @@ static void flush_percpu_swap_cluster(struct swap_info_struct *si)
 SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
-	unsigned char *swap_map;
+	unsigned long *swap_map;
+	unsigned long *bad_map;
 	struct swap_cluster_info *cluster_info;
 	struct file *swap_file, *victim;
 	struct address_space *mapping;
@@ -2283,6 +2270,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	p->swap_file = NULL;
 	swap_map = p->swap_map;
 	p->swap_map = NULL;
+	bad_map = p->bad_map;
+	p->bad_map = NULL;
 	maxpages = p->max;
 	cluster_info = p->cluster_info;
 	p->max = 0;
@@ -2293,7 +2282,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	mutex_unlock(&swapon_mutex);
 	kfree(p->global_cluster);
 	p->global_cluster = NULL;
-	vfree(swap_map);
+	kvfree(swap_map);
+	kvfree(bad_map);
 	free_cluster_info(cluster_info, maxpages);
 
 	inode = mapping->host;
@@ -2641,18 +2631,20 @@ static unsigned long read_swap_header(struct swap_info_struct *si,
 
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
@@ -2756,7 +2748,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	int nr_extents;
 	sector_t span;
 	unsigned long maxpages;
-	unsigned char *swap_map = NULL;
+	unsigned long *swap_map = NULL, *bad_map = NULL;
 	struct swap_cluster_info *cluster_info = NULL;
 	struct folio *folio = NULL;
 	struct inode *inode = NULL;
@@ -2852,16 +2844,24 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
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
 
@@ -2955,7 +2955,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
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
2.52.0


