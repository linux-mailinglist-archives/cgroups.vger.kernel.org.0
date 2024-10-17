Return-Path: <cgroups+bounces-5153-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C9C9A280E
	for <lists+cgroups@lfdr.de>; Thu, 17 Oct 2024 18:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16BD5B2D75A
	for <lists+cgroups@lfdr.de>; Thu, 17 Oct 2024 16:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21241DEFD7;
	Thu, 17 Oct 2024 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9izOWLO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3817ADF0;
	Thu, 17 Oct 2024 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181083; cv=none; b=EmxmYKrcVt/Z1gA8/TmIZP2+C0EQWkUzy1Lq2KIlRq4rq72+ey12WWnuE8Tp0rWR2m5RQ4gNDn+Nnv3/JEGSHACqIA6LVdBg0lA17RvR6/WPqdF7QIWXUjSiiqwO6TCN7j6nEUJexZg85RfZZ1Q2nUE7cBZjlE/COTOnUu72hT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181083; c=relaxed/simple;
	bh=mePIAvODg/PQ9ql7yYVdMpHovmSb2O/t3OSh7w18sc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPM5TLSOmIyuYEK3ArJSYubzYH1CMTGCPBWFAwK/ZDgAt6iAlEuDq7R4XT0NLXiF1B3GRWFWB3sgcIXGVyENgK6fH6uI8fmZHgxPihqFD+srSRd6wQxNLTaYGQvmj97WXZKe4KSDJn+vDJqu/5ShpcnTTrPFZpkSDK2eQdvhGeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9izOWLO; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e59a9496f9so14237877b3.0;
        Thu, 17 Oct 2024 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729181081; x=1729785881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42xKghtIevUZ4KWCWJ57cGxLc8WtHyRt0bs91p1Be2A=;
        b=J9izOWLOCG+A09JV3osxwHtYsUiVTJBq5TQfUangcg6TPLQKf4f6/b1zhT5uuYjd73
         6LuCrYLfPKavF/S5os9N9k18MtNpcdbWEtw4OB77SCXkG0aeUhxPfd8atbPGCapnEREZ
         8SACCt/xpuhz8II9c61U5MspI80TuQeq+aHZLh76JxwLYhTKcoYzMWWFePZ5oLGkzivE
         ranmilKyO1kvRbOVLkSqftjcUzNft90/0gUP6+pUSl+2BbTiGx7R+FF9XmI/VZwM1fS2
         vrAQrSpuWT9UqSwnA5UxGOIlDAFxzL2eCei28P5TM9QZhoYXPBjuKc8VzagC0US0ViWm
         hFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181081; x=1729785881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42xKghtIevUZ4KWCWJ57cGxLc8WtHyRt0bs91p1Be2A=;
        b=wAdA3Op9MFqT+fuhYR0nky2pxhFA4jtQFGNBsjwfyKdLtwqvbRe6gKoXODky8oCDpx
         gVmC1IQ1jKg/iifWZIMLV/ZiNXIqMMfpqsDGJNg8WGVkBCr3OG+HTUZjSqxHBmYYZaxF
         C1Vs5IyRH4Q/zj1A4Jlb4enKs24C7tFQe2g3Gej/SfKK0HYVdNRLXZBTMwG1+/1Ewwkc
         e29Z0ZE1+1Yqf5iX299ba/8WiD4EnGkWdaGXklHYzI4D9CRXjod1JW/lvb1XuCe8sZR2
         t60C/wwMqYScoBy5f7mFuyFPEsBuoSDzylKA6Zx6X6B1dgejdA64K7eG0GhsGbqOeFte
         WqoA==
X-Forwarded-Encrypted: i=1; AJvYcCVlRAqRRizHnsPqhk1xGXOYZuptsmPPdzSinYvYprCFdzOH5kV4828ViOUP5J7PXKiceZ5as2XB@vger.kernel.org, AJvYcCXM9oislBStPXpbt6wOJPrnDp0JPsEan4XFAY3wKGk44Zpug1tAoLzJhxjuWMWYYH7Lvo+A2g0wV32DszIR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0JkooMZ+dizDLnlGtwFlQIiuLkGuSao1HsgbOwVqGqXIsePFk
	X07J6+QohymicejvxFdDIJWwtNhyQxDmB8RD/Tb6z6kBDtItBn6J
X-Google-Smtp-Source: AGHT+IGFTgE4dzmkLQsc0IxQJCImcV/K009auCAoScYDCsh1hDfG7buFfBVyhizeG6GJlBICdSbZwg==
X-Received: by 2002:a05:690c:9a81:b0:6e3:d4e3:b9ad with SMTP id 00721157ae682-6e3d4e4fb49mr89001187b3.33.1729181081045;
        Thu, 17 Oct 2024 09:04:41 -0700 (PDT)
Received: from localhost (fwdproxy-frc-013.fbsv.net. [2a03:2880:21ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5ae862csm11867737b3.6.2024.10.17.09.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:04:40 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: hannes@cmpxchg.org
Cc: nphamcs@gmail.com,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lnyng@meta.com
Subject: [PATCH 1/1] memcg/hugetlb: Adding hugeTLB counters to memory controller
Date: Thu, 17 Oct 2024 09:04:38 -0700
Message-ID: <20241017160438.3893293-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>
References: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HugeTLB is added as a metric in memcg_stat_item, and is updated in the
alloc and free methods for hugeTLB, after (un)charging has already been
committed. Changes are batched and updated / flushed like the rest of
the memcg stats, which makes additional overhead by the infrequent
hugetlb allocs / frees minimal.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/memcontrol.h | 3 +++
 mm/hugetlb.c               | 5 +++++
 mm/memcontrol.c            | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 34d2da05f2f1..66e925ae499a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -39,6 +39,9 @@ enum memcg_stat_item {
 	MEMCG_KMEM,
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
+#ifdef CONFIG_HUGETLB_PAGE
+	MEMCG_HUGETLB,
+#endif
 	MEMCG_NR_STAT,
 };
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 190fa05635f4..ca7151096712 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1887,6 +1887,7 @@ void free_huge_folio(struct folio *folio)
 	struct hstate *h = folio_hstate(folio);
 	int nid = folio_nid(folio);
 	struct hugepage_subpool *spool = hugetlb_folio_subpool(folio);
+	struct mem_cgroup *memcg = get_mem_cgroup_from_current();
 	bool restore_reserve;
 	unsigned long flags;
 
@@ -1926,6 +1927,8 @@ void free_huge_folio(struct folio *folio)
 	hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
 					  pages_per_huge_page(h), folio);
 	mem_cgroup_uncharge(folio);
+	mod_memcg_state(memcg, MEMCG_HUGETLB, -pages_per_huge_page(h));
+	mem_cgroup_put(memcg);
 	if (restore_reserve)
 		h->resv_huge_pages++;
 
@@ -3093,6 +3096,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 	if (!memcg_charge_ret)
 		mem_cgroup_commit_charge(folio, memcg);
+
+	mod_memcg_state(memcg, MEMCG_HUGETLB, nr_pages);
 	mem_cgroup_put(memcg);
 
 	return folio;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7845c64a2c57..4180ee876adb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -320,6 +320,9 @@ static const unsigned int memcg_stat_items[] = {
 	MEMCG_KMEM,
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
+#ifdef CONFIG_HUGETLB_PAGE
+	MEMCG_HUGETLB,
+#endif
 };
 
 #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
@@ -1324,6 +1327,9 @@ static const struct memory_stat memory_stats[] = {
 	{ "sock",			MEMCG_SOCK			},
 	{ "vmalloc",			MEMCG_VMALLOC			},
 	{ "shmem",			NR_SHMEM			},
+#ifdef CONFIG_HUGETLB_PAGE
+	{ "hugeTLB",			MEMCG_HUGETLB			},
+#endif
 #ifdef CONFIG_ZSWAP
 	{ "zswap",			MEMCG_ZSWAP_B			},
 	{ "zswapped",			MEMCG_ZSWAPPED			},
-- 
2.43.5


