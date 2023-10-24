Return-Path: <cgroups+bounces-31-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6187D52BF
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 15:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39795B20C24
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149A02C859;
	Tue, 24 Oct 2023 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4VlaBiI"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDD8347A0
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 13:47:40 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAADC1BF5
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 06:47:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da05b786f1dso176316276.2
        for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155248; x=1698760048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zC2/AjWbzXkwFGJu5UOviuzr4L4X1GYNGPTyCuvFw8o=;
        b=r4VlaBiIIyGv+JAyiSfBVJQp+KYKVBP5MM5t0jdEetiExo6YyVSNv0kQ/fAy6kEc1x
         nkSICjCQVcKAM04qibN9NgDtay0QoakP6LjLA7vCeRfQkaHZQDuEovP41aiMdIgf0SiM
         3GoHZ1KUP+puQBpa4ATrTb5anWQTXUp59qMonTr3DTMfEn+YEyfIQrUbYfZdffoxAlkn
         ireFT1BunBirKvfOrJfmKAhMpyAgeGMVp8b1tbu/Tt6y9fDwCskYzFbWa2L7EFy6jKLb
         yGvPDXvMlidkwCzkbTGQq2+FcJSXT4HSNmoehqBB3pElPlynw0jbeNK/Q8FIti2H944k
         hitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155248; x=1698760048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zC2/AjWbzXkwFGJu5UOviuzr4L4X1GYNGPTyCuvFw8o=;
        b=pCqT5LMBY7FhW1IQTKWAHOaW7D0E0V86aRAqsTfw7Eu0fhDI9ozN5PKOZgn3GccbmY
         9xZMmQOWQYXEuM5REZFxx6+hZjogfcCsxxv4uUnb4a8suhBiuuXzXIrOvxGvp940CNcZ
         lsrzzGdwVjRXD8AsNFaCLmzg9UfauqWT/raPLHDdN4YYegifVB5xu4ukmUa0LhLUAx3L
         K56DVDdCAAbtiv/eZB+rFkBx8ABe2rqSDNQ/7dASMuLGTJcFT9YewZXcaCr/OfIhv6mg
         Qq886xOil3mUXVSWpkT+48jnHjpTFK6qrXjldA7agQkJTfpEXAD7eBtJrirqwgLQxkWQ
         5p2g==
X-Gm-Message-State: AOJu0YxHEQXu5f1b8npIdwBxGnaYajb+xTdXTaQbril8YTL0FN35cAtj
	7/J8ntdYo7U7cMNBZUEjY2amwDMkA3s=
X-Google-Smtp-Source: AGHT+IFtIla7jN3qQCOM5jBjQINYCYH8n10kTFpUDwIK13I4RwREYyTVERaiA7ZHusZIP5/hSujmrJfw8JM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:40c7:0:b0:da0:289e:c056 with SMTP id
 n190-20020a2540c7000000b00da0289ec056mr61156yba.8.1698155248287; Tue, 24 Oct
 2023 06:47:28 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:46:18 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-22-surenb@google.com>
Subject: [PATCH v2 21/39] mm/page_ext: enable early_page_ext when CONFIG_MEM_ALLOC_PROFILING_DEBUG=y
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com, 
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
2.42.0.758.gaed0368e0e-goog


