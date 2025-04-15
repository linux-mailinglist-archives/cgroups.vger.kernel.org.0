Return-Path: <cgroups+bounces-7563-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FADA89226
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C683A3B7524
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7D622FF4C;
	Tue, 15 Apr 2025 02:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="X3YcwjO9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72F521C9E9
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685251; cv=none; b=ZbtWgrH9vqZnZYqUjCD8xmXi6RIO5rL87qpgxV51n74towtw9tVgC2X7vIUPLKT/zCFG+ek5tloNLZMdBsgaztpmaUO6B+vQwYKQYrFQjOxujc751a/ruCnxuVihC5GRXN0TDvOykotPp8tGrhiNBDS+3cqVArpwDuIABrWtT44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685251; c=relaxed/simple;
	bh=iY7sUEg8RxvszMD15EveHMNsGLG7ckUp1GQHb7p3g4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RGiMAOes0s/eKPUiX5846Us26OYBkq68dSy4q64EDIP46gDrZjSsM2OmrfyK/no9Y1Tlp+ooazaR/SSThtAQALyvffJ/i3vElDskBDkOSf/N7OYsVcnSc04iMNaPo8qBeIbw6ByzO9+u+FelxD5UCgor7E5+UflNnDRPR/xHFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=X3YcwjO9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22403cbb47fso53265325ad.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685249; x=1745290049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4yZw6tSBeNw48uMiPAV08H8+5zhu9HJtv5YMARqzOY=;
        b=X3YcwjO9y65Gsm4R/lWIdmkJVfmM9nsfuyzeNvX5K0UgEww8fL8TEokcr7SlPS5i6P
         e5hqxfvJdFsrTmrAMRWQLjTcGF9YwbPzRt0dvX72IwVTGnMvy/Wfk2dNWcdOrAo07PSL
         bZdm7vO//fRi+sTBCbvUNGvTMsNxmxeQUo1zIR7vDejgC4JPxEciOj/0SgUBy40jh+Na
         bzu0ONIvaQICQWsISiDTR2E0PyUzQ+2y7Z3XEI7wS4r6jZdUvmOSGt17hyhIOl0Mi5Nd
         UOaWZhlY17ZwgnKI/a8G6uurhq91XKgZhtKJ7zgnEKDKzImiT0plgo50YtUPHJHKNBou
         5bhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685249; x=1745290049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4yZw6tSBeNw48uMiPAV08H8+5zhu9HJtv5YMARqzOY=;
        b=F4k7GRwjbl8Ws+2dZH1aiyycqdon4wDd44Mm0aaB69DgvN+VmR/BTCQj2NVNwsDyBD
         HxNKG0zyMxCU0bQG3J8j65VjQvOFAFLk96Td3wAY9yBVij/8oZwYQQ19/a2oPhKlZjje
         48d4MiKTdMZ1EzGsTLv/uvKmTD9SjxrZawrFJT29yW3C0Iz8e0Wd1nytBtiV0L6PWvCW
         B4IAQAbU7niVMDBDYHAJ1J9ZD0EbPURtaAqXAcHr9M43ScqhCZbtwXFMa/Kaw0OFq3+f
         XgQ/YVXMdJhF8VKrEyvSob2vYnYO8CscrY0v5MnFS4u/1drp+1oBGY+7nF4jhDp0FJJK
         qGYw==
X-Forwarded-Encrypted: i=1; AJvYcCXnstf3nVbbBVb/kOgT8AtYupGtqs9OpUrA9CkyrMsU72IdP4OFIZxa+/472fKkFmKMZbMzcvCW@vger.kernel.org
X-Gm-Message-State: AOJu0YyXeR3ZqnzDdjXmduYtbGZUHddDoUSuUDz8LcFD036INolY/tC1
	CelymejX8TvhxOWmYaLwmV73jCjKxkr1X9z2Z60zraATnaieGShCi6TZSzKWGHg=
X-Gm-Gg: ASbGncsXTgqR2xJ10/YjFhqijLPr7+aSOWlQRzLXzymsb/PyhB3RGmCXcxyxrpSvwwg
	x/KNcr1hLrGF9dv5itMpeKaDRNglQsrCSp2Xy0qJbQcn3Njoo/leecoc03w/EYQF1RjR5tgeWow
	AegB6fReb6pyYx98on/q5/Es8xjBRPbV/QIx15/p6Y8kte05nYjKGOOtJq2Fd0w6KdBjWdxYkcQ
	JHPgThzxSuTuiFSd1w9XfczI/RvlxYJv7/S+4b7ToZG28nGYhYb7TVUDgsgUh8Kk7QUFoFMCiug
	9RQtDjWNVTXCL6jWK3oNnncrqrLuIxBW5cfAEWEDDUmKhVrvWIF41LLxmEzkAYqUbwpDlQbF
X-Google-Smtp-Source: AGHT+IHc1pLuWcfx52pBjvHAkcC6la0P8uERYY4ckvTOHEzauARR1urHfVeCryhgzFD7fMiSaMQDhw==
X-Received: by 2002:a17:903:2f86:b0:223:47b4:aaf8 with SMTP id d9443c01a7336-22bea50e1a5mr207262015ad.52.1744685249046;
        Mon, 14 Apr 2025 19:47:29 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.47.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:47:28 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RFC 17/28] mm: mglru: prevent memory cgroup release in mglru
Date: Tue, 15 Apr 2025 10:45:21 +0800
Message-Id: <20250415024532.26632-18-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250415024532.26632-1-songmuchun@bytedance.com>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the near future, a folio will no longer pin its corresponding
memory cgroup. To ensure safety, it will only be appropriate to
hold the rcu read lock or acquire a reference to the memory cgroup
returned by folio_memcg(), thereby preventing it from being released.

In the current patch, the rcu read lock is employed to safeguard
against the release of the memory cgroup in mglru.

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/vmscan.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index eac5e6e70660..fbba14094c6d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3451,8 +3451,10 @@ static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
 	if (folio_nid(folio) != pgdat->node_id)
 		return NULL;
 
+	rcu_read_lock();
 	if (folio_memcg(folio) != memcg)
-		return NULL;
+		folio = NULL;
+	rcu_read_unlock();
 
 	return folio;
 }
@@ -4194,10 +4196,10 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	unsigned long addr = pvmw->address;
 	struct vm_area_struct *vma = pvmw->vma;
 	struct folio *folio = pfn_folio(pvmw->pfn);
-	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct mem_cgroup *memcg;
 	struct pglist_data *pgdat = folio_pgdat(folio);
-	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
+	struct lruvec *lruvec;
+	struct lru_gen_mm_state *mm_state;
 	DEFINE_MAX_SEQ(lruvec);
 	int gen = lru_gen_from_seq(max_seq);
 
@@ -4234,6 +4236,11 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 		}
 	}
 
+	rcu_read_lock();
+	memcg = folio_memcg(folio);
+	lruvec = mem_cgroup_lruvec(memcg, pgdat);
+	mm_state = get_mm_state(lruvec);
+
 	arch_enter_lazy_mmu_mode();
 
 	pte -= (addr - start) / PAGE_SIZE;
@@ -4270,6 +4277,8 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 
 	arch_leave_lazy_mmu_mode();
 
+	rcu_read_unlock();
+
 	/* feedback from rmap walkers to page table walkers */
 	if (mm_state && suitable_to_scan(i, young))
 		update_bloom_filter(mm_state, max_seq, pvmw->pmd);
-- 
2.20.1


