Return-Path: <cgroups+bounces-952-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E008A812140
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 23:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948571F212AA
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 22:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4649B7FBD6;
	Wed, 13 Dec 2023 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lcqtXjVF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D6A9C
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 14:12:48 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35f69467104so8335ab.1
        for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 14:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702505567; x=1703110367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV8hyND0FtQ75xxFPin42YXNFIjC4p2jnNaORqS/TvY=;
        b=lcqtXjVFIFGRMVmeWPF5F8Vnv52YjunOmG1/yfPy+HJsuXxA+wA9Ycj48cTmn+C6qk
         3ebphUuAS2YsqT5u36uA58yueHmEB0MGeVwNieNX9/iXQ0Hu1wnip3GcFh74i6BrYDhD
         mKgaomk6rv/MkOFQkgObOw7yn2Zi0WLSds5Zx7RGuxU+4TbBNRoV/2pp750vwIhuWr3m
         gm8WT8fEfeIu1r56ntsuagbIke3bFgnz+MX+lQc+MZKh2BpD2EFUkvaxyOpX6udWIstJ
         RVcGkoMKu3R5HjZZsQOzMYT43KiKhgFwFuetGBzBLhMlQnwz77/Ekl4GGb9PTVnHSxQ9
         WylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702505567; x=1703110367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WV8hyND0FtQ75xxFPin42YXNFIjC4p2jnNaORqS/TvY=;
        b=nApFZAoHcfnjz24lH53JlT1RsI0kXq2/AjCjzhPtbp59ymoSdKN41V0rdwT51RQdiq
         4c3pgUOySCVQImHGLBW0ft7u58uwlLGu5E+7pKnUdokSs8zppaEeGpTIjcMefW9Qx7vB
         +OAF/ouwDkhp+qMDjQQ/RgtHW6iqlNhkW2F4Vt/vjE2Kg4LjT1A7iY+6thDf+l9mU5yM
         vHhB6Qe3z96bMHdCYfkQtzVmd6WO2Nyss1BruCW0L0CFLFVUR7zNRQs4wZ+XprSa40ny
         3FqUDZU/AnrRxRIppx1zQxL5mLmIlLoAX/F3rGnDJU+psWegeS89EGi7lxLT0YEm3Q17
         7eRQ==
X-Gm-Message-State: AOJu0Ywabv9TL8W9RWonnqKvPt8QB28Wo+FJI/7wKcU48zGbP/c1igRB
	UWG0q46MKjq0raXWvSd5aPNy3WBlrR/ZqpNasA/Vzg==
X-Google-Smtp-Source: AGHT+IENYcrxYE5ozTDxyGwMECNbjPG9m12x3ZX2sXfvOtjNSL0c9ZjSTfiKOVAwGHqGdEKIRiaNxhzGaPEG6BwgHnI=
X-Received: by 2002:a05:6e02:20eb:b0:35f:79b5:b980 with SMTP id
 q11-20020a056e0220eb00b0035f79b5b980mr155440ilv.27.1702505567505; Wed, 13 Dec
 2023 14:12:47 -0800 (PST)
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
 <CALvZod5X1E6BrT3ErO4OLn3zK__s9c9YQC+yc0T=Tx-gBD3ADQ@mail.gmail.com> <CAJD7tkYGwnbBAen_4P7_gAjxwBKCE6XxcMmmcrqJz27vVXSCMA@mail.gmail.com>
In-Reply-To: <CAJD7tkYGwnbBAen_4P7_gAjxwBKCE6XxcMmmcrqJz27vVXSCMA@mail.gmail.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 13 Dec 2023 14:12:35 -0800
Message-ID: <CALvZod4ky3tmKaqMW8wVQDOQNotmT+Wgu+HFpGN=uOSkZ6ZA6w@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: remove direct use of __memcg_kmem_uncharge_page
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 2:05=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Wed, Dec 13, 2023 at 12:58=E2=80=AFPM Shakeel Butt <shakeelb@google.co=
m> wrote:
> >
> > On Wed, Dec 13, 2023 at 12:41=E2=80=AFPM Shakeel Butt <shakeelb@google.=
com> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 12:27=E2=80=AFPM Matthew Wilcox <willy@infrad=
ead.org> wrote:
> > > >
> > > > On Wed, Dec 13, 2023 at 08:23:25PM +0000, Shakeel Butt wrote:
> > > > > On Wed, Dec 13, 2023 at 08:31:00AM -0800, Yosry Ahmed wrote:
> > > > > > On Wed, Dec 13, 2023 at 8:27=E2=80=AFAM Matthew Wilcox <willy@i=
nfradead.org> wrote:
> > > > > > >
> > > > > > > On Wed, Dec 13, 2023 at 08:24:04AM -0800, Yosry Ahmed wrote:
> > > > > > > > I doubt an extra compound_head() will matter in that path, =
but if you
> > > > > > > > feel strongly about it that's okay. It's a nice cleanup tha=
t's all.
> > > > > > >
> > > > > > > i don't even understand why you think it's a nice cleanup.
> > > > > >
> > > > > > free_pages_prepare() is directly calling __memcg_kmem_uncharge_=
page()
> > > > > > instead of memcg_kmem_uncharge_page(), and open-coding checks t=
hat
> > > > > > already exist in both of them to avoid the unnecessary function=
 call
> > > > > > if possible. I think this should be the job of
> > > > > > memcg_kmem_uncharge_page(), but it's currently missing the
> > > > > > PageMemcgKmem() check (which is in __memcg_kmem_uncharge_page()=
).
> > > > > >
> > > > > > So I think moving that check to the wrapper allows
> > > > > > free_pages_prepare() to call memcg_kmem_uncharge_page() and wit=
hout
> > > > > > worrying about those memcg-specific checks.
> > > > >
> > > > > There is a (performance) reason these open coded check are presen=
t in
> > > > > page_alloc.c and that is very clear for __memcg_kmem_charge_page(=
) but
> > > > > not so much for __memcg_kmem_uncharge_page(). So, for uncharge pa=
th,
> > > > > this seems ok. Now to resolve Willy's concern for the fork() path=
, I
> > > > > think we can open code the checks there.
> > > > >
> > > > > Willy, any concern with that approach?
> > > >
> > > > The justification for this change is insufficient.  Or really any c=
hange
> > > > in this area.  It's fine the way it is.  "The check is done twice" =
is
> > > > really weak, when the check is so cheap (much cheaper than calling
> > > > compound_head!)
> > >
> > > I think that is what Yosry is trying i.e. reducing two calls to
> > > page_folio() to one in the page free path.
> >
> > Actually no, there will still be two calls to page_folio() even after
> > Yosry's change. One for PageMemcgKmem() and second in
> > __memcg_kmem_uncharge_page().
> >
> > I think I agree with Willy that this patch is actually adding one more
> > page_folio() call to the fork code path.
>
> It is adding one more page_folio(), yes, but to the process exit path.
>
> >
> > Maybe we just need to remove PageMemcgKmem() check in the
> > free_pages_prepare() and that's all.
>
> You mean call memcg_kmem_charge_page() directly in
> free_pages_prepare() without the PageMemcgKmem()? I think we can do
> that. My understanding is that this is not the case today because we
> want to avoid the function call if !PageMemcgKmem(). Do you believe
> the cost of the function call is negligible?

The compiler can potentially inline that function but on the other
hand we will do twice reads of page->compound_head due to READ_ONCE().

We don't have data to support one option or the other. Unless we can
show perf difference between the two, I think doing nothing (leave it
as is) will be the better use of our time.

