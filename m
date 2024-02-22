Return-Path: <cgroups+bounces-1806-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FA985FFAE
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 18:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A7A1C2541C
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 17:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3793D158D96;
	Thu, 22 Feb 2024 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="dUwkbRo/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BB9157E6F
	for <cgroups@vger.kernel.org>; Thu, 22 Feb 2024 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623597; cv=none; b=R976fdVqSK8gWFbAEDLT3f3E7cfTZicS3WsKuyUOS7YXW0/GFmu6jgVV6KJyhGmfaUWZrU3tZBo9knnuWYFNX3Aj0XHSY/ZTVmhwBEqhUK9IW0ueqMiPa0ZFkj5ZUonzQeG2mswO+NWodO19SFlJ0AgWd/Mh8dlC2QiH8ZAHytE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623597; c=relaxed/simple;
	bh=HFMzJSfAagxMsn8PANMQxhVlBhQeJV3s4jHhao7IlsQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqA29GKfoi9fYMrE0dMEOcTXHyo5H6nE61EiQG0qLMTxTFSKMlfu6f5Zb4WA3CTJUN/3w6TYKEtIAknrY5+VaSAfnoU6cABQzKFfG6PywJ4vV3lfSe7cYlVGQhw2RiCPRyh1A0ujO2zg6QiUuOzficl+OJ2N0Ssna8P6tRlLNa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=dUwkbRo/; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42dd6f6518fso26854611cf.1
        for <cgroups@vger.kernel.org>; Thu, 22 Feb 2024 09:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708623590; x=1709228390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhLjauiol2hX/CcN6wSXepYqvX9ekQ41OuBb1dZBQzE=;
        b=dUwkbRo/zGxx9V4pg7lnXDNrH/12crjApNGm2Q2xxjqsQ+v2rB5nxiefqSxuwzocKA
         tPk+QTnm059ZfEl8OMlD4HX4t/SXbXlNCWjgF6JrtQZGtQxi5RU1EL6TrkrOUCqRv3OQ
         9gyIpXQ+v5N4M+94vhSUmF0KvWZb2yt17vuZAqWzjPIrSO+iexv8t2v/uO67m/LfsfyN
         esQjijjIh3Vbp/mmBwdQ33ZloGSfJkMRqwHwAcN5ViPgLqwLLmHYlTzAbNfIIdL/YMds
         pLR6uZTP63fLywonb6n6NerRM4xNZPTFhdCbkPf773R1g6dFdth7O04BUXl5Dp+b09gy
         dfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708623590; x=1709228390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhLjauiol2hX/CcN6wSXepYqvX9ekQ41OuBb1dZBQzE=;
        b=FCHal0TaHdz+oPPxFOoaNsqLQ3KWtqFl+53nmBZQjmKVsA7LawcujKWGkWMxDmmmlM
         KBUZhIAorr6SUVtEdeCPMu+CS9/eTZdPNpTfVBI0O2gP5g/swmciReHSwq+/KQ1cf+ue
         /DNCT2U90rfta5gY2PDkh9A7G3vGXzsEkKiO+pm3pJMaLPw+dl7jX17IqGsxqZCjMpR3
         87W2BKMBiOkQq1bZkzAn9knW1wmXazgpTp/3N9AzAPi+c6oUOEqj/2PzsUm+2E4oqFCw
         xBi36ReTkP7owpcZ9So5OS3HxIsjHWDx7dJ9sI86S7sTD9FtMVSt5IsFPEilBvWDq9r/
         dLeg==
X-Forwarded-Encrypted: i=1; AJvYcCVgcsm2i68G6Tppx8sU0MksqBhO+w7sXwFRIX6TIhKSwWtDn/FM82r7nXvZxxHpODWGH8GItIkLCP72z5ddlRW1rgXj1E8NeQ==
X-Gm-Message-State: AOJu0Yy3y1HwoydyDcrvJQ47BRAbjbis7Kmwb8/Todmm4t+c+1WiknKS
	dj8pDj5o21cb3h4PbUnKWBwxinc6HyAv7TngaqZcMaIIrejrlJwVLKhkKwlvFQw=
X-Google-Smtp-Source: AGHT+IEp4MwFnGzbjUWvOKNS7CvUx1mMeLXTjvER84y2unxVOxwU99/U/wStbNygCnfZAxx//dKL9w==
X-Received: by 2002:ac8:5b84:0:b0:42e:3bf2:89ce with SMTP id a4-20020ac85b84000000b0042e3bf289cemr5044762qta.49.1708623590514;
        Thu, 22 Feb 2024 09:39:50 -0800 (PST)
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id f17-20020ac86ed1000000b0042e5ab6f24fsm259682qtv.7.2024.02.22.09.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:39:50 -0800 (PST)
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
Subject: [PATCH v5 05/11] iommu/io-pgtable-dart: use page allocation function provided by iommu-pages.h
Date: Thu, 22 Feb 2024 17:39:31 +0000
Message-ID: <20240222173942.1481394-6-pasha.tatashin@soleen.com>
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

Convert iommu/io-pgtable-dart.c to use the new page allocation functions
provided in iommu-pages.h., and remove unnecessary struct io_pgtable_cfg
argument from __dart_alloc_pages().

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Janne Grunau <j@jannau.net>
Acked-by: David Rientjes <rientjes@google.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/io-pgtable-dart.c | 37 +++++++++++++--------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/io-pgtable-dart.c b/drivers/iommu/io-pgtable-dart.c
index 74b1ef2b96be..ad28031e1e93 100644
--- a/drivers/iommu/io-pgtable-dart.c
+++ b/drivers/iommu/io-pgtable-dart.c
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 
 #include <asm/barrier.h>
+#include "iommu-pages.h"
 
 #define DART1_MAX_ADDR_BITS	36
 
@@ -106,18 +107,12 @@ static phys_addr_t iopte_to_paddr(dart_iopte pte,
 	return paddr;
 }
 
-static void *__dart_alloc_pages(size_t size, gfp_t gfp,
-				    struct io_pgtable_cfg *cfg)
+static void *__dart_alloc_pages(size_t size, gfp_t gfp)
 {
 	int order = get_order(size);
-	struct page *p;
 
 	VM_BUG_ON((gfp & __GFP_HIGHMEM));
-	p = alloc_pages(gfp | __GFP_ZERO, order);
-	if (!p)
-		return NULL;
-
-	return page_address(p);
+	return iommu_alloc_pages(gfp, order);
 }
 
 static int dart_init_pte(struct dart_io_pgtable *data,
@@ -262,13 +257,13 @@ static int dart_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 
 	/* no L2 table present */
 	if (!pte) {
-		cptep = __dart_alloc_pages(tblsz, gfp, cfg);
+		cptep = __dart_alloc_pages(tblsz, gfp);
 		if (!cptep)
 			return -ENOMEM;
 
 		pte = dart_install_table(cptep, ptep, 0, data);
 		if (pte)
-			free_pages((unsigned long)cptep, get_order(tblsz));
+			iommu_free_pages(cptep, get_order(tblsz));
 
 		/* L2 table is present (now) */
 		pte = READ_ONCE(*ptep);
@@ -419,8 +414,7 @@ apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	cfg->apple_dart_cfg.n_ttbrs = 1 << data->tbl_bits;
 
 	for (i = 0; i < cfg->apple_dart_cfg.n_ttbrs; ++i) {
-		data->pgd[i] = __dart_alloc_pages(DART_GRANULE(data), GFP_KERNEL,
-					   cfg);
+		data->pgd[i] = __dart_alloc_pages(DART_GRANULE(data), GFP_KERNEL);
 		if (!data->pgd[i])
 			goto out_free_data;
 		cfg->apple_dart_cfg.ttbr[i] = virt_to_phys(data->pgd[i]);
@@ -429,9 +423,10 @@ apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	return &data->iop;
 
 out_free_data:
-	while (--i >= 0)
-		free_pages((unsigned long)data->pgd[i],
-			   get_order(DART_GRANULE(data)));
+	while (--i >= 0) {
+		iommu_free_pages(data->pgd[i],
+				 get_order(DART_GRANULE(data)));
+	}
 	kfree(data);
 	return NULL;
 }
@@ -439,6 +434,7 @@ apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 static void apple_dart_free_pgtable(struct io_pgtable *iop)
 {
 	struct dart_io_pgtable *data = io_pgtable_to_data(iop);
+	int order = get_order(DART_GRANULE(data));
 	dart_iopte *ptep, *end;
 	int i;
 
@@ -449,15 +445,10 @@ static void apple_dart_free_pgtable(struct io_pgtable *iop)
 		while (ptep != end) {
 			dart_iopte pte = *ptep++;
 
-			if (pte) {
-				unsigned long page =
-					(unsigned long)iopte_deref(pte, data);
-
-				free_pages(page, get_order(DART_GRANULE(data)));
-			}
+			if (pte)
+				iommu_free_pages(iopte_deref(pte, data), order);
 		}
-		free_pages((unsigned long)data->pgd[i],
-			   get_order(DART_GRANULE(data)));
+		iommu_free_pages(data->pgd[i], order);
 	}
 
 	kfree(data);
-- 
2.44.0.rc0.258.g7320e95886-goog


