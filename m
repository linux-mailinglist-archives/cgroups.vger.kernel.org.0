Return-Path: <cgroups+bounces-1813-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB3985FFD2
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 18:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7718AB22435
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 17:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB2215AADE;
	Thu, 22 Feb 2024 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="USzYIUF1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D076157E81
	for <cgroups@vger.kernel.org>; Thu, 22 Feb 2024 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623607; cv=none; b=ETIZ4sU6v67HYKE/jt0GXjx0CDuFs5qww45PRKpNY7Q0ORH4LtffETRa2xMOSAJM3qvclQ7mq65QDO3zkuFnZPB33zggJHRcxJKsW9K7hvNap7w1YkPKKvA4sjYB9fDCWQ8YMphQzeWO19bcCAkZyHs/GXXuBY08BVljcBGOHAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623607; c=relaxed/simple;
	bh=1YoYeatwE0jJRPo4fjMAz9I4YBLnIqISqkXjJpSRXIY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hA0esdp86at7hUQZnOWXZhuudFNQbXWUERrVGxfY9nRa6u3GDik4eZ8KK7ayKF+ANbpQIhHRdKSgt0yF+713W8HgfaJvcYGc8SiyBqFchYb/kH/54NuPtW90DGmSMs6lSMl7LnN3qagAYxLUaaTTd2fA8WAmyYDXbZ/PTpZ8yvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=USzYIUF1; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42c758f075dso10247571cf.0
        for <cgroups@vger.kernel.org>; Thu, 22 Feb 2024 09:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708623595; x=1709228395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0ReaiTECyup4iu8c9tFSBLtkPVhLn8yFZIGfl9p6vs=;
        b=USzYIUF1WlhhKnEc6WdPED0RYcmsgwzPw0wfUuhKoekrOpqSEjVCChrWf39hbobYRZ
         BPClX781LHG3hOG+VSM8F/Qb6d/77N3A0xmCAB3l+aKgFnwsYtWvZfpx4JdUzSZ1vEBx
         4HnZwNC/nrtPFf64EcNDKnxBg1p8KBfmzwAksOM1VrAfDjJdQCrz8Y6tcNLiaPVZ+xsj
         PYHhYKxxfFDsxmDBJSOQDvlXgsx5iJzV623J9T+Kjk4AUPM/heBt9K8Co4MfEntv0+QD
         U+SSnFPumEHAhqXI+MUucWVzOnaQTzftQ7YeWcmHCKeklNOecifb2Hp7E9NDu34skGuj
         ScjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708623595; x=1709228395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0ReaiTECyup4iu8c9tFSBLtkPVhLn8yFZIGfl9p6vs=;
        b=OTS1ePePMrbm4hATi0ikITeDCXvBYUygK0zAyky8ow3RKW/Pdf/kcd8ojPhVNk9/WY
         pQQEtG5TPgHlP6QRFfgFYoSODkqjUe6Ap1abe0ufntdXO3fGYnNVpGcyfU5py20YQkNH
         u4Q044hyOMkhaOWx7YeGT9uXYziZ5a1zoOSjnz4TvKE65mTUGbxQpnCBP2kQ+zJ82+Ml
         m+uDDz36FSvS2xEA+xTYtLmhaMTBWFB+spGdzqVTwoR9/MeEabVvAMcSzf2pCzAv5PET
         SKS9A0m4rY3v5e90jy604kWpYSpMZY/yArTl+BnKk2kmDTFSSHlTyuYLRe1qiA+uaTPO
         B6eA==
X-Forwarded-Encrypted: i=1; AJvYcCWNjNEMG5CXC4mc9xNJ3AZ1xauwZIbZxUIU40+kz1kOKUT+UAw2mIk3Xgao3PQD42Wm0Shq6jXBT2OFWObyn7BEYvv2HZCkPg==
X-Gm-Message-State: AOJu0YwVSv6guM5m+llKylQc/urwV1kGJtUVqsP7ci5vN+iTeyJZXkNr
	JbZCC99whfiyGrZYT0+HvBctuV3dhS5xvR+EZCxL9UjJKX0UN2j8UvI1vRSMisA=
X-Google-Smtp-Source: AGHT+IEfgzE/uC4xDSwqJvxbjnpMCM7aGgkDw9ad0MN7VOXeeW4kWverRuOWKwGaZsiVILRRW0AILg==
X-Received: by 2002:ac8:6c2:0:b0:42d:f128:eccf with SMTP id j2-20020ac806c2000000b0042df128eccfmr3903788qth.33.1708623595045;
        Thu, 22 Feb 2024 09:39:55 -0800 (PST)
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id f17-20020ac86ed1000000b0042e5ab6f24fsm259682qtv.7.2024.02.22.09.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:39:54 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alim.akhtar@samsung.com,
	alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	dwmw2@infradead.org,
	hannes@cmpxchg.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jernej.skrabec@gmail.com,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	krzysztof.kozlowski@linaro.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com,
	marcan@marcan.st,
	mhiramat@kernel.org,
	m.szyprowski@samsung.com,
	pasha.tatashin@soleen.com,
	paulmck@kernel.org,
	rdunlap@infradead.org,
	robin.murphy@arm.com,
	samuel@sholland.org,
	suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev,
	thierry.reding@gmail.com,
	tj@kernel.org,
	tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com,
	rientjes@google.com,
	bagasdotme@gmail.com,
	mkoutny@suse.com
Subject: [PATCH v5 10/11] iommu: observability of the IOMMU allocations
Date: Thu, 22 Feb 2024 17:39:36 +0000
Message-ID: <20240222173942.1481394-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NR_IOMMU_PAGES into node_stat_item that counts number of pages
that are allocated by the IOMMU subsystem.

The allocations can be view per-node via:
/sys/devices/system/node/nodeN/vmstat.

For example:

$ grep iommu /sys/devices/system/node/node*/vmstat
/sys/devices/system/node/node0/vmstat:nr_iommu_pages 106025
/sys/devices/system/node/node1/vmstat:nr_iommu_pages 3464

The value is in page-count, therefore, in the above example
the iommu allocations amount to ~428M.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/iommu-pages.h | 30 ++++++++++++++++++++++++++++++
 include/linux/mmzone.h      |  3 +++
 mm/vmstat.c                 |  3 +++
 3 files changed, 36 insertions(+)

diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
index 35bfa369b134..daac2da00e40 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -20,6 +20,30 @@
  * large, i.e. multiple gigabytes in size.
  */
 
+/**
+ * __iommu_alloc_account - account for newly allocated page.
+ * @page: head struct page of the page.
+ * @order: order of the page
+ */
+static inline void __iommu_alloc_account(struct page *page, int order)
+{
+	const long pgcnt = 1l << order;
+
+	mod_node_page_state(page_pgdat(page), NR_IOMMU_PAGES, pgcnt);
+}
+
+/**
+ * __iommu_free_account - account a page that is about to be freed.
+ * @page: head struct page of the page.
+ * @order: order of the page
+ */
+static inline void __iommu_free_account(struct page *page, int order)
+{
+	const long pgcnt = 1l << order;
+
+	mod_node_page_state(page_pgdat(page), NR_IOMMU_PAGES, -pgcnt);
+}
+
 /**
  * __iommu_alloc_pages - allocate a zeroed page of a given order.
  * @gfp: buddy allocator flags
@@ -35,6 +59,8 @@ static inline struct page *__iommu_alloc_pages(gfp_t gfp, int order)
 	if (unlikely(!page))
 		return NULL;
 
+	__iommu_alloc_account(page, order);
+
 	return page;
 }
 
@@ -48,6 +74,7 @@ static inline void __iommu_free_pages(struct page *page, int order)
 	if (!page)
 		return;
 
+	__iommu_free_account(page, order);
 	__free_pages(page, order);
 }
 
@@ -67,6 +94,8 @@ static inline void *iommu_alloc_pages_node(int nid, gfp_t gfp, int order)
 	if (unlikely(!page))
 		return NULL;
 
+	__iommu_alloc_account(page, order);
+
 	return page_address(page);
 }
 
@@ -147,6 +176,7 @@ static inline void iommu_put_pages_list(struct list_head *page)
 		struct page *p = list_entry(page->prev, struct page, lru);
 
 		list_del(&p->lru);
+		__iommu_free_account(p, 0);
 		put_page(p);
 	}
 }
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a497f189d988..bb6bc504915a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -203,6 +203,9 @@ enum node_stat_item {
 #endif
 	NR_PAGETABLE,		/* used for pagetables */
 	NR_SECONDARY_PAGETABLE, /* secondary pagetables, e.g. KVM pagetables */
+#ifdef CONFIG_IOMMU_SUPPORT
+	NR_IOMMU_PAGES,		/* # of pages allocated by IOMMU */
+#endif
 #ifdef CONFIG_SWAP
 	NR_SWAPCACHE,
 #endif
diff --git a/mm/vmstat.c b/mm/vmstat.c
index db79935e4a54..8507c497218b 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1242,6 +1242,9 @@ const char * const vmstat_text[] = {
 #endif
 	"nr_page_table_pages",
 	"nr_sec_page_table_pages",
+#ifdef CONFIG_IOMMU_SUPPORT
+	"nr_iommu_pages",
+#endif
 #ifdef CONFIG_SWAP
 	"nr_swapcached",
 #endif
-- 
2.44.0.rc0.258.g7320e95886-goog


