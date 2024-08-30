Return-Path: <cgroups+bounces-4646-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BCE966944
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 21:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648CD1F235DB
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 19:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE02F1BC9FF;
	Fri, 30 Aug 2024 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="05cdAgAn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016331B29D2
	for <cgroups@vger.kernel.org>; Fri, 30 Aug 2024 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725044696; cv=none; b=PwobuBittNUaQOtooIzYNBhlcnQZWV6vy7ceCLGVqEWzo2U0tkQuFO/7QU17WcvrLCSD1n6rg5nL19rhhG7zuO6hjggMAcOVWHt3wDfmuWXyU/BahPoh/mckwmXdViDJfuQcfW6xX8vb8tfQ8Ym0YDj2+a6qwPc78DjPUGJ9bfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725044696; c=relaxed/simple;
	bh=k0LS5qtBUswMgqvBfneiqFMpv3IOMEx9hyg1k8+1YPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJ4Oqu+Mv/X0KJeIRDKBUgmzovQxmnyJp92o3TQtONuo6sLoBMYoC71P4hi2aois5jIXcpeKU1jVYKXkZl67rAi/i/dzQV1ljOEpe8evQGtshAcxT+fee7iAPzMS+TqeRSFsU5OLFyiaedxmHb2OkwIPDiGylQYCR5fR2hWHrHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=05cdAgAn; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3df03d1f1ddso1356340b6e.0
        for <cgroups@vger.kernel.org>; Fri, 30 Aug 2024 12:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725044694; x=1725649494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+oed5X3ICd5fPpoJH1QwaNbZnd+/2NqwMirUoUrwaQ=;
        b=05cdAgAnYcQGkomCEufhYs8qmpB3wgHyUrb3b5KD5UNQKRu+S0phtePBH4kj9XY//Z
         6tg1DXlyLmzYkH5kQF3wIvyMO+KoF9XIZw3/F1GIcGmM+0qdoFMHix3bnwneKrhcXE9n
         OIVKLHuGFR7DWqMUNF+xfO9Peva7ZHiXvhFQwVK5xxjwMf2rZLp0Ip7SHS2Fy0PTeaUg
         Dh89kJUlc8vgVuSbIYOoXQKU21A4K/I4lirKRMFj61vmzJFD0QfiiGbKpPH5Ri/aRU62
         KaivOgqolS8BwRv02E6tueZUdVCG0olDnkhDeR8XKOg2YdbAtfVSsXvpeLaj3sjio67U
         Or1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725044694; x=1725649494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+oed5X3ICd5fPpoJH1QwaNbZnd+/2NqwMirUoUrwaQ=;
        b=SuchQzORxGuWrZL1z48qs84oFTx8Fx9oDbFKt6a8/BtxGHyvkgiLaZF6vWXpyS4A8B
         YH5mx5RqNJ/kPVhHTV7RAOVmHt7vMEQ04Glt2v3FtA2HjyyYatX1hTeszRua0+nBDecI
         ZEW9OPwjhLoQAtDAt0R353JEipjMSQ6MCnLZPjUWiHSxqWNmRh0LOqIDMalKifnJG05+
         w/KJKwXGf4uW2deXh6KirfpTeaJ9mJXBcRqxVSCNmserCLx3NUVEWOOlMHx0s+ZfFQBD
         HZ/x5ZT5oN9OuzQn7Do4UbA7w40z3bpFukTCf9Rcy2FFIkUNcUmBoc058FnaO9Jec1TG
         ID5g==
X-Forwarded-Encrypted: i=1; AJvYcCVOO7Ja+0AyjCj26QUyD4I47xNa2E1IuknQICWJqJ++GHHrb2bihce/QRUs+teZFcrkZQQ+V1kO@vger.kernel.org
X-Gm-Message-State: AOJu0YzH1rXKSoP+1lhFsqv4qM8x9c5poAgnaAFDrPqMRTXH5yw+xrxn
	D4qWOfdVp+PhiYwt9Tcz6XdBch1fdbjGixVcy/md4809X2nX1VQvO5LZOwLe3Pw1pOwAS+XawEL
	idIKRRNQHr7TZaQKbyGAtqfvsm5AGFH872n4K
X-Google-Smtp-Source: AGHT+IHX9aU8yWEDpT+grmlscohk5Q8oTiUVyrd49xn2AheCv+N+Z7EnIH9qwE1WwtSRS8d6p9mAAqZrO4lBWzUbTTs=
X-Received: by 2002:a05:6808:4c0e:b0:3d9:2601:891c with SMTP id
 5614622812f47-3df05dbe483mr6485390b6e.30.1725044693783; Fri, 30 Aug 2024
 12:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827230753.2073580-1-kinseyho@google.com> <20240827230753.2073580-5-kinseyho@google.com>
 <56d42242-37fe-b94f-d3cb-00673f1e5efb@google.com> <CAF6N3nVWPJT+qrcz2jGw+sNoKge1qgDGSYg5f0Ur8a6O8ziUQg@mail.gmail.com>
In-Reply-To: <CAF6N3nVWPJT+qrcz2jGw+sNoKge1qgDGSYg5f0Ur8a6O8ziUQg@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 30 Aug 2024 13:04:17 -0600
Message-ID: <CAOUHufbREU2C0_r3K7Aqj01nYW+WeWyoPJZAkHkTM+6nbUsWGw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v3 4/5] mm: restart if multiple traversals raced
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	baolin.wang@linux.alibaba.com, tjmercier@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 11:45=E2=80=AFAM Kinsey Ho <kinseyho@google.com> wr=
ote:
>
> On Fri, Aug 30, 2024 at 3:04=E2=80=AFAM Hugh Dickins <hughd@google.com> w=
rote:
> >
> > mm-unstable commit 954dd0848c61 needs the fix below to be merged in;
> > but the commit after it (the 5/5) then renames "memcg" to "next",
> > so that one has to be adjusted too.
> >
> > [PATCH] mm: restart if multiple traversals raced: fix
> >
> > mem_cgroup_iter() reset memcg to NULL before the goto restart, so that
> > goto out_unlock does not then return an ungotten memcg, causing oopses
> > on stale memcg in many places (often in memcg_rstat_updated()).
> >
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >  mm/memcontrol.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 6f66ac0ad4f0..dd82dd1e1f0a 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1049,6 +1049,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgr=
oup *root,
> >                 if (cmpxchg(&iter->position, pos, memcg) !=3D pos) {
> >                         if (css && css !=3D &root->css)
> >                                 css_put(css);
> > +                       memcg =3D NULL;
> >                         goto restart;
> >                 }
> >
> > --
> > 2.35.3
>
> Hi Andrew,
>
> Would you prefer that I resend the series with Hugh's fix inserted?

Please send a new version to get this properly fixed, preferably move
the initialization of `memcg` from the declaration to right below
`restart`, and also add the following footers:

Reported-by: syzbot+e099d407346c45275ce9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/000000000000817cf10620e20d33@google.com/

