Return-Path: <cgroups+bounces-2122-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9A4885EAB
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 17:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8061F2205B
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 16:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885BB146010;
	Thu, 21 Mar 2024 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n1FznddA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EC1145B2A
	for <cgroups@vger.kernel.org>; Thu, 21 Mar 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039111; cv=none; b=MZDr79xR/q1hVbbLInj7PdOtGYTpEBeJru0iuVnPBFMPI0hLbyJSwiMH8ltQtr2lYemJWI9ZLABvdYPrKEUeQSLJGCOLWM/pUhEcJwobjgcpM19sjwXc6GCqWznuPGOa6mxfjBCFfs6oPOxzxqJa28ykKzVVK7efCT6nCek6Ex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039111; c=relaxed/simple;
	bh=T2jUZ7QMLZPcjI/ns9fVxadJ0NRTRbQsVWpuPq58jmE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mLhe1Fw/NOdTNmFf320WPinUCRpL7QoCfmq9A7iVRAMZ16B05O+U+IZFrOKx6ZfIs56XIG+vMDxbbKDYC3QWilfD4HkAlBeoMx9RccY2slJwlnwLpBYpK+xXzCJy0+tKhs+87mDdNa5gIa8pWVt9k7GkN8/s8krTuyoCw5MlWzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n1FznddA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a08eb0956so17789367b3.3
        for <cgroups@vger.kernel.org>; Thu, 21 Mar 2024 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039108; x=1711643908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AW33WX/ioh4EflqxU3ax5xPoUVjwxdtM7w8zUOaZaKk=;
        b=n1FznddAhEad7Uo+wB0FToFQ6tjHwLwFKY0i6peYxtLq6FrkNul0uhYsa8Dbk2gSFR
         j0eSnflo6yOWoCOwBhPT8y5TFTMWsKcBuXP6YLn4fQ2+Nr/Z39qgaCBnmN0l5IEz/Nqv
         vkItvd3axZDBr1fEEkPvfUuv3R5BkJviED5Mcq11pY2m9xhEHEFf1ZqT9nAZAhieMRR2
         nWTJVMdEaUSIMAux12vPr1fAwaR2UUMHcSbnktw1xKo5L6YTovTe4y9F/X/VRJaP8+xO
         y89LX0dnt5SISFkPWeKN3T99+XBJ+I24bKskWhbaHWEBDhE/lB4eFAogOU1k7OSC6xu9
         aUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039108; x=1711643908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AW33WX/ioh4EflqxU3ax5xPoUVjwxdtM7w8zUOaZaKk=;
        b=ZpoaOz3IKoib0ToaGzPmizd3WNWIKBb2aBpUSj27PZYdf6NJtulf69PH+bHATUUgqX
         EIgXWerO7t6J4EqyhGQXFR3FMGEoz4NbSsSUMdwa0bKWgAp9ueaTeomYO0B9qsgAx1/i
         fomukYUbt/D5+rHJ0dCnoZ8kYgbRhjZZjry4wDCQtbmAx2s9ITLXVOf/zGsXDGtn6A8y
         WZzmYomufBzQtd68YesrlvxpdTSn7tzCs0CCgKlf0g8xZ1QYm6Al/l2/p0z5ROxQiYur
         pdOJnYq8NWTNAiPCPHC+uv5iRf6xxjExwUhma5NJGglychmG2I7sBby3/7FdIZp0GXKh
         W8nA==
X-Forwarded-Encrypted: i=1; AJvYcCV41kgK/0ijWaH2bDEJP5vOrwthGRMwlyXcIro9uEn6GyIc4f3+2qz/Rfl9sZTPf753Yv/QiBtMezYCcn5HQUVUR05TpFagLA==
X-Gm-Message-State: AOJu0Yxg9Fl0M9JZQmG+AVdJREQU/YQ0t6TTmXgcwamrlS42PQJAGe6C
	LbUdzyfx0jkn9UrNs/WAP1I5j4JO4ZQwJ1kKJbMpckk43VkA4b9WvUv2ut3AfAy4MxelQgBAN/0
	NWQ==
X-Google-Smtp-Source: AGHT+IF7IbSbPrud7S4q2CO6A5a//4lNXuqCjaSBMjwnNeD7U+hML/0+WVDue04lWzY5rl3DmStBxkMY2eM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:11cc:b0:dd9:2789:17fb with SMTP id
 n12-20020a05690211cc00b00dd9278917fbmr720825ybu.3.1711039107919; Thu, 21 Mar
 2024 09:38:27 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:58 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-37-surenb@google.com>
Subject: [PATCH v6 36/37] MAINTAINERS: Add entries for code tagging and memory
 allocation profiling
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

The new code & libraries added are being maintained - mark them as such.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d5f99cc986d1..84c1505bc62a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5241,6 +5241,13 @@ S:	Supported
 F:	Documentation/process/code-of-conduct-interpretation.rst
 F:	Documentation/process/code-of-conduct.rst
 
+CODE TAGGING
+M:	Suren Baghdasaryan <surenb@google.com>
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+S:	Maintained
+F:	include/linux/codetag.h
+F:	lib/codetag.c
+
 COMEDI DRIVERS
 M:	Ian Abbott <abbotti@mev.co.uk>
 M:	H Hartley Sweeten <hsweeten@visionengravers.com>
@@ -14123,6 +14130,16 @@ F:	mm/memblock.c
 F:	mm/mm_init.c
 F:	tools/testing/memblock/
 
+MEMORY ALLOCATION PROFILING
+M:	Suren Baghdasaryan <surenb@google.com>
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	include/linux/alloc_tag.h
+F:	include/linux/codetag_ctx.h
+F:	lib/alloc_tag.c
+F:	lib/pgalloc_tag.c
+
 MEMORY CONTROLLER DRIVERS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.44.0.291.gc1ea87d7ee-goog


