Return-Path: <cgroups+bounces-614-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EB87FC5FE
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 21:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B4CFB22379
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 20:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C17F50256;
	Tue, 28 Nov 2023 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Xfs24UuL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404381BC8
	for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 12:49:45 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77d66c7af31so15642285a.1
        for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 12:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701204584; x=1701809384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agdpEgslqhHdhrn0hnWdDpIJa9Hen54IbPQiTYhpn3E=;
        b=Xfs24UuL16GbfUYKHftGUGEopYClHnDNCUlHM4fRVjS5JT9hJIK4RRCWRZONkAzHvD
         dlxs0Oh+2kJ3U/TqI40pCheDRRG2hhbHkEHeU3m3Vqn9LcvUFEhAlozx8nkGOlK5i71q
         GJPX8bWdbHet5KYTsVO02S6BE6oyESKT3wtx3nE0f7bPPqJCRxpn3ePJgT8MSL/uX64D
         HTNgreL+q5I01i6oMC2xsqJEbEtMBo8ocvacXtOIYNFSZhlTmVoaNfvxZq7bihc+3mnN
         sx4DOMCp0XBj+ER3hHJOYTzH2UKtNsg4wBjOHMDyo2dLiNo4azjByjAJpXb+fRVZVQIN
         98+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204584; x=1701809384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agdpEgslqhHdhrn0hnWdDpIJa9Hen54IbPQiTYhpn3E=;
        b=NhxbAYX38QfsSrhsH+jHXV7nCzvL0BD5oeVOudNHsNqstjnElP9Qjppda6EsWwjHmk
         cS94wKufnLnza6qclqvs0SNr91cYYxtVxGbV784RBiYMjXp12CNf/Tyvmrly2Q1fdWlw
         ZY9vipR+Ntrk6gWzLViYmGofkWLi5E14rDplpiq0HgNSUoMDeXakLTX+8UkFtXLj5jKI
         kKZNHgVrT2ErsvbsnsgCVHKYHXqWsEIOdckz8u2+oDb08l9nob7yr8QVtkoig39WFDrO
         xjDXTTpqO5riwGZ1JW/x3/c+YJo2X+XOqw/O1EnJ8cn9tWSSgQs6zNB/H5ZoTmwtO7HK
         bpQA==
X-Gm-Message-State: AOJu0YwzWWHPEelJDFwAfftPpods+kpdEIujbqanV6fSIrcR0y7c/JCS
	hCPsBsaYND5IHt++aQYOb8eHtw==
X-Google-Smtp-Source: AGHT+IGsN1gYKfhSPZCpUVGbGKIu06D7uLG0xM+OZwtg49W/WqG56O+xCl6uRGYTfUcoNhDPZKc9YQ==
X-Received: by 2002:a05:6214:2249:b0:67a:52eb:7a00 with SMTP id c9-20020a056214224900b0067a52eb7a00mr10312900qvc.7.1701204584210;
        Tue, 28 Nov 2023 12:49:44 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b0067a56b6adfesm1056863qvs.71.2023.11.28.12.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:49:43 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alex.williamson@redhat.com,
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
	jasowang@redhat.com,
	jernej.skrabec@gmail.com,
	jgg@ziepe.ca,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	kevin.tian@intel.com,
	krzysztof.kozlowski@linaro.org,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
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
	mst@redhat.com,
	m.szyprowski@samsung.com,
	netdev@vger.kernel.org,
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
	virtualization@lists.linux.dev,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com
Subject: [PATCH 03/16] iommu/io-pgtable-arm: use page allocation function provided by iommu-pages.h
Date: Tue, 28 Nov 2023 20:49:25 +0000
Message-ID: <20231128204938.1453583-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert iommu/io-pgtable-arm.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/io-pgtable-arm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 72dcdd468cf3..21d315151ad6 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -21,6 +21,7 @@
 #include <asm/barrier.h>
 
 #include "io-pgtable-arm.h"
+#include "iommu-pages.h"
 
 #define ARM_LPAE_MAX_ADDR_BITS		52
 #define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
@@ -197,7 +198,7 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 	void *pages;
 
 	VM_BUG_ON((gfp & __GFP_HIGHMEM));
-	p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
+	p = __iommu_alloc_pages_node(dev_to_node(dev), gfp, order);
 	if (!p)
 		return NULL;
 
@@ -221,7 +222,7 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 	dev_err(dev, "Cannot accommodate DMA translation for IOMMU page tables\n");
 	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
 out_free:
-	__free_pages(p, order);
+	__iommu_free_pages(p, order);
 	return NULL;
 }
 
@@ -231,7 +232,7 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
 	if (!cfg->coherent_walk)
 		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
 				 size, DMA_TO_DEVICE);
-	free_pages((unsigned long)pages, get_order(size));
+	iommu_free_pages(pages, get_order(size));
 }
 
 static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
-- 
2.43.0.rc2.451.g8631bc7472-goog


