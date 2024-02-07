Return-Path: <cgroups+bounces-1400-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8858384D016
	for <lists+cgroups@lfdr.de>; Wed,  7 Feb 2024 18:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1767A2810CA
	for <lists+cgroups@lfdr.de>; Wed,  7 Feb 2024 17:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD52127B79;
	Wed,  7 Feb 2024 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="arnOFxU5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA37786AD4
	for <cgroups@vger.kernel.org>; Wed,  7 Feb 2024 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707327685; cv=none; b=I8N4D06yRJGWBGQ4M4WvQfq2VP2PJiA5Yy5TEJVrfA8OcFPy8iFwjvaW0aSQIubQ0bsHz8WiTzfAupi1sLiB3ib8QlyD2+Mg3R6L2ruS39IGlup/bE6Vb/RGh9UFEuqKqRGO4jrvAsvVIrbs+ZNmc5ZcVqT3ib2RYYmHmgi4S34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707327685; c=relaxed/simple;
	bh=PHns6xqLyHWVS2RFXaEsGlNTnkb0vFPfE2pekEJ/kfI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUonKjjZqg3ukW/CcO3YtJVHK0cdPpdgAuJWiJH3lWJvyE91EPg6m1Lr/s0P//DWlWmE09I/X0T9k4Aaa0LAscgNkzusADMDzAC0rnrZkvVgzQCRkS51xW0akcItZpw49XHzVkiWg94rVzn96voBhUcA4a/PtdP7LWA5n3rofTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=arnOFxU5 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-783def87c8cso46581085a.0
        for <cgroups@vger.kernel.org>; Wed, 07 Feb 2024 09:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707327680; x=1707932480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrRTSlkta7nD8c1SJPx3AxPn1tn9y9LkFmhcOlF4lks=;
        b=arnOFxU5cn85jYFGkJUyCJxEvYG2g4lb29V0lw7lYx6dhVbOMMj1ZJLlqlx++DPplJ
         iilZAVjOvPgm///IjM6he5GyyUZ7k3FcvE1QswXro+J9VEWwR1FGRxzCU6YM1IfibVR4
         YrLd3Uzl+fzzLH/OijQWbSNVnurl9YVsX9kotUtzYq11B+3sbIrdtPD1c3vE8qIvxeHj
         m3+G8hf4JtneUetc3xoxy4KLQzIMQFKKPE2tnD4nga1XRdrJaxP8+zoWuFrqGuEs9wgn
         vDi7CaXbMmWjW5JPft9hlCObEl5wpy78Zo/G3gbKEUbekgswPzzmphP7LisVOoqurr6t
         8Tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707327680; x=1707932480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrRTSlkta7nD8c1SJPx3AxPn1tn9y9LkFmhcOlF4lks=;
        b=sY8VIdkWn93gsy6PAQbtjRwhAtLpTkuO5vBda5BqBfejm7aI03n29kqQwbcsEdaqSo
         jwUgjNVDTJIb7ALBczH9EeqgjQL0cs0y5tHk4ay6AyTFDPapmi/F1t/m7vCazSGaB+TG
         hJaZfvkyvj+4lMIGWzN/nsIlOTP9RtS6Bn4FgoERWQcJqrgTub3qJ0ZW0F+RXUtVJ4zu
         XwQvlpUg419C062pTxAOBdiCoDp6b7Jab29bfMJD3x3x4PnLnDaBF7pMSM5JaDxpEHWB
         Uj1OhHMnE4mPV9P0N1Go+YjpkdnA9WwTFyZsZWbAYvIOopPudpI8vvaT7ZV7Cu9g2DD2
         jh0Q==
X-Gm-Message-State: AOJu0YxYLGbXdP4+9KtVrBPWA8ZMpcaOzeJKTi74x0qFPnDuYUCWRLjF
	q6+x6tEPOciXPCIROwV1W8+HZTwR14ijBgV1AOq+Jqo3s0Tnp2FNaPWsNSt+rMc=
X-Google-Smtp-Source: AGHT+IHhb+pueaISZV6Y8tJp2t2CFo0mWlpmACo7IYuyoV1N2oy7KZrIG0XVhtVG+SmB5cwuhpqy+Q==
X-Received: by 2002:a05:620a:12c8:b0:785:3887:de18 with SMTP id e8-20020a05620a12c800b007853887de18mr6401324qkl.65.1707327679899;
        Wed, 07 Feb 2024 09:41:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCDfKWFIl6QUubNKHOK+J/TQZfBk6GOATQV7+UROelHHizxj2bMScNb5yjy+7wEKvrKAVO938EhFK3MDp4QvVuIEMns3aJNEfZ4lLhVczSUx4hYdn3X7Qx8HTpAiobpDi+dY9UU0JFYWP3sxFQVS1xxl7fcBVSx0blttAqIQWkGbtG/8OFxy5YJX+xNhtsJb3t9pvZsef+YcrlQh+9z7K1HEh5YIvRBqpPod3dD8oKW9DDybH9+3HAaHHBY8iiIHdHyvvhg/Qqh/tY8U66rdo6r4QvsxgmBFMyxznrxlOPKUwMUFVhM2YvFghVr6hKgb6KzPzIvg28q6LrAw8lD7weD0eI2MrfirCmooqnAA/zgK7D0KurMOIDpabn9VkUHuhE88OEKQ8h62/Wa2gdcl4YDdMkJY4DDjELGulQmsDVBCrUtil9loYc5aX8Gh2jq/ztHo3kv5ymJnfZ/h7e7WZdfaZvxSbUL64wc23AYR/EczgayCdZpmGXX2jQE3/KPfSIPAL6DXV6qvHIwUWL4vG18mc7tiVYDE//uM4hJo7eMbISiBgH4sundju5RQWqxyjeA3VcVHj+VPU4vBDpsrZVdnHRZeaGTV3rwC8oZXb19D/7KR1Wm7euJ76N5bgFnA7vjZhfsEp+F03DZsEUpCkkLYMsxrQWrLbAZIy488QP+Zdz41QqcwwktLByJIdIxAeRSxHxin8RRSgrxaqXRKius9NFl4oDbRCD6svZoHMd4UnX0vfYrQ0s8umvFi83/7gbRVCzXY4TP8NJFByhRuhTVTALB1EBu6ny+PtNXEQLdFexeijpQwT5/ahI+mpZ9ajMM7oM3At8FGk5pnU/BL1Nonz5Y8fjdV6tPG/C5Zk6RhURg9qAf+9R8Omad1eFWXxT9K6yqaix3pq9xGAZ8o3pF+xFI149xhPQNCmvLnHRgEmJUeIIm7boC4KgdrC5bBoaux
 c6ozrLySOAxoy5JAAUBKnlhPctpWnwmvtfHeBXAM+mRt1+c/cu3MhP0MSUMt9WZHns3r/985c1KNIPq0blR6t+yh5SOQk7YDqh0wPxUpt4Kax6NjryE1iCgR1+E5QeDElNdAVf+hiKcPe5+DO4dGivJK8C2DQW1E5U+dX94X2hiWwHcHd0IHOFqpQBMw3MYyXVibLuxNZq6E5ml+47r+bMOyL/Bqfi3ViLUhztHQ6nikGjlZcsJYY7JUssc0W5vg58IiiHspK92+rwN2jGd4sH3ALx4bgyCF0SF9flcBEtXUjRUNSmob4ETrVkz7HKMS7If6nnJcyM0Vbo0UMoOZmd5knYt1xz+hu+YULQesXnetGwV4BBbVo0WA5dRc2eIzIsQXmdql1aXqiSjGCn5mug3+d3TEVV9PvmDpKEou6WN731U4KQNAZjHoQUf6UFZNlFysQJQPL4NE73c76duMdmUXiGxzZFehKgNvB7y4Wu+1/j
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id e10-20020a37db0a000000b007854018044bsm696310qki.134.2024.02.07.09.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:41:19 -0800 (PST)
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
Subject: [PATCH v4 10/10] iommu: account IOMMU allocated memory
Date: Wed,  7 Feb 2024 17:41:02 +0000
Message-ID: <20240207174102.1486130-11-pasha.tatashin@soleen.com>
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

In order to be able to limit the amount of memory that is allocated
by IOMMU subsystem, the memory must be accounted.

Account IOMMU as part of the secondary pagetables as it was discussed
at LPC.

The value of SecPageTables now contains mmeory allocation by IOMMU
and KVM.

There is a difference between GFP_ACCOUNT and what NR_IOMMU_PAGES shows.
GFP_ACCOUNT is set only where it makes sense to charge to user
processes, i.e. IOMMU Page Tables, but there more IOMMU shared data
that should not really be charged to a specific process.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 2 +-
 Documentation/filesystems/proc.rst      | 4 ++--
 drivers/iommu/iommu-pages.h             | 2 ++
 include/linux/mmzone.h                  | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 17e6e9565156..15f80fea8df7 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1432,7 +1432,7 @@ PAGE_SIZE multiple when read back.
 	  sec_pagetables
 		Amount of memory allocated for secondary page tables,
 		this currently includes KVM mmu allocations on x86
-		and arm64.
+		and arm64 and IOMMU page tables.
 
 	  percpu (npn)
 		Amount of memory used for storing per-cpu kernel
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 104c6d047d9b..604b2dccdc5a 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1110,8 +1110,8 @@ KernelStack
 PageTables
               Memory consumed by userspace page tables
 SecPageTables
-              Memory consumed by secondary page tables, this currently
-              currently includes KVM mmu allocations on x86 and arm64.
+              Memory consumed by secondary page tables, this currently includes
+              KVM mmu and IOMMU allocations on x86 and arm64.
 NFS_Unstable
               Always zero. Previous counted pages which had been written to
               the server, but has not been committed to stable storage.
diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
index 7336f976b641..e3eb93857a73 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -27,6 +27,7 @@ static inline void __iommu_alloc_account(struct page *page, int order)
 	const long pgcnt = 1l << order;
 
 	mod_node_page_state(page_pgdat(page), NR_IOMMU_PAGES, pgcnt);
+	mod_lruvec_page_state(page, NR_SECONDARY_PAGETABLE, pgcnt);
 }
 
 /**
@@ -39,6 +40,7 @@ static inline void __iommu_free_account(struct page *page, int order)
 	const long pgcnt = 1l << order;
 
 	mod_node_page_state(page_pgdat(page), NR_IOMMU_PAGES, -pgcnt);
+	mod_lruvec_page_state(page, NR_SECONDARY_PAGETABLE, -pgcnt);
 }
 
 /**
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index bb6bc504915a..a18edcf12d53 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -202,7 +202,7 @@ enum node_stat_item {
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
 #endif
 	NR_PAGETABLE,		/* used for pagetables */
-	NR_SECONDARY_PAGETABLE, /* secondary pagetables, e.g. KVM pagetables */
+	NR_SECONDARY_PAGETABLE, /* secondary pagetables, KVM & IOMMU */
 #ifdef CONFIG_IOMMU_SUPPORT
 	NR_IOMMU_PAGES,		/* # of pages allocated by IOMMU */
 #endif
-- 
2.43.0.594.gd9cf4e227d-goog


