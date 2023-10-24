Return-Path: <cgroups+bounces-27-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFBF7D52A0
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 15:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F259E281A33
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833902B770;
	Tue, 24 Oct 2023 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EuxrHBnn"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158DD2B773
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 13:47:28 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4CD199B
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 06:47:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7a6fd18abso57838767b3.1
        for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 06:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155237; x=1698760037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xnkv01D37mdYs16/e0X4XkgAogHBJsuQ+iVjrKs+el4=;
        b=EuxrHBnnGWjn9JRknw1OT8akESrqgNNUzY6H2W3aj1xIl2YcqpTr80iyM49ZGtShxL
         kuhMylQuqa4aPWq2ibAkZF0fjUD79T8VVtYouzA1C1B+9UaL7cpqBkc54W34TkP8qtRn
         +i6AVLnnKZ4w9Jb3TDX/Ju2g29yQszEIMtJE4JtrLMQ06kL8uKbRyG/qkSwMRyjgWHxu
         oyLjrMe9gPmNmJ72k4jI6dRNE96iRYY+OaU08VaCxc+eCfSehFBdYUo+U9Ip0BkLXbxN
         woEenRP4rVrwcNd7nYO0AiyWZ00FJ70RsJwDJNRoy/46Dke44EtXNLGpt1JajR2ajlmm
         VseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155237; x=1698760037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xnkv01D37mdYs16/e0X4XkgAogHBJsuQ+iVjrKs+el4=;
        b=j/llsKSEeORsd+2cJUf7HlD4YwufM3XxDPvF/Y5HHYXfrgM2ouq5WsEdygrVtp4508
         clbj/QfxPJ/dsvW/txW+xysNORifiEFC4a2nHmcmRPjAGj877kWsjLq2Eg0Y9xbxqRT2
         E0/yDTpGzbt2YpsOxj59R4I+L8GQ1mtyOU8yb4RcsomXB8F+fR6YlixQtnrSDsF2ll/y
         rCdS4ZPLb10Yi9oLXneTUciOXkwJWtOLSgQgVhSXuKLFNPdLoRIop50+VCHX2TPKA366
         EwuC+lvQvTRQbMhhLmHy3VLNEqeuERxd/tR3lsmaNp2rVKwVqp+KmrKjn07n3/PZORCz
         uEOg==
X-Gm-Message-State: AOJu0YzrZQPZ/U3nJlP2ffob7dIruN+TEEr5u9ZJYz66HFH/Mq7XtRvg
	S8ivwDCT0nl6tVYgyA4pQ8qgRkmuVug=
X-Google-Smtp-Source: AGHT+IF+McJ3mA6RssmQwfp7//Pg5OsKi1Xdwm0aQawyQdn+hvoXflHVr9pzXpd28dOZCYLaDsPpXEXkw0g=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a0d:d954:0:b0:5a7:bfcf:2cb8 with SMTP id
 b81-20020a0dd954000000b005a7bfcf2cb8mr268838ywe.1.1698155237063; Tue, 24 Oct
 2023 06:47:17 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:46:13 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-17-surenb@google.com>
Subject: [PATCH v2 16/39] lib: introduce support for page allocation tagging
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

Introduce helper functions to easily instrument page allocators by
storing a pointer to the allocation tag associated with the code that
allocated the page in a page_ext field.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/page_ext.h    |  1 -
 include/linux/pgalloc_tag.h | 73 +++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug           |  1 +
 lib/alloc_tag.c             | 17 +++++++++
 mm/mm_init.c                |  1 +
 mm/page_alloc.c             |  4 ++
 mm/page_ext.c               |  4 ++
 7 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/pgalloc_tag.h

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index be98564191e6..07e0656898f9 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -4,7 +4,6 @@
 
 #include <linux/types.h>
 #include <linux/stacktrace.h>
-#include <linux/stackdepot.h>
 
 struct pglist_data;
 
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
new file mode 100644
index 000000000000..a060c26eb449
--- /dev/null
+++ b/include/linux/pgalloc_tag.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * page allocation tagging
+ */
+#ifndef _LINUX_PGALLOC_TAG_H
+#define _LINUX_PGALLOC_TAG_H
+
+#include <linux/alloc_tag.h>
+
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+
+#include <linux/page_ext.h>
+
+extern struct page_ext_operations page_alloc_tagging_ops;
+extern struct page_ext *page_ext_get(struct page *page);
+extern void page_ext_put(struct page_ext *page_ext);
+
+static inline union codetag_ref *codetag_ref_from_page_ext(struct page_ext *page_ext)
+{
+	return (void *)page_ext + page_alloc_tagging_ops.offset;
+}
+
+static inline struct page_ext *page_ext_from_codetag_ref(union codetag_ref *ref)
+{
+	return (void *)ref - page_alloc_tagging_ops.offset;
+}
+
+static inline union codetag_ref *get_page_tag_ref(struct page *page)
+{
+	if (page && mem_alloc_profiling_enabled()) {
+		struct page_ext *page_ext = page_ext_get(page);
+
+		if (page_ext)
+			return codetag_ref_from_page_ext(page_ext);
+	}
+	return NULL;
+}
+
+static inline void put_page_tag_ref(union codetag_ref *ref)
+{
+	page_ext_put(page_ext_from_codetag_ref(ref));
+}
+
+static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
+				   unsigned int order)
+{
+	union codetag_ref *ref = get_page_tag_ref(page);
+
+	if (ref) {
+		alloc_tag_add(ref, task->alloc_tag, PAGE_SIZE << order);
+		put_page_tag_ref(ref);
+	}
+}
+
+static inline void pgalloc_tag_sub(struct page *page, unsigned int order)
+{
+	union codetag_ref *ref = get_page_tag_ref(page);
+
+	if (ref) {
+		alloc_tag_sub(ref, PAGE_SIZE << order);
+		put_page_tag_ref(ref);
+	}
+}
+
+#else /* CONFIG_MEM_ALLOC_PROFILING */
+
+static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
+				   unsigned int order) {}
+static inline void pgalloc_tag_sub(struct page *page, unsigned int order) {}
+
+#endif /* CONFIG_MEM_ALLOC_PROFILING */
+
+#endif /* _LINUX_PGALLOC_TAG_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 475a14e70566..e1eda1450d68 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -972,6 +972,7 @@ config MEM_ALLOC_PROFILING
 	depends on PROC_FS
 	depends on !DEBUG_FORCE_WEAK_PER_CPU
 	select CODE_TAGGING
+	select PAGE_EXTENSION
 	help
 	  Track allocation source code and record total allocation size
 	  initiated at that code location. The mechanism can be used to track
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 4fc031f9cefd..2d5226d9262d 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -3,6 +3,7 @@
 #include <linux/fs.h>
 #include <linux/gfp.h>
 #include <linux/module.h>
+#include <linux/page_ext.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_buf.h>
 #include <linux/seq_file.h>
@@ -124,6 +125,22 @@ static bool alloc_tag_module_unload(struct codetag_type *cttype,
 	return module_unused;
 }
 
+static __init bool need_page_alloc_tagging(void)
+{
+	return true;
+}
+
+static __init void init_page_alloc_tagging(void)
+{
+}
+
+struct page_ext_operations page_alloc_tagging_ops = {
+	.size = sizeof(union codetag_ref),
+	.need = need_page_alloc_tagging,
+	.init = init_page_alloc_tagging,
+};
+EXPORT_SYMBOL(page_alloc_tagging_ops);
+
 static struct ctl_table memory_allocation_profiling_sysctls[] = {
 	{
 		.procname	= "mem_profiling",
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 50f2f34745af..8e72e431dc35 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -24,6 +24,7 @@
 #include <linux/page_ext.h>
 #include <linux/pti.h>
 #include <linux/pgtable.h>
+#include <linux/stackdepot.h>
 #include <linux/swap.h>
 #include <linux/cma.h>
 #include "internal.h"
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 95546f376302..d490d0f73e72 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -52,6 +52,7 @@
 #include <linux/psi.h>
 #include <linux/khugepaged.h>
 #include <linux/delayacct.h>
+#include <linux/pgalloc_tag.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
@@ -1093,6 +1094,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 			__memcg_kmem_uncharge_page(page, order);
 		reset_page_owner(page, order);
 		page_table_check_free(page, order);
+		pgalloc_tag_sub(page, order);
 		return false;
 	}
 
@@ -1135,6 +1137,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 	reset_page_owner(page, order);
 	page_table_check_free(page, order);
+	pgalloc_tag_sub(page, order);
 
 	if (!PageHighMem(page)) {
 		debug_check_no_locks_freed(page_address(page),
@@ -1535,6 +1538,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 
 	set_page_owner(page, order, gfp_flags);
 	page_table_check_alloc(page, order);
+	pgalloc_tag_add(page, current, order);
 }
 
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 4548fcc66d74..3c58fe8a24df 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -10,6 +10,7 @@
 #include <linux/page_idle.h>
 #include <linux/page_table_check.h>
 #include <linux/rcupdate.h>
+#include <linux/pgalloc_tag.h>
 
 /*
  * struct page extension
@@ -82,6 +83,9 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
 #if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
 	&page_idle_ops,
 #endif
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	&page_alloc_tagging_ops,
+#endif
 #ifdef CONFIG_PAGE_TABLE_CHECK
 	&page_table_check_ops,
 #endif
-- 
2.42.0.758.gaed0368e0e-goog


