Return-Path: <cgroups+bounces-7916-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 138F1AA3C67
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8EF1B659DF
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F592DEB85;
	Tue, 29 Apr 2025 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZHfA0mO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E7E2DCB7A;
	Tue, 29 Apr 2025 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969936; cv=none; b=i0nrcqlnH6cW1UmL2f/nSGuEefq2bfHIHqhx2Dwl32MRf7odirWTNCTQfEssTRUARiNdViJmBUjdQIrQGXtEKlgM81l8oYp9IThV+TxbrNu1/HHnc6kyln2ts1YKtoEeaC8NMn2fT8gLGD7aLbpwC4Ncs/paTsZGexYxu1C4zSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969936; c=relaxed/simple;
	bh=6lu4oF39SEcXcDQcSnvnULT5GeUPSdpjuo9d07J7rEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/4liRd12lXc3crmj363JLSaMaCFu3SolskvKZ+mX/USnuhBTO07gVtgwQQMBGtdQ9zDYl6i2OOSFwobNvRDtlPJD/529X0RVKNhvpuqlTmoExCsjEEMEK1848aQaimngYktOJyAtDW3qrMpgNc/CvEFK0RLKuZXxZ+zv9gx9z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZHfA0mO; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70427fb838cso55256907b3.2;
        Tue, 29 Apr 2025 16:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969933; x=1746574733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKE37L6euvcRArGqI2WCdwnU49QgVd0+WJwqbTjSGfU=;
        b=VZHfA0mOypSbyP/7KjOi+WCRZg2L1pgSEC68x+apyOGN8qCxYma2DlR4vaW1cOo4Tw
         y3AVg8bNWecMQBnD8gUbs2eASJMF3thfJ117cVZwaljxevHY/zxwtB7f+i+hv1qcseL0
         oQSko+Ypgeo2h4Mu9yPJR1khyoH0ZUljfadvSWOqOsevEr0tnhAJ9EaMkiOVYx7d0CJt
         H354rcmlx4SPFxABVCmLSK1INv6g/D4I/DYIPlN4BLRlhuemLe1oBRc9rhspyOlbsMs2
         U+i7cge7YRRnphA9aCE748WjX0I2Dx9cwpnX9WgrK1v8MnOaTGXV8Noa+smZDltpGqPZ
         2gLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969933; x=1746574733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKE37L6euvcRArGqI2WCdwnU49QgVd0+WJwqbTjSGfU=;
        b=m0nqRcXiV6hzMehGRCl8lgd//E9uTHziDFPf+G/epv5/o6iD74rDbp/8Ps+QKEuCLo
         +FzrA4krZ/ZvKpnDWI1PNE4wZpHHs/6w429alU1eZjXUvkyqKhACHLFJEcI7XmzOe+mt
         Igc5nfcgsjTFDSB75QvpLE2q2rG26l7VEa08RvqYAgz42BQxoLoE+HDNnsym4BUXF/gT
         vI0lJNb3gL/CD4SZl713BScuJQNFQuJCvdTnwr1h3DP0+CSLgPKBzJPZhawlKXVv0tgn
         2zgYlzvSSEMvxphFP0CzgdfLFvDmBxW1jVBexbRTO5YpstkGQUkfVvjuQ7Fywopbsbu+
         wt1w==
X-Forwarded-Encrypted: i=1; AJvYcCU01+Cb9IQvFbE37Mnuw+1AJP9S3ax/ZJ0l/jPvERqy1CG+2U/tpuuAaSptYh9+q1HgJN693VGz@vger.kernel.org, AJvYcCVKNWf/x7xHv7RXHSLeo5nNCYU0rqkpOq3AXppLfUvOMuaoZMb9FJ9VDsjc7VI/OSCJwVTJsd0t6I/4fIVQ@vger.kernel.org, AJvYcCXd3vIfXP6OD0FK8AHAYXku5noTWa2GyaZ6mKzMwIaMCDMKzAiLRbYy00qWr+/2pScn5iaUrevr+V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwNMWSOmCy2ibGw4yobslEa+QiOpwKb3IYJOdcBxzMFnCu2Hgi
	WaBLwWDfNa+iAxzpRqH8+u+b3zNSE2XnVmL/tZiPbD8dkV4wiw1K
X-Gm-Gg: ASbGncuRtXcR5ZT2AKJ1PJOUCU0ag8bPVEgeAzJT+JT/uLkC9z1H3igZwvXFB+jO0zL
	6h4dBj6YK7W4gwu5tE/wEeDTamsT64YqxVY3gTrlGNs1UcFpfhP0oAzSJ9h4po2CMWf8QJWOUOk
	3oTCVXUCzCRmJeXa1RsJM+xG29sSo6XKAo8boqKKvdWThyWkLeh2G0VrBGH5YZYs3nOV0Dkjlgl
	91ewYKiHgR8afIoyyr1sDrYF7KhUR5Q+hiiw7CH2hp8OITw42bSHv5BM2EC0MLYcn/WK+mJy6OF
	m0Ze1OuTWTLQf2UMIgLu0JMDTe+mzyU=
X-Google-Smtp-Source: AGHT+IFO87ET7RNKrk3UF1PEUh15ufHAa0Xuh+MHK1ieSEIT7Rz22UvQkjilBKaStSwIpkQPF5GxvQ==
X-Received: by 2002:a05:690c:7304:b0:6f9:7a3c:1fe with SMTP id 00721157ae682-708abe2046emr20914727b3.23.1745969933102;
        Tue, 29 Apr 2025 16:38:53 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708ae1edd01sm700967b3.115.2025.04.29.16.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:38:52 -0700 (PDT)
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
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	peterx@redhat.com
Subject: [RFC PATCH v2 04/18] mm: swap: add an abstract API for locking out swapoff
Date: Tue, 29 Apr 2025 16:38:32 -0700
Message-ID: <20250429233848.3093350-5-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429233848.3093350-1-nphamcs@gmail.com>
References: <20250429233848.3093350-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we get a reference to the backing swap device in order to
lock out swapoff and ensure its validity. This does not make sense in
the new virtual swap design, especially after the swap backends are
decoupled - a swap entry might not have any backing swap device at all,
and its backend might change at any time during its lifetime.

In preparation for this, abstract away the swapoff locking out behavior
into a generic API.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h | 12 ++++++++++++
 mm/memory.c          | 13 +++++++------
 mm/shmem.c           |  7 +++----
 mm/swap_state.c      | 10 ++++------
 mm/userfaultfd.c     | 11 ++++++-----
 5 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 8b8c10356a5c..23eaf44791d4 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -709,5 +709,17 @@ static inline bool mem_cgroup_swap_full(struct folio *folio)
 }
 #endif
 
+static inline bool trylock_swapoff(swp_entry_t entry,
+				struct swap_info_struct **si)
+{
+	return get_swap_device(entry);
+}
+
+static inline void unlock_swapoff(swp_entry_t entry,
+				struct swap_info_struct *si)
+{
+	put_swap_device(si);
+}
+
 #endif /* __KERNEL__*/
 #endif /* _LINUX_SWAP_H */
diff --git a/mm/memory.c b/mm/memory.c
index fb7b8dc75167..e92914df5ca7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4305,6 +4305,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	struct swap_info_struct *si = NULL;
 	rmap_t rmap_flags = RMAP_NONE;
 	bool need_clear_cache = false;
+	bool swapoff_locked = false;
 	bool exclusive = false;
 	swp_entry_t entry;
 	pte_t pte;
@@ -4365,8 +4366,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	/* Prevent swapoff from happening to us. */
-	si = get_swap_device(entry);
-	if (unlikely(!si))
+	swapoff_locked = trylock_swapoff(entry, &si);
+	if (unlikely(!swapoff_locked))
 		goto out;
 
 	folio = swap_cache_get_folio(entry, vma, vmf->address);
@@ -4713,8 +4714,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		if (waitqueue_active(&swapcache_wq))
 			wake_up(&swapcache_wq);
 	}
-	if (si)
-		put_swap_device(si);
+	if (swapoff_locked)
+		unlock_swapoff(entry, si);
 	return ret;
 out_nomap:
 	if (vmf->pte)
@@ -4732,8 +4733,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		if (waitqueue_active(&swapcache_wq))
 			wake_up(&swapcache_wq);
 	}
-	if (si)
-		put_swap_device(si);
+	if (swapoff_locked)
+		unlock_swapoff(entry, si);
 	return ret;
 }
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 1ede0800e846..8ef72dcc592e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2262,8 +2262,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	if (is_poisoned_swp_entry(swap))
 		return -EIO;
 
-	si = get_swap_device(swap);
-	if (!si) {
+	if (!trylock_swapoff(swap, &si)) {
 		if (!shmem_confirm_swap(mapping, index, swap))
 			return -EEXIST;
 		else
@@ -2411,7 +2410,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	}
 	folio_mark_dirty(folio);
 	swap_free_nr(swap, nr_pages);
-	put_swap_device(si);
+	unlock_swapoff(swap, si);
 
 	*foliop = folio;
 	return 0;
@@ -2428,7 +2427,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		folio_unlock(folio);
 		folio_put(folio);
 	}
-	put_swap_device(si);
+	unlock_swapoff(swap, si);
 
 	return error;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index ca42b2be64d9..81f69b2df550 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -419,12 +419,11 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 	if (non_swap_entry(swp))
 		return ERR_PTR(-ENOENT);
 	/* Prevent swapoff from happening to us */
-	si = get_swap_device(swp);
-	if (!si)
+	if (!trylock_swapoff(swp, &si))
 		return ERR_PTR(-ENOENT);
 	index = swap_cache_index(swp);
 	folio = filemap_get_folio(swap_address_space(swp), index);
-	put_swap_device(si);
+	unlock_swapoff(swp, si);
 	return folio;
 }
 
@@ -439,8 +438,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	void *shadow = NULL;
 
 	*new_page_allocated = false;
-	si = get_swap_device(entry);
-	if (!si)
+	if (!trylock_swapoff(entry, &si))
 		return NULL;
 
 	for (;;) {
@@ -538,7 +536,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	put_swap_folio(new_folio, entry);
 	folio_unlock(new_folio);
 put_and_return:
-	put_swap_device(si);
+	unlock_swapoff(entry, si);
 	if (!(*new_page_allocated) && new_folio)
 		folio_put(new_folio);
 	return result;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index d06453fa8aba..f40bbfd09fd5 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1161,6 +1161,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	struct folio *src_folio = NULL;
 	struct anon_vma *src_anon_vma = NULL;
 	struct mmu_notifier_range range;
+	bool swapoff_locked = false;
 	int err = 0;
 
 	flush_cache_range(src_vma, src_addr, src_addr + PAGE_SIZE);
@@ -1367,8 +1368,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			goto out;
 		}
 
-		si = get_swap_device(entry);
-		if (unlikely(!si)) {
+		swapoff_locked = trylock_swapoff(entry, &si);
+		if (unlikely(!swapoff_locked)) {
 			err = -EAGAIN;
 			goto out;
 		}
@@ -1399,7 +1400,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				pte_unmap(src_pte);
 				pte_unmap(dst_pte);
 				src_pte = dst_pte = NULL;
-				put_swap_device(si);
+				unlock_swapoff(entry, si);
 				si = NULL;
 				/* now we can block and wait */
 				folio_lock(src_folio);
@@ -1425,8 +1426,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	if (src_pte)
 		pte_unmap(src_pte);
 	mmu_notifier_invalidate_range_end(&range);
-	if (si)
-		put_swap_device(si);
+	if (swapoff_locked)
+		unlock_swapoff(entry, si);
 
 	return err;
 }
-- 
2.47.1


