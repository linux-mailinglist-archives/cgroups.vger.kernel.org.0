Return-Path: <cgroups+bounces-1461-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF478520A5
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 22:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3E31F22CFF
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 21:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E715EE78;
	Mon, 12 Feb 2024 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1sbrvriH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A845EE7A
	for <cgroups@vger.kernel.org>; Mon, 12 Feb 2024 21:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774045; cv=none; b=Vy4kpu17/lT1C8VyNbBsFazvXkcCnqxmFFiHytDFYgaB+TlKbVRD2MIDlyULj9k+k7RGrKxWK/Z3D0te365Kq4BMO2VvL3qvZUeXBAUghgMeOKuGUBNiuMMGpZar6MTG7OO282r5Pz8vWf0Z45NtVJ61n/5LbvkJKiPd4yNGLJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774045; c=relaxed/simple;
	bh=5ChqV8HHhpLeW+E8kMoIkC2NLvWtduhWvlkcjpnpm1w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QsBmfCgx1Zr6/OiBW0clsDtwh2HlZkT+3S96mDvgmFxEpri3Hl7N4xUrtjbeP1fZ2SWs1/n5xp0clbkKiKdR0mihkml3KBrCAMkzaqh8VelgI41trauZ654BrGw8ELjkd4LLyE8sjpqaknGWPVAjUset3jB0PYg1+gg+gxdJVVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1sbrvriH; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so1072987276.2
        for <cgroups@vger.kernel.org>; Mon, 12 Feb 2024 13:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774042; x=1708378842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/sI0PWD0cr+RKARN01FIe/JdJLbOCpqo744sqtIKAHU=;
        b=1sbrvriH73mQp8gpsJeAGGW9oO1S5Z9thwgjrip2JSRnVpYSHCVgjk5a1Qnj9Xc0xi
         exT3BhixN0wsdesoHOH5YfIUnQJhPsCEi7yCScf+RApnfSyM6SpBs66CPhLRnBlwY/r5
         eoTM761VuyPQkpg5MmrGxZtIkD+ZFjGt9jYvk1Z+u8MibtcN6nPPTw2YbXxTsYG5hPd0
         Ca1m8pct+iYMJmuEEZOblIFKFW5DGSmkDtdEDyKNZeOdGcmry/uhuAImuok2Idr5xlxJ
         59s6VhEOb9Gzt7tWsJomK6edp056CIScs37u/NfRjeUHDBt+wodrk8UWLnXQzy7Y0FeU
         NM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774042; x=1708378842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/sI0PWD0cr+RKARN01FIe/JdJLbOCpqo744sqtIKAHU=;
        b=QXFNUxNM5XaMU+wh/GsPgWkNwShO/hJRlCM50gvszY+SLqFyctaZ5QSakXLURiTmKH
         6odmOj5AYkN36mOmKQQhm/1HJRdzIf2KHwdHFGw9GFvMc4TDhCVK4Fzg38WOUVKFbiTc
         fR7fsgRgPCYMpXQ3qRFRCAu0FVUsNi+1ixx+ox36AS1nr7aXl1Ep6roDoGex5Qxv2w9i
         pykZ5d+7qaS/tKWeqDkEgFRrkNqoUf1AO1W7uIY+wBIoK1b3CM2hNQOWOifr4Gt5YZIf
         wt/ZG+zSFvD0zrr46DxXC/R3UxXgavyoqBnKw7Es3BuJ3h+qadrm856xSGqNDxTjCkgL
         iM0A==
X-Forwarded-Encrypted: i=1; AJvYcCU4ehvGwNQHd9Qn9k65gGxMrUkmsArOCROSnNBFq0EfvI/8C3iNrKgw1C9SHxi6LECafh1PhPlKc9hklssU2dN9YwSdU1nSnQ==
X-Gm-Message-State: AOJu0YzOr/apt/Zl5xNXEpwWU40AAJxDff7ziAvCwIXGUS6u932etGPR
	Ee25s5z1V9d3kosKlVFmgv0l9RMvkSYymYCwzxSxS12P3uVPOOzRnGiV7FXyKmjWmnepTwdr8pD
	fAg==
X-Google-Smtp-Source: AGHT+IGlJug7UeocMp/yJN58BwDAI5E8aN7090iq/Hzoe26lNZkGF0b2He1z8X2tvc+mRRdeZBlUlmhSz1U=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a05:6902:2186:b0:dc6:cafd:dce5 with SMTP id
 dl6-20020a056902218600b00dc6cafddce5mr2274526ybb.12.1707774041837; Mon, 12
 Feb 2024 13:40:41 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:18 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-33-surenb@google.com>
Subject: [PATCH v3 32/35] codetag: debug: skip objext checking when it's for
 objext itself
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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

objext objects are created with __GFP_NO_OBJ_EXT flag and therefore have
no corresponding objext themselves (otherwise we would get an infinite
recursion). When freeing these objects their codetag will be empty and
when CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled this will lead to false
warnings. Introduce CODETAG_EMPTY special codetag value to mark
allocations which intentionally lack codetag to avoid these warnings.
Set objext codetags to CODETAG_EMPTY before freeing to indicate that
the codetag is expected to be empty.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h | 26 ++++++++++++++++++++++++++
 mm/slab.h                 | 25 +++++++++++++++++++++++++
 mm/slab_common.c          |  1 +
 mm/slub.c                 |  8 ++++++++
 4 files changed, 60 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 0a5973c4ad77..1f3207097b03 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -77,6 +77,27 @@ static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag *tag)
 	return v;
 }
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+
+#define CODETAG_EMPTY	(void *)1
+
+static inline bool is_codetag_empty(union codetag_ref *ref)
+{
+	return ref->ct == CODETAG_EMPTY;
+}
+
+static inline void set_codetag_empty(union codetag_ref *ref)
+{
+	if (ref)
+		ref->ct = CODETAG_EMPTY;
+}
+
+#else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
+
+static inline bool is_codetag_empty(union codetag_ref *ref) { return false; }
+
+#endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
+
 static inline void __alloc_tag_sub(union codetag_ref *ref, size_t bytes)
 {
 	struct alloc_tag *tag;
@@ -87,6 +108,11 @@ static inline void __alloc_tag_sub(union codetag_ref *ref, size_t bytes)
 	if (!ref || !ref->ct)
 		return;
 
+	if (is_codetag_empty(ref)) {
+		ref->ct = NULL;
+		return;
+	}
+
 	tag = ct_to_alloc_tag(ref->ct);
 
 	this_cpu_sub(tag->counters->bytes, bytes);
diff --git a/mm/slab.h b/mm/slab.h
index c4bd0d5348cb..cf332a839bf4 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -567,6 +567,31 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 			gfp_t gfp, bool new_slab);
 
+
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+
+static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
+{
+	struct slabobj_ext *slab_exts;
+	struct slab *obj_exts_slab;
+
+	obj_exts_slab = virt_to_slab(obj_exts);
+	slab_exts = slab_obj_exts(obj_exts_slab);
+	if (slab_exts) {
+		unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
+						 obj_exts_slab, obj_exts);
+		/* codetag should be NULL */
+		WARN_ON(slab_exts[offs].ref.ct);
+		set_codetag_empty(&slab_exts[offs].ref);
+	}
+}
+
+#else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
+
+static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
+
+#endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
+
 static inline bool need_slab_obj_ext(void)
 {
 #ifdef CONFIG_MEM_ALLOC_PROFILING
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 21b0b9e9cd9e..d5f75d04ced2 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -242,6 +242,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		 * assign slabobj_exts in parallel. In this case the existing
 		 * objcg vector should be reused.
 		 */
+		mark_objexts_empty(vec);
 		kfree(vec);
 		return 0;
 	}
diff --git a/mm/slub.c b/mm/slub.c
index 4d480784942e..1136ff18b4fe 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1890,6 +1890,14 @@ static inline void free_slab_obj_exts(struct slab *slab)
 	if (!obj_exts)
 		return;
 
+	/*
+	 * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
+	 * corresponding extension will be NULL. alloc_tag_sub() will throw a
+	 * warning if slab has extensions but the extension of an object is
+	 * NULL, therefore replace NULL with CODETAG_EMPTY to indicate that
+	 * the extension for obj_exts is expected to be NULL.
+	 */
+	mark_objexts_empty(obj_exts);
 	kfree(obj_exts);
 	slab->obj_exts = 0;
 }
-- 
2.43.0.687.g38aa6559b0-goog


