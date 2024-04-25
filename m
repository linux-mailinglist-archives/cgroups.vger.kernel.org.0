Return-Path: <cgroups+bounces-2707-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BEB8B2959
	for <lists+cgroups@lfdr.de>; Thu, 25 Apr 2024 22:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2834284A54
	for <lists+cgroups@lfdr.de>; Thu, 25 Apr 2024 20:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADC7152E13;
	Thu, 25 Apr 2024 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H8BEzjvY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F41C152539
	for <cgroups@vger.kernel.org>; Thu, 25 Apr 2024 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075258; cv=none; b=X7K9crXiA82Ri7pE80fphy+NTUblncjxQeeDtU10TiZerI/gSazf9O5JomUA7m4QtxotrK7U1v8P54W107MXCjNdiV6oNLwZjV9/ZbZKWcxILuflaA+8yGrg50lReEzgGYg9eeyVXkJxsX8L5ehWrQpGcOZwu+I+9tCxiKL4+z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075258; c=relaxed/simple;
	bh=RsL33zhcB30tglM6Diadti+mLV67sxPKk763/larZbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlflYDqmMk/qyJwj1oxKg7eTPwqL6x4oDkVab+viAXXc3HuikyvwSa8LZXWIWl7etfUZTVPH0GgCxncabmR0GwBAj0CuI7qBEYCT7Kcx8uUnN+5gLDXYW584f/0TdaA+gdF8YUz7f9HB9M0za7eRbUDAfoS4L1W/9potivWZaoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H8BEzjvY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e86d56b3bcso13079335ad.1
        for <cgroups@vger.kernel.org>; Thu, 25 Apr 2024 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714075256; x=1714680056; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MPiDO/NuWlBDCPQueU9revoy2ZKV+QsKTFlIIgwR/BM=;
        b=H8BEzjvYMqd9ukWk6BvhUgQeVYcytWXhHIUNyPbExaAqZYsGAzPqnETc9g/TjD3XVE
         Bc4cleGI/I5P0Vcg7omNm97w37kns1WF4/Xok9aUm1I4fKHJLZRc1rUPpZ+6ZVF+kGoJ
         0EtfuNI17tu7FfsLTOP2omZwBxwNGabLaQiLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714075256; x=1714680056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPiDO/NuWlBDCPQueU9revoy2ZKV+QsKTFlIIgwR/BM=;
        b=D4N5UD8q23GTwQpcg2T+3zz+dkTiDG/chsJEgUc7UMF/B1Z4zej2F9ztV5ITfZmoio
         VqWlq1AzelLqn0uIwZtStnQSBXc59C/UCdz4cFWuJ79bxqcNBeFp7iRJyp8r4OApC2KB
         Guw1z/rmpqeAok0Hmo2HpPU2SLOiTy38Y039KEw/Dmu4tAp8+8P6+mImo28THLWFok3V
         U6ZTMvKOhdolTkVZCXUAsWNvOsWzSFQZUHH7wqpxN4ctredMY+QeUA5sdl1R0cexj1JG
         69zuEYkT8jvsdCe5J5UYtmgq0gz/eIL13q3+zpraUVxls+4YdwOscGJwRAxTIxgVPZEZ
         lagw==
X-Forwarded-Encrypted: i=1; AJvYcCU0bfH6J5grQqZw2qFHfmJpM3Hvpoc/M/gIwpiKbn2HhwOFj87GVB5+KrNRhGMLrkqpnBGwsW9XQ47aA32X3j3tEbSje7vy1A==
X-Gm-Message-State: AOJu0YygrTeOUEQvIUdM4BrHbJnQ0ZdCJmttLuxwoLiObj0gvMNujFKx
	mhD38cNgK0epRNpWT9COgoXeL0RNHqj43svpDWHgxSbPfsigymnawR7I6Ovc9w==
X-Google-Smtp-Source: AGHT+IE6JexzSiX4UEJL+PmTLg5gqo1fs/oXapxe/m5ukwMdDHkh0tlGukFG1HB8DiSr+x/ZzZPsrg==
X-Received: by 2002:a17:902:e5c9:b0:1e3:f27c:457d with SMTP id u9-20020a170902e5c900b001e3f27c457dmr603222plf.65.1714075255870;
        Thu, 25 Apr 2024 13:00:55 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090311c500b001d8f81ecea1sm14246157plh.172.2024.04.25.13.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 13:00:55 -0700 (PDT)
Date: Thu, 25 Apr 2024 13:00:54 -0700
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, akpm@linux-foundation.org,
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
	willy@infradead.org, liam.howlett@oracle.com,
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net,
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com,
	tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
	paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com,
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com,
	ytcoode@gmail.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
	glider@google.com, elver@google.com, dvyukov@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com,
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
	kernel-team@android.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 00/37] Memory allocation profiling
Message-ID: <202404251254.FE91E2FD8@keescook>
References: <20240321163705.3067592-1-surenb@google.com>
 <202404241852.DC4067B7@keescook>
 <3eyvxqihylh4st6baagn6o6scw3qhcb6lapgli4wsic2fvbyzu@h66mqxcikmcp>
 <CAJuCfpFtj7MVY+9FaKfq0w7N1qw8=jYifC0sBUAySk=AWBhK6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFtj7MVY+9FaKfq0w7N1qw8=jYifC0sBUAySk=AWBhK6Q@mail.gmail.com>

On Thu, Apr 25, 2024 at 08:39:37AM -0700, Suren Baghdasaryan wrote:
> On Wed, Apr 24, 2024 at 8:26 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Wed, Apr 24, 2024 at 06:59:01PM -0700, Kees Cook wrote:
> > > On Thu, Mar 21, 2024 at 09:36:22AM -0700, Suren Baghdasaryan wrote:
> > > > Low overhead [1] per-callsite memory allocation profiling. Not just for
> > > > debug kernels, overhead low enough to be deployed in production.
> > >
> > > Okay, I think I'm holding it wrong. With next-20240424 if I set:
> > >
> > > CONFIG_CODE_TAGGING=y
> > > CONFIG_MEM_ALLOC_PROFILING=y
> > > CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y
> > >
> > > My test system totally freaks out:
> > >
> > > ...
> > > SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> > > Oops: general protection fault, probably for non-canonical address 0xc388d881e4808550: 0000 [#1] PREEMPT SMP NOPTI
> > > CPU: 0 PID: 0 Comm: swapper Not tainted 6.9.0-rc5-next-20240424 #1
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> > > RIP: 0010:__kmalloc_node_noprof+0xcd/0x560
> > >
> > > Which is:
> > >
> > > __kmalloc_node_noprof+0xcd/0x560:
> > > __slab_alloc_node at mm/slub.c:3780 (discriminator 2)
> > > (inlined by) slab_alloc_node at mm/slub.c:3982 (discriminator 2)
> > > (inlined by) __do_kmalloc_node at mm/slub.c:4114 (discriminator 2)
> > > (inlined by) __kmalloc_node_noprof at mm/slub.c:4122 (discriminator 2)
> > >
> > > Which is:
> > >
> > >         tid = READ_ONCE(c->tid);
> > >
> > > I haven't gotten any further than that; I'm EOD. Anyone seen anything
> > > like this with this series?
> >
> > I certainly haven't. That looks like some real corruption, we're in slub
> > internal data structures and derefing a garbage address. Check kasan and
> > all that?
> 
> Hi Kees,
> I tested next-20240424 yesterday with defconfig and
> CONFIG_MEM_ALLOC_PROFILING enabled but didn't see any issue like that.
> Could you share your config file please?

Well *that* took a while to .config bisect. I probably should have found
it sooner, but CONFIG_DEBUG_KMEMLEAK=y is what broke me. Without that,
everything is lovely! :)

I can reproduce it now with:

$ make defconfig kvm_guest.config
$ ./scripts/config -e CONFIG_MEM_ALLOC_PROFILING -e CONFIG_DEBUG_KMEMLEAK

-Kees

-- 
Kees Cook

