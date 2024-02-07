Return-Path: <cgroups+bounces-1394-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B517D84CFF2
	for <lists+cgroups@lfdr.de>; Wed,  7 Feb 2024 18:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406D21F21820
	for <lists+cgroups@lfdr.de>; Wed,  7 Feb 2024 17:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8D88529D;
	Wed,  7 Feb 2024 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="EoUOPJZq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEFC82C6C
	for <cgroups@vger.kernel.org>; Wed,  7 Feb 2024 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707327675; cv=none; b=ac5tThObS9KvS0T1vfWySZLCqNsHgAsuP/VqdK0Lqgrf3ICRKQTJNlNbd99BFAtvLkwCmf21AQ6Xq16PAXEN5L1LxCOaA37rMOM7jhRh25ftgRyEAEgKoACTtVyShROC4pQEeFc/Zm3HyED1YXctRYfWRfvlItCuNqCtLBp9dp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707327675; c=relaxed/simple;
	bh=AyDhKMG7S7cQfjgGw2PWtIuAn98wOXnvamJdaOq8UGM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogGfBkFTPnhG6Je8mpyyR87ANKPTsjKZvKZN3izefzGpQA1i3wrXBkl86yhtWK89GGgvFb2OOys1kHb7xGNp1yTNZSwnVCZ/VB4tf4Vn5wRIz5kocuTWQMkVMMtZ9q1vJwaZIIv4QpjvAGtw19FqnGaHQUY7I8tdlrKR/3drkzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=EoUOPJZq reason="key not found in DNS"; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so578098b6e.3
        for <cgroups@vger.kernel.org>; Wed, 07 Feb 2024 09:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707327672; x=1707932472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nU1hsaMMETz5PI0ifQcx6wtutKo5o6JsITK4WP9xIfM=;
        b=EoUOPJZqjuAK0E8FFZF6cnpWhyYIZx0BM2NXr2TZ/eeHYhVkzw/g0dW5xIyexjEXYR
         ndNUgaAnnKW8A92RCLkS4+ekxz3SrWhtP+kXHGCJPE2cjtXCd98glsuSQu9MCTG78P7z
         oW2OuSPaueZ/bhUftZC6xIPx2imZGPhKhtTGQr8yuvTEp1SHbO+R3aK7JiVhDFEtQ6w9
         irzYHg8LINtzoxlQGoeaPoJ6Hgmw1AL0uW5H56CFiy34M/pDg9UnRmvGW/iQwMYCKgg1
         bnNzPLamyo4qeZnPJUtPnKyRg6A5y9fE/UteyBFSlGqlfIGzCcry6jbWaTvXNbzdzG9i
         NsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707327672; x=1707932472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU1hsaMMETz5PI0ifQcx6wtutKo5o6JsITK4WP9xIfM=;
        b=J4ul2/R3D/cWAERXOBhjwHoEln8yx+v3PE5PsZ4/4oSc9smVESVWLYuvg7lsMJEiv+
         wxCc1DmFp0rvj2Jk4D+rZ2Dt41rjFS+lXz/osVTpaP0iMqC2BpJ72y2p/3Y+NPxV+isb
         wYe7Ms4ezAoYgwr7zOAbqmG4pfG+PCigCPn4mZT/kHOAf3Rbg01W+RyieCt0I/Og3jmI
         TthvriVs41BX1exv1lPgsk8f0B/z15Ihm79U4EiE5eWi7kJJjnu5zkoejL+KwrPFojJX
         AQtceJoZIawZsRSnPH5siIhOaD/U7GDfh7YqS1HcX+3dv9S0c8N9/RDF1DRE1uDoPioJ
         Gc3Q==
X-Gm-Message-State: AOJu0Ywq8yBJJmBakqoXnaZxKsI05FXYMJ+rsfc863T10N1hi93Jk7aT
	AMV7A5dbu2bVnnYeWY7WDrraIB1PDPYaZc7N4ZYFYp0FPuHFqK2D8zjjSKJSJtQ=
X-Google-Smtp-Source: AGHT+IFfEVUCKzT5CwUfTWDGYwi/acQYuhOxMwLwTqPmmzQgMoM1RPknF1EO7W4FpUIP2TDEpv0nmA==
X-Received: by 2002:a05:6808:170b:b0:3bf:cd78:6759 with SMTP id bc11-20020a056808170b00b003bfcd786759mr7147363oib.54.1707327672178;
        Wed, 07 Feb 2024 09:41:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZFB7U9B7PRWrPSa4Vm9JmfrqIfgvQmXJpEOBtNUmvSOjpwYquO3trQQgAz1YG9ML/HHjiBiy6VD9fRFGt91lhuf7+nYjR4rQlDPNeLxvlF7lf5fsIURb6D/+FPxIXEfNHePjZwnf/eJKPk8N4hejgBf9CgxBjRH8C7zoRBr70yQfJMx+T+z8aHOmeUBJfXbUrOyuqrIB/jOTCZIIPUxodCnNa1HjKcJxAaMlaebQghiZoxFazuVbzaancHHc0RIiOoAgPGBaVoCWC9ZSqEacGLMMVR4oUYKJob8ZjjrmLluN3Gm70Hp9p8E4+If2Dz/WCStrviHsRKJYQfwIJxjmgQnEgQ5lpg+7KBJ1NyE2I3J0fCX4nG5vqXgnpOARX2y9NWm1phXJf1JYc5/Oojpc0G5y/8V5o0yHcg73qI0YEtASy23+RxEI3SR3SJ8lVgg6RymMoVips177XOLYq6YaZjGnJzDqUa0QaF/0yvsAw1A1WMQVKSBhnl80xpbCHUp/AngwVe7DX3D00A2BcP/JC9KlEJSWAjruJ53zMgT0EAnEVgDNEu553g//Lqlo7rAS9pJ2BzEyAw7MRBh3zcmKCnIsh8VtTjh+jxgZ0T0y5RyB8UZC9WdMH/ywue7GfpHzx4WMaLAB1fPOK/jnCnItRzlZE2cnR6+UcobUeymHUia9MinrA42aJDGwz48xLeZUapI6z3XaSjbDqNA6bu2hwarQQHP/o6+CgxfItlyueY2yKNinbbQ3sGtjYVyJFpr36wZHL3Im3jTbCJhBhywPdZxuB92WxvF09LB4AFcM2ZSs6j1NCGbUgVlYH061oIVzrduqppQBTG7pKegtnxU77zowM9wwgFdby+9EWfzCmujL1sJ0k4aFxPhY5ZrgmQhCxiLHTwSSHD6bSZmhB1GostD0qm2aczbx36w/TWAN3T0NYTrysQg6sPtb2IO9x18Eng1
 YnIK0trnAheCgMO/3csZdfTu2FEA9Y9+tOJBtd0Kvu9kmJ01kz7cZ1+TY91LWy0W7NPAgrABtVr3uIriVrWIUS74fFRAWjk534ed/073Z3w8fm/dfgqszqf3hNAFXNLaKUjUlzsDxGOB2dhzQEEtNloHFSHvL9wtNSji6PcpYZC4Bg/W/kadih/Qh75sYZqtohZI9BMa2rYOLzNHCCy+rUAlKvhROT19ZzyqSb1BeoKi76qoL+qcgp96Drr0FjPc641vD7GlZiZcBKiOR5Qp+pJOxYhfqNe75t5Ma1xpvmJToVXrNx4f475KpOmW/LBYXSiN9TZX3XEhD6Wo9gSGAkZbyQZHNbpp88as+ALb1ZUQCQ+hOh414MHuPZKbmNdlt+6/7W4P2qOp/U/IiG3Xg0qHla/DOU+J437gr+hBNBiHCguyxl3s04AH/aHOLV4MCYYur/xHb0eZWBCD6XhOuBZv9h8Tj/knG/C05njAez74oc
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id e10-20020a37db0a000000b007854018044bsm696310qki.134.2024.02.07.09.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:41:11 -0800 (PST)
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
Subject: [PATCH v4 04/10] iommu/io-pgtable-dart: use page allocation function provided by iommu-pages.h
Date: Wed,  7 Feb 2024 17:40:56 +0000
Message-ID: <20240207174102.1486130-5-pasha.tatashin@soleen.com>
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
2.43.0.594.gd9cf4e227d-goog


