Return-Path: <cgroups+bounces-1758-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 295EE85E80A
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 20:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31152828A4
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 19:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D07514C5A8;
	Wed, 21 Feb 2024 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I60tfXUB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598AE14AD0F
	for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 19:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544503; cv=none; b=YwCerLH+pTllE6exZ/vlUXBKufYvLL8A3OZnvyM67WXQq7bbZ/UUxTdyi9mXRrWBWTfGbEBdM0m08+zwrKZYhD0Y9fXz5TrzsPmgGfqeBe2VRvJmt3UzOlwdNk07+Y8ZDWfqlbx2N0R9Bc2sB8YkpWecTtoarqcnr0uQoLevEEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544503; c=relaxed/simple;
	bh=tJ3w7T50tuSGE7zeIkRop76WTSZpdbl8TVHGhzHrDHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C3cEY+RE6CuIYQWnKnMjQOL7WFWFd0UENSIY/PlKeJ5GgbwQxDS5+4i31UqJUUrFCY7DeB1ElZet7JJwNlutTIp03k0HoaYz9lI9sw8L5YWbGfei++qf4+MmTsitclyS2c7ZYJQrwsh8yzg65yPcfydwnLrTF4rxuOvqqbyVQzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I60tfXUB; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6088fa18619so9942527b3.2
        for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 11:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544500; x=1709149300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tPPJBer4xtwbKjpAS2Ohhk9ejLfkpDLeASf186TPNEc=;
        b=I60tfXUBQ7h4hK/1lnwmCB9svJL5J/Q95mhSU58YPOQhMpkiOy3JoeaU8LEs+wXIbx
         0i1ti2VW+V6uszIxTNSHuregujLmiTznjqIzc4INDeSN42c/JOrNDozj3zNtKXORqHnE
         Ak6j3n+QIsz2tx85cuFB2KUrLWBQaouw4f1pnuiMjaBvVSEXYOsc0jFtRatrZynt+cSd
         RAIosOEG/hqzTY/by4ODaFZB1Xi3DXC12q0gliEttJx4/rt771FuJ+OmPzRm8FceQIAx
         Fi0rTH8YwEJL+NuBBlC8Mc9yvwxX/7H0RiXjGg4h/xkpyHkkWc/mvnRlqz9JBPO0nEu8
         WBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544500; x=1709149300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPPJBer4xtwbKjpAS2Ohhk9ejLfkpDLeASf186TPNEc=;
        b=cQbsvD/32IOLPcmKY/fiVpuZO+cT3NP9OhOMc4+upwDKdWHsEkFRQwMb/476L0gjmj
         gldEtPW5gQYrZ2GjsulAU88ig4VlW+okMuTN2rLsZJdcX+vBDDEC645pwNIfa7SrXFtt
         IHRwRcRK1a3gy28KKADuLfQJRps2BWhheuThdV3TfysD+0kq6dbfrFQHotzdWQ5UA89n
         OlrGRHBx53e5QryVCdnf53q5Y/xCULvo500dmP46aiojcywJOM3p59lA4wPLpbjaVAs/
         GI+GZCG5q9U+FGcSFAqmYX2dLlPQaWyAvTjOZ2ENE0DB9tdmV7LdWIqZKs7L4NI0DD1x
         8VCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOkOWfmywfkBXgo3rB9jE9Sl02+8VWe08JdJt6jEMeMQK6f8ySzr//irRQABHrPhYflvjOmF6NXRgZ/KwqR3kAsf3vFbjyew==
X-Gm-Message-State: AOJu0YxrttNZtLhm2GGhWFbVQjrPjKC7TOxRRQmpgRcnjMZ4zN7KegCF
	Xrh94ckA0U7dQrCKSvGMY/FU0aEOlI/upQzp2eZCrKkRfxUV5MeJmsoV+hMCN8ZWDVUUwvV198Z
	ShA==
X-Google-Smtp-Source: AGHT+IFeU9fBllBbqeIlv/z5gUqfuWqisiGNNlq6CXUqUD/DUi+PbsZNeU43mHL5nXzTrIUoTAFCk30SjNk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:6902:1008:b0:dbe:387d:a8ef with SMTP id
 w8-20020a056902100800b00dbe387da8efmr14985ybt.1.1708544500266; Wed, 21 Feb
 2024 11:41:40 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:33 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-21-surenb@google.com>
Subject: [PATCH v4 20/36] mm/page_ext: enable early_page_ext when CONFIG_MEM_ALLOC_PROFILING_DEBUG=y
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
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For all page allocations to be tagged, page_ext has to be initialized
before the first page allocation. Early tasks allocate their stacks
using page allocator before alloc_node_page_ext() initializes page_ext
area, unless early_page_ext is enabled. Therefore these allocations will
generate a warning when CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled.
Enable early_page_ext whenever CONFIG_MEM_ALLOC_PROFILING_DEBUG=y to
ensure page_ext initialization prior to any page allocation. This will
have all the negative effects associated with early_page_ext, such as
possible longer boot time, therefore we enable it only when debugging
with CONFIG_MEM_ALLOC_PROFILING_DEBUG enabled and not universally for
CONFIG_MEM_ALLOC_PROFILING.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/page_ext.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index 3c58fe8a24df..e7d8f1a5589e 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -95,7 +95,16 @@ unsigned long page_ext_size;
 
 static unsigned long total_usage;
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+/*
+ * To ensure correct allocation tagging for pages, page_ext should be available
+ * before the first page allocation. Otherwise early task stacks will be
+ * allocated before page_ext initialization and missing tags will be flagged.
+ */
+bool early_page_ext __meminitdata = true;
+#else
 bool early_page_ext __meminitdata;
+#endif
 static int __init setup_early_page_ext(char *str)
 {
 	early_page_ext = true;
-- 
2.44.0.rc0.258.g7320e95886-goog


