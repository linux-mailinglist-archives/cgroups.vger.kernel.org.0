Return-Path: <cgroups+bounces-2118-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D975C885E95
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 17:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED9E1C23115
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 16:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2271448F0;
	Thu, 21 Mar 2024 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E0KvrSRM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFAB143C5C
	for <cgroups@vger.kernel.org>; Thu, 21 Mar 2024 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039104; cv=none; b=k73F7Cvwk5yKOB5gwIJAlK7uFEzg4KXd+sRpnRcU8cEYfbJoosw+gUGx1WuR0Lq20gpwWOS7XHa6WLf/Ntqiy7P0Pcro72UlxrwOX1C2ZvQu65s+6NTPFHgMNMdQCBx3/gjxJ84+GxBbZjFt0GYGROzmuuEdCbmxdNPTf0xmGJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039104; c=relaxed/simple;
	bh=fjKlaW/3iFj7zPGvTnymctnlWUNRXZfhInu7vpc6prw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iMCnnYW88GxSzuc+opj76bT/1XL2rXo3UXNzYLRUsuoASLyyNhabTlOn4EqA4/RTQxqFjFLXTERgSqgzsvwLfF0u1NhNkREXdk6NQQun02ygpe6tCaL0NlKAPGbqnt7K5LfIk1x+eLLNqaNFqEtxRdzNF7EJV0Hf+5MakBt1ylA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E0KvrSRM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so1392332276.0
        for <cgroups@vger.kernel.org>; Thu, 21 Mar 2024 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039099; x=1711643899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iYMC0aOkTaJuIlgenfbozu9BZf0q2gbSOAGaj6P53nM=;
        b=E0KvrSRMpOVxB6+HRxKmyqpn6yLuCVPcbTSetv8BZo2Bkk3ZZ0JN+kb4fSidNRcyre
         6VivHskWOl+XBLRVQsL4C+66Q2fGO6Sa0U7eyX9wq2RwvAScaK9vggovE12tgLa6aomK
         ORvcKmBraYoBAzmAbfrQEIdb0KLroarrKp9+KqYOdj9NES1LWjw/r+5msqvpZnPYvkAP
         MI9vl1+IuR12dohLhhLLICPe0EiD/CUjEBFL5dVoX8Qhsi49rS2RLCsC2TsdKwCeHxW2
         ZtCii3YQmJuB4uFezQalvPk+0mKc91xueeVCZBzb67VmDzD58RHw/z8PY+hQsA6v642c
         EOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039099; x=1711643899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYMC0aOkTaJuIlgenfbozu9BZf0q2gbSOAGaj6P53nM=;
        b=cS3OMJQGK0ZuL46GvEAfa8i4U+mP1jP7SNDRQKzoHGMgT+ZIqDpRym7RDbzZHZK37o
         Vqf5yOdsyeRfzQ7gHf6W6XO1EayNFPmgc8Er/FzdmfFH/cWrWdJOfOxyPtXJnOUQV5W1
         uC2w/aSzIOnMsSV/IVEjq9xsaaBTjyTUNiRI5LiwG7gege4L33479qq2Knic6sEu5uwf
         JUH243YK3F8n+iLrVcfAL32V8dfoN4CU2mzgQiNeBqyabEe09zg31cFytmIoDrmvRuAW
         763J9tiKVO8+VJEbc0NYxsQD+fr/GFY7GTQyOOZHrutNe9r3XbbcqAO+1ewA+YjIHwHm
         dAyg==
X-Forwarded-Encrypted: i=1; AJvYcCVx0svzgSSEvXbUgKUaAEHiaD9faxMRAfZ+bVSinh7J7flvM8fUR0dq7at9KWwFneKuYhg80otlawEeuaoPvmkBSm3yECeozw==
X-Gm-Message-State: AOJu0YxV7czzs8o2UThsqE0qW52U9dWVeZQQl/usqJemt2szUSEv/NUg
	3Wppmg3/Tj41ZQO0UKcExdlMlVxbF8aFOb5e8iZMUezsoxVveq3Y5u3U4LK9b3p3qNHUYxOHVjU
	1IA==
X-Google-Smtp-Source: AGHT+IEl39fT88zAybCKFbgD7Ybs+bIKptMpR9e50EtGQF6WZVLSjiN4xDj0a9gSVDcCEVc03olmfnidgNM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:2009:b0:dcd:c091:e86 with SMTP id
 dh9-20020a056902200900b00dcdc0910e86mr979486ybb.13.1711039099264; Thu, 21 Mar
 2024 09:38:19 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:54 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-33-surenb@google.com>
Subject: [PATCH v6 32/37] lib: add memory allocations report in show_mem()
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

Include allocations in show_mem reports.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/alloc_tag.h |  7 +++++++
 include/linux/codetag.h   |  1 +
 lib/alloc_tag.c           | 38 ++++++++++++++++++++++++++++++++++++++
 lib/codetag.c             |  5 +++++
 mm/show_mem.c             | 26 ++++++++++++++++++++++++++
 5 files changed, 77 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index cf69e037f645..aefe3c81a1e3 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -30,6 +30,13 @@ struct alloc_tag {
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
+struct codetag_bytes {
+	struct codetag *ct;
+	s64 bytes;
+};
+
+size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sleep);
+
 static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
 {
 	return container_of(ct, struct alloc_tag, ct);
diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index bfd0ba5c4185..c2a579ccd455 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -61,6 +61,7 @@ struct codetag_iterator {
 }
 
 void codetag_lock_module_list(struct codetag_type *cttype, bool lock);
+bool codetag_trylock_module_list(struct codetag_type *cttype);
 struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype);
 struct codetag *codetag_next_ct(struct codetag_iterator *iter);
 
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 617c2fbb6673..e24830c44783 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -86,6 +86,44 @@ static const struct seq_operations allocinfo_seq_op = {
 	.show	= allocinfo_show,
 };
 
+size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sleep)
+{
+	struct codetag_iterator iter;
+	struct codetag *ct;
+	struct codetag_bytes n;
+	unsigned int i, nr = 0;
+
+	if (can_sleep)
+		codetag_lock_module_list(alloc_tag_cttype, true);
+	else if (!codetag_trylock_module_list(alloc_tag_cttype))
+		return 0;
+
+	iter = codetag_get_ct_iter(alloc_tag_cttype);
+	while ((ct = codetag_next_ct(&iter))) {
+		struct alloc_tag_counters counter = alloc_tag_read(ct_to_alloc_tag(ct));
+
+		n.ct	= ct;
+		n.bytes = counter.bytes;
+
+		for (i = 0; i < nr; i++)
+			if (n.bytes > tags[i].bytes)
+				break;
+
+		if (i < count) {
+			nr -= nr == count;
+			memmove(&tags[i + 1],
+				&tags[i],
+				sizeof(tags[0]) * (nr - i));
+			nr++;
+			tags[i] = n;
+		}
+	}
+
+	codetag_lock_module_list(alloc_tag_cttype, false);
+
+	return nr;
+}
+
 static void __init procfs_init(void)
 {
 	proc_create_seq("allocinfo", 0444, NULL, &allocinfo_seq_op);
diff --git a/lib/codetag.c b/lib/codetag.c
index 408062f722ce..5ace625f2328 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -36,6 +36,11 @@ void codetag_lock_module_list(struct codetag_type *cttype, bool lock)
 		up_read(&cttype->mod_lock);
 }
 
+bool codetag_trylock_module_list(struct codetag_type *cttype)
+{
+	return down_read_trylock(&cttype->mod_lock) != 0;
+}
+
 struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype)
 {
 	struct codetag_iterator iter = {
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 8dcfafbd283c..bdb439551eef 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -423,4 +423,30 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 #ifdef CONFIG_MEMORY_FAILURE
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	{
+		struct codetag_bytes tags[10];
+		size_t i, nr;
+
+		nr = alloc_tag_top_users(tags, ARRAY_SIZE(tags), false);
+		if (nr) {
+			pr_notice("Memory allocations:\n");
+			for (i = 0; i < nr; i++) {
+				struct codetag *ct = tags[i].ct;
+				struct alloc_tag *tag = ct_to_alloc_tag(ct);
+				struct alloc_tag_counters counter = alloc_tag_read(tag);
+
+				/* Same as alloc_tag_to_text() but w/o intermediate buffer */
+				if (ct->modname)
+					pr_notice("%12lli %8llu %s:%u [%s] func:%s\n",
+						  counter.bytes, counter.calls, ct->filename,
+						  ct->lineno, ct->modname, ct->function);
+				else
+					pr_notice("%12lli %8llu %s:%u func:%s\n",
+						  counter.bytes, counter.calls, ct->filename,
+						  ct->lineno, ct->function);
+			}
+		}
+	}
+#endif
 }
-- 
2.44.0.291.gc1ea87d7ee-goog


