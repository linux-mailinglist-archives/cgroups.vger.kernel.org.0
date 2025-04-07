Return-Path: <cgroups+bounces-7405-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2733A7F146
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 01:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30DD1773FE
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E57222B8D5;
	Mon,  7 Apr 2025 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcKZnDfC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65627225A40;
	Mon,  7 Apr 2025 23:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069348; cv=none; b=c6UtkUTfBaJO5AYR4+UHutsoKV7OwtGpcLBd/XUnQYr1bzsJStKty9HmoF3AiSVYPpRJfl4mOsXQSnm8kW4BQg9P05aPP3neuLLKkG/lNvQLX3Who1S/cYi7qDeTFs7co3AJdUOrkzE1TudcJFMaz28NEOifYp59EgBOhqRA6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069348; c=relaxed/simple;
	bh=dBGQq1Pd6BCPNuVeF0eBxyPWwJHVwMcLmBXDM7kyFz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anQa9uH+D7B+EWAe3DFDJVZKUPXKelc5Bxc7w1bIC5FLt0LkHf6Bh5vsJnnwsVsxGpXjFpLhkp+y4/3dHhXu33PMO1g78k+qxugAsJvWH3iFEUzecOaOHQIzFA+6q1uCt4wAScuB3gfKhZOf3IeoBbigAm2RhKSVeDYPXq0bAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcKZnDfC; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6feab7c5f96so47626957b3.3;
        Mon, 07 Apr 2025 16:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744069345; x=1744674145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfUGs0YddbsQ4nD768mNJH2PaDd6ou20rVgkj7mY+Lk=;
        b=mcKZnDfCsH/s1EdAQwrRx6Y9wI0PoBxm1hsYTSZJR8mtQvOK83DbmMeBIYBoNJD4wj
         yjsxp0LnGpeFBhWcNjiKrZ+f8WVVjztqKn6Du9vhiL7DEBG48Tuq6vUywnH6PzIb83lY
         CBV/Q6p5uAFONV4eSZSArScCD4weCauqnNzF13JW0OtxBRKhddvnbeVBwXz0UuU+hkrk
         JHsC6yf3p2qt5fVxN/gZBtNNxMR5SplT+t/+q41XZK5YHDi+isqrg8FvbomrHtD6O7QI
         pzHhU5ePuSwqCqZNzDMaT0QDjL4vIuO9AM7Q2IXjwj4n1pE2EVm3HKywm1hdW1mZw2+q
         BpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069345; x=1744674145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfUGs0YddbsQ4nD768mNJH2PaDd6ou20rVgkj7mY+Lk=;
        b=lb6j4VirFDptu+BeShPWO7ie870N9OokdAQur93X4E3EBUQ4pYxzogycNPl68Zl+Sv
         46Dta2i4rDaIQVBFoOialmt3cJqirpuWMZS2zy//aNrll9buhjN1FF6h0V+ZpYoH/K95
         jgTGeXmoGccHL2j5jylQY5pOoPRRb/QIw3R5JFNSuT/jqLkto+OODZeo3zlTpTqG61WO
         L4CDYYPHgJOwD8W1rc2M+8jcq/CWoxlUhBy+nVdIaTRd/Ao2+ZLOvoTcHopbJ1/3u8vH
         o4aDdrCXiZU5bsvBnFcaLcs7wrVnKmqswW/4e9bVNsip07VGKrUHTe2RwfQQOprg3ZKH
         rveA==
X-Forwarded-Encrypted: i=1; AJvYcCURetcbxioT3fCvhCB1EQiLVnrZv8TfOySPPE9bsWG1WEI4H43K8lYa1AhAcSTDPUKh8OEyLk1IXAg=@vger.kernel.org, AJvYcCVUJ4G4LUw3IHrxzGsccmQ2ieW7qXScIvlm62e4c4MONXS+70RC28kFmErER5j+koc87EOXe7IE@vger.kernel.org, AJvYcCX16fXnkAmvKb8E8osXPlMs7mmeoazcVLYsw8dxqQBBbcPGR8nohfHcuLwH5QDKLfG2K350arcpQxrJ7dz4@vger.kernel.org
X-Gm-Message-State: AOJu0YzthWf8QGbF48Sydbt8u1hP0lTubLcAMDuLzDRpRTqKaKCEfL7o
	gLNcBFxJKXjkjIvJyn9KaqngDIN2vaKi9Egx+9hjJ9H3mEhYT1Ha
X-Gm-Gg: ASbGncugidutNgUV3qd1NIroWKzDM42ronsFEY8C1OnAgitheFhoOpr6jLHm1PANsG9
	SajsWM02PIu9HHwYVXZohvfxvxTvbGIISEiJesPPIEo97X47Jd7miLiiGdo2nRYbAlvXrYxSWdL
	/KpAiBn8BkskkWIHLL2m0HykOQhbc6+1w87FB90GYc5Wk5IDDBAhCNKM6oFOt5XglH5wj578Ee2
	84iUdjh9a7DtM1LiEqQY+6U0m8ZUP/HuctzWRWo2w1zzWhH+sbmKz42UPd8R5S2+mkHADmlgVrl
	b+1AQbQgDXD4dULEThKeiBKZH/9wvgUP
X-Google-Smtp-Source: AGHT+IHmylSLqkbMnakEdnta4Mc1w3JFTnb3aV7dqAhsLXyWaelffY0XhjOBtjJGz+rADBjFj72DYg==
X-Received: by 2002:a05:690c:ecf:b0:6ef:69b2:eac with SMTP id 00721157ae682-703e1500617mr242935697b3.4.1744069345103;
        Mon, 07 Apr 2025 16:42:25 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1e5c6f5sm27876857b3.37.2025.04.07.16.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 16:42:24 -0700 (PDT)
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
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 02/14] mm: swap: add an abstract API for locking out swapoff
Date: Mon,  7 Apr 2025 16:42:03 -0700
Message-ID: <20250407234223.1059191-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250407234223.1059191-1-nphamcs@gmail.com>
References: <20250407234223.1059191-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we get a reference to the backing swap device in order to
lock out swapoff and ensure its validity. This is no longer sufficient
and/or doable when the swap entries are decoupled from their backing
stores - a swap entry might not have any backing swap device at all.

In preparation for this decoupling work, abstract away the swapoff
locking out behavior into a generic API (whose implementation will
eventually differ between the old and the new swap implementation).

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h | 12 ++++++++++++
 mm/memory.c          | 13 +++++++------
 mm/shmem.c           |  7 +++----
 mm/swap_state.c      | 10 ++++------
 4 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index b13b72645db3..e479fd31c6d6 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -706,5 +706,17 @@ static inline bool mem_cgroup_swap_full(struct folio *folio)
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
-- 
2.47.1


