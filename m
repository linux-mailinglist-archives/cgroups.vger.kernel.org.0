Return-Path: <cgroups+bounces-1808-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D625B85FFAA
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 18:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BBF92886FB
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7111158D76;
	Thu, 22 Feb 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="kgWL7qSK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DE8156998
	for <cgroups@vger.kernel.org>; Thu, 22 Feb 2024 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623597; cv=none; b=Sb/FXLshNYoAUsKzxMdfR1yzlzvzBT3yIiN8IKRr7EQQIbi72wqZeKbkTvKPfKMRynaDJD/BxtiY3rRfeppdhrqLTsfXfvczrsAAO2NCPG2PpUw9bGq+mVxePrLC2jDRcf4eK8UX/R06wQccRfCrD/OfzwGzsV1vGydM+sJ86wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623597; c=relaxed/simple;
	bh=MO9zupR8uvU3mAVWpwjGwF/5I/sWszt0d3zRSJTo/LE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJJhtuCHU3BlTSAQ0LLYCcObL+j4GgLYNTE18sfAVzJ15khASztaKsQ/ogILIYe/GDV+5hvkGfpUi1INSz4LCRt+Z2AgOHNJa816sEg+p7oWtf7jFA9bdYMTdlYktZVAO91Y5va/PJqXWtHH0HKNXBvxx6b0JvX1Na8kYC99U2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=kgWL7qSK; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42e457b4edbso6211841cf.3
        for <cgroups@vger.kernel.org>; Thu, 22 Feb 2024 09:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708623589; x=1709228389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9sOCaXXTnuRzyvLt2S+i0eLigQNp6D64P7FATFt28E=;
        b=kgWL7qSKrkDISDWErtzFAM3YdEsISgMQN2Grsg1Kd3QAEsGtmDE266Ab7meFXa7J9p
         RF2I/rjuqMtR4EaXO0Ej2mM1b1LiZ6/+2XqmHdD3+1ond2x7uxlD+Xg1pla9jKG6GcJK
         x2IIZvTBZ1dj0xDslNyCe3EQIe+8kqKuk8ZUykNn2mP3gHVFzj42+R1cCYgcbMzwADjw
         nFF7YX7L55glWaz4rT3lcsy2eMOS84fSCQzWcACbWTc2Sm6dg8MAbpfbFZ7AHlsNHG6c
         8t2EuCyQrxTDERSIyKcLADb0mrUuAy74C5KxrHk7dV9JdDFttaLdCORsmgYH1geMsGcJ
         B56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708623589; x=1709228389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9sOCaXXTnuRzyvLt2S+i0eLigQNp6D64P7FATFt28E=;
        b=USDjHSMWuydCxOZxn6s+W+D5UbP5jSI+igFhKAjwE6y2Quuw36GfCo4A0mZfaAgY5o
         19foDiNJ5mh/jb097QiT9mStxSvkbrF/49YMqpD29okoRO5agksRWdygUDZrNYNkMPZ7
         T2fgliqX+ON3zKtZFjhhepfi2SdR0wOluXFLCnzZ+NwfyW2sfaWodNZe/8qR6jI/ev2u
         8/IVszDYlgdQE1F7Htb3VVjMyCxp+3dRUb9GVEdpn8BELxGjj/MPVMpM//2H1V9VoE4V
         c6/8x1shIOkTlLSL/oTEs2QqhOx02bPCqPkeQ5vw7zmUQGUMDEzjlHp6ZVgIIxdk6JMK
         h+bg==
X-Forwarded-Encrypted: i=1; AJvYcCW8vIv2bYqea+N2PuEQdWQv4r6rjdkGEyrGtecKS6cHokkcvKZ3JapxkUTNgwDGfqz4gW54aYfXabxR5cstWtUukV/IXqjUqw==
X-Gm-Message-State: AOJu0YwX24rHijplFn7btDTXNUPQx0yZMPuqSs/O8RKwhqkzcilLKg4I
	rZ+HVMm17YdCmSPVS9XcwDlktBtDYHoy/8nFRKDqf+dd1bk00YWFMwuPlUULD6o=
X-Google-Smtp-Source: AGHT+IEnNHT8mmpNAC8qGBK3waMn+7XKEftGRHH+gMR5BoK6c8bTMJMeqnbIkBxo5nuTApw4Lzgcmg==
X-Received: by 2002:a05:622a:103:b0:42d:b355:1538 with SMTP id u3-20020a05622a010300b0042db3551538mr27425174qtw.55.1708623589605;
        Thu, 22 Feb 2024 09:39:49 -0800 (PST)
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id f17-20020ac86ed1000000b0042e5ab6f24fsm259682qtv.7.2024.02.22.09.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:39:49 -0800 (PST)
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
Subject: [PATCH v5 04/11] iommu/io-pgtable-arm: use page allocation function provided by iommu-pages.h
Date: Thu, 22 Feb 2024 17:39:30 +0000
Message-ID: <20240222173942.1481394-5-pasha.tatashin@soleen.com>
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

Convert iommu/io-pgtable-arm.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/io-pgtable-arm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f7828a7aad41..3d23b924cec1 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -21,6 +21,7 @@
 #include <asm/barrier.h>
 
 #include "io-pgtable-arm.h"
+#include "iommu-pages.h"
 
 #define ARM_LPAE_MAX_ADDR_BITS		52
 #define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
@@ -198,14 +199,10 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 
 	VM_BUG_ON((gfp & __GFP_HIGHMEM));
 
-	if (cfg->alloc) {
+	if (cfg->alloc)
 		pages = cfg->alloc(cookie, size, gfp);
-	} else {
-		struct page *p;
-
-		p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
-		pages = p ? page_address(p) : NULL;
-	}
+	else
+		pages = iommu_alloc_pages_node(dev_to_node(dev), gfp, order);
 
 	if (!pages)
 		return NULL;
@@ -233,7 +230,7 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 	if (cfg->free)
 		cfg->free(cookie, pages, size);
 	else
-		free_pages((unsigned long)pages, order);
+		iommu_free_pages(pages, order);
 
 	return NULL;
 }
@@ -249,7 +246,7 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
 	if (cfg->free)
 		cfg->free(cookie, pages, size);
 	else
-		free_pages((unsigned long)pages, get_order(size));
+		iommu_free_pages(pages, get_order(size));
 }
 
 static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
-- 
2.44.0.rc0.258.g7320e95886-goog


