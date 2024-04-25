Return-Path: <cgroups+bounces-2709-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 654688B2ACA
	for <lists+cgroups@lfdr.de>; Thu, 25 Apr 2024 23:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FF9EB20F2A
	for <lists+cgroups@lfdr.de>; Thu, 25 Apr 2024 21:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A880A155A34;
	Thu, 25 Apr 2024 21:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zIEs2nrq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108BA155734
	for <cgroups@vger.kernel.org>; Thu, 25 Apr 2024 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080917; cv=none; b=RER5zpJsihB83jX52blqM3z6RYqbhMgXVyWP0G+VK5ASVWjFDzFnrAoZio035qjhx1aOZ8WujUAg5moM26C7chOV7HNV9tHzHj9v8lgjm+cWLQ8H3XH9RaBFTUDnqiqX6988fh/mhgRsrh9+kBXJf+gU+nbwz4TGNKC19XmFhUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080917; c=relaxed/simple;
	bh=2qnfxzwBZ+1IL0G1LGYLrncnZO5VsqWJdO3vHTL8sE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbZdHz18C93htBgkMptrdNJ4yh48ZWYSI/c72W+JA46a3yocMguGI+jXuaK1bUBfHkA4Wm4bmCDr/cnrXzEAZ1JmhU8k/2VIE0ReL7H4L4R9DthZQWefNlwfiGcMYcLXCw981AlWb/DQ+gLM6M4U5ZmrrHDRXk74C3hC9e8Ybz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zIEs2nrq; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc236729a2bso1521044276.0
        for <cgroups@vger.kernel.org>; Thu, 25 Apr 2024 14:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714080915; x=1714685715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNAVjZRL3SNvhEv7UtPjNVw2qSZLNXEHiDVYNBop7Cg=;
        b=zIEs2nrqO3yO9rI/l50CxSWuWlEnVu0aVTy68lWKm6PAGnFHe55G+yxIqqbDk6w2ef
         bZyxADXa0JJtf9apSYz7nbiZ1PFZlKD1xJ6QYmpWy6M5S9lviDwU+QjI3wB0vHHatDXK
         7nQiGkaetqvNPlPFLKQh86Ef64ZAuKT+gZ/gGf9GFUbUx9Um6G2vgYSNYAJUUeeGI9E3
         KxnUWMV22hbZjh0NKkwonQCDSb1ykK7Pw0WsAb9SQBcGAEF9Ubbi4j57rAOe7tinbUtq
         n6FRtN0EpyZys6jX3FKdcPfeN3OhRVzhaJntcMHuMkGcAWnclQDROROWIkWN/YAxXGA8
         NwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714080915; x=1714685715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNAVjZRL3SNvhEv7UtPjNVw2qSZLNXEHiDVYNBop7Cg=;
        b=lMe5/2HTdKGaAkimzY4PnSeP5vnsKOh61r4KYCfA/nlGfH1ldLKRiUslpNfYAcJUd8
         Lv2gOSPk1xMbntNaa5xTBdQR+Jjo4Y7wNHH3qGU2ggiTD698GFI+lHcHcuGxdMGQeHAT
         2ad4j04j5OQYct3rSWnoAXelNiG+PSkQISR/DBpznc6HnbzVdcwMnSj/fUppopfvBSD+
         I0jCSM/kRnu/5PwiJWoWJ5dyfY0zQANSLw6ud2p2MTIahfZEDjOL2lZ6izqDfyfhXP7n
         FZcdpsliE9lWLN+ijf75g1ntLsk1AmE+RkHKiPT4DT6r9xDP5kzuLIJ8ok21hAknuyqn
         MO/A==
X-Forwarded-Encrypted: i=1; AJvYcCX0wBz5ruv6/VbORQDeu+dEtRzvRSN0QGaGLHQ+xA/iQpg2jL8RpkXr/VzLvmbVDxxZ0BJdubAVu+zipH350oAOrLH0R5rO0w==
X-Gm-Message-State: AOJu0YwrgATbe6ckyCBm7UuCrjYNAMaled/ltw5eoV2HRHJiAqXDrTau
	XY7PV2auf4xSZOHwz7XMac96GVSwvUIqoBOkKqbeRGcUcNStxSLNtpDxCpFa4fAdoxwifwnA5Lm
	0aFL+bMFmC1gRpgkA6WU268jGx7jjrGfyEUKO
X-Google-Smtp-Source: AGHT+IGQ7MeXm0dvILJ0AXWrIM9WmgMhHcldUahIe6fZQn6xXrjGpkS7ue/fUW0Lq66Lii1hOI5w9eO9wnXdvzFvETU=
X-Received: by 2002:a25:c5cb:0:b0:de5:56ca:759b with SMTP id
 v194-20020a25c5cb000000b00de556ca759bmr991751ybe.2.1714080914454; Thu, 25 Apr
 2024 14:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com> <202404241852.DC4067B7@keescook>
 <3eyvxqihylh4st6baagn6o6scw3qhcb6lapgli4wsic2fvbyzu@h66mqxcikmcp>
 <CAJuCfpFtj7MVY+9FaKfq0w7N1qw8=jYifC0sBUAySk=AWBhK6Q@mail.gmail.com> <202404251254.FE91E2FD8@keescook>
In-Reply-To: <202404251254.FE91E2FD8@keescook>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 25 Apr 2024 14:35:03 -0700
Message-ID: <CAJuCfpHcz+GVjFqcjxq4=tCzJyPZFFRATWDNChyEUyV_Ru+g5A@mail.gmail.com>
Subject: Re: [PATCH v6 00/37] Memory allocation profiling
To: Kees Cook <keescook@chromium.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, akpm@linux-foundation.org, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
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
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, songmuchun@bytedance.com, 
	jbaron@akamai.com, aliceryhl@google.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 1:01=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Thu, Apr 25, 2024 at 08:39:37AM -0700, Suren Baghdasaryan wrote:
> > On Wed, Apr 24, 2024 at 8:26=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Wed, Apr 24, 2024 at 06:59:01PM -0700, Kees Cook wrote:
> > > > On Thu, Mar 21, 2024 at 09:36:22AM -0700, Suren Baghdasaryan wrote:
> > > > > Low overhead [1] per-callsite memory allocation profiling. Not ju=
st for
> > > > > debug kernels, overhead low enough to be deployed in production.
> > > >
> > > > Okay, I think I'm holding it wrong. With next-20240424 if I set:
> > > >
> > > > CONFIG_CODE_TAGGING=3Dy
> > > > CONFIG_MEM_ALLOC_PROFILING=3Dy
> > > > CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=3Dy
> > > >
> > > > My test system totally freaks out:
> > > >
> > > > ...
> > > > SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, Nodes=3D=
1
> > > > Oops: general protection fault, probably for non-canonical address =
0xc388d881e4808550: 0000 [#1] PREEMPT SMP NOPTI
> > > > CPU: 0 PID: 0 Comm: swapper Not tainted 6.9.0-rc5-next-20240424 #1
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 0=
2/06/2015
> > > > RIP: 0010:__kmalloc_node_noprof+0xcd/0x560
> > > >
> > > > Which is:
> > > >
> > > > __kmalloc_node_noprof+0xcd/0x560:
> > > > __slab_alloc_node at mm/slub.c:3780 (discriminator 2)
> > > > (inlined by) slab_alloc_node at mm/slub.c:3982 (discriminator 2)
> > > > (inlined by) __do_kmalloc_node at mm/slub.c:4114 (discriminator 2)
> > > > (inlined by) __kmalloc_node_noprof at mm/slub.c:4122 (discriminator=
 2)
> > > >
> > > > Which is:
> > > >
> > > >         tid =3D READ_ONCE(c->tid);
> > > >
> > > > I haven't gotten any further than that; I'm EOD. Anyone seen anythi=
ng
> > > > like this with this series?
> > >
> > > I certainly haven't. That looks like some real corruption, we're in s=
lub
> > > internal data structures and derefing a garbage address. Check kasan =
and
> > > all that?
> >
> > Hi Kees,
> > I tested next-20240424 yesterday with defconfig and
> > CONFIG_MEM_ALLOC_PROFILING enabled but didn't see any issue like that.
> > Could you share your config file please?
>
> Well *that* took a while to .config bisect. I probably should have found
> it sooner, but CONFIG_DEBUG_KMEMLEAK=3Dy is what broke me. Without that,
> everything is lovely! :)
>
> I can reproduce it now with:
>
> $ make defconfig kvm_guest.config
> $ ./scripts/config -e CONFIG_MEM_ALLOC_PROFILING -e CONFIG_DEBUG_KMEMLEAK

Thanks! I'll use this to reproduce the issue and will see if we can
handle that recursion in a better way.

>
> -Kees
>
> --
> Kees Cook

