Return-Path: <cgroups+bounces-65-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CC27D5ABD
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 20:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B711281ADE
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 18:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E6B30F9D;
	Tue, 24 Oct 2023 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yCiaZWxX"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7829215E92
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 18:39:08 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF76186
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 11:39:05 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32d9b507b00so3492360f8f.1
        for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 11:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698172744; x=1698777544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYl/hPQ1QO/qnjhfpaigT8V90o1Z/zrFBqqxchQb6PA=;
        b=yCiaZWxXRcnAxiUlTsv9w7FhSeSFqNa67B2b3PjcLp2h/ZumDiW6QSLTrRBQH9RaTj
         TSV2yfXmYFONRu5NIgMBuA4vev42FP04sO2ZTdbQ+5GgFeSM7tSZaqgxf/GapDfxIfPU
         9xAikhkPlOFOObe6aupQlpMQT2eBHTGQ3JDVAnhf7oyYdcJ0ktOvvSspdJdesBZZQLuS
         I5Bc19S1TYS7Hzg8ArNDDgEwv10Rxvtyda7md2HP8tMN1kfkXH+dP2yXhM/n9EetSPXw
         g1mVoNIpzsaEv/WhfPSK2pnBz8Kc0zRyH92+tmfQvSP5rfw/HF/8XfE6a+/3PjqaZ75d
         RC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698172744; x=1698777544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYl/hPQ1QO/qnjhfpaigT8V90o1Z/zrFBqqxchQb6PA=;
        b=p/smGXxXOVWVefxkIOucSJuYL4tg7f800hX7I0jbmz2nrX9E8osY+WqbDqzu1J03kw
         NLF/K2njGLH30SOMDozuhtWml8Vt0iXkOQ1TwYFS6kIZPA+w8qXACmwnXdVDyM87i+xi
         klGUw5pm6Ou83IjNtimUwdE0mszJ0S0j9jInyz71CkCzMrb1WwVzxlhWQbGAKzDyOTgG
         Mmj+kYUsIRwnnphowFUFb3HEZxs8Yy4OQYL1pW7Wf+PupIpz2jxLjG0Ty+nWIwAQE/xi
         mgA+XQKIB6schpjk2IRlqh+RkZcxKQRanW3bMmUBvR0+IaUv+go2PIV3ckPCzHHJnjpl
         A5GA==
X-Gm-Message-State: AOJu0YxpRzmfNap6IEuvsMdd+2kA+ffFtZymaQXNj5wNuY/sXBydjWwx
	SX1HitoiaOMoXZ897mk40XeD7waSzX3pxBo16h4wPg==
X-Google-Smtp-Source: AGHT+IEBkrXV9tW6JjjS6KAesMgogqWbIPz6JOX8ffpbsI1yBbmL6peaStLCV8xe25eowD6jRKUcC8TJUMwxtgmJk8k=
X-Received: by 2002:adf:fe8a:0:b0:32d:ad05:906c with SMTP id
 l10-20020adffe8a000000b0032dad05906cmr10224110wrr.3.1698172743492; Tue, 24
 Oct 2023 11:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com> <ZTgM74EapT9mea2l@P9FQF9L96D.corp.robot.car>
In-Reply-To: <ZTgM74EapT9mea2l@P9FQF9L96D.corp.robot.car>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 24 Oct 2023 11:38:47 -0700
Message-ID: <CAJuCfpGNQpFLnUsEpGgiDmOBW17RXJ3B-u2+ogi7NNhfi-gBLQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/39] Memory allocation profiling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org, 
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
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 11:29=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> On Tue, Oct 24, 2023 at 06:45:57AM -0700, Suren Baghdasaryan wrote:
> > Updates since the last version [1]
> > - Simplified allocation tagging macros;
> > - Runtime enable/disable sysctl switch (/proc/sys/vm/mem_profiling)
> > instead of kernel command-line option;
> > - CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT to select default enable state;
> > - Changed the user-facing API from debugfs to procfs (/proc/allocinfo);
> > - Removed context capture support to make patch incremental;
> > - Renamed uninstrumented allocation functions to use _noprof suffix;
> > - Added __GFP_LAST_BIT to make the code cleaner;
> > - Removed lazy per-cpu counters; it turned out the memory savings was
> > minimal and not worth the performance impact;
>
> Hello Suren,
>
> > Performance overhead:
> > To evaluate performance we implemented an in-kernel test executing
> > multiple get_free_page/free_page and kmalloc/kfree calls with allocatio=
n
> > sizes growing from 8 to 240 bytes with CPU frequency set to max and CPU
> > affinity set to a specific CPU to minimize the noise. Below is performa=
nce
> > comparison between the baseline kernel, profiling when enabled, profili=
ng
> > when disabled and (for comparison purposes) baseline with
> > CONFIG_MEMCG_KMEM enabled and allocations using __GFP_ACCOUNT:
> >
> >                         kmalloc                 pgalloc
> > (1 baseline)            12.041s                 49.190s
> > (2 default disabled)    14.970s (+24.33%)       49.684s (+1.00%)
> > (3 default enabled)     16.859s (+40.01%)       56.287s (+14.43%)
> > (4 runtime enabled)     16.983s (+41.04%)       55.760s (+13.36%)
> > (5 memcg)               33.831s (+180.96%)      51.433s (+4.56%)
>
> some recent changes [1] to the kmem accounting should have made it quite =
a bit
> faster. Would be great if you can provide new numbers for the comparison.
> Maybe with the next revision?
>
> And btw thank you (and Kent): your numbers inspired me to do this kmemcg
> performance work. I expect it still to be ~twice more expensive than your
> stuff because on the memcg side we handle separately charge and statistic=
s,
> but hopefully the difference will be lower.

Yes, I saw them! Well done! I'll definitely update my numbers once the
patches land in their final form.

>
> Thank you!

Thank you for the optimizations!

>
> [1]:
>   patches from next tree, so no stable hashes:
>     mm: kmem: reimplement get_obj_cgroup_from_current()
>     percpu: scoped objcg protection
>     mm: kmem: scoped objcg protection
>     mm: kmem: make memcg keep a reference to the original objcg
>     mm: kmem: add direct objcg pointer to task_struct
>     mm: kmem: optimize get_obj_cgroup_from_current()

