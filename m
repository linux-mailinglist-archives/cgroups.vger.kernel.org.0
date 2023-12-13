Return-Path: <cgroups+bounces-953-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BE981214C
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 23:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E18B21005
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 22:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118E47FBDA;
	Wed, 13 Dec 2023 22:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g51u3axR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC749C
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 14:16:07 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a1f47f91fc0so897624266b.0
        for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 14:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702505766; x=1703110566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLTmz5NciLF4rNowjjDuTk50N1sFl4Unka4K7FuS3Xc=;
        b=g51u3axRVVLcCfVOrOgDRgoDKAJRzi4ZICCEmEskpzYRNF2pGmKUOPLm49g2gJlZ3/
         dNrsry10+Fj4zbJWzcGoXowzkRNdfW9c4eT2gAzo7N466NJ0jgns0BO735adESleTjme
         0GWWwCc3bBJPR/Ko30jRHqHphT5XgnvQLMuWirnDaW9PvLufotOlQUgip9UeZICxUgxG
         mM6X8LocOmkzsT45kh0uyuubGLJq40hhemz+gcYHwuHFosWF/vK5p34fHLPr8FMfzl1U
         0V0RA/9bZ+KjS+xWm0YerDLgqxK8bQm+ZIBWaIenYiChM2NVRrWkVDqWWT9vHDrUasWP
         rIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702505766; x=1703110566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLTmz5NciLF4rNowjjDuTk50N1sFl4Unka4K7FuS3Xc=;
        b=mn1qxoldOl/6GREGvpVid2Q7Qxy2TjK3yODL3W/gu/OCUfQUhN0rLdoiClkMRakK7a
         jaFuFPiZ92aKwJFjeNDkB3eoyDXcvHlSsELWpNMKU9w3M0xYerKeqK7h0Yganhsn8RWQ
         o0NulXu0Y97DXWeVuz3xmDKJwN5YkBjRkggX95jjQqxfjpE/gxKdm0okXWDLhXe6F8Yf
         STSZ+8EIvaIodda0pdD25erqL+ge+d9PB4cjQm/YvstbDa7Nqp/N2JaXHiuFmBgLzVfb
         kkZLU0e/AxFY4ApP6zJFZg3NvZ2+9GJcTRx2BWrsmBzCRjg4hx++kETMMOd1r0oGZ2j/
         VO2w==
X-Gm-Message-State: AOJu0YwA0lIZEWLcnG5VOejueT5LgwhQB9HUjTRYvbxHWUBGUBZF8ujk
	x6KkMq2A4RDkRduGLqH9EOHoTydlnovoyG9p+2/uJA==
X-Google-Smtp-Source: AGHT+IFofV/+NPAePxHDP3xt0CYJYYFDLSmDOHSDQIVKivkX4dTllwijliAvjMwADo/c/q/pSQ1c0opm9Gl0ScjilW0=
X-Received: by 2002:a17:907:971d:b0:a19:a19b:55f1 with SMTP id
 jg29-20020a170907971d00b00a19a19b55f1mr6336000ejc.129.1702505765965; Wed, 13
 Dec 2023 14:16:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213130414.353244-1-yosryahmed@google.com>
 <ZXnHSPuaVW913iVZ@casper.infradead.org> <CAJD7tkbuyyGNjhLcZfzBYBX+BSUCvBbMpUPyzgHcRPTM4jL9Gg@mail.gmail.com>
 <ZXnQCaficsZC2bN4@casper.infradead.org> <CAJD7tkY8xxfYFuP=4vFm7A+p7LqUEzdcFdPjhogccGPTjqsSKg@mail.gmail.com>
 <ZXnabMOjwASD+RO9@casper.infradead.org> <CAJD7tkaUGw9mo88xSiTNhVC6EKkzvaJOh=nOwY6WYcG+skQynQ@mail.gmail.com>
 <ZXnbZlrOmrapIpb4@casper.infradead.org> <CAJD7tkbjNZ=16vj4uR3BVeTzaJUR2_PCMs+zF_uT+z+DYpaDZw@mail.gmail.com>
 <20231213202325.2cq3hwpycsvxcote@google.com> <ZXoTmwIiBoeLItlg@casper.infradead.org>
 <CALvZod7bGiQvEGjiDcKeFFDhdTkAr18rK+20orLX+vCkK4WUUA@mail.gmail.com>
 <CALvZod5X1E6BrT3ErO4OLn3zK__s9c9YQC+yc0T=Tx-gBD3ADQ@mail.gmail.com>
 <CAJD7tkYGwnbBAen_4P7_gAjxwBKCE6XxcMmmcrqJz27vVXSCMA@mail.gmail.com> <CALvZod4ky3tmKaqMW8wVQDOQNotmT+Wgu+HFpGN=uOSkZ6ZA6w@mail.gmail.com>
In-Reply-To: <CALvZod4ky3tmKaqMW8wVQDOQNotmT+Wgu+HFpGN=uOSkZ6ZA6w@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 13 Dec 2023 14:15:29 -0800
Message-ID: <CAJD7tkacrZ_ToSvqdkSFQ+hQAuxUWd1A8jDk-+5BDhx5xSwR+w@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: remove direct use of __memcg_kmem_uncharge_page
To: Shakeel Butt <shakeelb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 2:12=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Wed, Dec 13, 2023 at 2:05=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Wed, Dec 13, 2023 at 12:58=E2=80=AFPM Shakeel Butt <shakeelb@google.=
com> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 12:41=E2=80=AFPM Shakeel Butt <shakeelb@googl=
e.com> wrote:
> > > >
> > > > On Wed, Dec 13, 2023 at 12:27=E2=80=AFPM Matthew Wilcox <willy@infr=
adead.org> wrote:
> > > > >
> > > > > On Wed, Dec 13, 2023 at 08:23:25PM +0000, Shakeel Butt wrote:
> > > > > > On Wed, Dec 13, 2023 at 08:31:00AM -0800, Yosry Ahmed wrote:
> > > > > > > On Wed, Dec 13, 2023 at 8:27=E2=80=AFAM Matthew Wilcox <willy=
@infradead.org> wrote:
> > > > > > > >
> > > > > > > > On Wed, Dec 13, 2023 at 08:24:04AM -0800, Yosry Ahmed wrote=
:
> > > > > > > > > I doubt an extra compound_head() will matter in that path=
, but if you
> > > > > > > > > feel strongly about it that's okay. It's a nice cleanup t=
hat's all.
> > > > > > > >
> > > > > > > > i don't even understand why you think it's a nice cleanup.
> > > > > > >
> > > > > > > free_pages_prepare() is directly calling __memcg_kmem_uncharg=
e_page()
> > > > > > > instead of memcg_kmem_uncharge_page(), and open-coding checks=
 that
> > > > > > > already exist in both of them to avoid the unnecessary functi=
on call
> > > > > > > if possible. I think this should be the job of
> > > > > > > memcg_kmem_uncharge_page(), but it's currently missing the
> > > > > > > PageMemcgKmem() check (which is in __memcg_kmem_uncharge_page=
()).
> > > > > > >
> > > > > > > So I think moving that check to the wrapper allows
> > > > > > > free_pages_prepare() to call memcg_kmem_uncharge_page() and w=
ithout
> > > > > > > worrying about those memcg-specific checks.
> > > > > >
> > > > > > There is a (performance) reason these open coded check are pres=
ent in
> > > > > > page_alloc.c and that is very clear for __memcg_kmem_charge_pag=
e() but
> > > > > > not so much for __memcg_kmem_uncharge_page(). So, for uncharge =
path,
> > > > > > this seems ok. Now to resolve Willy's concern for the fork() pa=
th, I
> > > > > > think we can open code the checks there.
> > > > > >
> > > > > > Willy, any concern with that approach?
> > > > >
> > > > > The justification for this change is insufficient.  Or really any=
 change
> > > > > in this area.  It's fine the way it is.  "The check is done twice=
" is
> > > > > really weak, when the check is so cheap (much cheaper than callin=
g
> > > > > compound_head!)
> > > >
> > > > I think that is what Yosry is trying i.e. reducing two calls to
> > > > page_folio() to one in the page free path.
> > >
> > > Actually no, there will still be two calls to page_folio() even after
> > > Yosry's change. One for PageMemcgKmem() and second in
> > > __memcg_kmem_uncharge_page().
> > >
> > > I think I agree with Willy that this patch is actually adding one mor=
e
> > > page_folio() call to the fork code path.
> >
> > It is adding one more page_folio(), yes, but to the process exit path.
> >
> > >
> > > Maybe we just need to remove PageMemcgKmem() check in the
> > > free_pages_prepare() and that's all.
> >
> > You mean call memcg_kmem_charge_page() directly in
> > free_pages_prepare() without the PageMemcgKmem()? I think we can do
> > that. My understanding is that this is not the case today because we
> > want to avoid the function call if !PageMemcgKmem(). Do you believe
> > the cost of the function call is negligible?
>
> The compiler can potentially inline that function but on the other
> hand we will do twice reads of page->compound_head due to READ_ONCE().
>
> We don't have data to support one option or the other. Unless we can
> show perf difference between the two, I think doing nothing (leave it
> as is) will be the better use of our time.

Ack, let's just leave it for now. FWIW, I believe what this patch is
doing will eventually be the right thing to do once the code is
folio-ized and the calls to page_folio() disappear naturally anyway.

