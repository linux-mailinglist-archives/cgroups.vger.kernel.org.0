Return-Path: <cgroups+bounces-16909-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mNR/DDNgLGqAQAQAu9opvQ
	(envelope-from <cgroups+bounces-16909-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 21:38:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C970E67C163
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 21:38:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=s5StCNIa;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16909-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16909-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CE4D3026F17
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 19:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF7637EFFF;
	Fri, 12 Jun 2026 19:37:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A1395AE9
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 19:37:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293072; cv=none; b=e0NSvPD3pYoN3qOJlZVD94hFiPoAXjKY/DZEv2n2CqE+lfIlDsTRMYM9I9jOkCOhabOq4FuOlgf6/Uy9OncGnmQ+6O9YjdTyqks32AVxUKXJfO6FzekZ3FbIavCm3ISqDHQcz5bPDh0Hn45/GLRvlUnayYkzlzLkAhsRUA4yIoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293072; c=relaxed/simple;
	bh=GPJqpDBdb0V4C10uL+8eC6yu6T61hvq1607Ih4XOBbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDNDQC4+Ks3tJhfazzYf1kV8yby/n+dZjbv/5JMWF8gDDKsLXDaHCEaye6qSrlXJK9ZmE/JcugF6Tk4OR6hCbLsHEWibwIyN1J+6OuW14BDJFjNQJmLkzDhgSAyWlG2R7ekviFVX04QlHKmLB5aDHcLjO2UjGyzDuwCTQLbY45k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s5StCNIa; arc=none smtp.client-ip=209.85.167.170
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-48650c78e09so521734b6e.2
        for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 12:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781293068; x=1781897868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s51VAY71W1rg9Oc1QVt/7ynJ7sjjnCFpUMpOA9M0z38=;
        b=s5StCNIaznKdhGvWfNBlHHlU7Z71hXw0M05UDJXza3U+p4KFjpl6K/VF+Qao9ZuSHt
         ylNwdAwp/LtzJpqenB0fhR0O2rOVF2fh/eMmB23Kja4omDmH1xYaOv4dEeFsR4lNiEM/
         iMX1ytkUd62vFuqZK0mAMza7E6qbo48uIdRTptjjVk1U7SokKyUWTRm7NS5ksggRLydc
         roTSH+DJSqmtNCAlWt27olo5N3fb7+idgLU6VADeMpWXY2quotQpEAhx+q2dyllRQCtE
         f5sTcysYp+LV+Z78sdPc6Sn6AyDHBUT86j82VFEtI2p+bUj2FR8396pvMa+VtOU3YxUp
         la+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781293068; x=1781897868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s51VAY71W1rg9Oc1QVt/7ynJ7sjjnCFpUMpOA9M0z38=;
        b=AKXjqjIakrgpoLbEeSRzcOxQsuB5R7rph7gpuOc3Ve8HPUUj3fsK6QfSs85imDyq44
         EGuVv4YbL2vFpW5BI3qTrFmjVEaWn7Z+TOaZTg6rYvRR88PJdXUGndeh3RCJpvQd7+hW
         fPr8NfBz1GK5RmYsg+fsZP8R40CnjzCoyIRuEbr2oOo/XtHPwHgG0J3vTU9E6GLHq53G
         98DeFNNI1du/JoKkTlY7Byg54l3cg4gnZSecsPaXchnwBflvoVJwSZeyhABgAF/a8IXr
         51tTrKVi9/es6cGPEHEkuuj02LLW+9Lwf8ZGTJvvgq9i757FMHV12qLzea+MJ+LKLByL
         yWRw==
X-Forwarded-Encrypted: i=1; AFNElJ/fd+vq1jfpZnhZG73eEIP0/GxEOftUz6dZ9Zvajg/nKUUuYpftTQYEKQYfXDJwkKSRbQYbrC6H@vger.kernel.org
X-Gm-Message-State: AOJu0YyHay8fAbQgivPRKfkAaqSRhFbvgiASLxbxwY+ddsbcAddDaWmx
	efRJAsj0I3KCt2M7wEmxQ31XixGusZxUuZgKpwpefhL74GsIeWnWuNdMW0zwymrq
X-Gm-Gg: Acq92OFbJTKvPaEkZa/p4E8ZZzZvwLErVkEGdbwUfXX6+zqZrOtcV6SRH0iJDsArSfu
	AGgAA9ImwN1mODlfC8sOORC4MANxrcqMjGkTSoG+7T+iINxh/VBLxfWj4OUYCimCfuxPrAdR8p4
	oM17df70PTr1gLUlM4ZCk9qRemBUGkiwZWGNbUCIn42Mctn6k2DtfYONWXH0AZjvWDmbryF5w3e
	W4k7/7IeQuI0hSJxEUjX3PHVwvxSgOj9e4xmx8YDBO+KKevUr18ex1hstPgPLoRcdjubNhvOvzB
	ypMuelmhOR6oUIVPqSYfSA5/jfZIRrtJGF79iJtBtFQRSKU1KaJ8Kjhe3bB5DVzbNs+Os7cRpe6
	O/LVtyWmx/Q1HEQ6mfQwmci9QIJe67IGc+iDdYs7RunsGn0h1KKiVD00O1pQufY6F3BrLcIRHcJ
	cMVVLpaZ5aoeKdC6kFaMhbUx7bHyL3qo1iTBFO/0GUMljoQsEin80warDG
X-Received: by 2002:a05:6808:8613:b0:480:4024:3bb with SMTP id 5614622812f47-48741ab6e19mr472988b6e.24.1781293067414;
        Fri, 12 Jun 2026 12:37:47 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-487315a90d8sm1529220b6e.17.2026.06.12.12.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:37:46 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: chrisl@kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	yosry@kernel.org,
	david@kernel.org,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	chengming.zhou@linux.dev,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	qi.zheng@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	riel@surriel.com,
	gourry@gourry.net,
	haowenchao22@gmail.com,
	kernel-team@meta.com,
	nphamcs@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v2 3/7] mm, swap: support physical swap as a vswap backend
Date: Fri, 12 Jun 2026 12:37:34 -0700
Message-ID: <20260612193738.2183968-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612193738.2183968-1-nphamcs@gmail.com>
References: <20260612193738.2183968-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,lge.com,infradead.org,google.com,surriel.com,gourry.net,gmail.com,meta.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16909-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:yosry@kernel.org,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:youngjun.park@lge.com,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:nphamcs@gmail.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C970E67C163

Add physical swap as a backend for the virtual swap layer.

With physical swap backing, vswap can allocate a physical slot on
demand when needed: as a fallback for zswap_store failures, or as
the destination for zswap writeback.

Each vswap entry's physical slot is tracked via a Pointer-tagged
swap_table entry on the physical cluster (rmap back to the vswap
entry).

Suggested-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h |  10 +
 mm/memory.c          |   8 +-
 mm/page_io.c         | 131 ++++++++---
 mm/swap.h            |  10 +
 mm/swap_table.h      |  60 +++++
 mm/swapfile.c        | 538 ++++++++++++++++++++++++++++++++++++++++---
 mm/vmscan.c          |   2 +-
 mm/vswap.h           | 139 ++++++++++-
 mm/zswap.c           |  93 +++++---
 9 files changed, 879 insertions(+), 112 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 822b1c90db1c..5162404770bb 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -447,6 +447,16 @@ extern int swp_swapcount(swp_entry_t entry);
 struct backing_dev_info;
 extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
 sector_t swap_folio_sector(struct folio *folio);
+sector_t swap_entry_sector(swp_entry_t entry);
+
+#ifdef CONFIG_VSWAP
+swp_entry_t folio_realloc_swap(struct folio *folio);
+#else
+static inline swp_entry_t folio_realloc_swap(struct folio *folio)
+{
+	return (swp_entry_t){};
+}
+#endif
 
 /*
  * If there is an existing swap slot reference (swap entry) and the caller
diff --git a/mm/memory.c b/mm/memory.c
index 9d6f78d04fd2..2495f071123c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4524,13 +4524,13 @@ static inline bool should_try_to_free_swap(struct swap_info_struct *si,
 	 * are fast, and meanwhile, swap cache pinning the slot deferring the
 	 * release of metadata or fragmentation is a more critical issue.
 	 */
-	if (data_race(si->flags & SWP_SYNCHRONOUS_IO))
+	if (swap_entry_backend_has_flag(si, folio->swap, SWP_SYNCHRONOUS_IO))
 		return true;
 	/*
 	 * Non-swapfile backends cannot be reused for future swapouts.
 	 * Free the swap slot unless backed by contiguous physical swap.
 	 */
-	if (is_vswap_entry(folio->swap))
+	if (!folio_phys_swap_backed(folio))
 		return true;
 	if (mem_cgroup_swap_full(folio) || (vma->vm_flags & VM_LOCKED) ||
 	    folio_test_mlocked(folio))
@@ -4840,7 +4840,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		swap_update_readahead(folio, vma, vmf->address);
 	if (!folio) {
 		/* Swapin bypasses readahead for SWP_SYNCHRONOUS_IO devices */
-		if (data_race(si->flags & SWP_SYNCHRONOUS_IO))
+		if (swap_entry_backend_has_flag(si, entry, SWP_SYNCHRONOUS_IO))
 			folio = swapin_sync(entry, GFP_HIGHUSER_MOVABLE,
 					    thp_swapin_suitable_orders(vmf) | BIT(0),
 					    vmf, NULL, 0);
@@ -5015,7 +5015,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 */
 			exclusive = true;
 		} else if (exclusive && folio_test_writeback(folio) &&
-			  data_race(si->flags & SWP_STABLE_WRITES)) {
+			  swap_entry_backend_has_flag(si, entry, SWP_STABLE_WRITES)) {
 			/*
 			 * This is tricky: not all swap backends support
 			 * concurrent page modifications while under writeback.
diff --git a/mm/page_io.c b/mm/page_io.c
index 784531060746..b4c4a9d79893 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -256,6 +256,7 @@ static void swap_zeromap_folio_clear(struct folio *folio)
  */
 int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug)
 {
+	swp_entry_t phys;
 	int ret = 0;
 
 	if (folio_free_swap(folio))
@@ -288,8 +289,14 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug)
 	 */
 	swap_zeromap_folio_clear(folio);
 
+	/*
+	 * For vswap: release stale non-swapfile backings (e.g. ZSWAP from a
+	 * previous swapout cycle) so zswap_store or folio_realloc_swap
+	 * starts on clean slots. Contiguous PHYS backing is preserved for
+	 * reuse by folio_realloc_swap.
+	 */
 	if (is_vswap_entry(folio->swap))
-		folio_release_vswap_backing(folio);
+		folio_release_non_phys_swap_backing(folio);
 
 	if (zswap_store(folio)) {
 		count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
@@ -305,8 +312,19 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug)
 	rcu_read_unlock();
 
 	if (is_vswap_entry(folio->swap)) {
-		folio_mark_dirty(folio);
-		return AOP_WRITEPAGE_ACTIVATE;
+		/*
+		 * zswap_store rolled back any partial vtable state on
+		 * failure (see folio_release_non_phys_swap_backing call in
+		 * zswap_store's check_old path), so any contiguous PHYS
+		 * backing from a prior cycle is preserved and reused here.
+		 */
+		phys = folio_realloc_swap(folio);
+		if (!phys.val) {
+			folio_mark_dirty(folio);
+			return AOP_WRITEPAGE_ACTIVATE;
+		}
+		__swap_writepage_phys(folio, swap_plug, phys);
+		return 0;
 	}
 
 	return __swap_writepage(folio, swap_plug);
@@ -398,12 +416,12 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 	mempool_free(sio, sio_pool);
 }
 
-static void swap_writepage_fs(struct folio *folio, struct swap_iocb **swap_plug)
+static void swap_writepage_fs(struct folio *folio,
+			      struct swap_info_struct *sis, loff_t pos,
+			      struct swap_iocb **swap_plug)
 {
 	struct swap_iocb *sio = swap_plug ? *swap_plug : NULL;
-	struct swap_info_struct *sis = __swap_entry_to_info(folio->swap);
 	struct file *swap_file = sis->swap_file;
-	loff_t pos = swap_dev_pos(folio->swap);
 
 	count_swpout_vm_event(folio);
 	folio_start_writeback(folio);
@@ -435,13 +453,13 @@ static void swap_writepage_fs(struct folio *folio, struct swap_iocb **swap_plug)
 }
 
 static void swap_writepage_bdev_sync(struct folio *folio,
-		struct swap_info_struct *sis)
+		struct swap_info_struct *sis, sector_t sector)
 {
 	struct bio_vec bv;
 	struct bio bio;
 
 	bio_init(&bio, sis->bdev, &bv, 1, REQ_OP_WRITE | REQ_SWAP);
-	bio.bi_iter.bi_sector = swap_folio_sector(folio);
+	bio.bi_iter.bi_sector = sector;
 	bio_add_folio_nofail(&bio, folio, folio_size(folio), 0);
 
 	bio_associate_blkg_from_page(&bio, folio);
@@ -471,6 +489,41 @@ static void swap_writepage_bdev_async(struct folio *folio,
 	submit_bio(bio);
 }
 
+#ifdef CONFIG_VSWAP
+void __swap_writepage_phys(struct folio *folio, struct swap_iocb **swap_plug,
+			   swp_entry_t phys_entry)
+{
+	struct swap_info_struct *sis = __swap_entry_to_info(phys_entry);
+	sector_t sector = swap_entry_sector(phys_entry);
+	struct bio *bio;
+
+	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
+	VM_WARN_ON(swap_is_vswap(sis));
+
+	if (data_race(sis->flags & SWP_FS_OPS)) {
+		swap_writepage_fs(folio, sis, swap_dev_pos(phys_entry),
+				  swap_plug);
+		return;
+	}
+
+	if (data_race(sis->flags & SWP_SYNCHRONOUS_IO)) {
+		swap_writepage_bdev_sync(folio, sis, sector);
+		return;
+	}
+
+	bio = bio_alloc(sis->bdev, 1, REQ_OP_WRITE | REQ_SWAP, GFP_NOIO);
+	bio->bi_iter.bi_sector = sector;
+	bio->bi_end_io = end_swap_bio_write;
+	bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
+
+	bio_associate_blkg_from_page(bio, folio);
+	count_swpout_vm_event(folio);
+	folio_start_writeback(folio);
+	folio_unlock(folio);
+	submit_bio(bio);
+}
+#endif
+
 int __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug)
 {
 	struct swap_info_struct *sis = __swap_entry_to_info(folio->swap);
@@ -489,14 +542,10 @@ int __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug)
 	 * is safe.
 	 */
 	if (data_race(sis->flags & SWP_FS_OPS))
-		swap_writepage_fs(folio, swap_plug);
-	/*
-	 * ->flags can be updated non-atomically,
-	 * but that will never affect SWP_SYNCHRONOUS_IO, so the data_race
-	 * is safe.
-	 */
+		swap_writepage_fs(folio, sis, swap_dev_pos(folio->swap),
+				  swap_plug);
 	else if (data_race(sis->flags & SWP_SYNCHRONOUS_IO))
-		swap_writepage_bdev_sync(folio, sis);
+		swap_writepage_bdev_sync(folio, sis, swap_folio_sector(folio));
 	else
 		swap_writepage_bdev_async(folio, sis);
 	return 0;
@@ -606,11 +655,11 @@ static bool swap_read_folio_zeromap(struct folio *folio)
 	return true;
 }
 
-static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
+static void swap_read_folio_fs(struct folio *folio,
+			       struct swap_info_struct *sis, loff_t pos,
+			       struct swap_iocb **plug)
 {
-	struct swap_info_struct *sis = __swap_entry_to_info(folio->swap);
 	struct swap_iocb *sio = NULL;
-	loff_t pos = swap_dev_pos(folio->swap);
 
 	if (plug)
 		sio = *plug;
@@ -641,13 +690,13 @@ static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
 }
 
 static void swap_read_folio_bdev_sync(struct folio *folio,
-		struct swap_info_struct *sis)
+		struct swap_info_struct *sis, sector_t sector)
 {
 	struct bio_vec bv;
 	struct bio bio;
 
 	bio_init(&bio, sis->bdev, &bv, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = swap_folio_sector(folio);
+	bio.bi_iter.bi_sector = sector;
 	bio_add_folio_nofail(&bio, folio, folio_size(folio), 0);
 	/*
 	 * Keep this task valid during swap readpage because the oom killer may
@@ -663,12 +712,12 @@ static void swap_read_folio_bdev_sync(struct folio *folio,
 }
 
 static void swap_read_folio_bdev_async(struct folio *folio,
-		struct swap_info_struct *sis)
+		struct swap_info_struct *sis, sector_t sector)
 {
 	struct bio *bio;
 
 	bio = bio_alloc(sis->bdev, 1, REQ_OP_READ, GFP_KERNEL);
-	bio->bi_iter.bi_sector = swap_folio_sector(folio);
+	bio->bi_iter.bi_sector = sector;
 	bio->bi_end_io = end_swap_bio_read;
 	bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
 	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
@@ -677,6 +726,22 @@ static void swap_read_folio_bdev_async(struct folio *folio,
 	submit_bio(bio);
 }
 
+static void swap_read_folio_phys(struct folio *folio, swp_entry_t phys_entry,
+				struct swap_iocb **plug)
+{
+	struct swap_info_struct *sis = __swap_entry_to_info(phys_entry);
+	sector_t sector = swap_entry_sector(phys_entry);
+
+	zswap_folio_swapin(folio);
+
+	if (data_race(sis->flags & SWP_FS_OPS))
+		swap_read_folio_fs(folio, sis, swap_dev_pos(phys_entry), plug);
+	else if (data_race(sis->flags & SWP_SYNCHRONOUS_IO))
+		swap_read_folio_bdev_sync(folio, sis, sector);
+	else
+		swap_read_folio_bdev_async(folio, sis, sector);
+}
+
 void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
 	struct swap_info_struct *sis = __swap_entry_to_info(folio->swap);
@@ -684,6 +749,7 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	bool workingset = folio_test_workingset(folio);
 	unsigned long pflags;
 	bool in_thrashing;
+	swp_entry_t phys;
 
 	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio) && !synchronous, folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -708,20 +774,15 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	if (zswap_load(folio) != -ENOENT)
 		goto finish;
 
-	if (unlikely(sis->flags & SWP_VSWAP)) {
-		folio_unlock(folio);
-		goto finish;
-	}
-
-	/* We have to read from slower devices. Increase zswap protection. */
-	zswap_folio_swapin(folio);
-
-	if (data_race(sis->flags & SWP_FS_OPS)) {
-		swap_read_folio_fs(folio, plug);
-	} else if (synchronous) {
-		swap_read_folio_bdev_sync(folio, sis);
+	if (swap_is_vswap(sis)) {
+		phys = vswap_to_phys(folio->swap);
+		if (!phys.val) {
+			folio_unlock(folio);
+			goto finish;
+		}
+		swap_read_folio_phys(folio, phys, plug);
 	} else {
-		swap_read_folio_bdev_async(folio, sis);
+		swap_read_folio_phys(folio, folio->swap, plug);
 	}
 
 finish:
diff --git a/mm/swap.h b/mm/swap.h
index 2f17c2003e43..559732c16ffd 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -285,6 +285,16 @@ static inline void swap_read_unplug(struct swap_iocb *plug)
 void swap_write_unplug(struct swap_iocb *sio);
 int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug);
 int __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug);
+#ifdef CONFIG_VSWAP
+void __swap_writepage_phys(struct folio *folio, struct swap_iocb **swap_plug,
+			   swp_entry_t phys_entry);
+#else
+static inline void __swap_writepage_phys(struct folio *folio,
+					 struct swap_iocb **swap_plug,
+					 swp_entry_t phys_entry)
+{
+}
+#endif
 
 /* linux/mm/swap_state.c */
 extern struct address_space swap_space __read_mostly;
diff --git a/mm/swap_table.h b/mm/swap_table.h
index fd7f0fb9836a..b50ebcd9e4de 100644
--- a/mm/swap_table.h
+++ b/mm/swap_table.h
@@ -4,8 +4,11 @@
 
 #include <linux/rcupdate.h>
 #include <linux/atomic.h>
+#include <linux/swapops.h>
 #include "swap.h"
 
+struct zswap_entry;
+
 /* A typical flat array in each cluster as swap table */
 struct swap_table {
 	atomic_long_t entries[SWAPFILE_CLUSTER];
@@ -368,4 +371,61 @@ static inline unsigned short __swap_cgroup_clear(struct swap_cluster_info *ci,
 }
 #endif
 
+/*
+ * Pointer-tagged swap table entry: rmap for vswap-backing physical slots.
+ *
+ * On physical clusters, a Pointer-tagged entry stores the offset of the
+ * vswap entry that owns this physical slot (the reverse map). Only the
+ * offset is stored; the swap type is implicit (always vswap_si->type,
+ * since there is exactly one vswap device). The top bit is reserved as
+ * a cache-only flag, set when vswap swap_count drops to 0 but the folio
+ * is still in swap cache.
+ *
+ *   Pointer:  |C|---- vswap offset ----|100|
+ *             C = SWP_RMAP_CACHE_ONLY (bit 63)
+ */
+#ifdef CONFIG_VSWAP
+extern struct swap_info_struct *vswap_si;
+
+#define SWP_TB_PTR_MARK_BITS	3
+#define SWP_TB_PTR_MARK		0b100UL
+#define SWP_TB_PTR_MARK_MASK	((1UL << SWP_TB_PTR_MARK_BITS) - 1)
+#define SWP_RMAP_CACHE_ONLY	(1UL << (BITS_PER_LONG - 1))
+#define SWP_RMAP_ENTRY_MASK	(~(SWP_RMAP_CACHE_ONLY | SWP_TB_PTR_MARK_MASK))
+
+static inline bool swp_tb_is_pointer(unsigned long swp_tb)
+{
+	return (swp_tb & SWP_TB_PTR_MARK_MASK) == SWP_TB_PTR_MARK;
+}
+
+static inline unsigned long swp_entry_to_swp_tb_ptr(swp_entry_t entry)
+{
+	return (swp_offset(entry) << SWP_TB_PTR_MARK_BITS) | SWP_TB_PTR_MARK;
+}
+
+static inline swp_entry_t swp_tb_ptr_to_swp_entry(unsigned long swp_tb)
+{
+	unsigned long offset;
+
+	VM_WARN_ON(!swp_tb_is_pointer(swp_tb));
+	offset = (swp_tb & SWP_RMAP_ENTRY_MASK) >> SWP_TB_PTR_MARK_BITS;
+	return swp_entry(vswap_si->type, offset);
+}
+#else
+#define SWP_RMAP_CACHE_ONLY	0UL
+static inline bool swp_tb_is_pointer(unsigned long swp_tb)
+{
+	return false;
+}
+static inline unsigned long swp_entry_to_swp_tb_ptr(swp_entry_t entry)
+{
+	return 0;
+}
+static inline swp_entry_t swp_tb_ptr_to_swp_entry(unsigned long swp_tb)
+{
+	return (swp_entry_t){};
+}
+
+#endif /* CONFIG_VSWAP */
+
 #endif
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a79373db45df..18c53117503d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -145,10 +145,22 @@ static DEFINE_PER_CPU(struct percpu_vswap_cluster, percpu_vswap_cluster) = {
 static bool vswap_alloc(struct folio *folio);
 static void vswap_free_cluster(struct swap_info_struct *si,
 			       struct swap_cluster_info *ci);
+static void vswap_mark_cache_only(struct swap_info_struct *si,
+				  struct swap_cluster_info *ci,
+				  unsigned int ci_off);
+static void vswap_clear_cache_only(struct swap_info_struct *si,
+				   struct swap_cluster_info *ci,
+				   unsigned int ci_start, int nr);
 #else
 static inline bool vswap_alloc(struct folio *folio) { return false; }
 static inline void vswap_free_cluster(struct swap_info_struct *si,
 				      struct swap_cluster_info *ci) {}
+static inline void vswap_mark_cache_only(struct swap_info_struct *si,
+					 struct swap_cluster_info *ci,
+					 unsigned int ci_off) {}
+static inline void vswap_clear_cache_only(struct swap_info_struct *si,
+					  struct swap_cluster_info *ci,
+					  unsigned int ci_start, int nr) {}
 #endif
 
 /* May return NULL on invalid type, caller must check for NULL return */
@@ -257,7 +269,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	need_reclaim = ((flags & TTRS_ANYWAY) ||
 			((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) ||
 			((flags & TTRS_FULL) && mem_cgroup_swap_full(folio) &&
-			 !is_vswap_entry(folio->swap)));
+			 folio_phys_swap_backed(folio)));
 	if (!need_reclaim || !folio_swapcache_freeable(folio))
 		goto out_unlock;
 
@@ -351,19 +363,24 @@ offset_to_swap_extent(struct swap_info_struct *sis, unsigned long offset)
 	BUG();
 }
 
-sector_t swap_folio_sector(struct folio *folio)
+sector_t swap_entry_sector(swp_entry_t entry)
 {
-	struct swap_info_struct *sis = __swap_entry_to_info(folio->swap);
+	struct swap_info_struct *sis = __swap_entry_to_info(entry);
 	struct swap_extent *se;
 	sector_t sector;
 	pgoff_t offset;
 
-	offset = swp_offset(folio->swap);
+	offset = swp_offset(entry);
 	se = offset_to_swap_extent(sis, offset);
 	sector = se->start_block + (offset - se->start_page);
 	return sector << (PAGE_SHIFT - 9);
 }
 
+sector_t swap_folio_sector(struct folio *folio)
+{
+	return swap_entry_sector(folio->swap);
+}
+
 /*
  * swap allocation tell device that a cluster of swap can now be discarded,
  * to allow the swap device to optimize its wear-levelling.
@@ -879,6 +896,72 @@ static int swap_cluster_setup_bad_slot(struct swap_info_struct *si,
 	return ret;
 }
 
+/*
+ * Try to reclaim a Pointer-tagged physical slot backing a vswap entry.
+ * The physical cluster lock must NOT be held. Returns the number of physical
+ * slots reclaimed (the backing folio's page count), or < 0 on failure.
+ */
+static int try_to_reclaim_vswap_backing(struct swap_info_struct *si,
+					unsigned long offset)
+{
+	struct swap_cluster_info *ci;
+	swp_entry_t vswap_entry, phys_base;
+	struct folio *folio;
+	unsigned long swp_tb;
+	unsigned int ci_off, i;
+	int ret;
+
+	ci = swap_cluster_lock(si, offset);
+	if (!ci)
+		return -1;
+	ci_off = offset % SWAPFILE_CLUSTER;
+	swp_tb = __swap_table_get(ci, ci_off);
+	if (!swp_tb_is_pointer(swp_tb) || !(swp_tb & SWP_RMAP_CACHE_ONLY)) {
+		swap_cluster_unlock(ci);
+		return -1;
+	}
+	vswap_entry = swp_tb_ptr_to_swp_entry(swp_tb);
+	swap_cluster_unlock(ci);
+
+	folio = swap_cache_get_folio(vswap_entry);
+	if (!folio)
+		return -1;
+
+	if (!folio_trylock(folio)) {
+		folio_put(folio);
+		return -1;
+	}
+
+	if (!folio_matches_swap_entry(folio, vswap_entry)) {
+		folio_unlock(folio);
+		folio_put(folio);
+		return -1;
+	}
+
+	/*
+	 * Re-validate under folio lock. The folio's first vswap entry is
+	 * folio->swap; the rmap value we just read is folio->swap + i for
+	 * some i in [0, nr_pages). Check the folio's first entry still maps
+	 * to the contiguous physical run that includes our target offset.
+	 */
+	i = vswap_entry.val - folio->swap.val;
+	phys_base = vswap_to_phys(folio->swap);
+	if (!phys_base.val || swp_type(phys_base) != si->type ||
+	    swp_offset(phys_base) + i != offset ||
+	    i >= folio_nr_pages(folio)) {
+		folio_unlock(folio);
+		folio_put(folio);
+		return -1;
+	}
+
+	ret = folio_nr_pages(folio);
+	if (!folio_free_swap(folio))
+		ret = -1;
+	folio_unlock(folio);
+	folio_put(folio);
+	return ret;
+}
+
 /*
  * Reclaim drops the ci lock, so the cluster may become unusable (freed or
  * stolen by a lower order). @usable will be set to false if that happens.
@@ -902,6 +985,13 @@ static bool cluster_reclaim_range(struct swap_info_struct *si,
 	spin_unlock(&ci->lock);
 	do {
 		swp_tb = swap_table_get(ci, offset % SWAPFILE_CLUSTER);
+		if (swp_tb_is_pointer(swp_tb)) {
+			rcu_read_unlock();
+			if (try_to_reclaim_vswap_backing(si, offset) < 0)
+				goto relock;
+			rcu_read_lock();
+			continue;
+		}
 		if (swp_tb_get_count(swp_tb))
 			break;
 		if (swp_tb_is_folio(swp_tb))
@@ -909,6 +999,7 @@ static bool cluster_reclaim_range(struct swap_info_struct *si,
 				break;
 	} while (++offset < end);
 	rcu_read_unlock();
+relock:
 
 	/* Re-lookup: dynamic cluster may have been freed while lock was dropped */
 	ci = swap_cluster_lock(si, start);
@@ -980,6 +1071,8 @@ static bool __swap_cluster_alloc_entries(struct swap_info_struct *si,
 {
 	unsigned int order;
 	unsigned long nr_pages;
+	swp_entry_t vswap_entry, v;
+	unsigned int i;
 
 	lockdep_assert_held(&ci->lock);
 
@@ -999,8 +1092,26 @@ static bool __swap_cluster_alloc_entries(struct swap_info_struct *si,
 		order = folio_order(folio);
 		nr_pages = 1 << order;
 		swap_cluster_assert_empty(ci, ci_off, nr_pages, false);
-		__swap_cache_add_folio(ci, folio, swp_entry(si->type,
-							    ci_off + cluster_offset(si, ci)));
+		if (folio_test_swapcache(folio)) {
+			/*
+			 * Folio already in the swap cache: we are allocating
+			 * physical backing for its vswap entry. Point each
+			 * physical slot back at its own vswap entry
+			 * (Pointer-tagged rmap).
+			 */
+			VM_WARN_ON(!is_vswap_entry(folio->swap));
+			vswap_entry = folio->swap;
+			for (i = 0; i < nr_pages; i++) {
+				v = vswap_entry;
+				v.val += i;
+				__swap_table_set(ci, ci_off + i,
+						 swp_entry_to_swp_tb_ptr(v));
+			}
+		} else {
+			__swap_cache_add_folio(ci, folio,
+				swp_entry(si->type,
+					  ci_off + cluster_offset(si, ci)));
+		}
 	} else if (IS_ENABLED(CONFIG_HIBERNATION)) {
 		order = 0;
 		nr_pages = 1;
@@ -1180,6 +1291,17 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 					offset += abs(nr_reclaim);
 					continue;
 				}
+			} else if (swp_tb_is_pointer(swp_tb) &&
+				   swap_rmap_is_cache_only(ci, offset % SWAPFILE_CLUSTER)) {
+				spin_unlock(&ci->lock);
+				nr_reclaim = try_to_reclaim_vswap_backing(si, offset);
+				ci = swap_cluster_lock(si, offset);
+				if (!ci)
+					goto next;
+				if (nr_reclaim > 0) {
+					offset += nr_reclaim;
+					continue;
+				}
 			}
 			offset++;
 		}
@@ -1501,12 +1623,14 @@ static bool get_swap_device_info(struct swap_info_struct *si)
  * Fast path try to get swap entries with specified order from current
  * CPU's swap entry pool (a cluster).
  */
-static bool swap_alloc_fast(struct folio *folio)
+static swp_entry_t swap_alloc_fast(struct folio *folio)
 {
 	unsigned int order = folio_order(folio);
 	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
-	unsigned int offset;
+	unsigned long offset, found = 0;
+
+	lockdep_assert_held(&this_cpu_ptr(&percpu_swap_cluster)->lock);
 
 	/*
 	 * Once allocated, swap_info_struct will never be completely freed,
@@ -1515,25 +1639,28 @@ static bool swap_alloc_fast(struct folio *folio)
 	si = this_cpu_read(percpu_swap_cluster.si[order]);
 	offset = this_cpu_read(percpu_swap_cluster.offset[order]);
 	if (!si || !offset || !get_swap_device_info(si))
-		return false;
+		return (swp_entry_t){};
 
 	ci = swap_cluster_lock(si, offset);
 	if (ci && cluster_is_usable(ci, order)) {
 		if (cluster_is_empty(ci))
 			offset = cluster_offset(si, ci);
-		alloc_swap_scan_cluster(si, ci, folio, offset);
+		found = alloc_swap_scan_cluster(si, ci, folio, offset);
 	} else if (ci) {
 		swap_cluster_unlock(ci);
 	}
 
 	put_swap_device(si);
-	return folio_test_swapcache(folio);
+	if (found)
+		return swp_entry(si->type, found);
+	return (swp_entry_t){};
 }
 
 /* Rotate the device and switch to a new cluster */
-static void swap_alloc_slow(struct folio *folio)
+static swp_entry_t swap_alloc_slow(struct folio *folio)
 {
 	struct swap_info_struct *si, *next;
+	unsigned long found;
 
 	spin_lock(&swap_avail_lock);
 start_over:
@@ -1542,12 +1669,12 @@ static void swap_alloc_slow(struct folio *folio)
 		plist_requeue(&si->avail_list, &swap_avail_head);
 		spin_unlock(&swap_avail_lock);
 		if (get_swap_device_info(si)) {
-			cluster_alloc_swap_entry(si, folio);
+			found = cluster_alloc_swap_entry(si, folio);
 			put_swap_device(si);
-			if (folio_test_swapcache(folio))
-				return;
+			if (found)
+				return swp_entry(si->type, found);
 			if (folio_test_large(folio))
-				return;
+				return (swp_entry_t){};
 		}
 
 		spin_lock(&swap_avail_lock);
@@ -1565,6 +1692,7 @@ static void swap_alloc_slow(struct folio *folio)
 			goto start_over;
 	}
 	spin_unlock(&swap_avail_lock);
+	return (swp_entry_t){};
 }
 
 /*
@@ -1749,6 +1877,8 @@ static void swap_put_entries_cluster(struct swap_info_struct *si,
 			}
 			/* count will be 0 after put, slot can be reclaimed */
 			need_reclaim = true;
+			if (swap_is_vswap(si))
+				vswap_mark_cache_only(si, ci, ci_off);
 		}
 		/*
 		 * A count != 1 or cached slot can't be freed. Put its swap
@@ -1855,6 +1985,7 @@ static int swap_dup_entries_cluster(struct swap_info_struct *si,
 			goto failed;
 		}
 	} while (++ci_off < ci_end);
+	vswap_clear_cache_only(si, ci, ci_start, nr);
 	swap_cluster_unlock(ci);
 	return 0;
 failed:
@@ -1942,17 +2073,12 @@ int folio_alloc_swap(struct folio *folio)
 		}
 	}
 
-	/*
-	 * Skip vswap when zswap is disabled - without zswap, vswap entries
-	 * have nowhere to go on writeout (no physical fallback yet; that
-	 * arrives in the next patch).
-	 */
-	if (zswap_is_enabled() && vswap_alloc(folio))
+	if (vswap_alloc(folio))
 		goto done;
 
 again:
 	local_lock(&percpu_swap_cluster.lock);
-	if (!swap_alloc_fast(folio))
+	if (!swap_alloc_fast(folio).val)
 		swap_alloc_slow(folio);
 	local_unlock(&percpu_swap_cluster.lock);
 
@@ -1973,6 +2099,56 @@ int folio_alloc_swap(struct folio *folio)
 }
 
 #ifdef CONFIG_VSWAP
+static void vswap_mark_cache_only(struct swap_info_struct *si,
+				  struct swap_cluster_info *ci,
+				  unsigned int ci_off)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+	struct swap_cluster_info *pci;
+	swp_entry_t phys;
+	unsigned long vt;
+
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+	vt = __vtable_get(ci_dyn, ci_off);
+
+	if (vtable_type(vt) == VSWAP_SWAPFILE) {
+		phys = vtable_to_phys(vt);
+		pci = __swap_entry_to_cluster(phys);
+		swap_rmap_mark_cache_only(pci, swp_cluster_offset(phys));
+	}
+}
+
+/*
+ * Clear the cache-only rmap hint for entries re-referenced from count 0 to 1
+ * (no longer reclaimable), so the physical reclaim scanner skips them.
+ */
+static void vswap_clear_cache_only(struct swap_info_struct *si,
+				   struct swap_cluster_info *ci,
+				   unsigned int ci_start, int nr)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+	struct swap_cluster_info *pci;
+	unsigned long swp_tb, vt;
+	swp_entry_t phys;
+	unsigned int off;
+
+	if (!swap_is_vswap(si))
+		return;
+
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+	for (off = ci_start; off < ci_start + nr; off++) {
+		swp_tb = __swap_table_get(ci, off);
+		if (!swp_tb_is_folio(swp_tb) || swp_tb_get_count(swp_tb) != 1)
+			continue;
+		vt = __vtable_get(ci_dyn, off);
+		if (vtable_type(vt) != VSWAP_SWAPFILE)
+			continue;
+		phys = vtable_to_phys(vt);
+		pci = __swap_entry_to_cluster(phys);
+		swap_rmap_clear_cache_only(pci, swp_cluster_offset(phys));
+	}
+}
+
 static void vswap_free_cluster(struct swap_info_struct *si,
 			       struct swap_cluster_info *ci)
 {
@@ -1997,12 +2173,21 @@ static void vswap_free_cluster(struct swap_info_struct *si,
 	kfree_rcu(ci_dyn, rcu);
 }
 
+static void __swap_cluster_free_phys_backing(struct swap_info_struct *psi,
+					     struct swap_cluster_info *pci,
+					     unsigned int ci_start,
+					     unsigned int nr_pages);
+
 void __vswap_release_backing(struct swap_cluster_info *ci,
 			     unsigned int ci_start, unsigned int nr)
 {
 	struct swap_cluster_info_dynamic *ci_dyn;
+	struct swap_info_struct *psi;
+	unsigned long phys_start = 0, phys_end = 0;
+	unsigned int phys_type = 0;
 	unsigned int ci_off;
 	unsigned long vt;
+	swp_entry_t phys;
 
 	lockdep_assert_held(&ci->lock);
 	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
@@ -2010,11 +2195,40 @@ void __vswap_release_backing(struct swap_cluster_info *ci,
 	for (ci_off = ci_start; ci_off < ci_start + nr; ci_off++) {
 		vt = __vtable_get(ci_dyn, ci_off);
 
+		/*
+		 * Flush batched physical slots when the next entry
+		 * breaks contiguity, changes type/device, or would
+		 * cross a SWAPFILE_CLUSTER boundary (the free helper
+		 * operates on a single cluster).
+		 */
+		if (phys_start != phys_end &&
+		    (vtable_type(vt) != VSWAP_SWAPFILE ||
+		     swp_type(vtable_to_phys(vt)) != phys_type ||
+		     swp_offset(vtable_to_phys(vt)) != phys_end ||
+		     phys_end % SWAPFILE_CLUSTER == 0)) {
+			psi = __swap_type_to_info(phys_type);
+			__swap_cluster_free_phys_backing(psi,
+				__swap_entry_to_cluster(
+					swp_entry(phys_type, phys_start)),
+				phys_start % SWAPFILE_CLUSTER,
+				phys_end - phys_start);
+			phys_start = phys_end = 0;
+		}
+
 		switch (vtable_type(vt)) {
+		case VSWAP_SWAPFILE:
+			if (phys_start == phys_end) {
+				phys = vtable_to_phys(vt);
+				phys_start = swp_offset(phys);
+				phys_end = phys_start + 1;
+				phys_type = swp_type(phys);
+			} else {
+				phys_end++;
+			}
+			break;
 		case VSWAP_ZSWAP:
 			zswap_entry_free(vtable_to_zswap(vt));
 			break;
-		case VSWAP_SWAPFILE:
 		case VSWAP_NONE:
 			break;
 		default:
@@ -2027,6 +2241,15 @@ void __vswap_release_backing(struct swap_cluster_info *ci,
 		if (__swap_table_test_zero(ci, ci_off))
 			__swap_table_clear_zero(ci, ci_off);
 	}
+
+	if (phys_start != phys_end) {
+		psi = __swap_type_to_info(phys_type);
+		__swap_cluster_free_phys_backing(psi,
+			__swap_entry_to_cluster(
+				swp_entry(phys_type, phys_start)),
+			phys_start % SWAPFILE_CLUSTER,
+			phys_end - phys_start);
+	}
 }
 
 /**
@@ -2056,6 +2279,113 @@ void folio_release_vswap_backing(struct folio *folio)
 	spin_unlock(&ci->lock);
 }
 
+/**
+ * folio_release_non_phys_swap_backing() - Drop a folio's non-physical vswap backing.
+ * @folio: the folio, occupying a virtual swap entry.
+ *
+ * Release any ZSWAP or zero-filled backing recorded for @folio's virtual
+ * swap entry, leaving the slots empty so the writeout path can install fresh
+ * physical backing. Contiguous physical (VSWAP_SWAPFILE) backing is left in
+ * place for reuse, and the all-empty (VSWAP_NONE) case is a no-op.
+ *
+ * Called from the writeout path before zswap_store or folio_realloc_swap to
+ * clear partial ZSWAP state left by a prior failed zswap_store.
+ *
+ * Context: Caller must hold the folio lock; @folio must be in the swap cache
+ * and occupy a virtual swap entry.
+ */
+void folio_release_non_phys_swap_backing(struct folio *folio)
+{
+	struct swap_cluster_info *ci;
+	struct swap_cluster_info_dynamic *ci_dyn;
+	int nr = folio_nr_pages(folio);
+	unsigned int voff;
+	unsigned long vt;
+	enum vswap_backing_type type;
+
+	ci = __swap_entry_to_cluster(folio->swap);
+	if (!ci)
+		return;
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+	voff = swp_cluster_offset(folio->swap);
+
+	spin_lock(&ci->lock);
+	vt = __vtable_get(ci_dyn, voff);
+	type = vtable_type(vt);
+
+	if (type == VSWAP_SWAPFILE || type == VSWAP_NONE) {
+		spin_unlock(&ci->lock);
+		return;
+	}
+
+	__vswap_release_backing(ci, voff, nr);
+	spin_unlock(&ci->lock);
+}
+
+/**
+ * folio_realloc_swap() - Back a virtual swap folio with a physical swap slot.
+ * @folio: the folio, occupying a virtual swap entry.
+ *
+ * Ensure @folio's virtual swap entry has physical (swapfile) backing,
+ * allocating a physical slot on demand if it has none. Called from the
+ * writeout path and from zswap writeback to move a vswap entry onto a real
+ * swapfile slot. If @folio is already physically backed, the existing
+ * physical entry is returned unchanged.
+ *
+ * Context: Caller must hold the folio lock; @folio must be in the swap cache
+ * and occupy a virtual swap entry.
+ * Return: The physical swap entry now backing @folio, or an empty entry
+ * (.val == 0) on failure.
+ */
+swp_entry_t folio_realloc_swap(struct folio *folio)
+{
+	swp_entry_t vswap_entry = folio->swap;
+	struct swap_cluster_info *ci;
+	struct swap_cluster_info_dynamic *ci_dyn;
+	unsigned int voff;
+	swp_entry_t phys_entry = {};
+	swp_entry_t pe;
+	int i, nr = folio_nr_pages(folio);
+
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
+	VM_WARN_ON(!is_vswap_entry(vswap_entry));
+
+	phys_entry = vswap_to_phys(vswap_entry);
+	if (phys_entry.val)
+		return phys_entry;
+
+	local_lock(&percpu_swap_cluster.lock);
+	phys_entry = swap_alloc_fast(folio);
+	if (!phys_entry.val)
+		phys_entry = swap_alloc_slow(folio);
+	local_unlock(&percpu_swap_cluster.lock);
+
+	if (!phys_entry.val)
+		return (swp_entry_t){};
+
+	voff = swp_cluster_offset(vswap_entry);
+
+	ci = __swap_entry_to_cluster(vswap_entry);
+	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+	spin_lock(&ci->lock);
+	/*
+	 * Install PHYS backing without freeing any prior contents of the
+	 * vtable. The caller is responsible for any cleanup of the prior
+	 * backing - for example, zswap_writeback_entry calls in with the
+	 * slot still pointing at the loaded zswap_entry (which it uses
+	 * for decompress before zswap_entry_free), and swap_writeout
+	 * calls folio_release_non_phys_swap_backing first to drop partial
+	 * ZSWAP state.
+	 */
+	for (i = 0; i < nr; i++) {
+		pe.val = phys_entry.val + i;
+		__vtable_set(ci_dyn, voff + i, vtable_mk_phys(pe));
+	}
+	spin_unlock(&ci->lock);
+
+	return phys_entry;
+}
 #endif /* CONFIG_VSWAP */
 
 /**
@@ -2187,6 +2517,71 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
  * Free a set of swap slots after their swap count dropped to zero, or will be
  * zero after putting the last ref (saves one __swap_cluster_put_entry call).
  */
+#ifdef CONFIG_VSWAP
+/*
+ * Clear swap table entries to NULL and reset zero flags.
+ * Does not touch memcg or count - caller handles those.
+ */
+static void __swap_cluster_clear_table(struct swap_cluster_info *ci,
+				       unsigned int ci_start,
+				       unsigned int nr_pages)
+{
+	unsigned int ci_off;
+
+	lockdep_assert_held(&ci->lock);
+	for (ci_off = ci_start; ci_off < ci_start + nr_pages; ci_off++) {
+		__swap_table_set(ci, ci_off, null_to_swp_tb());
+		if (!SWAP_TABLE_HAS_ZEROFLAG)
+			__swap_table_clear_zero(ci, ci_off);
+	}
+}
+#endif
+
+/*
+ * Common tail for freeing swap slots: device-level accounting
+ * and cluster list management.
+ */
+static void __swap_cluster_finish_free(struct swap_info_struct *si,
+				       struct swap_cluster_info *ci,
+				       unsigned int ci_start,
+				       unsigned int nr_pages)
+{
+	lockdep_assert_held(&ci->lock);
+	swap_range_free(si, cluster_offset(si, ci) + ci_start, nr_pages);
+	swap_cluster_assert_empty(ci, ci_start, nr_pages, false);
+
+	if (!ci->count)
+		free_cluster(si, ci);
+	else
+		partial_free_cluster(si, ci);
+}
+
+#ifdef CONFIG_VSWAP
+/*
+ * Free physical swap slots that were backing vswap entries (Pointer-tagged).
+ * Clears the physical swap table, decrements cluster count, and does
+ * device-level accounting. Called from folio_release_vswap_backing.
+ */
+static void __swap_cluster_free_phys_backing(struct swap_info_struct *psi,
+					     struct swap_cluster_info *pci,
+					     unsigned int ci_start,
+					     unsigned int nr_pages)
+{
+	/*
+	 * Caller holds the vswap cluster lock (asserted in
+	 * folio_release_vswap_backing). Nest the physical cluster lock under it
+	 * - same lockdep class, so use SINGLE_DEPTH_NESTING to silence
+	 * PROVE_LOCKING.
+	 */
+	spin_lock_nested(&pci->lock, SINGLE_DEPTH_NESTING);
+	VM_WARN_ON(pci->count < nr_pages);
+	pci->count -= nr_pages;
+	__swap_cluster_clear_table(pci, ci_start, nr_pages);
+	__swap_cluster_finish_free(psi, pci, ci_start, nr_pages);
+	swap_cluster_unlock(pci);
+}
+#endif
+
 void __swap_cluster_free_entries(struct swap_info_struct *si,
 				 struct swap_cluster_info *ci,
 				 unsigned int ci_start, unsigned int nr_pages)
@@ -2194,7 +2589,6 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 	unsigned long old_tb;
 	unsigned short batch_id = 0, id_cur;
 	unsigned int ci_off = ci_start, ci_end = ci_start + nr_pages;
-	unsigned long ci_head = cluster_offset(si, ci);
 	unsigned int batch_off = ci_off;
 
 	VM_WARN_ON(ci->count < nr_pages);
@@ -2232,13 +2626,7 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 	if (batch_id)
 		mem_cgroup_uncharge_swap(batch_id, ci_off - batch_off);
 
-	swap_range_free(si, ci_head + ci_start, nr_pages);
-	swap_cluster_assert_empty(ci, ci_start, nr_pages, false);
-
-	if (!ci->count)
-		free_cluster(si, ci);
-	else
-		partial_free_cluster(si, ci);
+	__swap_cluster_finish_free(si, ci, ci_start, nr_pages);
 }
 
 int __swap_count(swp_entry_t entry)
@@ -3012,19 +3400,93 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
 
 static int try_to_unuse(unsigned int type)
 {
+	struct swap_cluster_info *pci;
+	struct mempolicy mpol = { .mode = MPOL_DEFAULT };
 	struct mm_struct *prev_mm;
 	struct mm_struct *mm;
 	struct list_head *p;
 	int retval = 0;
 	struct swap_info_struct *si = swap_info[type];
 	struct folio *folio;
-	swp_entry_t entry;
-	unsigned int i;
+	swp_entry_t entry, vswap_entry;
+	unsigned long swp_tb;
+	unsigned int i, j, ci_off;
 
 	if (!swap_usage_in_pages(si))
 		goto success;
 
 retry:
+	/*
+	 * Free vswap-backing slots (Pointer-tagged) first. Walk physical
+	 * clusters, read the vswap entry from the rmap, ensure the data
+	 * is in the swap cache, and transition PHYS to FOLIO. No page table
+	 * walk needed - just free the physical backing.
+	 */
+	i = 0;
+	while (IS_ENABLED(CONFIG_VSWAP) &&
+	       swap_usage_in_pages(si) &&
+	       !signal_pending(current) &&
+	       (i = find_next_to_unuse(si, i)) != 0) {
+		swp_entry_t phys;
+
+		pci = __swap_offset_to_cluster(si, i);
+		if (!pci)
+			continue;
+		ci_off = i % SWAPFILE_CLUSTER;
+
+		spin_lock(&pci->lock);
+		swp_tb = __swap_table_get(pci, ci_off);
+		spin_unlock(&pci->lock);
+
+		if (!swp_tb_is_pointer(swp_tb))
+			continue;
+
+		vswap_entry = swp_tb_ptr_to_swp_entry(swp_tb);
+
+		folio = swap_cache_get_folio(vswap_entry);
+		if (!folio) {
+			folio = swap_cache_alloc_folio(vswap_entry,
+						      GFP_KERNEL, BIT(0), NULL,
+						      &mpol, NO_INTERLEAVE_INDEX);
+			if (IS_ERR(folio))
+				continue;
+			swap_read_folio(folio, NULL);
+			folio_lock(folio);
+		} else {
+			folio_lock(folio);
+		}
+
+		if (!folio_matches_swap_entry(folio, vswap_entry)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			continue;
+		}
+
+		/*
+		 * Re-validate under folio lock: rmap holds folio->swap + j
+		 * for some j in [0, nr_pages). Check folio->swap still maps
+		 * to the contiguous physical run that includes our slot i.
+		 */
+		j = vswap_entry.val - folio->swap.val;
+		phys = vswap_to_phys(folio->swap);
+		if (!phys.val || swp_type(phys) != type ||
+		    swp_offset(phys) + j != i ||
+		    j >= folio_nr_pages(folio)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			continue;
+		}
+
+		folio_wait_writeback(folio);
+		folio_release_vswap_backing(folio);
+		folio_mark_dirty(folio);
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+
+	if (!swap_usage_in_pages(si))
+		goto success;
+
 	retval = shmem_unuse(type);
 	if (retval)
 		return retval;
@@ -3068,6 +3530,14 @@ static int try_to_unuse(unsigned int type)
 
 		entry = swp_entry(type, i);
 
+		if (IS_ENABLED(CONFIG_VSWAP)) {
+			swp_tb = swap_table_get(
+				__swap_offset_to_cluster(si, i),
+				i % SWAPFILE_CLUSTER);
+			if (swp_tb_is_pointer(swp_tb))
+				continue;
+		}
+
 		folio = swap_cache_get_folio(entry);
 		if (!folio)
 			continue;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 288d3787e6d4..7eebf42f8561 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1533,7 +1533,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * space if we are running out.
 		 */
 		if (folio_test_swapcache(folio) &&
-		    ((mem_cgroup_swap_full(folio) && !is_vswap_entry(folio->swap)) ||
+		    ((mem_cgroup_swap_full(folio) && folio_phys_swap_backed(folio)) ||
 		     folio_test_mlocked(folio)))
 			folio_free_swap(folio);
 		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
diff --git a/mm/vswap.h b/mm/vswap.h
index 25d6094af6af..8470ee5b857d 100644
--- a/mm/vswap.h
+++ b/mm/vswap.h
@@ -9,6 +9,7 @@
 
 
 #include <linux/swap.h>
+#include "swap.h"
 
 struct zswap_entry;
 
@@ -32,10 +33,53 @@ enum vswap_backing_type {
 
 #ifdef CONFIG_VSWAP
 
-#include "swap.h"
 #include "swap_table.h"
 
-extern struct swap_info_struct *vswap_si;
+static inline bool is_vswap_entry(swp_entry_t entry)
+{
+	return swap_is_vswap(__swap_entry_to_info(entry));
+}
+
+/*
+ * Rmap cache-only helpers for physical cluster Pointer-tagged entries.
+ * SWP_RMAP_CACHE_ONLY records, inline on the physical swap_table entry,
+ * that the backing vswap entry has swap_count == 0 (swap-cache-only, so
+ * reclaimable). The physical reclaim scanner reads it directly instead of
+ * chasing the rmap into the vswap layer and paying the cluster-lookup
+ * indirection.
+ */
+
+static inline void swap_rmap_mark_cache_only(struct swap_cluster_info *ci,
+					     unsigned int off)
+{
+	atomic_long_t *table;
+
+	table = rcu_dereference_check(ci->table, true);
+	atomic_long_or(SWP_RMAP_CACHE_ONLY, &table[off]);
+}
+
+static inline void swap_rmap_clear_cache_only(struct swap_cluster_info *ci,
+					      unsigned int off)
+{
+	atomic_long_t *table;
+
+	table = rcu_dereference_check(ci->table, true);
+	atomic_long_and(~SWP_RMAP_CACHE_ONLY, &table[off]);
+}
+
+static inline bool swap_rmap_is_cache_only(struct swap_cluster_info *ci,
+					   unsigned int off)
+{
+	atomic_long_t *table;
+	bool ret;
+
+	VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
+	rcu_read_lock();
+	table = rcu_dereference(ci->table);
+	ret = table && (atomic_long_read(&table[off]) & SWP_RMAP_CACHE_ONLY);
+	rcu_read_unlock();
+	return ret;
+}
 
 /*
  * Virtual table entry encoding for vswap clusters.
@@ -159,6 +203,25 @@ vswap_lock_cluster(swp_entry_t entry, unsigned int *voff)
 	return ci_dyn;
 }
 
+static inline swp_entry_t vswap_to_phys(swp_entry_t entry)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+	unsigned int voff;
+	unsigned long vt;
+
+	ci_dyn = vswap_lock_cluster(entry, &voff);
+	if (!ci_dyn)
+		return (swp_entry_t){};
+
+	vt = __vtable_get(ci_dyn, voff);
+	spin_unlock(&ci_dyn->ci.lock);
+
+	if (vtable_type(vt) != VSWAP_SWAPFILE)
+		return (swp_entry_t){};
+
+	return vtable_to_phys(vt);
+}
+
 void __vswap_release_backing(struct swap_cluster_info *ci,
 			     unsigned int ci_start, unsigned int nr);
 
@@ -195,6 +258,7 @@ static inline struct zswap_entry *vswap_zswap_load(swp_entry_t entry)
 
 
 void folio_release_vswap_backing(struct folio *folio);
+void folio_release_non_phys_swap_backing(struct folio *folio);
 
 /*
  * Walk nr vtable slots starting at voff in ci_dyn. Returns the prefix
@@ -274,6 +338,17 @@ static inline int vswap_check_backing(swp_entry_t entry, int nr,
 	return ret;
 }
 
+static inline bool folio_phys_swap_backed(struct folio *folio)
+{
+	swp_entry_t entry = folio->swap;
+	int nr = folio_nr_pages(folio);
+	enum vswap_backing_type type;
+
+	return !is_vswap_entry(entry) ||
+	       (vswap_check_backing(entry, nr, &type) == nr &&
+		type == VSWAP_SWAPFILE);
+}
+
 static inline int vswap_cluster_alloc_vtable(struct swap_cluster_info_dynamic *ci_dyn)
 {
 	ci_dyn->virtual_table = kcalloc(SWAPFILE_CLUSTER,
@@ -293,6 +368,27 @@ static inline void vswap_cluster_free_vtable(struct swap_cluster_info *ci)
 
 #else /* !CONFIG_VSWAP */
 
+static inline bool is_vswap_entry(swp_entry_t entry)
+{
+	return false;
+}
+
+static inline swp_entry_t vswap_to_phys(swp_entry_t entry)
+{
+	return (swp_entry_t){};
+}
+
+static inline bool folio_phys_swap_backed(struct folio *folio)
+{
+	return true;
+}
+
+static inline bool swap_rmap_is_cache_only(struct swap_cluster_info *ci,
+					   unsigned int off)
+{
+	return false;
+}
+
 static inline void __vswap_release_backing(struct swap_cluster_info *ci,
 					   unsigned int ci_start,
 					   unsigned int nr) {}
@@ -306,6 +402,7 @@ static inline struct zswap_entry *vswap_zswap_load(swp_entry_t entry)
 }
 
 static inline void folio_release_vswap_backing(struct folio *folio) {}
+static inline void folio_release_non_phys_swap_backing(struct folio *folio) {}
 
 struct swap_cluster_info_dynamic;
 static inline int __vswap_check_backing(struct swap_cluster_info_dynamic *ci_dyn,
@@ -324,17 +421,35 @@ static inline void vswap_cluster_free_vtable(struct swap_cluster_info *ci) {}
 
 #endif /* CONFIG_VSWAP */
 
-#ifdef CONFIG_SWAP
-#include "swap.h"
-static inline bool is_vswap_entry(swp_entry_t entry)
-{
-	return swap_is_vswap(__swap_entry_to_info(entry));
-}
-#else
-static inline bool is_vswap_entry(swp_entry_t entry)
+/*
+ * Test a per-backend swap flag (SWP_SYNCHRONOUS_IO, SWP_STABLE_WRITES, ...)
+ * for @entry. For a vswap entry the property belongs to the current
+ * physical backing rather than vswap_si itself; resolve to the backing
+ * and test there. Returns false for zswap/zero/unbacked vswap entries
+ * as they don't have a backing bdev.
+ */
+static inline bool swap_entry_backend_has_flag(struct swap_info_struct *si,
+					       swp_entry_t entry,
+					       unsigned long flag)
 {
-	return false;
+	struct swap_info_struct *phys_si;
+	swp_entry_t phys;
+	bool has_flag;
+
+	if (!swap_is_vswap(si))
+		return data_race(si->flags & flag);
+
+	phys = vswap_to_phys(entry);
+	if (!phys.val)
+		return false;
+
+	phys_si = get_swap_device(phys);
+	if (!phys_si)
+		return false;
+
+	has_flag = data_race(phys_si->flags & flag);
+	put_swap_device(phys_si);
+	return has_flag;
 }
-#endif /* CONFIG_SWAP */
 
 #endif /* _MM_VSWAP_H */
diff --git a/mm/zswap.c b/mm/zswap.c
index 466f8a182716..5daff7a25f67 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -993,6 +993,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct folio *folio;
 	struct mempolicy *mpol;
 	struct swap_info_struct *si;
+	swp_entry_t phys = {};
 	int ret = 0;
 
 	/* try to allocate swap cache folio */
@@ -1000,16 +1001,6 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	if (!si)
 		return -EEXIST;
 
-	/*
-	 * Vswap entries have no physical backing - writeback would fail
-	 * and SIGBUS the caller. Bail before we waste a swap-cache folio
-	 * allocation.
-	 */
-	if (si->flags & SWP_VSWAP) {
-		put_swap_device(si);
-		return -EINVAL;
-	}
-
 	mpol = get_task_policy(current);
 	folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0), NULL, mpol,
 				       NO_INTERLEAVE_INDEX);
@@ -1028,40 +1019,78 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	/*
 	 * folio is locked, and the swapcache is now secured against
 	 * concurrent swapping to and from the slot, and concurrent
-	 * swapoff so we can safely dereference the zswap tree here.
-	 * Verify that the swap entry hasn't been invalidated and recycled
-	 * behind our backs, to avoid overwriting a new swap folio with
-	 * old compressed data. Only when this is successful can the entry
-	 * be dereferenced.
+	 * swapoff so we can safely dereference the zswap tree (or vswap
+	 * vtable) here. Verify that the swap entry hasn't been
+	 * invalidated and recycled behind our backs, to avoid overwriting
+	 * a new swap folio with old compressed data. Only when this is
+	 * successful can the entry be dereferenced.
 	 */
-	tree = swap_zswap_tree(swpentry);
-	if (entry != xa_load(tree, offset)) {
-		ret = -ENOMEM;
-		goto out;
+	if (swap_is_vswap(si)) {
+		if (entry != vswap_zswap_load(swpentry)) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		/*
+		 * Allocate physical backing BEFORE decompress - if it fails,
+		 * no wasted work. folio_realloc_swap sets vtable to PHYS,
+		 * overwriting ZSWAP - the old entry pointer is only held
+		 * by the caller now.
+		 */
+		phys = folio_realloc_swap(folio);
+		if (!phys.val) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else {
+		tree = swap_zswap_tree(swpentry);
+		if (entry != xa_load(tree, offset)) {
+			ret = -ENOMEM;
+			goto out;
+		}
 	}
 
 	if (!zswap_decompress(entry, folio)) {
 		ret = -EIO;
+		/*
+		 * For vswap: folio_realloc_swap already moved the entry
+		 * out of the vtable. Restore it via vswap_zswap_store so
+		 * the entry stays tracked (and the just-allocated PHYS
+		 * slot is freed). For non-vswap: entry is still in the
+		 * zswap tree.
+		 */
+		if (swap_is_vswap(si) && phys.val)
+			vswap_zswap_store(swpentry, entry);
 		goto out;
 	}
 
-	xa_erase(tree, offset);
+	if (!swap_is_vswap(si))
+		xa_erase(tree, offset);
 
 	count_vm_event(ZSWPWB);
 	if (entry->objcg)
 		count_objcg_events(entry->objcg, ZSWPWB, 1);
 
-	zswap_entry_free(entry);
-
 	/* folio is up to date */
 	folio_mark_uptodate(folio);
 
 	/* move it to the tail of the inactive list after end_writeback */
 	folio_set_reclaim(folio);
 
-	/* start writeback */
-	ret = __swap_writepage(folio, NULL);
-	WARN_ON_ONCE(ret);
+	/*
+	 * Start writeback. __swap_writepage_phys is void; __swap_writepage
+	 * returns 0 today (async IO errors surface in the bio end_io
+	 * callback). Either way the entry has been moved out of its prior
+	 * location (vtable PHYS for vswap, removed from tree otherwise),
+	 * so we own the free.
+	 */
+	if (swap_is_vswap(si)) {
+		__swap_writepage_phys(folio, NULL, phys);
+	} else {
+		ret = __swap_writepage(folio, NULL);
+		WARN_ON_ONCE(ret);
+	}
+
+	zswap_entry_free(entry);
 
 out:
 	if (ret) {
@@ -1212,6 +1241,18 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	if (!zswap_shrinker_enabled || !mem_cgroup_zswap_writeback_enabled(memcg))
 		return 0;
 
+	/*
+	 * With CONFIG_VSWAP, vswap-backed zswap entries need a physical
+	 * swap slot allocated on demand (via folio_realloc_swap) for
+	 * writeback. If no physical slots are available, writeback will
+	 * fail - skip the shrinker to avoid spinning on entries we cannot
+	 * drain. Vanilla zswap-on-swapfile is unaffected because every
+	 * zswap entry already has a backing slot; gate on CONFIG_VSWAP so
+	 * the check compiles out there.
+	 */
+	if (IS_ENABLED(CONFIG_VSWAP) && !get_nr_swap_pages())
+		return 0;
+
 	/*
 	 * The shrinker resumes swap writeback, which will enter block
 	 * and may enter fs. XXX: Harmonize with vmscan.c __GFP_FS
@@ -1558,7 +1599,7 @@ bool zswap_store(struct folio *folio)
 	 * writeback could overwrite the new data in the swapfile.
 	 */
 	if (partial_store && is_vswap_entry(swp))
-		folio_release_vswap_backing(folio);
+		folio_release_non_phys_swap_backing(folio);
 	else if (!ret && !is_vswap_entry(swp)) {
 		unsigned type = swp_type(swp);
 		pgoff_t offset = swp_offset(swp);
-- 
2.53.0-Meta


