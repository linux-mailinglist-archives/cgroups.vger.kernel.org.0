Return-Path: <cgroups+bounces-950-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE6581204A
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 21:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457F51C210E6
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 20:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905477E571;
	Wed, 13 Dec 2023 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WixNw9Tz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58919C
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 12:58:24 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d0b40bb704so37325ad.0
        for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 12:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702501104; x=1703105904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjA89IEVHAVYT/DUQohpH3j1+gx/EjaXpeh999f1dzc=;
        b=WixNw9Tz6OuJx3DW4e/8NsgWA/4laS98stghm0/4bXbXiBDCIGKTOyitWuJbaK8UgZ
         bXX1yIIB4AufuqlHpDzakRR6H8cKQukf4A2Yn/bGO+z6Ko/8s1j7tm9F3vAQVSVCuegV
         nZnWLs7Hp65IQxBzeyOR33YDJFDlQ1PZa7nGZz29Cj9RJ9hGjWzQQUzChI2tyhIx8htr
         ir+Yf+4q+G/P8z+q8K80kpg0TGKkxQJvJWhUjKHPELPytE+3Va7XWvyWO4kD5ypVkK8b
         s3Ro/K0/b0l2kR8uOhzhIJkWovYnQ7rVAOMCZ/Xl9ztVJ1/H05vojtVJ/0/agcnuLZcY
         XYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702501104; x=1703105904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjA89IEVHAVYT/DUQohpH3j1+gx/EjaXpeh999f1dzc=;
        b=VnoaF5apsxSO2IqOwDLXuGNeZqvEeJEHfZ9tHrsIlIEXCvtAsz/UfjnAVpR/Ln7SRz
         yHQTHpceOPQhA//5iUp8qobfZNL345xP03zH5Y8LnV8+4lj01KtMIXUVktwQTsyH+j00
         pC8pbdIRhT96tqL/qfIGp7EkkSwNe6mHlhMJ3QuY5vUtVPN6SC70SDFRxZLBzQJoHxlb
         aQmMxg3ch2idItuMAghOoAMyHc7MQhJtapEJ7oKaOzRKPkUqDClzFRnDSLmo+awhgy36
         TsymT9Td78IlBzYtbQ1bdKwhaRD4CxG9rDlUDrd2cKOZO0yUhrBE7BkzifDUCRUoWIdd
         xcaw==
X-Gm-Message-State: AOJu0YxD5iHj/u6r/HIUgy3zQaHB2SNftWTaxO0bLHgJZAJbikQd5NAu
	XxTYbScd813iKsQK6ncVfT7seAYLyQXCRr9lIl0xxg==
X-Google-Smtp-Source: AGHT+IEiL4ergZMc81Oh9/1PFa2OeHSgr/9ucV1Bi0ZD5svsZR+k+77JXGoBnVON/ikzDWK1GyrNDq/Q4ZRU3bbgWi0=
X-Received: by 2002:a17:902:ecc3:b0:1d0:55ef:4f76 with SMTP id
 a3-20020a170902ecc300b001d055ef4f76mr1289567plh.9.1702501104079; Wed, 13 Dec
 2023 12:58:24 -0800 (PST)
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
In-Reply-To: <CALvZod7bGiQvEGjiDcKeFFDhdTkAr18rK+20orLX+vCkK4WUUA@mail.gmail.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 13 Dec 2023 12:58:11 -0800
Message-ID: <CALvZod5X1E6BrT3ErO4OLn3zK__s9c9YQC+yc0T=Tx-gBD3ADQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: remove direct use of __memcg_kmem_uncharge_page
To: Matthew Wilcox <willy@infradead.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 12:41=E2=80=AFPM Shakeel Butt <shakeelb@google.com>=
 wrote:
>
> On Wed, Dec 13, 2023 at 12:27=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> >
> > On Wed, Dec 13, 2023 at 08:23:25PM +0000, Shakeel Butt wrote:
> > > On Wed, Dec 13, 2023 at 08:31:00AM -0800, Yosry Ahmed wrote:
> > > > On Wed, Dec 13, 2023 at 8:27=E2=80=AFAM Matthew Wilcox <willy@infra=
dead.org> wrote:
> > > > >
> > > > > On Wed, Dec 13, 2023 at 08:24:04AM -0800, Yosry Ahmed wrote:
> > > > > > I doubt an extra compound_head() will matter in that path, but =
if you
> > > > > > feel strongly about it that's okay. It's a nice cleanup that's =
all.
> > > > >
> > > > > i don't even understand why you think it's a nice cleanup.
> > > >
> > > > free_pages_prepare() is directly calling __memcg_kmem_uncharge_page=
()
> > > > instead of memcg_kmem_uncharge_page(), and open-coding checks that
> > > > already exist in both of them to avoid the unnecessary function cal=
l
> > > > if possible. I think this should be the job of
> > > > memcg_kmem_uncharge_page(), but it's currently missing the
> > > > PageMemcgKmem() check (which is in __memcg_kmem_uncharge_page()).
> > > >
> > > > So I think moving that check to the wrapper allows
> > > > free_pages_prepare() to call memcg_kmem_uncharge_page() and without
> > > > worrying about those memcg-specific checks.
> > >
> > > There is a (performance) reason these open coded check are present in
> > > page_alloc.c and that is very clear for __memcg_kmem_charge_page() bu=
t
> > > not so much for __memcg_kmem_uncharge_page(). So, for uncharge path,
> > > this seems ok. Now to resolve Willy's concern for the fork() path, I
> > > think we can open code the checks there.
> > >
> > > Willy, any concern with that approach?
> >
> > The justification for this change is insufficient.  Or really any chang=
e
> > in this area.  It's fine the way it is.  "The check is done twice" is
> > really weak, when the check is so cheap (much cheaper than calling
> > compound_head!)
>
> I think that is what Yosry is trying i.e. reducing two calls to
> page_folio() to one in the page free path.

Actually no, there will still be two calls to page_folio() even after
Yosry's change. One for PageMemcgKmem() and second in
__memcg_kmem_uncharge_page().

I think I agree with Willy that this patch is actually adding one more
page_folio() call to the fork code path.

Maybe we just need to remove PageMemcgKmem() check in the
free_pages_prepare() and that's all.

