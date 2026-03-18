Return-Path: <cgroups+bounces-14901-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FFCEW8ou2kcfwIAu9opvQ
	(envelope-from <cgroups+bounces-14901-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:34:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A8F2C37CA
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFFA1309A708
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5F13AA1B6;
	Wed, 18 Mar 2026 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWABf8+l"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEC53AA1B3
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873033; cv=none; b=bn9E5oLgm6My72mKtYASx/33w9M2xW53qb/6RufLZrkjiL/jAIKrB9tI/tMHTlQXk871bEZTyvp3VRnMZAgX7IprNE0KGRUp6nY+fOFywEAa7+/AuiZqRdx4j23RFlaiO6goVMWcI48btP9SHKVr1GS/8KWNXNtFvKS3opdQ1xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873033; c=relaxed/simple;
	bh=tSbAGFzM0rPNBekxwFiAW6mhLbDdWSD3o5yij0k3zco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC+JGBTRbgebiMFzYrruVtidLI9owKTeC0xfQ606HsetTrONRkJtlkrj4QwMXBRzQuBRTgA804QKw0mOTBvFdn6ejfRiHlsDmsV24riVeKRD4KnBkVr+ag4+SgWygwwrMlnpJjrXqkWUtoaY7Lke2iM8cVaPoMkbnbpACBF7d1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWABf8+l; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40974bf7781so1008392fac.0
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 15:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773873028; x=1774477828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3Gvdm3PaljwFAuBB/+7hzNv2aerA2JysVE5/2pi+vc=;
        b=hWABf8+lxCE633Zqw6GUEz4AKq6xB8Fep/b2Os7ZyggHx1Bpmr5kk5NunSzowMcHWq
         T4lTXAQ9oeERJ842v+FydGdC+Qw3sQM5Oggjs+cLPYJQSdFAO9OAUEWOm/c/ZUCt0odv
         Dn6b181j5RVBIDLCuHH+jdXc2cRJnZPgM3XnbYRHjDKz/Cgt+zvuammjxq1vwQXQ8NQB
         lJxT9lzhbB5iRJa/W86CSzDF7yKCpY1fVsIPGCxqWMXzJ2T5XEmbGYVYGCvq71a6C8A3
         r4T6/srB4qUVEQFitEkMnVpuf54V0zPIPb9Di/BBdp43ps6pGDxl1i/9rWMkRwWryehU
         KqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873028; x=1774477828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I3Gvdm3PaljwFAuBB/+7hzNv2aerA2JysVE5/2pi+vc=;
        b=SulGuaOzuSnEaJzA7d/dfOw57w2f3KJKuMwAE9DTGHNHNB4l+PRrLl8hsD1GgfrZUh
         yS03bmlNgx/cQqMJ0V8giW+WQKopTW66Bs6UTgqkeWF8yO1SVwGzcZepPWBg/1gGNVHR
         uKYCPdOl2WfwFHC6xOXxdlXm5AJ72oQIPjzLBcnzgjOqVV7McL1DWPx/09GvNjXh22Fn
         KZQ58WV7TQukLCdbnwhg38N5HJ5LjXsw3w0ghhCkrPMfu7FRK9eccgxsRu0Zy+94VmrT
         fItI7ofJf+1PQiM3npxu+N/zviOUlYl/0diPQ3paLsZ0swFMlYi/lfIqdkcoy6dO9Gvz
         Q3IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwiULI5Ci1dr2FT/ajvJ4zyIfnuhEg8jRbWcY0qsviBy4Imo7/zwWV/dNBxe1cVTpdLLKo2OmV@vger.kernel.org
X-Gm-Message-State: AOJu0YxdPrNFYL+X1fXWOcrNN7Zs8Y10YwmlGdl2Q+4xPkLCRSt/qre0
	kG+mGmKCLfdMB2MnA/aeWOkC2gFMNpduiRNCsEgjjLCG9OAtenWaVDHc
X-Gm-Gg: ATEYQzwzSs5iYBznSYa+26H38X2Yyv/vyBduJRz+7fKzXiwskgoQTD1lsnVEhHGED5i
	FAaR+y0cwWMopZwV18rJyF3m074pWZfyct59Eva+TH855NHuxMloxLujwT2X0WqjCyYFzN6VPbi
	UR5ED6hcmnGRd72msVRfJE49oZ3/F8bZWrYkGO3N0MwMGvCSli0cLeK3skzvVyarRJU051uahN/
	XIJ23/Und+NKW07dFOF6rng4Efja1Uc4GwNs3OE5MK78BiTr/IWdwJZWgie4bfyiawNeoTUyrZa
	gpy34S3LsOPHcQ/HHHGGqe7pbsFAEzcAlNrVU7hEfER9j0igBj3mD5EFGEdZRLgNTbWoLZcxvXO
	FdwHg8zsM1fNSScsE1cfTs+057LnMazrST66gzFryXf4wNREr7ouzDRUJA22EXKiaYW8k0uBP4M
	HfzbM+ROqxVPfGNRpXetO4Gz8MUAe0zMKgtD1WFUhINW8m
X-Received: by 2002:a4a:e901:0:b0:67b:a735:fd27 with SMTP id 006d021491bc7-67c1840f4camr748576eaf.25.1773873027435;
        Wed, 18 Mar 2026 15:30:27 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:9::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c0d88c6aasm2616134eaf.9.2026.03.18.15.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:30:27 -0700 (PDT)
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
Subject: [PATCH v4 19/21] swap: simplify swapoff using virtual swap
Date: Wed, 18 Mar 2026 15:29:50 -0700
Message-ID: <20260318222953.441758-20-nphamcs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14901-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.876];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4A8F2C37CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 mm/filemap.c             |  14 +-
 mm/shmem.c               | 196 +---------------
 mm/swapfile.c            | 474 +++++++++------------------------------
 4 files changed, 126 insertions(+), 565 deletions(-)

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
diff --git a/mm/filemap.c b/mm/filemap.c
index ebd75684cb0a7..53aad273ea2f1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4614,13 +4614,13 @@ static void filemap_cachestat(struct address_space *mapping,
 
 				/*
 				 * Getting a swap entry from the shmem
-				 * inode means we beat
-				 * shmem_unuse(). rcu_read_lock()
-				 * ensures swapoff waits for us before
-				 * freeing the swapper space. However,
-				 * we can race with swapping and
-				 * invalidation, so there might not be
-				 * a shadow in the swapcache (yet).
+				 * inode means we beat swapoff.
+				 * rcu_read_lock() ensures swapoff waits
+				 * for us before freeing the swapper
+				 * space. However, we can race with
+				 * swapping and invalidation, so there
+				 * might not be a shadow in the swapcache
+				 * (yet).
 				 */
 				shadow = swap_cache_get_shadow(swp);
 				if (!shadow)
diff --git a/mm/shmem.c b/mm/shmem.c
index 3a346cca114ab..984e01ea88d3c 100644
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
 
@@ -2116,12 +1941,12 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 }
 
 /*
- * When a page is moved from swapcache to shmem filecache (either by the
- * usual swapin of shmem_get_folio_gfp(), or by the less common swapoff of
- * shmem_unuse_inode()), it may have been read in earlier from swap, in
- * ignorance of the mapping it belongs to.  If that mapping has special
- * constraints (like the gma500 GEM driver, which requires RAM below 4GB),
- * we may need to copy to a suitable page before moving to filecache.
+ * When a page is moved from swapcache to shmem filecache (by the usual
+ * swapin of shmem_get_folio_gfp()), it may have been read in earlier from
+ * swap, in ignorance of the mapping it belongs to.  If that mapping has
+ * special constraints (like the gma500 GEM driver, which requires RAM
+ * below 4GB), we may need to copy to a suitable page before moving to
+ * filecache.
  *
  * In a future release, this may well be extended to respect cpuset and
  * NUMA mempolicy, and applied also to anonymous pages in do_swap_page();
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
index aeb3575df8a0b..b553652125d11 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1741,300 +1741,12 @@ unsigned int count_swap_pages(int type, int free)
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
@@ -2046,7 +1758,6 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
 					unsigned int prev)
 {
 	unsigned int i;
-	unsigned char count;
 
 	/*
 	 * No need for swap_lock here: we're just looking
@@ -2055,8 +1766,7 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
 	 * allocations from this area (while holding swap_lock).
 	 */
 	for (i = prev + 1; i < si->max; i++) {
-		count = READ_ONCE(si->swap_map[i]);
-		if (count && swap_count(count) != SWAP_MAP_BAD)
+		if (swap_slot_allocated(si, i))
 			break;
 		if ((i % LATENCY_LIMIT) == 0)
 			cond_resched();
@@ -2068,101 +1778,139 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
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
2.52.0


