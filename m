Return-Path: <cgroups+bounces-2093-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6964B885DEC
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 17:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E875282062
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 16:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFFE134423;
	Thu, 21 Mar 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbIJR/q8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6254B1A27D
	for <cgroups@vger.kernel.org>; Thu, 21 Mar 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039048; cv=none; b=bIhD500emWkuSdyLD3JkaQjXBquTzv60GjM/Flpgl6EOY4bmmHm5+kq1tRYQgQf4zDs4pLgZtd32dOK//3kIePHFYGIl9C5h7aWej9W5pe7wXiICC+ZWqefTZwzzVIMUK3LS68pfRLgSirnhBfOmPLACb+5GSCtpyZkyHkyPW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039048; c=relaxed/simple;
	bh=FTfpkMz7knxr9PqAm/DqbYAED2rQQG3uETEf+9W7BLc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r98bUnccqnogpvq+m625KMTrQOz92UwawRNQQFROa1cIzjXrq8Qh/lpfkpkE/GtAsU+MQXDTWUrvLaqb0HwR3wZI7lwgKX8HgdEnQpDO1/AB3evEFEldbbLIiFwrI/VbnkaJzOPZgzWsUWXjOavZpnCiC4rQZTgKZTLU9Z9M1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbIJR/q8; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a2386e932so22611537b3.1
        for <cgroups@vger.kernel.org>; Thu, 21 Mar 2024 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039045; x=1711643845; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WOYiJPoOo6EZ1v2aVMfBUZhNa7dlHF73f/fDRlekI3w=;
        b=XbIJR/q88u883eJMWJlL9qorr4Q5+ewvfriJb0VMGeF91tlbGowBNb/0+1qYjCsaFF
         GjQ/MBJsA+YbgJWQhVVmylNbzrEAwwcZzyh+C9Cp0pDfWCCw9cU4ktJ74FB4gbKpJqPL
         EaGfYdjXMbCQLtCLafzicbvOrWPi7ka5REbzp4QNgHVgHcNsGGvLLOK69BKx1WzGa8Nr
         gslz3I5UqWwSoXkMzMUTn4kR7O7ySZ2RdxMleVSUijvDybPWHSCz7Y6xQaziC6PJFhL5
         H7jBpKmIXFO22iUk/EMazdQodpUDTDVRh4VsiMfy1/sRqq0xAnSONI9oCUzeWH+ocbZC
         1i1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039045; x=1711643845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOYiJPoOo6EZ1v2aVMfBUZhNa7dlHF73f/fDRlekI3w=;
        b=V8TZm62a5904QHLxb175e+BFhGgoVr7fGsGDGFvstX6hMTlRajrVfkUpF1IbtVdw+9
         J0tNRfONrztnw9piYAaYFFPPO1ftddeb+M3XOMXOC0emcwwlwmB3rd76w+i2JqlotC0T
         zxb9LV3GIVHDf7i/ogUYOJ5W2x4JK9ZWXWmDfRuzfPC/GR0VRSty/ztrcGE3Y58iWHW9
         curLR8lU2lWsPPLoyrHNx44z1utXj8by1XpLQh6CNYG3KlApxgzFR+2qzF9Itzq7bgwI
         H3o0bQKOiGWbv7EgpqDpEG1dIha9YMroeWAhDFT+QFRMGVa0RLcfTn3E1hr81IDZCa3X
         JiKg==
X-Forwarded-Encrypted: i=1; AJvYcCUR+ucURkXYG/WqLzSBjnqn69Bub/kjLgISSiUlR6RDEV2Ifi3HPqSWKRDvHIuvXVpZccaaXjTHOivLOyh6kqt4/45XrXAcgw==
X-Gm-Message-State: AOJu0YwOpsXkXkzTD4sm3p/fAc4wIEfI2/LETj1VoGrbkZqXEGfnpNFC
	LjB0JFBE/cYidzsfC5gbSFsKf5XHzxyJZam3e3pmaIr7DmKN/CEYvwbw8Jm6rSzcF3BQyh2GvWh
	jdw==
X-Google-Smtp-Source: AGHT+IEAhjSJyNICBFt8fC07FMUXAIv3JTrEOHUKD0VuV0TBcrEbM/VY7SJ2rrR05OxGMObTDGwgaQeFx3s=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:72f:b0:dc6:eea0:1578 with SMTP id
 l15-20020a056902072f00b00dc6eea01578mr2412289ybt.13.1711039045315; Thu, 21
 Mar 2024 09:37:25 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:29 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-8-surenb@google.com>
Subject: [PATCH v6 07/37] mm: introduce __GFP_NO_OBJ_EXT flag to selectively
 prevent slabobj_ext creation
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
when allocating slabobj_ext on a slab.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/gfp_types.h | 11 +++++++++++
 mm/slub.c                 |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 868c8fb1bbc1..e36e168d8cfd 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -52,6 +52,9 @@ enum {
 #endif
 #ifdef CONFIG_LOCKDEP
 	___GFP_NOLOCKDEP_BIT,
+#endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+	___GFP_NO_OBJ_EXT_BIT,
 #endif
 	___GFP_LAST_BIT
 };
@@ -93,6 +96,11 @@ enum {
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+#define ___GFP_NO_OBJ_EXT       BIT(___GFP_NO_OBJ_EXT_BIT)
+#else
+#define ___GFP_NO_OBJ_EXT       0
+#endif
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -133,12 +141,15 @@ enum {
  * node with no fallbacks or placement policy enforcements.
  *
  * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
+ *
+ * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
 #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
+#define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
 
 /**
  * DOC: Watermark modifiers
diff --git a/mm/slub.c b/mm/slub.c
index 5c896c76812d..2cb53642a091 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1889,6 +1889,8 @@ static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	void *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
+	/* Prevent recursive extension vector allocation */
+	gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
 	if (!vec)
-- 
2.44.0.291.gc1ea87d7ee-goog


