Return-Path: <cgroups+bounces-2460-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A7B8A3938
	for <lists+cgroups@lfdr.de>; Sat, 13 Apr 2024 02:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740441C2161E
	for <lists+cgroups@lfdr.de>; Sat, 13 Apr 2024 00:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A845E1C6BB;
	Sat, 13 Apr 2024 00:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Qf3BFwBr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8ADFC0B
	for <cgroups@vger.kernel.org>; Sat, 13 Apr 2024 00:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712967936; cv=none; b=M7me75CfjOq3kgtKp/JMLnMmG1wB4urHHtT6cKK0fRRrZpT/GQiI/Z1EotAgiNqoWh9AwS0EGpfmzU9BPnNpru1O74nblmUhTBTPM2oND7bu2rmq/9UQpCc80Uc2NVuhKZVJha9n9mPUVI5mos1Z+ygj/7OzjGIzVYCWWVaPPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712967936; c=relaxed/simple;
	bh=Nx3bZRHaQNwraFlQZI3/durTvXjgqwuVRXLjOZZduHE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1q54Ijqm6wrn4tewrGvk15Ffi+udRauZMjDbGcQcgdGnwqpNFUvhKCUNAhuFaahlWCWNzXwZrMsH+DMn0fwC6abNiwuuR0Doz/NQmc+naMUdGQcwS/8jyEJnSzr6TqA9gaXoU5w932LfZrq3tHC6dlfwMxAam6K9E7HXBn3GAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Qf3BFwBr; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6eb6b7094a8so158958a34.0
        for <cgroups@vger.kernel.org>; Fri, 12 Apr 2024 17:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1712967931; x=1713572731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=63yVyQgEqo2cT7rWVkBtS9/N+xrka1mo9DBNzoSqbsM=;
        b=Qf3BFwBrh3fv1r3ipcVW/a8PR95CowPi7dVBuZ+9QO7+cK4pSnQ1yjtdeHWJ1QqzWu
         T/CSRuw4wIaC/+2yPfRNWQvCS4j+ygKcWMg0Zcofbqf4XNu/QDQ9u17uU1Aeyma1d+TE
         d/M1NH+drpso73JCTVG25+Cufdt91tbo/UDxm98EQpfjX8JNc6GopsIAqU1l+qrxE6Ve
         KVxoStl+gk9KTJQwjzqqH7Lj0UdrxsE3/cM+QOIz/yh5ZewuLHW7j8W0a+qr4M8IIDXk
         DbkZswpU2EgUKtHH0vZwmBmON1DpHrm7jYdCY8FxG6XQRNA/NmMeRH7wdvQiGankhh5R
         aR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712967931; x=1713572731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63yVyQgEqo2cT7rWVkBtS9/N+xrka1mo9DBNzoSqbsM=;
        b=R2LFIQjwclXoaU/yB8JaWRCRvBHLDz4YlA47Po1KltPFdc1W+a25Sz7FIgtsXbGxTl
         t4E/n4pNO1xUPVbG4g6J/MPAXRfqPlv95MbO8hDVvh+3s0HlNqNvEcer5CQDY5O8QBfy
         Lz+1ZCIyUu2r0Po+tc7F/6j89x3se4ozxjRLQBDP7x2rUJR/I9bqYV5rUdlU99w9kuVS
         Yazd3IoGPOOtnrDl8hrFPKMESWk1Rs8GvsgAr3tX9QvRMdWanVs+dVaHLo4oC7q8sM1Q
         11NVrwLYeIGhFNJKR+35Yt1Jn82KyEWB52dULMOFb6LhgkfbP7ZvrEXTZ5uxkFPzRCYB
         wo1w==
X-Forwarded-Encrypted: i=1; AJvYcCXClLktxt5gmLOsPrX6nPLJOzfGeOopsxXrw4FzGcDmx5/kZ+2y9I18hJkoVEGbwRYPq49Ry8Za+L5aEnkTeYQGlOBIeOCJYA==
X-Gm-Message-State: AOJu0YxLIb/m4N8gLWYYYBm5KYbCkzqiv+Sfc6ziZv88EyuoNdNAjaTg
	h1Gi/7Yu+5bCuYEo865Hhyo4sv8NsnUREFwZdT3GmdotrIXZ8RcAizYvguZzP6Y=
X-Google-Smtp-Source: AGHT+IGmmSLufriFZ7xkUlQYwmHrJvWk6RRFIShCPmF9PtgFnBnMl8wu2EFFWe8ZzLIq79vC6G5l9Q==
X-Received: by 2002:a9d:4d87:0:b0:6eb:5654:d77f with SMTP id u7-20020a9d4d87000000b006eb5654d77fmr4234028otk.15.1712967931426;
        Fri, 12 Apr 2024 17:25:31 -0700 (PDT)
Received: from soleen.c.googlers.com.com (128.174.85.34.bc.googleusercontent.com. [34.85.174.128])
        by smtp.gmail.com with ESMTPSA id wl25-20020a05620a57d900b0078d5fece9a6sm3053490qkn.101.2024.04.12.17.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 17:25:31 -0700 (PDT)
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
Subject: [PATCH v6 06/11] iommu/exynos: use page allocation function provided by iommu-pages.h
Date: Sat, 13 Apr 2024 00:25:17 +0000
Message-ID: <20240413002522.1101315-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240413002522.1101315-1-pasha.tatashin@soleen.com>
References: <20240413002522.1101315-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert iommu/exynos-iommu.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/exynos-iommu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index d98c9161948a..c666ecab955d 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -22,6 +22,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
+#include "iommu-pages.h"
+
 typedef u32 sysmmu_iova_t;
 typedef u32 sysmmu_pte_t;
 static struct iommu_domain exynos_identity_domain;
@@ -900,11 +902,11 @@ static struct iommu_domain *exynos_iommu_domain_alloc_paging(struct device *dev)
 	if (!domain)
 		return NULL;
 
-	domain->pgtable = (sysmmu_pte_t *)__get_free_pages(GFP_KERNEL, 2);
+	domain->pgtable = iommu_alloc_pages(GFP_KERNEL, 2);
 	if (!domain->pgtable)
 		goto err_pgtable;
 
-	domain->lv2entcnt = (short *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
+	domain->lv2entcnt = iommu_alloc_pages(GFP_KERNEL, 1);
 	if (!domain->lv2entcnt)
 		goto err_counter;
 
@@ -930,9 +932,9 @@ static struct iommu_domain *exynos_iommu_domain_alloc_paging(struct device *dev)
 	return &domain->domain;
 
 err_lv2ent:
-	free_pages((unsigned long)domain->lv2entcnt, 1);
+	iommu_free_pages(domain->lv2entcnt, 1);
 err_counter:
-	free_pages((unsigned long)domain->pgtable, 2);
+	iommu_free_pages(domain->pgtable, 2);
 err_pgtable:
 	kfree(domain);
 	return NULL;
@@ -973,8 +975,8 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 					phys_to_virt(base));
 		}
 
-	free_pages((unsigned long)domain->pgtable, 2);
-	free_pages((unsigned long)domain->lv2entcnt, 1);
+	iommu_free_pages(domain->pgtable, 2);
+	iommu_free_pages(domain->lv2entcnt, 1);
 	kfree(domain);
 }
 
-- 
2.44.0.683.g7961c838ac-goog


