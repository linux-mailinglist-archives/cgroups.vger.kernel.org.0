Return-Path: <cgroups+bounces-1399-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D07084D014
	for <lists+cgroups@lfdr.de>; Wed,  7 Feb 2024 18:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA3D1F21B0C
	for <lists+cgroups@lfdr.de>; Wed,  7 Feb 2024 17:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E1D127B52;
	Wed,  7 Feb 2024 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="AkOSHjAK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCD8614E
	for <cgroups@vger.kernel.org>; Wed,  7 Feb 2024 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707327684; cv=none; b=IEyANwaYSlTc33hMf02rrXUYKgSlHwYbuT2KtOEPYYNkpHqGK0AeyJRq3aFrmrsOX5xcAq9Hz69l2YaFcIZAgC+poPcmNNUVBvK905vaM0dnK3Mu84UssCY1ExM5bUq5cYbpKrkOI4cMfVkGjHZC6BVe9lCV/RE7sPnliGZW30g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707327684; c=relaxed/simple;
	bh=emnFf+hIj/iK5Aa7oIuD3PcB+/9O2Drd8YFDdFcevF0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brvzrOHgzIQWo2n6f6s0jqxjBF2n+KCar1XH+d/0OO4n151PrGUo34SaNeJAVmU0Rjy7c3uUO3aKA3EN3uF7YRVAEHDHD+v8v9WKa/WDknhcBaQc0OAw8nnPrvAq+0c3FpJfkxWjK/2cfwdoI2U/g/o2yeucieQTW6FKssf42kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=AkOSHjAK reason="key not found in DNS"; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78552105081so53126585a.3
        for <cgroups@vger.kernel.org>; Wed, 07 Feb 2024 09:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707327679; x=1707932479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOJ5ut398ow/2WlP29EDaCAozkqg/KeyQvQPT/mKdCU=;
        b=AkOSHjAKsA/gstic0PJ5KRAiRBzoDrBj4F8Rs9JtXHJWbkDdsp8CbtLVRdQrrNPelj
         WLYPrpkHkqSrriNwG0/mlrIgmCfQ8BfzqSA+s1ky317zrDMYo1N0dDA6Ebmp5+WwOmdy
         6GFuJFqtwsFeXW1D/6f0FHvBp2DzI6YuMxm2CWzh4HX0eEJO/h+ci+FcW0OJZToQq/Gw
         +hHo713cBJ7vwPlMhFZdbqm4SKuD6wevNVS8SNpJDd5ObXz9CK0IV19/fjYB1/zeGURV
         tA91MFdj/YxncnuMWl2rZE1YP4XgVqLwcbz3gInId1G+DbjNWJIdy6gy0KDlByyCIsyd
         g6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707327679; x=1707932479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOJ5ut398ow/2WlP29EDaCAozkqg/KeyQvQPT/mKdCU=;
        b=vHAFxSpGv2ZKWZ+e0k6CWkYJPC8zTdm8xou/Yan8/b1gQYS7D4uwW3+d246ldZgfZH
         O32hz6U04fFD/m8IFy9NE3MEKeNiRaG0QfCuU4RGXxYLZaQoIedP+urr/Hd9ZFxRNqsW
         XSTWDvwODaMDZTUxu5TlIGzDTETPRbGqSh0kNvigmN0n28Zl4bWkDYCzx/bh0LRLrG8P
         rWEINpq5JGaTuVTSq0Xee0ZRNTak+T/nWfKDUmKUVTpvOUpw9fzqTICSP/7ZNPTPmpX4
         eaH1zbLpBjRD2mwvfUSF0GwrSf3GWRYwhc7/4PluYCR9NnDCVr8ux41U09JcPSBNpMNX
         ohIQ==
X-Gm-Message-State: AOJu0YwZjst3uwD2nW6XKQHDjB73Zt7PA7S7IzcS7tWm/wFtkYOxyJKE
	LH2qEs1fsAt1heo/C79cwEjr3UfSuYnF+iLqjWj/rHQZv8n76BpQzXeQcjGLWI4=
X-Google-Smtp-Source: AGHT+IGzHmYfHKKzBsKfi2sS1p/R7NZ/BV205sSyGSsoTpCiCT38UMcgyp+aJmcRhxrEuO8FJ5t6XA==
X-Received: by 2002:a05:620a:190e:b0:783:549a:aa3f with SMTP id bj14-20020a05620a190e00b00783549aaa3fmr6972919qkb.67.1707327678787;
        Wed, 07 Feb 2024 09:41:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5l5W9Ag0S1GSuk5ze64Pqkrc0g2WtQQ/c427L6Wd+pcn5y13WR4x4V+lQaH1CcBBG5XXPSlgnlFtQgmmtEQb6/2LSLxJ10zLMWQZ8PdceFohV3IOcvUrAvNBCceQnwz5PJ+IIMQwQYJUvxZuVNp2jbd/U7E0vX/YRkDOFSFIshcKcKG2qswuchLCaZI1W0y8aa587Wr7wrEtsX8r4bweBTcsf8UaI+ns0u+SHUw+Fd98rEDOWGSH86cbJqLx+yxCrP6JKLabCKo0gQ0exvrWKQG8EFrJAMCTgsQDEay4sOC7d1p+AMXIaNnmuIsVuIoDJ2k0xpNk6ZfzFdRjT2/0tObrAQTGlZxe1100kS23WYT5U3shsLvQAqEpLxW3C/F2u4E1SvpMeSQCGdYshpROXy8qT5LlLdErr+vz3+feGVxWOjgKuYmCEXRqCrsGwKsEFJ6NqvP/O345Oaw15ZwYZhEiMpSHbWmCz3iXvnM8DQ5k2G9kCUfTEhbrpnwFfplTvFcLDWPiRTXBrZWKrKupRBfEtSP6zcP/McBN4ArHkINjn/oV4kCQipJoSCWb5xsCYPpSqJmHveceVJb/mM2qMjvu2DMe3jgySfVXxZ16iNz5JtG9degRa0XrH3iCwEBeitTK6goM0eoGtVIWbGExhGvKS2qxPKN8m+p5hn6aQT/xvruo5ghDNFxbC6ClB6AqNECLyg7ZdWg+kyt5nzHVMuu2nQ9eTGnjhfu5/NksQjr8r7Yjdk/lt1V4avjeXyxAwec0bzW03SdqtLnEZ4ix0sQuIFWSeOkd8+jJo7ka8RLo0vJLSxU5cmnYYSiaAE9/WZpm4mtbZpHCBn6jw+3gXjiDTCAZQkKybZD+IW9+Ua47DSmVzWh+SujH1HqbbQ6J3aX7fsM8cL+5mpo7aAXcFTOdhOfpejLAJybs8RuPZULp7k2HKZFLZcj/3smDH+QlgAA
 v+viEzlHnhxD8gwig/TVFwXduy2fJIryQb6xREtFO2kvs7rR0ze1qIhdPdoAdHpRi5zLY2FAaEzpNEe2mCr/hobwhz309FnEBGy3p4duYtaZy1zL2a4zFrNv5tiNnNcl0oJQIymIZEpA0gTG5Efh7EhezVq+BSrf/HYiigfcwHL2Kk0NSzTpZ1MdpdyJIqYVNw8qE0NZs/+w1hYGvTx09SD5Nyi9xL3/BRW2rCQxgyeyXpqGjk4oyXoKnR3l8WNiJ1iJD0nmckKOAXNplAPi/pNtSQ2aFjtC+ApLt075lhvFnm6wSPA8FBaPLrsV4jV48R7yNVf4gpZmuobPWdbcSx3DBmdJTRV3njPssZ/V2j2NiSDHtOBbh1aUz+Ua+gQUiepqzMS1Bw7UsDY3XjEzkvcpINTtsFGpTHvY3dZcb6W0ggjjMkZ309cd/5G3Qjk/+SEAoMU1Z40QF5/SV8NcemsKNKcbEDW6SFstkb0TygjllY
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id e10-20020a37db0a000000b007854018044bsm696310qki.134.2024.02.07.09.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:41:18 -0800 (PST)
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
Subject: [PATCH v4 09/10] iommu: observability of the IOMMU allocations
Date: Wed,  7 Feb 2024 17:41:01 +0000
Message-ID: <20240207174102.1486130-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
References: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
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
index c412d0aaa399..7336f976b641 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -17,6 +17,30 @@
  * state can be rather large, i.e. multiple gigabytes in size.
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
  * __iommu_alloc_pages_node - allocate a zeroed page of a given order from
  * specific NUMA node.
@@ -35,6 +59,8 @@ static inline struct page *__iommu_alloc_pages_node(int nid, gfp_t gfp,
 	if (unlikely(!page))
 		return NULL;
 
+	__iommu_alloc_account(page, order);
+
 	return page;
 }
 
@@ -53,6 +79,8 @@ static inline struct page *__iommu_alloc_pages(gfp_t gfp, int order)
 	if (unlikely(!page))
 		return NULL;
 
+	__iommu_alloc_account(page, order);
+
 	return page;
 }
 
@@ -89,6 +117,7 @@ static inline void __iommu_free_pages(struct page *page, int order)
 	if (!page)
 		return;
 
+	__iommu_free_account(page, order);
 	__free_pages(page, order);
 }
 
@@ -197,6 +226,7 @@ static inline void iommu_free_pages_list(struct list_head *page)
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
2.43.0.594.gd9cf4e227d-goog


