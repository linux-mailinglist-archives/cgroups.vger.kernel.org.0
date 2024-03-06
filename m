Return-Path: <cgroups+bounces-1971-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E03C873E8E
	for <lists+cgroups@lfdr.de>; Wed,  6 Mar 2024 19:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCCDA286DDC
	for <lists+cgroups@lfdr.de>; Wed,  6 Mar 2024 18:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E63514037D;
	Wed,  6 Mar 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1KfMp0PK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BE913F004
	for <cgroups@vger.kernel.org>; Wed,  6 Mar 2024 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749492; cv=none; b=TeWa3kW7EJWMO0yui40SSVuC8w1jZW+LoMEJM59UnPNY3EkxROz9/JDLP0wo2hNZlzFVdeFcQrKZaU2s8OXg1zMziQkHzvRnSYuyuGDjQPAHT+nSamGJEujHA2IGSF1jOkVaLtp8D0Q+zIWKhuPsWx8u3uDsOLu0IBslEJBFpqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749492; c=relaxed/simple;
	bh=WLWDcJtwdBHze169gQOcBi865vcRSQ+3nZi2PdvDZ/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tcTdLzRiZaZTQIcwJaBOgMgnmg8YP4LKP2ZQP9Fdm3h7J8vJXwN8rW24moJb4XTL5G3WE979vYOPrEprBDGy1n+AQ3JGZFxnMqAnN6NhKxw0vK0SLbIx4DQeb9wQk7WD/GQ0+5ANP9Yv5l5VwkBdBcXdKMz+2PaApxAlZb6g79Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1KfMp0PK; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f38d676cecso15099007b3.0
        for <cgroups@vger.kernel.org>; Wed, 06 Mar 2024 10:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749489; x=1710354289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IB/ApQiOXGBR0WmAItdSsQq8CBMweolDZikHX0/GsD8=;
        b=1KfMp0PK5sV5fxGjrToabD8KFuTy7c2KLrtthvHdsw9bYvxmbdBEfYqMsA3t6p3hug
         PKR133x6UYvB8tg532ueA425iSPUq/+f3uUqOUygBb9+LhcbRTR/CAm47ye5mUojs3fb
         rxhjipNeDQMMTkgV9OkKN7DELynUc/O0bidvJiQZ/WyCLK/bwL8flJFyI8YVN3vxOZ3w
         VKFHW/nBRyfxXn88trP3JLJuDICHOUW0j+wJ0mpYyYApSOaTTH0UQEwNLYLEfrkW4fjB
         6OiTIgXGG8YQBbO2huzbhp/QWb44h+0kX+skM6nn2lDkbCI7YUiZ6X33Vm+DZoWIJXQW
         ecCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749489; x=1710354289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IB/ApQiOXGBR0WmAItdSsQq8CBMweolDZikHX0/GsD8=;
        b=eW/E9/MU4WphTe/DgCsSI+F1RI30liw8rYXx6vJv6rmaq89UPjW5nyshXa7LfcZaJP
         URluTJ5osyT/lACiqYUfYZixxA/INatszklr0OUmymake68tJ9u8UyQv8NdTYjLEdPZa
         Ghr7LGrtag2bJbBXaH2ZA1hKMizX7TuTJBwW55XcMmO9DNelHJ58NEx6s+t1cFoDU9kk
         X8BMvmm0j5OsA7985FInh2BQYheL0cHlxirm2FuqlozOjp/Zj9o3CCPy9nitIZu5gJDe
         BWH0c924syeDTK0AzH0t8/AENG0mTMnce47Qw749Amj54fhhdhFMeP50BqA5cevpWOMx
         hYUA==
X-Forwarded-Encrypted: i=1; AJvYcCX6zeo+YDjM4tKRJdoOx3Sp2s0OmfIXXdemYXzv2+fC4FYbo8BLdFFTsBEvz/mWzg51Aq76DAxQaLu55wXo7SwVyJmeXGQikA==
X-Gm-Message-State: AOJu0YzC48cqcarDyF/LNe5p7VgGhH4FQ1ZiQnn4bo7pb6B5sbeabEul
	1AxwquV3FRHCxYt/dYOSpLapkPCeO6OW4sYKMK4Get6xUzRjPYZAMmq+ipAdlylKWS7Q1biA7+L
	zXQ==
X-Google-Smtp-Source: AGHT+IFVqihldBNv4wgyZ0iAVVxZ+bY4OMcJ5N94UurEgGn8+DdCU01VG5gLaZEk+WmQHH2kGW3d+2j2Wcc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:110c:b0:dc6:e884:2342 with SMTP id
 o12-20020a056902110c00b00dc6e8842342mr1897962ybu.5.1709749489247; Wed, 06 Mar
 2024 10:24:49 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:00 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-3-surenb@google.com>
Subject: [PATCH v5 02/37] asm-generic/io.h: Kill vmalloc.h dependency
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
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

Needed to avoid a new circular dependency with the memory allocation
profiling series.

Naturally, a whole bunch of files needed to include vmalloc.h that were
previously getting it implicitly.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/asm-generic/io.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index bac63e874c7b..c27313414a82 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -991,7 +991,6 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
 
 #ifdef __KERNEL__
 
-#include <linux/vmalloc.h>
 #define __io_virt(x) ((void __force *)(x))
 
 /*
-- 
2.44.0.278.ge034bb2e1d-goog


