Return-Path: <cgroups+bounces-14897-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gINcDsgou2kcfwIAu9opvQ
	(envelope-from <cgroups+bounces-14897-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:35:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D8F2C3855
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A52324295A
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1773A0E85;
	Wed, 18 Mar 2026 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPFLMiRj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995D039B4A5
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873027; cv=none; b=iV7RZS6/tEeKaDCrG5SoIPrx47p5tga6SMuwUb12Pg4LeEmeCNzlYxcL+QMPUBYUJdS1CGrqsnlj6vtqHhdTzir4lw+/uHNCHlFXGrJJqwQ4k3/G3+TGuqfDmicgniP+iMJTd+zXUDBFdmYXj7/lubQ54vomv+b5QQEuYeIJ7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873027; c=relaxed/simple;
	bh=qex24j/fvB5i2Hxp1YyD8djSdhK+3xIGWCRj2JuMS4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqmhh32QESegN6UeodvnxD4b4sPiVbYBR+VY7W53Ktg/ivpsiBNh0kaV0uqPk+mzSFAQVTlUCuYzxeItlmxYNKJeW7/uZuZ8Sw3PAUnF/Xz1iBj4cB2EERhNKGy8+YY9xCTaqWB1j6b7KDi6JziCWAWwbSOSWPZGxOvZjv9r9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPFLMiRj; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-415c8a4d2e6so201945fac.0
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 15:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773873023; x=1774477823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LyvvsB8h9QhouSf22weZV/t1lxO86Z5/SzpfGB0vfc=;
        b=LPFLMiRjp/Vh3Ey0gniZZWilBC2NdVWSiUdP2K8UBYnb8wT/zBh83oZIL4VrzT3PBf
         3Wi+J1qVvUDFSn5TBRSxfe5NSwjj4gGHQIhOe8JvmGkLWiW3qm9E6iHBsWySZzNbXFEX
         c5Yqp9gBDgLXJ6TONv5CtLEpFWxGMhlzH1uQl7L5EqkNav+H4FEhiyupqDsJUTTzv9qx
         TQeXwDWvT4A+IIblNfDs1TX/g7hnx2MdmT3a8cGjGRHNcGmDQhpG8uQ7jWHL4KWOvtIm
         bFTnvDG+cLVLvvMxukrYPzpijVIX+ez+Wb0j80l8SK1tOvYzRLOiFcnYRNYJkiS3Qy5D
         1KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873023; x=1774477823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7LyvvsB8h9QhouSf22weZV/t1lxO86Z5/SzpfGB0vfc=;
        b=s2YeZZXlYk8qoDqgCwB56dGwyHC4Rs7yat4BWBSCL8YVwS8dZalXng5Iw5FyG37O9p
         6AE4PYednobrMGkXQ1GWJLie/Gg8kr1URe73c1BxMGjrnGt5Zeqr/Pe4pXUJzjGmWNNR
         fXRk0hM2cl7pW79l06qOhvzrH4NvRelU+XW5hug2vBbWIC07iCcyazkP5pwnjsW7AGgS
         X3HCYAAL+29mlm40j1L6PiHQdS9KYG6LwY4DiHvtuecEysIcMCKBhH7v1nkenbHKRTLZ
         onIbUqLn5MlEmL4VCrK8f4OqEaGXes6LXn5sITEAVKmEpD+Z359dgzItKKnS3ZD+bldk
         Zrug==
X-Forwarded-Encrypted: i=1; AJvYcCXZrqiCnyhYLMbNzz4V/iBkvHrpDsoUEY3nMV7ubZGpQafrHqhQXqvltUHu6sdhIchsyz2BTlzY@vger.kernel.org
X-Gm-Message-State: AOJu0YzY7nQwaR1kh/+5M6/XOVAXSJrYqgBE2CndC7Ro0T2lsM9Y/1FC
	XBKnjitXinUQTOI3bdfaT81Ogq8+G2/8ogxfYKKHlFMZdtz880tuL3XU
X-Gm-Gg: ATEYQzz0bytZ9v83dQrZssRvdAN47Z+Ewj7jUGU1PXI5T1CTqMCXfO816ZEz8L16xqG
	pHyZVYQ1e7DuuimC9xhUwX5mR3ogEwiM2iPg59zNfVognu5FBD++MD8EurRqoowOnuw6ivfzfV4
	snpHGDYrthhiVXr7qLQvYQtF1/BJxJLu2J6TPSahHzq9sXdk62k6HGTljmMjpIDeYoj7PdNiKLq
	HXghk+OcJPrconFKLbO3yxkZJzCtMd0KT7dWHuroR4errYES9GJEidH0joZE4kDGoW3uJWYP9eV
	kpOr8PR7+FwfNPjpSXMomT08D/JwBvNoEknsfxQD/1IKlEXJL+dy8Hkkc00MsHHWZBlnSKX8w/x
	Jz80fPcej5DOonkP8YRZKODSnP2qhvTNH0Bk/HNFBHP6lPYzCZRrwXOwFc4Oy1dNWR9+7Iw7F5B
	lJAKkGuBCIJute1PW1Z1RzH6qxT66qpVt6XsgxqAagD4jrLw==
X-Received: by 2002:a05:6870:ac09:b0:409:77a9:f951 with SMTP id 586e51a60fabf-41bd3f3e873mr3474315fac.11.1773873023263;
        Wed, 18 Mar 2026 15:30:23 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd2d4cb20sm3817722fac.17.2026.03.18.15.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:30:22 -0700 (PDT)
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
Subject: [PATCH v4 17/21] swapfile: remove zeromap bitmap
Date: Wed, 18 Mar 2026 15:29:48 -0700
Message-ID: <20260318222953.441758-18-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318222953.441758-1-nphamcs@gmail.com>
References: <20260318222953.441758-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14897-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.868];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96D8F2C3855
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Zero swap entries are now treated as a separate, decoupled backend in
the virtual swap layer. The zeromap bitmap of physical swapfile is no
longer used - remove it. This does not have any behavioral change, and
save 1 bit per swap page in terms of memory overhead.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h |  1 -
 mm/swapfile.c        | 30 +++++-------------------------
 2 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index fa73696733744..cc1ca4ac2946d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -260,7 +260,6 @@ struct swap_info_struct {
 	signed char	type;		/* strange name for an index */
 	unsigned int	max;		/* extent of the swap_map */
 	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
-	unsigned long *zeromap;		/* kvmalloc'ed bitmap to track zero pages */
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
 	struct list_head free_clusters; /* free clusters list */
 	struct list_head full_clusters; /* full clusters list */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 32aa080d96a4d..aeb3575df8a0b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2320,8 +2320,7 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
 
 static void setup_swap_info(struct swap_info_struct *si, int prio,
 			    unsigned char *swap_map,
-			    struct swap_cluster_info *cluster_info,
-			    unsigned long *zeromap)
+			    struct swap_cluster_info *cluster_info)
 {
 	si->prio = prio;
 	/*
@@ -2332,7 +2331,6 @@ static void setup_swap_info(struct swap_info_struct *si, int prio,
 	si->avail_list.prio = -si->prio;
 	si->swap_map = swap_map;
 	si->cluster_info = cluster_info;
-	si->zeromap = zeromap;
 }
 
 static void _enable_swap_info(struct swap_info_struct *si)
@@ -2350,12 +2348,11 @@ static void _enable_swap_info(struct swap_info_struct *si)
 
 static void enable_swap_info(struct swap_info_struct *si, int prio,
 				unsigned char *swap_map,
-				struct swap_cluster_info *cluster_info,
-				unsigned long *zeromap)
+				struct swap_cluster_info *cluster_info)
 {
 	spin_lock(&swap_lock);
 	spin_lock(&si->lock);
-	setup_swap_info(si, prio, swap_map, cluster_info, zeromap);
+	setup_swap_info(si, prio, swap_map, cluster_info);
 	spin_unlock(&si->lock);
 	spin_unlock(&swap_lock);
 	/*
@@ -2373,7 +2370,7 @@ static void reinsert_swap_info(struct swap_info_struct *si)
 {
 	spin_lock(&swap_lock);
 	spin_lock(&si->lock);
-	setup_swap_info(si, si->prio, si->swap_map, si->cluster_info, si->zeromap);
+	setup_swap_info(si, si->prio, si->swap_map, si->cluster_info);
 	_enable_swap_info(si);
 	spin_unlock(&si->lock);
 	spin_unlock(&swap_lock);
@@ -2444,7 +2441,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
 	unsigned char *swap_map;
-	unsigned long *zeromap;
 	struct swap_cluster_info *cluster_info;
 	struct file *swap_file, *victim;
 	struct address_space *mapping;
@@ -2539,8 +2535,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	p->swap_file = NULL;
 	swap_map = p->swap_map;
 	p->swap_map = NULL;
-	zeromap = p->zeromap;
-	p->zeromap = NULL;
 	maxpages = p->max;
 	cluster_info = p->cluster_info;
 	p->max = 0;
@@ -2552,7 +2546,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	kfree(p->global_cluster);
 	p->global_cluster = NULL;
 	vfree(swap_map);
-	kvfree(zeromap);
 	free_cluster_info(cluster_info, maxpages);
 
 	inode = mapping->host;
@@ -3016,7 +3009,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	sector_t span;
 	unsigned long maxpages;
 	unsigned char *swap_map = NULL;
-	unsigned long *zeromap = NULL;
 	struct swap_cluster_info *cluster_info = NULL;
 	struct folio *folio = NULL;
 	struct inode *inode = NULL;
@@ -3122,17 +3114,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (error)
 		goto bad_swap_unlock_inode;
 
-	/*
-	 * Use kvmalloc_array instead of bitmap_zalloc as the allocation order might
-	 * be above MAX_PAGE_ORDER incase of a large swap file.
-	 */
-	zeromap = kvmalloc_array(BITS_TO_LONGS(maxpages), sizeof(long),
-				    GFP_KERNEL | __GFP_ZERO);
-	if (!zeromap) {
-		error = -ENOMEM;
-		goto bad_swap_unlock_inode;
-	}
-
 	if (si->bdev && bdev_stable_writes(si->bdev))
 		si->flags |= SWP_STABLE_WRITES;
 
@@ -3199,7 +3180,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	prio = DEF_SWAP_PRIO;
 	if (swap_flags & SWAP_FLAG_PREFER)
 		prio = swap_flags & SWAP_FLAG_PRIO_MASK;
-	enable_swap_info(si, prio, swap_map, cluster_info, zeromap);
+	enable_swap_info(si, prio, swap_map, cluster_info);
 
 	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s\n",
 		K(si->pages), name->name, si->prio, nr_extents,
@@ -3227,7 +3208,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	si->flags = 0;
 	spin_unlock(&swap_lock);
 	vfree(swap_map);
-	kvfree(zeromap);
 	if (cluster_info)
 		free_cluster_info(cluster_info, maxpages);
 	if (inced_nr_rotate_swap)
-- 
2.52.0


