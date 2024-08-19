Return-Path: <cgroups+bounces-4353-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33704957420
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 21:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658AA1C235ED
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4431D54E9;
	Mon, 19 Aug 2024 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dEb37k3D"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216EC1D54CB
	for <cgroups@vger.kernel.org>; Mon, 19 Aug 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094386; cv=none; b=FlUcfXdfQgZNdpqbrDxO9StXA6QngDXS3/9wM3L/du1D/LF++lKG9kF2CUI5aj99m9gIeuR7oIZxSBrzWJBiczi5cN3fRd35439lAr3rraCD6RV8B1j95WJooEbmBxoAv0JjUOJH4g5gIMV4aBneyl5tew4/VALezNJu8Q0GDHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094386; c=relaxed/simple;
	bh=VISjCPnbKrAiztzAFSiDft/7IotbQpEpNxABM+V65y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNWgpzTuH88xwnhkb5MN6e81F2WccBS2uWKpR60yt1E4hCtEgjnLtu+Jaifc0HONE08oo7TdUTi1T7vmcP4brF8WGuA+082hVszz0eHY8iTR2N0w4dTr9mTRORMl/U02O9VCbf6Mt7gqCP6F6M+CwH8hHNGPwo8OYYljOJBZDVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dEb37k3D; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bec4fc82b0so6994351a12.1
        for <cgroups@vger.kernel.org>; Mon, 19 Aug 2024 12:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724094382; x=1724699182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VISjCPnbKrAiztzAFSiDft/7IotbQpEpNxABM+V65y4=;
        b=dEb37k3DTKLhz8943FgPqhFCqn/inW5/lh4q2piW4ieU3PxNsum/pDuOBxLn6OsUM+
         eZSiU2IOIKdEbpRDk0L898hVGU9rNHKDwrni1G/vcuNyHD41NoOfFNOPO+mnsOi2i9lP
         3srNcKxgGG4TQq2xZbsfzegoMc2h5bEDj4HP6gqn1WbhlJ83+l202SJYRkvkfuKUzZtv
         hQezWimQM1NjAD9JlOk9yt306H0yKJLA5jPzAYAu/M3tQ5PIFHA8M41hSc5ehwsH4ZLF
         MwDbuuwIaZ+nycZRhY89voLmmibkNPf2gJxL36zcU7mVW+dh3JIpSlhBPBjsIOQBQeDX
         2fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724094382; x=1724699182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VISjCPnbKrAiztzAFSiDft/7IotbQpEpNxABM+V65y4=;
        b=ajQ9LAn81hivhkxFWBOL3uu6uXN1VMpBYOxnbx7EZJPWjV5vDW4imIxhsDTTcv1L4W
         sGLgZRyctHDBPQgCwm+1NfdJOVTa6fCPPeTLQP4X9AHut4+pHcrpxGlf+96eBOXe2ygW
         UNPYoLAp9U0yoO31v8/bODVTCSaavPr1kZw4RRVzkz7zTal+9149iKDYYVrG37p6EUdn
         QW4hkZ2o1CQT69Q/BZ9He9HQZMnJpLI7w50UELi590LDMe/YnSSWNjDpAERm4ffcjtES
         FoLTZeBiCEjWuKoTIFefZuaeXBzi4Sc2QzIxUarW3eUppQTMpPyl8flB+1srhGDNoL6P
         oNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7JZ6cg/BrIW0QeW4QgBpwciGTLNku+oR07wiQlvYas8vExkRmarZ63GhwEWyqGx6H3UYlf8Xo@vger.kernel.org
X-Gm-Message-State: AOJu0YxY9wZcntA3Imve4DSCfTpqAIoR1Qgxgn4YGHNOmVTXkAwpWv3J
	RShIVOFOTWNqiLJrBAfKEKr4ikKX3bvW5MIbjVoRO2/5Tz5O6dPnofyBXYqBJ7dtdNy0VZ9xFnI
	9BxKQ3YYjcwLIvihKQ4wXqJby6SkGOqrGlYHC
X-Google-Smtp-Source: AGHT+IH0iRyJtUrU93XJ+DPiBi62y8rSBstCZOvrLtJz+l82/qtYFsRaQGGJ3beTy9fdroDR3Is5QPxMwnhk7Ke6ktU=
X-Received: by 2002:a17:907:3f0d:b0:a7d:c464:d5f3 with SMTP id
 a640c23a62f3a-a8643f7712amr60252866b.11.1724094381681; Mon, 19 Aug 2024
 12:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814171800.23558-1-me@yhndnzj.com> <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
 <CAJD7tkZ_jNuYQsGMyS1NgMf335Gi4_x5Ybkts_=+g5OyjtJQDQ@mail.gmail.com>
 <a2f67cbcc987cdb2d907f9c133e7fcb6a848992d.camel@yhndnzj.com>
 <CAKEwX=MDZdAHei3=UyYrsgWqyt-41_vOdCvTxj35O62NZhcN2A@mail.gmail.com>
 <20240815150819.9873910fa73a3f9f5e37ef4d@linux-foundation.org>
 <CAJD7tkZ3v9N1D=0SSphPFMETbih5DadcAiOK=VVv=7J6_ohytQ@mail.gmail.com> <CAKEwX=Pz4Pe-CAevBvxUCpPZJ-fRseLN4T35Wt3mb84gqCY25w@mail.gmail.com>
In-Reply-To: <CAKEwX=Pz4Pe-CAevBvxUCpPZJ-fRseLN4T35Wt3mb84gqCY25w@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 19 Aug 2024 12:05:44 -0700
Message-ID: <CAJD7tkaY3FsL-9YeDuVG=QtCK-dgm71EJ2L_T3KfGUa9VW_JkA@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from
 parent cg too
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Yuan <me@yhndnzj.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 4:32=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Aug 15, 2024 at 3:10=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Thu, Aug 15, 2024 at 3:08=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Thu, 15 Aug 2024 12:12:26 -0700 Nhat Pham <nphamcs@gmail.com> wrot=
e:
> > >
> > > > > Yeah, I thought about the other way around and reached the same
> > > > > conclusion.
> > > > > And there's permission boundary in the mix too - if root disables=
 zswap
> > > > > writeback for its cgroup, the subcgroups, which could possibly be=
 owned
> > > > > by other users, should not be able to reenable this.
> > > >
> > > > Hmm yeah, I think I agree with your and Yosry's reasonings :) It
> > > > doesn't affect our use case AFAICS, and the code looks solid to me,
> > > > so:
> > > >
> > > > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > >
> > > But you'd still like an update to Documentation/admin-guide/cgroup-v2=
.rst?
> >
> >
> > Yeah I'd rather see a v2 with updated docs, and hopefully a selftest
> > if the existing tests problem is resolved.
>
> Ah yeah, I was thinking this could be done in a follow-up patch.
>
> But yes, please - documentation. Preferably everything together as v2.
>
> >
> > Also, do we want a Fixes tag and to backport this so that current
> > users get the new behavior ASAP?
>
> Hmm, I wonder if it's more confusing for users to change the behavior
> in older kernels.
>
> (OTOH, if this already is what people expect, then yeah it's a good
> idea to backport).

My rationale is that if people will inevitably get the behavior change
when they upgrade their kernel, I'd rather they get it sooner rather
than later, before more users start depending on the old behavior.

I am guessing there is a chance this is not what backports are meant
for. Andrew, any thoughts on this?

