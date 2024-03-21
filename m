Return-Path: <cgroups+bounces-2089-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3AB885DCF
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 17:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4F9281CDE
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E491332B8;
	Thu, 21 Mar 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wWAs86Pz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE21EA95
	for <cgroups@vger.kernel.org>; Thu, 21 Mar 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039039; cv=none; b=d4mbG7i5aNhNOFE9NFIHxRenxJyXn1hvLY1Qp4EgNdy3ZMMVy+Xoe9c/X8rLb0lyJIa0JLSFG2KUGfV2VLnU1Ix9tE1uI7A/T0e6gV29ZBS02vG8rX4br+YKsw4i4jfFNK2Qo14CU+8sNBpXrHrwDcT77RQlZiTL7QzzITSRtGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039039; c=relaxed/simple;
	bh=HDNKqGkk/azPcTtEhJHN+gpMAx3GoPDUVnE3EYb5Lwg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=elqMevOeMZMA5mcCr2BQm5R06hOosCTKzu9PIb/GQb7PexmCCD6p6CwOP/ocsyhUI3NPkQyQ/m+7hD9CikubqKD5m+TVOaBLjWNIyOs9YHMa4cgnuz+wwshhPvNmrrDNj6yGAtMFHN+5zhc0F1km+z3yrw4kd/TJgzSR9n7x9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wWAs86Pz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd073522cso21742827b3.1
        for <cgroups@vger.kernel.org>; Thu, 21 Mar 2024 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039037; x=1711643837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRKfaiB6dOVHxpZUYVy57amQHTHiIgtHPVa28h/bxKY=;
        b=wWAs86Pzoa7/o4uO9DUaKalp5/lqsafBptAizETSwrwxG543E6aMELKTNZSJkOAIe0
         bRt0Sx5bIrvo0fEeZIMOi/WnS3w8QvJt+cukgQ97dy2sUMu/2XvrkrSPB3wxcsHWECwJ
         gXSz591epccQDT13TSfHCWEmVtILtlUzWaK6lofLdZtFD76e6xRP7kFw62KtCG/PeU3h
         vCzqp4N2MCFbRN6fJ/OGzaUN0Z+fXQRfoKah+oG2oqXKYQLTWQzgy3lkLXpiFckDQa+N
         mwKOtfm5DRQgGMMMcGfaLNoBA9YRBfqKZZyBJ0++lPTsszo1wJOPkxqU9dNzI9czQynf
         t+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039037; x=1711643837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRKfaiB6dOVHxpZUYVy57amQHTHiIgtHPVa28h/bxKY=;
        b=l7IvOeRiUDbsxKeqsazyYhxAci/+Gl1x0yqk2sL79e17JsVGvvrk+ovQvhqUsxjrEc
         1NevmLK+HWxnKl//ly22+M6Fy1Mrir8v8j1y7g7A/AC+Qfj7H0SenElAYt7XRXc6NXvJ
         8zV6yVnMSnf+eIkd933qMTGP4w6jxzSi9J5OzhMtayEfG8Bpb7fZktkW6a3eAb3DgsxP
         m1bZGTEZWN7IH0DLjX2IyGhVGqRI7h7zdGUOcVKhRz2AVDrg5dH43Culvs3hyvL4FRp5
         gwLNVuSl3S2gdOS69uoW/QF5ZbFW/B2rqRXzv6GurLISjQwu0UTsFHADgwLe6KL3Just
         Vflg==
X-Forwarded-Encrypted: i=1; AJvYcCXbAPVL+4E3DRqo3uJEAofNp3zQba9pI0VJwjJwJT5BGmnqdzjiTTDdHqKcuMHmzGZnNTWf0o7arYnvRjuLgu+tabuqedGccw==
X-Gm-Message-State: AOJu0YxrpuQOnZlEFIeGtkNb3WMeeXPalX724ere8hS1H1LP34xhnpo1
	D+FG7D9SCluYwPCLa3l5JVY72j8KG/3T9ngeVWtLfiPOn8qEtTsEZtacxLX45Q85CdpfagQuooD
	qzg==
X-Google-Smtp-Source: AGHT+IFYgw5ohbM2qs9qWLSKEHVv/3K2+6lhzKzCxOpGXwJ9EG3Fd8M+K30yKZwcBlNXdCTg4+rc5Suy1A8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:690c:f88:b0:610:f11e:9d24 with SMTP id
 df8-20020a05690c0f8800b00610f11e9d24mr1686171ywb.4.1711039036599; Thu, 21 Mar
 2024 09:37:16 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:25 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-4-surenb@google.com>
Subject: [PATCH v6 03/37] mm/slub: Mark slab_free_freelist_hook() __always_inline
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

From: Kent Overstreet <kent.overstreet@linux.dev>

It seems we need to be more forceful with the compiler on this one.
This is done for performance reasons only.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1bb2a93cf7b6..bc9f40889834 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2106,9 +2106,9 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 	return !kasan_slab_free(s, x, init);
 }
 
-static inline bool slab_free_freelist_hook(struct kmem_cache *s,
-					   void **head, void **tail,
-					   int *cnt)
+static __fastpath_inline
+bool slab_free_freelist_hook(struct kmem_cache *s, void **head, void **tail,
+			     int *cnt)
 {
 
 	void *object;
-- 
2.44.0.291.gc1ea87d7ee-goog


