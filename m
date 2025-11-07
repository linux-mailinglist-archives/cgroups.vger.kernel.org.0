Return-Path: <cgroups+bounces-11669-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF09AC41E0C
	for <lists+cgroups@lfdr.de>; Fri, 07 Nov 2025 23:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C44F4EB59E
	for <lists+cgroups@lfdr.de>; Fri,  7 Nov 2025 22:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DBA314B7A;
	Fri,  7 Nov 2025 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tKXxgKOL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207D4314A90
	for <cgroups@vger.kernel.org>; Fri,  7 Nov 2025 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555808; cv=none; b=pmSYHhd7LvtEnVuPXQn6x/L1YP0StocddY2yhlErGeZ7iRgYuWEIED+7KOIYQn03MNZo6pMBCaeIqCc386eWcvTSbXhKIdQtALoUJmneUFHgrVUq8ChnX1CZmNTuPT6njcoOfQJQhAW7/s6ujMIdcviUL06SQd7X6PCZTILxO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555808; c=relaxed/simple;
	bh=UCpXheq+ISF5ooL3BArG9j5Ni7nrQ94FnST2TGVI9qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSHHjeENdhu1Y+iRwr16xbkAVPGAfxOWN1CuOC/WJ4BM2WiyP57p+vQgnZ080/DV+2ey/vXNohc0xrJH3kuMf0dT6251SIZGzwYR6EoGaANX6vju70Hyfdi02yXJon7biVPzRG6SA4eFNGmLhoVFYz1fNbxV2tnKi057ODeROBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tKXxgKOL; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ed8e22689dso7654231cf.1
        for <cgroups@vger.kernel.org>; Fri, 07 Nov 2025 14:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555806; x=1763160606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCHR6ylRLZZ9pqd+jMer6/IGdndwoE5PhK5YE6dS19U=;
        b=tKXxgKOLQJx65x89wlHUjXEms19V2h4+fJag0WnIJD5oEG/ILVml5bMn3kzA7LHKDD
         LoQdZb79TEU0fFHEdNl4l22hrCtI6XV8X/jowNCQvk0BBSWLp7FemAeYB11k0uAvNb7V
         lgfICkxQx5DM7N94uYFET8BHEPw5QZfJIzV8alY5IYe45jTno/a5NixiBZ1VsLouSE6z
         k6i4CxCDOAQIkmBhb/f18FuKH9Iu6OVyW7xn5oYvaATF3mWOYCaHW+Ytm/K5ENzoTYZ7
         3wiIgHSuVrFFM5Gic9V9B2gxUDC60XHGkWXocxp36ukAuwShuqz/V3LH8hgfXHKzLCF8
         d5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555806; x=1763160606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jCHR6ylRLZZ9pqd+jMer6/IGdndwoE5PhK5YE6dS19U=;
        b=rvAS3GrwNFlP00IZbSwhQVCdT7/NA27gCDr3R4v33MgfYub8QOUAuFQLNmkBpMDgDh
         J8sSN99GMLKt/1lafdXNm+QSSUo9rEKAHqNG7pOOUJ+yjHaIXU1nU4OtNW6qa4af6lkB
         ORO+k6iJLlmNN/9aUbRJUXC0OT4HSu6mNv0N2pZbrRhXg8BFV6HQy7J+C9HRVLFhEh+e
         RZUKa1vqTKW9LmCQ9NgWkOf5mioVW795eglGPwM6WchTwIOKQ06JSoh7rcAIQWPI53Ef
         7CeqiDMeKd19AGmih9sExAzBx837aNa13/RIcUyMBkr+JBW5NnCUT4vrCcTbYHmnyb2y
         5/iA==
X-Forwarded-Encrypted: i=1; AJvYcCX21e6IDwIzINMeTZVwieTtIZGds0X2XTzvicMp6kI6hwcYjUQmoeqsRFOxo9ciIaDsgg9b9n4L@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2AtxDNxRiaPDqvhDEhChZxNYqAWv201PLCfbBn7TOJmZAyW9+
	dNpeoprbyZjHAZ3vTjg5tFPm1NV0pUA5GbNQTa69IHjFy1P5frfC/Xd1jRgaCHKa1DQ=
X-Gm-Gg: ASbGncuNAjW8lpCBBrCDELFiBDRuCXizxoeXabUXmJA1QpC4FVvGRBVtX/WMxm2ipSz
	pw3QXSHj9Cb3m/I1CSBMHtReb+oeKzrY6Wg50H1eWgzYNRIDQGCrUEe8OcZ5Wm+r4SdfjvycNae
	oAYjuq8fNu7Lb/1E4xIdoYiajvHOg9I58jQUlBJlw8Ozuwn6Hhw9xmI/dksbKqzHctZx0OBnxF0
	9T25xe0EOQ7gk0NH7QqnV95U9I0hcvjziGMGDXi1YTt6ZO9MicOx6Nv2xuiwfdmtCfa0bgaBnax
	15i0SoNq2m9h7PoJd3QdPYRvlfHeNgYiZ7LL/F3LRiQ4MtkchE+ZNDCiCrRkx9BQCIypmg6xRc7
	QtC1/mdu9fgV2cosZ58km6i3ny4UN9YJBN/cFF9+3VlrNd3iqakO3Reih4BFXnratutVXJrI0o9
	/+3w6H1r7ta5Fbq1txeLnJkXvIR+VCVHp5LzVrLsvtrkpX15zOHyPnUzBThy+nfukQFpz/EkJUj
	CzXADjE+TKsaQ==
X-Google-Smtp-Source: AGHT+IFFPECdAOsGcbR+MEazzzIO7MJP4xCB0/B2/FxsL9mdOEjwM8IeKSGUWcVdouQFvc3wSAz+tg==
X-Received: by 2002:a05:622a:120f:b0:4ed:6e79:acf7 with SMTP id d75a77b69052e-4eda4fa468emr10231361cf.41.1762555806006;
        Fri, 07 Nov 2025 14:50:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:05 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kees@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	rientjes@google.com,
	jackmanb@google.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	usamaarif642@gmail.com,
	brauner@kernel.org,
	oleg@redhat.com,
	namcao@linutronix.de,
	escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: [RFC PATCH 1/9] gfp: Add GFP_PROTECTED for protected-node allocations
Date: Fri,  7 Nov 2025 17:49:46 -0500
Message-ID: <20251107224956.477056-2-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107224956.477056-1-gourry@gourry.net>
References: <20251107224956.477056-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GFP_PROTECTED changes the nodemask checks when ALLOC_CPUSET
is set in the page allocator to check the full set of nodes
in cpuset->mems_allowed rather than just sysram nodes in
task->mems_default.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/gfp_types.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 65db9349f905..2c0c250ade3a 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -58,6 +58,7 @@ enum {
 #ifdef CONFIG_SLAB_OBJ_EXT
 	___GFP_NO_OBJ_EXT_BIT,
 #endif
+	___GFP_PROTECTED_BIT,
 	___GFP_LAST_BIT
 };
 
@@ -103,6 +104,7 @@ enum {
 #else
 #define ___GFP_NO_OBJ_EXT       0
 #endif
+#define ___GFP_PROTECTED	BIT(___GFP_PROTECTED_BIT)
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -115,6 +117,7 @@ enum {
 #define __GFP_HIGHMEM	((__force gfp_t)___GFP_HIGHMEM)
 #define __GFP_DMA32	((__force gfp_t)___GFP_DMA32)
 #define __GFP_MOVABLE	((__force gfp_t)___GFP_MOVABLE)  /* ZONE_MOVABLE allowed */
+#define __GFP_PROTECTED	((__force gfp_t)___GFP_PROTECTED) /* Protected nodes allowed */
 #define GFP_ZONEMASK	(__GFP_DMA|__GFP_HIGHMEM|__GFP_DMA32|__GFP_MOVABLE)
 
 /**
-- 
2.51.1


