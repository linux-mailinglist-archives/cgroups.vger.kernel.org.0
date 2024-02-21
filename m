Return-Path: <cgroups+bounces-1741-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D3885E79C
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 20:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60AC3B24B81
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 19:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0168A1272A3;
	Wed, 21 Feb 2024 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yAuSI3zF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3586AFE
	for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544465; cv=none; b=ggIPnDzJ5xjCLfsVsXeHNE476ZjcYrKbBs/KSQDNhafHi3UBNAZdoCECsrADkFJUzhY+KMGgAwulnbd6s+9ipC/PNPxZ+IQ85kwq7rggCsFmJ3DVhvtkfNxNgad362j3COfJaUavSBWuZcw+OATCb4wd+PRxlaHARi1VLZDnqgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544465; c=relaxed/simple;
	bh=0jXC3LDzUrrolAiGzpejaFGts6g9gPbvSne6eR9EGZ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p6ia8pj9hcZHTX4Y0uJOtmU2rSWivU4RKXfZnbr+xRzuc6i1s2RjMeL0F25bVhaCi5ZvGqXnMr9S0KGM0BRm64dilMbJGTjmEXTT5xVI3AyyOfGiaJHXTdbfF3qABBjK6AaA8U5SjNVQmdEHoZlqpXZRri43fWM28mGuUZ+bEhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yAuSI3zF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so9038061276.3
        for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 11:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544463; x=1709149263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDZXV5wClyo81E7oQNbL7t5gFNRFpKZi8JXsyoMDgnM=;
        b=yAuSI3zFtBXJEqtOJqcZ7nFCZUwHdfr+Wu9iAy+CuCFuvUw5k6vUh7m1pSo109/ecX
         eSPLwSRNwaXOqgo30uW6xG4srrJBOp0FJJJ9WQg25TVgBagpMiS06f8PbtRUhpgZfJ+G
         /BENEgZ40l/qfZlXROmPnL3iaMo3Ir8io6yPVmam5fXDzpRaKEV2XWFuOw5c5anxWg4F
         L2iIEHk/SziLOzPkLdx9HL0V/ZcRdUwSWr2v+rTGBLMnGn/wimFfRjzk3cSpVk5LhOHb
         PA9J1utGbhUv15ENpNNyZeGO/9eT+53mAsavVQfxW85P+kvMf8JguBecVxFwrDEEHdth
         E2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544463; x=1709149263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDZXV5wClyo81E7oQNbL7t5gFNRFpKZi8JXsyoMDgnM=;
        b=OBK5OIsQ82li5cUcpqQEmrffvUfFRjjcZPqLcQ6oYS+9Bs4d59EoRImWpPD1wR9JOw
         18/122LTJz5PJ4UaV+n4koXjZrGgTqSpPj0qAAGoAhqvY0/V22jtzNHKA1wltANqmmHH
         nDq1rFBM4FOlYRKUpnffJyFcSiGAFjjrpjX/fxYYvJEj6HoHj9E/3M4Ajkkb9WkFrrLn
         smeAUTj1zjPBX8M5/oupRVynivhmLRNzSNBRYsvnyEYNBq0SYUYMTgWhI45/HgeIjOOw
         9tiAq6FN0NL/TdpFO+s44yOAi+302jxOy+z3aq1QzxptZhgq/ZuLrkYaSLIcRuCPnVeQ
         TAzA==
X-Forwarded-Encrypted: i=1; AJvYcCWobo4F7xJfuJyQwvYQ7F5K/rON5VP2FryAECt9mRKzdnwviK3OKYyWDUVij6lOAMVcEkEa4Qg0euO7OcMNeNnWzrzeSRVXWw==
X-Gm-Message-State: AOJu0YzWLM0Cs58L0bFgwksokfe6PKICkvpg7HQSjXPjpdDMSaMPp+RI
	0H7tg+ZD3pGlZvpWqZs7mxVBamqBltJftHJj2JVm2nHWDWDSGaChJaZAX3usJ5rUPDEtp4VyZdO
	IDQ==
X-Google-Smtp-Source: AGHT+IHYTX89gbhdUEyuW7HvamV6v1+4UrLx/voxHAa1LwjOId1uGP/0Vg+lc29zmz5uf9mDtRdIligkWrQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:6902:1008:b0:dc6:d9eb:6422 with SMTP id
 w8-20020a056902100800b00dc6d9eb6422mr17397ybt.10.1708544463028; Wed, 21 Feb
 2024 11:41:03 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:16 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-4-surenb@google.com>
Subject: [PATCH v4 03/36] mm/slub: Mark slab_free_freelist_hook() __always_inline
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

From: Kent Overstreet <kent.overstreet@linux.dev>

It seems we need to be more forceful with the compiler on this one.
This is done for performance reasons only.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..d31b03a8d9d5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2121,7 +2121,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 	return !kasan_slab_free(s, x, init);
 }
 
-static inline bool slab_free_freelist_hook(struct kmem_cache *s,
+static __always_inline bool slab_free_freelist_hook(struct kmem_cache *s,
 					   void **head, void **tail,
 					   int *cnt)
 {
-- 
2.44.0.rc0.258.g7320e95886-goog


