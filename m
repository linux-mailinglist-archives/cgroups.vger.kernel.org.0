Return-Path: <cgroups+bounces-13791-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCCoEakHiWnK1QQAu9opvQ
	(envelope-from <cgroups+bounces-13791-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 23:01:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 140DE10A565
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 23:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82F633006B40
	for <lists+cgroups@lfdr.de>; Sun,  8 Feb 2026 22:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DA23587A9;
	Sun,  8 Feb 2026 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrEohGqx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58494378802
	for <cgroups@vger.kernel.org>; Sun,  8 Feb 2026 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770587964; cv=none; b=VF579WJ4bZsDcHngf97k8PrlC8hPsQUvSm9mtdCg+rhEqPkfnjbLN8pJYLMp2iwZJPdpTGqPayIf0o0BUd528yZs1v/n58dEEUYemjyebSK44qVt9hmPC496ImpamieB7d7m9ptU9HXxUDvfClBf/dY7pnxRjaSfSiE6c++hnu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770587964; c=relaxed/simple;
	bh=4S//sVasRQpLuFOgTf1g1s/n9F4LnVnZLXTw2n2VLDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNHXeZK06CYoem+BhY/3rPu2yihpAsyr/UR/JrMDwYk53VlV7MQbSV3J812sc/m4xRokipWfS5cT1qKzQUGaBevTbL6H7GWf4xhvEgBoTczuPu908wvqjPVUYXglx0VzevLDy+qaWCM6YCm2eeE6ucKCEiuU5NEvqK6pYRw+9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrEohGqx; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45f004e7d71so3268423b6e.1
        for <cgroups@vger.kernel.org>; Sun, 08 Feb 2026 13:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587963; x=1771192763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4m66NSEdK1BRkgjUBQQieU2eKX3oRCTL4lRkohCFyaM=;
        b=YrEohGqxyEl+V/349NtPW3y+wbhqqbDrIFD2jESanGzcnrsOuAem1ivgsPYN95d955
         KPWXFtyDsWV4TTeyv1k1SfKv+GMjkoyM2/SpCTPDxZ7KuAAGWUmNe6lZvhyrFMGVL6Nv
         7nlcvG+fyb/g3pHUFNtRVQUeWm5WjUtb8Ggnk9ERLH0ceTSFIFcv/7BIi2q5KfnDUG2d
         xL7Kdb7KFb079R4a5iYMlbmcgC0++yp7h1Em+K0258XSlt4lJIsHSHt3joIMR/S5sYqS
         OUdsGbAuXA+LsARa6iKmw8CfqqYbbz5TzsAOPNQCeAbY3MNod/KVt0zU9GXlGdJ5Frim
         4bhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587963; x=1771192763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4m66NSEdK1BRkgjUBQQieU2eKX3oRCTL4lRkohCFyaM=;
        b=LBO5laj4PPMZFMYKSGBmPADhNZfyUMY08EfnY79LHZenwjLdjpLgH998E1pQf70YLG
         a1oH9Be+6im9UUAgdBJXQMte1S1XHxCX9PH1mO7ejEWL7jpeDUlYnluBmBKoEuT7nMvo
         zcxXA6sOzQ98NGj0PVFe4BSIPpZhokhir2pbNpKdI6hiP3EOeKZXA8xH1rOtBIiUDLrY
         lNe0U66yQhozTlSBsRcEOQJvsq5rH7TJw8j6u3emCBG7uvxkxFhpz48IuuxzliiWlwIa
         m0ZDaAF+K20O8SJMD1nn0RdReM7HFw7eUWfwQOrLovQ4f02WLOrPWNkP9iwB4PDQOJ4N
         j1GQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5kBvN1iS53zMVDsjBM1RCon4Xy58BzjNLzqIp97QT3/U0+7vaGnD6Cwk5NCDjFWmr0VIuYjb1@vger.kernel.org
X-Gm-Message-State: AOJu0YxoV7EJ8g5Dq4MIGQdnfPyf6qOdHqD3EcPfrEuPgWixCDhKgd0k
	rS1OBXwBQmCu3LFQC4UBaDPUjhSuSgXqPn4V77Paq3vQOgzJ6zznspyg
X-Gm-Gg: AZuq6aJO7k2yzazgltN6Kir9gh3brA//uM2p4YBNDkJk9slc4PvTArG+l464VpfOjuK
	jfnJd3o1fLIFyIKvGMcwi52SKIdOn83qoFto78gtm5RwF+zIBZ9cA6W7qVinuxnGKvR5abotqL/
	M76ez7JhkKrmfCXSzqiHmU01rIGuiDE8LMMjXnh5M4SdLUPt4Ufe3y0D8dQNBmurfJLAiLrwxEW
	HkrNi4pglfAbKkTURy6MW71Rn2wH47Igqe3JdV2EhBQDTh+IqVqHwA4Lm8f3R5VdylhuyUedDZC
	6HVNSgce3R0E5V9xhkNAce9skaTPKXK5eX6uONpBgKmkbd6TGu0Qhqai4Aj7A/i56h2DkQkGu/T
	TYjJ7WZYludEP9fJ46YZRNfg48LeBjkDQw4iY3sVU3hK/9Z53tMpXTXrgA28Z2fspHLTYORJSP9
	8eLW6LpwbPOjopg4xvOzP3SNr2EXXAdNDW
X-Received: by 2002:a05:6808:1903:b0:45a:3d58:6475 with SMTP id 5614622812f47-462e9b9a0d2mr7347861b6e.13.1770587963127;
        Sun, 08 Feb 2026 13:59:23 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462fe9a16a1sm5402674b6e.2.2026.02.08.13.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:59:21 -0800 (PST)
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
Subject: [PATCH v3 19/20] swap: simplify swapoff using virtual swap
Date: Sun,  8 Feb 2026 13:58:32 -0800
Message-ID: <20260208215839.87595-20-nphamcs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13791-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 140DE10A565
X-Rspamd-Action: no action

This patch presents the second applications of virtual swap design -
simplifying and optimizing swapoff.

With virtual swap slots stored at page table entries and used as indices
to various swap-related data structures, we no longer have to perform a
page table walk in swapoff. Simply iterate through all the allocated
swap slots on the swapfile, find their corresponding virtual swap slots,
and fault them in.

This is significantly cleaner, as well as slightly more performant,
especially when there are a lot of unrelated VMAs (since the old swapoff
code would have to traverse through all of them).

In a simple benchmark, in which we swapoff a 32 GB swapfile that is 50%
full, and in which there is a process that maps a 128GB file into
memory:

Baseline:
sys: 11.48s

New Design:
sys: 9.96s

Disregarding the real time reduction (which is mostly due to more IO
asynchrony), the new design reduces the kernel CPU time by about 13%.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/shmem_fs.h |   7 +-
 mm/shmem.c               | 184 +--------------
 mm/swapfile.c            | 474 +++++++++------------------------------
 3 files changed, 113 insertions(+), 552 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index e2069b3179c41..bac6b6cafe89c 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -41,17 +41,13 @@ struct shmem_inode_info {
 	unsigned long		swapped;	/* subtotal assigned to swap */
 	union {
 	    struct offset_ctx	dir_offsets;	/* stable directory offsets */
-	    struct {
-		struct list_head shrinklist;	/* shrinkable hpage inodes */
-		struct list_head swaplist;	/* chain of maybes on swap */
-	    };
+	    struct list_head	shrinklist;	/* shrinkable hpage inodes */
 	};
 	struct timespec64	i_crtime;	/* file creation time */
 	struct shared_policy	policy;		/* NUMA memory alloc policy */
 	struct simple_xattrs	xattrs;		/* list of xattrs */
 	pgoff_t			fallocend;	/* highest fallocate endindex */
 	unsigned int		fsflags;	/* for FS_IOC_[SG]ETFLAGS */
-	atomic_t		stop_eviction;	/* hold when working on inode */
 #ifdef CONFIG_TMPFS_QUOTA
 	struct dquot __rcu	*i_dquot[MAXQUOTAS];
 #endif
@@ -127,7 +123,6 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 		struct list_head *folio_list);
 void shmem_truncate_range(struct inode *inode, loff_t start, uoff_t end);
-int shmem_unuse(unsigned int type);
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 unsigned long shmem_allowable_huge_orders(struct inode *inode,
diff --git a/mm/shmem.c b/mm/shmem.c
index 3a346cca114ab..61790752bdf6d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -290,9 +290,6 @@ bool vma_is_shmem(const struct vm_area_struct *vma)
 	return vma_is_anon_shmem(vma) || vma->vm_ops == &shmem_vm_ops;
 }
 
-static LIST_HEAD(shmem_swaplist);
-static DEFINE_SPINLOCK(shmem_swaplist_lock);
-
 #ifdef CONFIG_TMPFS_QUOTA
 
 static int shmem_enable_quotas(struct super_block *sb,
@@ -1413,16 +1410,6 @@ static void shmem_evict_inode(struct inode *inode)
 			}
 			spin_unlock(&sbinfo->shrinklist_lock);
 		}
-		while (!list_empty(&info->swaplist)) {
-			/* Wait while shmem_unuse() is scanning this inode... */
-			wait_var_event(&info->stop_eviction,
-				       !atomic_read(&info->stop_eviction));
-			spin_lock(&shmem_swaplist_lock);
-			/* ...but beware of the race if we peeked too early */
-			if (!atomic_read(&info->stop_eviction))
-				list_del_init(&info->swaplist);
-			spin_unlock(&shmem_swaplist_lock);
-		}
 	}
 
 	simple_xattrs_free(&info->xattrs, sbinfo->max_inodes ? &freed : NULL);
@@ -1435,153 +1422,6 @@ static void shmem_evict_inode(struct inode *inode)
 #endif
 }
 
-static unsigned int shmem_find_swap_entries(struct address_space *mapping,
-				pgoff_t start, struct folio_batch *fbatch,
-				pgoff_t *indices, unsigned int type)
-{
-	XA_STATE(xas, &mapping->i_pages, start);
-	struct folio *folio;
-	swp_entry_t entry;
-	swp_slot_t slot;
-
-	rcu_read_lock();
-	xas_for_each(&xas, folio, ULONG_MAX) {
-		if (xas_retry(&xas, folio))
-			continue;
-
-		if (!xa_is_value(folio))
-			continue;
-
-		entry = radix_to_swp_entry(folio);
-		slot = swp_entry_to_swp_slot(entry);
-
-		/*
-		 * swapin error entries can be found in the mapping. But they're
-		 * deliberately ignored here as we've done everything we can do.
-		 */
-		if (!slot.val || swp_slot_type(slot) != type)
-			continue;
-
-		indices[folio_batch_count(fbatch)] = xas.xa_index;
-		if (!folio_batch_add(fbatch, folio))
-			break;
-
-		if (need_resched()) {
-			xas_pause(&xas);
-			cond_resched_rcu();
-		}
-	}
-	rcu_read_unlock();
-
-	return folio_batch_count(fbatch);
-}
-
-/*
- * Move the swapped pages for an inode to page cache. Returns the count
- * of pages swapped in, or the error in case of failure.
- */
-static int shmem_unuse_swap_entries(struct inode *inode,
-		struct folio_batch *fbatch, pgoff_t *indices)
-{
-	int i = 0;
-	int ret = 0;
-	int error = 0;
-	struct address_space *mapping = inode->i_mapping;
-
-	for (i = 0; i < folio_batch_count(fbatch); i++) {
-		struct folio *folio = fbatch->folios[i];
-
-		error = shmem_swapin_folio(inode, indices[i], &folio, SGP_CACHE,
-					mapping_gfp_mask(mapping), NULL, NULL);
-		if (error == 0) {
-			folio_unlock(folio);
-			folio_put(folio);
-			ret++;
-		}
-		if (error == -ENOMEM)
-			break;
-		error = 0;
-	}
-	return error ? error : ret;
-}
-
-/*
- * If swap found in inode, free it and move page from swapcache to filecache.
- */
-static int shmem_unuse_inode(struct inode *inode, unsigned int type)
-{
-	struct address_space *mapping = inode->i_mapping;
-	pgoff_t start = 0;
-	struct folio_batch fbatch;
-	pgoff_t indices[PAGEVEC_SIZE];
-	int ret = 0;
-
-	do {
-		folio_batch_init(&fbatch);
-		if (!shmem_find_swap_entries(mapping, start, &fbatch,
-					     indices, type)) {
-			ret = 0;
-			break;
-		}
-
-		ret = shmem_unuse_swap_entries(inode, &fbatch, indices);
-		if (ret < 0)
-			break;
-
-		start = indices[folio_batch_count(&fbatch) - 1];
-	} while (true);
-
-	return ret;
-}
-
-/*
- * Read all the shared memory data that resides in the swap
- * device 'type' back into memory, so the swap device can be
- * unused.
- */
-int shmem_unuse(unsigned int type)
-{
-	struct shmem_inode_info *info, *next;
-	int error = 0;
-
-	if (list_empty(&shmem_swaplist))
-		return 0;
-
-	spin_lock(&shmem_swaplist_lock);
-start_over:
-	list_for_each_entry_safe(info, next, &shmem_swaplist, swaplist) {
-		if (!info->swapped) {
-			list_del_init(&info->swaplist);
-			continue;
-		}
-		/*
-		 * Drop the swaplist mutex while searching the inode for swap;
-		 * but before doing so, make sure shmem_evict_inode() will not
-		 * remove placeholder inode from swaplist, nor let it be freed
-		 * (igrab() would protect from unlink, but not from unmount).
-		 */
-		atomic_inc(&info->stop_eviction);
-		spin_unlock(&shmem_swaplist_lock);
-
-		error = shmem_unuse_inode(&info->vfs_inode, type);
-		cond_resched();
-
-		spin_lock(&shmem_swaplist_lock);
-		if (atomic_dec_and_test(&info->stop_eviction))
-			wake_up_var(&info->stop_eviction);
-		if (error)
-			break;
-		if (list_empty(&info->swaplist))
-			goto start_over;
-		next = list_next_entry(info, swaplist);
-		if (!info->swapped)
-			list_del_init(&info->swaplist);
-	}
-	spin_unlock(&shmem_swaplist_lock);
-
-	return error;
-}
-
 /**
  * shmem_writeout - Write the folio to swap
  * @folio: The folio to write
@@ -1668,24 +1508,9 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 	}
 
 	if (!folio_alloc_swap(folio)) {
-		bool first_swapped = shmem_recalc_inode(inode, 0, nr_pages);
 		int error;
 
-		/*
-		 * Add inode to shmem_unuse()'s list of swapped-out inodes,
-		 * if it's not already there.  Do it now before the folio is
-		 * removed from page cache, when its pagelock no longer
-		 * protects the inode from eviction.  And do it now, after
-		 * we've incremented swapped, because shmem_unuse() will
-		 * prune a !swapped inode from the swaplist.
-		 */
-		if (first_swapped) {
-			spin_lock(&shmem_swaplist_lock);
-			if (list_empty(&info->swaplist))
-				list_add(&info->swaplist, &shmem_swaplist);
-			spin_unlock(&shmem_swaplist_lock);
-		}
-
+		shmem_recalc_inode(inode, 0, nr_pages);
 		swap_shmem_alloc(folio->swap, nr_pages);
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(folio->swap));
 
@@ -3106,7 +2931,6 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	info = SHMEM_I(inode);
 	memset(info, 0, (char *)inode - (char *)info);
 	spin_lock_init(&info->lock);
-	atomic_set(&info->stop_eviction, 0);
 	info->seals = F_SEAL_SEAL;
 	info->flags = (flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
 	info->i_crtime = inode_get_mtime(inode);
@@ -3115,7 +2939,6 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	if (info->fsflags)
 		shmem_set_inode_flags(inode, info->fsflags, NULL);
 	INIT_LIST_HEAD(&info->shrinklist);
-	INIT_LIST_HEAD(&info->swaplist);
 	simple_xattrs_init(&info->xattrs);
 	cache_no_acl(inode);
 	if (sbinfo->noswap)
@@ -5785,11 +5608,6 @@ void __init shmem_init(void)
 	BUG_ON(IS_ERR(shm_mnt));
 }
 
-int shmem_unuse(unsigned int type)
-{
-	return 0;
-}
-
 int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
 {
 	return 0;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e1cb01b821ff3..9478707ce3ffa 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1738,300 +1738,12 @@ unsigned int count_swap_pages(int type, int free)
 }
 #endif /* CONFIG_HIBERNATION */
 
-static inline int pte_same_as_swp(pte_t pte, pte_t swp_pte)
+static bool swap_slot_allocated(struct swap_info_struct *si,
+		unsigned long offset)
 {
-	return pte_same(pte_swp_clear_flags(pte), swp_pte);
-}
-
-/*
- * No need to decide whether this PTE shares the swap entry with others,
- * just let do_wp_page work it out if a write is requested later - to
- * force COW, vm_page_prot omits write permission from any private vma.
- */
-static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long addr, swp_entry_t entry, struct folio *folio)
-{
-	struct page *page;
-	struct folio *swapcache;
-	spinlock_t *ptl;
-	pte_t *pte, new_pte, old_pte;
-	bool hwpoisoned = false;
-	int ret = 1;
-
-	/*
-	 * If the folio is removed from swap cache by others, continue to
-	 * unuse other PTEs. try_to_unuse may try again if we missed this one.
-	 */
-	if (!folio_matches_swap_entry(folio, entry))
-		return 0;
-
-	swapcache = folio;
-	folio = ksm_might_need_to_copy(folio, vma, addr);
-	if (unlikely(!folio))
-		return -ENOMEM;
-	else if (unlikely(folio == ERR_PTR(-EHWPOISON))) {
-		hwpoisoned = true;
-		folio = swapcache;
-	}
-
-	page = folio_file_page(folio, swp_offset(entry));
-	if (PageHWPoison(page))
-		hwpoisoned = true;
-
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
-	if (unlikely(!pte || !pte_same_as_swp(ptep_get(pte),
-						swp_entry_to_pte(entry)))) {
-		ret = 0;
-		goto out;
-	}
-
-	old_pte = ptep_get(pte);
-
-	if (unlikely(hwpoisoned || !folio_test_uptodate(folio))) {
-		swp_entry_t swp_entry;
-
-		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
-		if (hwpoisoned) {
-			swp_entry = make_hwpoison_entry(page);
-		} else {
-			swp_entry = make_poisoned_swp_entry();
-		}
-		new_pte = swp_entry_to_pte(swp_entry);
-		ret = 0;
-		goto setpte;
-	}
-
-	/*
-	 * Some architectures may have to restore extra metadata to the page
-	 * when reading from swap. This metadata may be indexed by swap entry
-	 * so this must be called before swap_free().
-	 */
-	arch_swap_restore(folio_swap(entry, folio), folio);
-
-	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
-	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
-	folio_get(folio);
-	if (folio == swapcache) {
-		rmap_t rmap_flags = RMAP_NONE;
-
-		/*
-		 * See do_swap_page(): writeback would be problematic.
-		 * However, we do a folio_wait_writeback() just before this
-		 * call and have the folio locked.
-		 */
-		VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
-		if (pte_swp_exclusive(old_pte))
-			rmap_flags |= RMAP_EXCLUSIVE;
-		/*
-		 * We currently only expect small !anon folios, which are either
-		 * fully exclusive or fully shared. If we ever get large folios
-		 * here, we have to be careful.
-		 */
-		if (!folio_test_anon(folio)) {
-			VM_WARN_ON_ONCE(folio_test_large(folio));
-			VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
-			folio_add_new_anon_rmap(folio, vma, addr, rmap_flags);
-		} else {
-			folio_add_anon_rmap_pte(folio, page, vma, addr, rmap_flags);
-		}
-	} else { /* ksm created a completely new copy */
-		folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
-		folio_add_lru_vma(folio, vma);
-	}
-	new_pte = pte_mkold(mk_pte(page, vma->vm_page_prot));
-	if (pte_swp_soft_dirty(old_pte))
-		new_pte = pte_mksoft_dirty(new_pte);
-	if (pte_swp_uffd_wp(old_pte))
-		new_pte = pte_mkuffd_wp(new_pte);
-setpte:
-	set_pte_at(vma->vm_mm, addr, pte, new_pte);
-	swap_free(entry);
-out:
-	if (pte)
-		pte_unmap_unlock(pte, ptl);
-	if (folio != swapcache) {
-		folio_unlock(folio);
-		folio_put(folio);
-	}
-	return ret;
-}
-
-static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
-			unsigned long addr, unsigned long end,
-			unsigned int type)
-{
-	pte_t *pte = NULL;
-	struct swap_info_struct *si;
-
-	si = swap_info[type];
-	do {
-		struct folio *folio;
-		unsigned long offset;
-		unsigned char swp_count;
-		softleaf_t entry;
-		swp_slot_t slot;
-		int ret;
-		pte_t ptent;
-
-		if (!pte++) {
-			pte = pte_offset_map(pmd, addr);
-			if (!pte)
-				break;
-		}
-
-		ptent = ptep_get_lockless(pte);
-		entry = softleaf_from_pte(ptent);
-
-		if (!softleaf_is_swap(entry))
-			continue;
-
-		slot = swp_entry_to_swp_slot(entry);
-		if (swp_slot_type(slot) != type)
-			continue;
-
-		offset = swp_slot_offset(slot);
-		pte_unmap(pte);
-		pte = NULL;
-
-		folio = swap_cache_get_folio(entry);
-		if (!folio) {
-			struct vm_fault vmf = {
-				.vma = vma,
-				.address = addr,
-				.real_address = addr,
-				.pmd = pmd,
-			};
-
-			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-						&vmf);
-		}
-		if (!folio) {
-			swp_count = READ_ONCE(si->swap_map[offset]);
-			if (swp_count == 0 || swp_count == SWAP_MAP_BAD)
-				continue;
-			return -ENOMEM;
-		}
-
-		folio_lock(folio);
-		folio_wait_writeback(folio);
-		ret = unuse_pte(vma, pmd, addr, entry, folio);
-		if (ret < 0) {
-			folio_unlock(folio);
-			folio_put(folio);
-			return ret;
-		}
-
-		folio_free_swap(folio);
-		folio_unlock(folio);
-		folio_put(folio);
-	} while (addr += PAGE_SIZE, addr != end);
-
-	if (pte)
-		pte_unmap(pte);
-	return 0;
-}
-
-static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
-				unsigned long addr, unsigned long end,
-				unsigned int type)
-{
-	pmd_t *pmd;
-	unsigned long next;
-	int ret;
-
-	pmd = pmd_offset(pud, addr);
-	do {
-		cond_resched();
-		next = pmd_addr_end(addr, end);
-		ret = unuse_pte_range(vma, pmd, addr, next, type);
-		if (ret)
-			return ret;
-	} while (pmd++, addr = next, addr != end);
-	return 0;
-}
-
-static inline int unuse_pud_range(struct vm_area_struct *vma, p4d_t *p4d,
-				unsigned long addr, unsigned long end,
-				unsigned int type)
-{
-	pud_t *pud;
-	unsigned long next;
-	int ret;
-
-	pud = pud_offset(p4d, addr);
-	do {
-		next = pud_addr_end(addr, end);
-		if (pud_none_or_clear_bad(pud))
-			continue;
-		ret = unuse_pmd_range(vma, pud, addr, next, type);
-		if (ret)
-			return ret;
-	} while (pud++, addr = next, addr != end);
-	return 0;
-}
-
-static inline int unuse_p4d_range(struct vm_area_struct *vma, pgd_t *pgd,
-				unsigned long addr, unsigned long end,
-				unsigned int type)
-{
-	p4d_t *p4d;
-	unsigned long next;
-	int ret;
-
-	p4d = p4d_offset(pgd, addr);
-	do {
-		next = p4d_addr_end(addr, end);
-		if (p4d_none_or_clear_bad(p4d))
-			continue;
-		ret = unuse_pud_range(vma, p4d, addr, next, type);
-		if (ret)
-			return ret;
-	} while (p4d++, addr = next, addr != end);
-	return 0;
-}
-
-static int unuse_vma(struct vm_area_struct *vma, unsigned int type)
-{
-	pgd_t *pgd;
-	unsigned long addr, end, next;
-	int ret;
-
-	addr = vma->vm_start;
-	end = vma->vm_end;
-
-	pgd = pgd_offset(vma->vm_mm, addr);
-	do {
-		next = pgd_addr_end(addr, end);
-		if (pgd_none_or_clear_bad(pgd))
-			continue;
-		ret = unuse_p4d_range(vma, pgd, addr, next, type);
-		if (ret)
-			return ret;
-	} while (pgd++, addr = next, addr != end);
-	return 0;
-}
+	unsigned char count = READ_ONCE(si->swap_map[offset]);
 
-static int unuse_mm(struct mm_struct *mm, unsigned int type)
-{
-	struct vm_area_struct *vma;
-	int ret = 0;
-	VMA_ITERATOR(vmi, mm, 0);
-
-	mmap_read_lock(mm);
-	if (check_stable_address_space(mm))
-		goto unlock;
-	for_each_vma(vmi, vma) {
-		if (vma->anon_vma && !is_vm_hugetlb_page(vma)) {
-			ret = unuse_vma(vma, type);
-			if (ret)
-				break;
-		}
-
-		cond_resched();
-	}
-unlock:
-	mmap_read_unlock(mm);
-	return ret;
+	return count && swap_count(count) != SWAP_MAP_BAD;
 }
 
 /*
@@ -2043,7 +1755,6 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
 					unsigned int prev)
 {
 	unsigned int i;
-	unsigned char count;
 
 	/*
 	 * No need for swap_lock here: we're just looking
@@ -2052,8 +1763,7 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
 	 * allocations from this area (while holding swap_lock).
 	 */
 	for (i = prev + 1; i < si->max; i++) {
-		count = READ_ONCE(si->swap_map[i]);
-		if (count && swap_count(count) != SWAP_MAP_BAD)
+		if (swap_slot_allocated(si, i))
 			break;
 		if ((i % LATENCY_LIMIT) == 0)
 			cond_resched();
@@ -2065,101 +1775,139 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
 	return i;
 }
 
+#define	for_each_allocated_offset(si, offset)	\
+	while (swap_usage_in_pages(si) && \
+		!signal_pending(current) && \
+		(offset = find_next_to_unuse(si, offset)) != 0)
+
+static struct folio *pagein(swp_entry_t entry, struct swap_iocb **splug,
+		struct mempolicy *mpol)
+{
+	bool folio_was_allocated;
+	struct folio *folio = __read_swap_cache_async(entry, GFP_KERNEL, mpol,
+			NO_INTERLEAVE_INDEX, &folio_was_allocated, false);
+
+	if (folio_was_allocated)
+		swap_read_folio(folio, splug);
+	return folio;
+}
+
 static int try_to_unuse(unsigned int type)
 {
-	struct mm_struct *prev_mm;
-	struct mm_struct *mm;
-	struct list_head *p;
-	int retval = 0;
 	struct swap_info_struct *si = swap_info[type];
+	struct swap_iocb *splug = NULL;
+	struct mempolicy *mpol;
+	struct blk_plug plug;
+	unsigned long offset;
 	struct folio *folio;
 	swp_entry_t entry;
 	swp_slot_t slot;
-	unsigned int i;
+	int ret = 0;
 
 	if (!swap_usage_in_pages(si))
 		goto success;
 
-retry:
-	retval = shmem_unuse(type);
-	if (retval)
-		return retval;
-
-	prev_mm = &init_mm;
-	mmget(prev_mm);
-
-	spin_lock(&mmlist_lock);
-	p = &init_mm.mmlist;
-	while (swap_usage_in_pages(si) &&
-	       !signal_pending(current) &&
-	       (p = p->next) != &init_mm.mmlist) {
+	mpol = get_task_policy(current);
+	blk_start_plug(&plug);
 
-		mm = list_entry(p, struct mm_struct, mmlist);
-		if (!mmget_not_zero(mm))
+	/* first round - submit the reads */
+	offset = 0;
+	for_each_allocated_offset(si, offset) {
+		slot = swp_slot(type, offset);
+		entry = swp_slot_to_swp_entry(slot);
+		if (!entry.val)
 			continue;
-		spin_unlock(&mmlist_lock);
-		mmput(prev_mm);
-		prev_mm = mm;
-		retval = unuse_mm(mm, type);
-		if (retval) {
-			mmput(prev_mm);
-			return retval;
-		}
 
-		/*
-		 * Make sure that we aren't completely killing
-		 * interactive performance.
-		 */
-		cond_resched();
-		spin_lock(&mmlist_lock);
+		folio = pagein(entry, &splug, mpol);
+		if (folio)
+			folio_put(folio);
 	}
-	spin_unlock(&mmlist_lock);
+	blk_finish_plug(&plug);
+	swap_read_unplug(splug);
+	splug = NULL;
+	lru_add_drain();
+
+	/* second round - updating the virtual swap slots' backing state */
+	offset = 0;
+	for_each_allocated_offset(si, offset) {
+		slot = swp_slot(type, offset);
+retry:
+		entry = swp_slot_to_swp_entry(slot);
+		if (!entry.val) {
+			if (!swap_slot_allocated(si, offset))
+				continue;
 
-	mmput(prev_mm);
+			if (signal_pending(current)) {
+				ret = -EINTR;
+				goto out;
+			}
 
-	i = 0;
-	while (swap_usage_in_pages(si) &&
-	       !signal_pending(current) &&
-	       (i = find_next_to_unuse(si, i)) != 0) {
+			/* we might be racing with zswap writeback or disk swapout */
+			schedule_timeout_uninterruptible(1);
+			goto retry;
+		}
 
-		slot = swp_slot(type, i);
-		entry = swp_slot_to_swp_entry(slot);
-		folio = swap_cache_get_folio(entry);
-		if (!folio)
-			continue;
+		/* try to allocate swap cache folio */
+		folio = pagein(entry, &splug, mpol);
+		if (!folio) {
+			if (!swp_slot_to_swp_entry(swp_slot(type, offset)).val)
+				continue;
 
+			ret = -ENOMEM;
+			pr_err("swapoff: unable to allocate swap cache folio for %lu\n",
+						entry.val);
+			goto out;
+		}
+
+		folio_lock(folio);
 		/*
-		 * It is conceivable that a racing task removed this folio from
-		 * swap cache just before we acquired the page lock. The folio
-		 * might even be back in swap cache on another swap area. But
-		 * that is okay, folio_free_swap() only removes stale folios.
+		 * We need to check if the folio is still in swap cache, and is still
+		 * backed by the physical swap slot we are trying to release.
+		 *
+		 * We can, for instance, race with zswap writeback, obtaining the
+		 * temporary folio it allocated for decompression and writeback, which
+		 * would be promptly deleted from swap cache. By the time we lock that
+		 * folio, it might have already contained stale data.
+		 *
+		 * Concurrent swap operations might have also come in before we
+		 * reobtain the folio's lock, deleting the folio from swap cache,
+		 * invalidating the virtual swap slot, then swapping out the folio
+		 * again to a different swap backends.
+		 *
+		 * In all of these cases, we must retry the physical -> virtual lookup.
 		 */
-		folio_lock(folio);
+		if (!folio_matches_swap_slot(folio, entry, slot)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			if (signal_pending(current)) {
+				ret = -EINTR;
+				goto out;
+			}
+			schedule_timeout_uninterruptible(1);
+			goto retry;
+		}
+
 		folio_wait_writeback(folio);
-		folio_free_swap(folio);
+		vswap_store_folio(entry, folio);
+		folio_mark_dirty(folio);
 		folio_unlock(folio);
 		folio_put(folio);
 	}
 
-	/*
-	 * Lets check again to see if there are still swap entries in the map.
-	 * If yes, we would need to do retry the unuse logic again.
-	 * Under global memory pressure, swap entries can be reinserted back
-	 * into process space after the mmlist loop above passes over them.
-	 *
-	 * Limit the number of retries? No: when mmget_not_zero()
-	 * above fails, that mm is likely to be freeing swap from
-	 * exit_mmap(), which proceeds at its own independent pace;
-	 * and even shmem_writeout() could have been preempted after
-	 * folio_alloc_swap(), temporarily hiding that swap.  It's easy
-	 * and robust (though cpu-intensive) just to keep retrying.
-	 */
-	if (swap_usage_in_pages(si)) {
-		if (!signal_pending(current))
-			goto retry;
-		return -EINTR;
+	/* concurrent swappers might still be releasing physical swap slots... */
+	while (swap_usage_in_pages(si)) {
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			goto out;
+		}
+		schedule_timeout_uninterruptible(1);
 	}
 
+out:
+	swap_read_unplug(splug);
+	if (ret)
+		return ret;
+
 success:
 	/*
 	 * Make sure that further cleanups after try_to_unuse() returns happen
-- 
2.47.3


