Return-Path: <cgroups+bounces-1500-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4305C852AC5
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 09:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A343AB2337A
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 08:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5D01C680;
	Tue, 13 Feb 2024 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQC6uG1A"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E949249EF
	for <cgroups@vger.kernel.org>; Tue, 13 Feb 2024 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812242; cv=none; b=bLnOTllTLfiDv1+CD5MLgp/R+D0pru6FCSewEuQeAkDzHNBoWVKzjO2VTlnfG1CdNzaOk279w27VV2zCNaQw+zORAgVOIotKWqRdZlqObH01RVEAOqOxcmfj/Qk9n+Qu7Q9A6s1hB6D8wNlrTzXDYvUPmR8W+O52uslmRSF3WDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812242; c=relaxed/simple;
	bh=k0dlcOpqCeQ859XsaJEpqmX/eHez3ZKf32wZRP8twEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rH+jg23hS933+QpuXnrdcfWsjbDJPhEEvgCmIpvSxTdV1uEiAMV6HzNsFzhuf2ch2DpoHCQvQXbdn6BwHCA5gfGZSYOZpXwnRM4lDYPWCBAZu20Tp5XI63YaeOa/Tiv/dWHK2w7d+m1wbUTLWn2Js3WhF92JiZWx6o4iOcTp1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQC6uG1A; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso3986880276.0
        for <cgroups@vger.kernel.org>; Tue, 13 Feb 2024 00:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707812239; x=1708417039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hC5Sp72DpOGszEFoskDK+zxBIS3uARFrNh6dT/DOYpw=;
        b=aQC6uG1AXej3oTFT3m2fKoYa7LYFxfuAxPkLfo/+dHttTZeAGK1ACiZfvHg7uw0Mk1
         NyffctXcL4SO7EBLTKauvlsluF9l45qqYYS/KQONb+jIPCiLK+c+WbNi/zBkjJmV5iQn
         WsnqaAKYBSrfSkW7fXdosoOrkNwAzcUp43y8upwgTF2pjdBLkjHiuPGOfOCToa6iDsSZ
         CavdtF6mFt5fTzar38xQes3PQzi0/e6CRsAp0GocFdrTQFzMDfarix1y1+EUFBjx1Fx0
         EFHr6x3Um7GcCahg2w7MywWIgN9lVJvVg/DnGOrIZQvRXVxFAH/k3iDSS1SZW7/xRNNz
         zarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707812239; x=1708417039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hC5Sp72DpOGszEFoskDK+zxBIS3uARFrNh6dT/DOYpw=;
        b=P0o3eX6r28wheESrUjwUISP8cFN9C4DlG7kCXtc1xe5XaXaM8OXwph/cXiuesP3tNC
         sQjuzgU1dJP6///GfxXotuMCCbv0ekn+meXT9ybke4IZLmSkJR58ryNxStYPmM5h7pyH
         JoCtWAZrcFQgghdTZyX4AwAn3q+dNryAi0VLlyNqCUv2J3HLyegznbM6KRfRrt85eKeW
         poYY8t+wD0QePYXSi+RB4HbG2gptp2jWCeo50pDnrotWOc1XxZWh1Kn5tAlr3h4iKUn9
         qHl4MMcbmTi5d9EY4WJQo9fgA2sLd7S8LLCd9vf0nvj6VcD82ZBuntDK4z9pBcLiAp7L
         NZqQ==
X-Gm-Message-State: AOJu0Yy1OhawahGEoSoEMnTUD6hKxYjcrAcXmnAmoAZl9b3vLluhjDw/
	bIaJkWUNBoXwUB1Ocuu7WETtgoXrYRgxbL517lyMNGT/B9KY3Fh/tGiMvwqnQKj1t6LEKR38IMX
	amHXxvCaN/bHw29wpNe1I9oWpOl+peLoQQZ9/
X-Google-Smtp-Source: AGHT+IHjpakmjDseMf+FthsBajS4lohi+4SNf65A0StZavoAeiHzVp/HPng86atAuU0FiQuCDBbDYkv0F+8/PL8mBAs=
X-Received: by 2002:a25:6841:0:b0:dcd:24b6:1aee with SMTP id
 d62-20020a256841000000b00dcd24b61aeemr45209ybc.47.1707812238953; Tue, 13 Feb
 2024 00:17:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-32-surenb@google.com>
 <202402121606.687E798B@keescook> <20240212192242.44493392@gandalf.local.home> <wvn5hh63omtqvs4e3jy7vfu7fvkikkzkhqbmcd7vdtmm7jta7s@qjagmjwle2z3>
In-Reply-To: <wvn5hh63omtqvs4e3jy7vfu7fvkikkzkhqbmcd7vdtmm7jta7s@qjagmjwle2z3>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Feb 2024 00:17:04 -0800
Message-ID: <CAJuCfpE2hMx4rUSex3rX_wWiGOt=rX5FWms98Rd6WAaVqW6yvw@mail.gmail.com>
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>, 
	akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz, 
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
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 8:33=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Mon, Feb 12, 2024 at 07:22:42PM -0500, Steven Rostedt wrote:
> > On Mon, 12 Feb 2024 16:10:02 -0800
> > Kees Cook <keescook@chromium.org> wrote:
> >
> > > >  #endif
> > > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > > > + {
> > > > +         struct seq_buf s;
> > > > +         char *buf =3D kmalloc(4096, GFP_ATOMIC);
> > >
> > > Why 4096? Maybe use PAGE_SIZE instead?
> >
> > Will it make a difference for architectures that don't have 4096 PAGE_S=
IZE?
> > Like PowerPC which has PAGE_SIZE of anywhere between 4K to 256K!
>
> it's just a string buffer

We should document that __show_mem() prints only the top 10 largest
allocations, therefore as long as this buffer is large enough to hold
10 records we should be good. Technically we could simply print one
record at a time and then the buffer can be smaller.

