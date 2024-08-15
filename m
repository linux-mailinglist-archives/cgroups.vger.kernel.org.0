Return-Path: <cgroups+bounces-4309-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C73953AB4
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 21:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65D21C22557
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 19:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D05C78C73;
	Thu, 15 Aug 2024 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZVLUgqN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED405644E;
	Thu, 15 Aug 2024 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723749160; cv=none; b=PimpBWVGEvoG/YXEII4KjSzWwQCSBXl9jOVpLmkTrgOV/V0DflotozuGHemJDfwCBEbma7OpO9C0T2sS8LRSLpvhEt6xIhn0SJF7aeAn3KZEpFwahvhpOqWakBy1NRIQcZttziAxMCF9g6Yu7c0CX2Un1gcXuVO/A+gwl5ybg+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723749160; c=relaxed/simple;
	bh=mFfzZ3pFgqDb8mIZqmgPfNFtwYForYW8jYw7gaAy3c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZmskEsGDXjBNETDm0N+OSZn5lnR4DZsuYW+Farn+rzX3A6681o40UvmLysT8SpTdYvvnJ+MO/rFt0IpjXz1znyjtaBM9hCbQOWUElEOOf3JHWDR+V0fvW/pGZHsswGvsnFh6LOHV3lrl02Hi/AlazK/N66CODjMk5MdhETFCrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZVLUgqN; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf6beda0c0so7353976d6.1;
        Thu, 15 Aug 2024 12:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723749157; x=1724353957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFfzZ3pFgqDb8mIZqmgPfNFtwYForYW8jYw7gaAy3c4=;
        b=JZVLUgqN6++xTLUKeq/GzeeMKUn98j8WAJzKVbGO4mFMin+69KfUuCyFtm3nOlUI18
         C7fW0uLd5+9sZxZ2OLXV0Nf6gVM97g9ECNru1k+ulbK+24AfQ2uTwKNxac0LXfPXrWpA
         YOWqohvRzOUsDukbAO19B0/4lYCIxyGYXZdY21JVvlWqlj1kU7R+SNW8hEEcYAFHF0za
         NMguxNJ8/M0Em3qRCNzRuDs34G4uq0DZh9fFfkLMfQR8yl9fKIFUtcWsbMJrnHrlCY2O
         oh1WUNSyPNpR0yj9kvgTVk//+rxUPVP1FpHcM3Pt3csLUaOTrQp/OT75PMYsnV3O0P0H
         79/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723749157; x=1724353957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFfzZ3pFgqDb8mIZqmgPfNFtwYForYW8jYw7gaAy3c4=;
        b=Zjglpb1S64EoAEFPLU+YJyGI0DgsMrmFnF0lfAKxCv78QcWXkUbqxmXDb6d5CZpwwb
         UYbWWOg44JDCTgnkWElC5ScP3WVgum6E1lDMlDbodYCG8emAsSdwtR6CvnjgkLOc9vjE
         +hiVa7KMHE/YUtEDlQzVcDpm2QBLn5PrWqqXNIsahABRqsdmVrqfgIJBv71PKCw8Tg0R
         Dy/F5SmS0uFBJyDJsN+18x/BF5xu0X0LIei7dcF5l0fG/mSwoMIzJASGRxd028iT1y0c
         lhTs7tVfkvmCVqlArDBRprNDVABcMWxXREq1F4Q/3Uv/KwLlad7EaNFNyvojCL9xwxUS
         /SPA==
X-Forwarded-Encrypted: i=1; AJvYcCUWiOT8YH081qj+lyKa4ex84GAQhifJoK3YtUQUMjo10PaQBc9HHcUsUANAxZGmoHUAVvyxjOl0wPPzBiKV81WdP9eZXVmvz7iPf19GCcOIY4Ht8rr8xAhg8BMAMZ+AccPNbDZaYw==
X-Gm-Message-State: AOJu0YwcxAo/8OQ9qcVPyMqYSBuQLfqpotXXkBeXR4DqMpT5NgQdaRA0
	g0PwrPyfIjPWiZk1soeS+knAQLz3zPil3Xh4rZes48rOKvQnpiH3nW1ZNoSG3OPQCXtfufN5krZ
	QIMFVtxOGjIFGPsLNMqP/VydXHlY=
X-Google-Smtp-Source: AGHT+IEn/1oERfpX0KiSjifFU04Jgclm2hv8aboG2vr2BmvzqniXqnbcBMH4kvGFVH3Y1dIl6cPxXpob+kp2eSbtPzg=
X-Received: by 2002:a05:6214:5542:b0:6b9:5fb9:113f with SMTP id
 6a1803df08f44-6bf7ce04b10mr7208596d6.27.1723749157464; Thu, 15 Aug 2024
 12:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814171800.23558-1-me@yhndnzj.com> <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
 <CAJD7tkZ_jNuYQsGMyS1NgMf335Gi4_x5Ybkts_=+g5OyjtJQDQ@mail.gmail.com> <a2f67cbcc987cdb2d907f9c133e7fcb6a848992d.camel@yhndnzj.com>
In-Reply-To: <a2f67cbcc987cdb2d907f9c133e7fcb6a848992d.camel@yhndnzj.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 15 Aug 2024 12:12:26 -0700
Message-ID: <CAKEwX=MDZdAHei3=UyYrsgWqyt-41_vOdCvTxj35O62NZhcN2A@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from
 parent cg too
To: Mike Yuan <me@yhndnzj.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 1:43=E2=80=AFPM Mike Yuan <me@yhndnzj.com> wrote:
>
> On 2024-08-14 at 13:22 -0700, Yosry Ahmed wrote:
> > On Wed, Aug 14, 2024 at 12:52=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> =
wrote:
> > >
> > > On Wed, Aug 14, 2024 at 10:20=E2=80=AFAM Mike Yuan <me@yhndnzj.com> w=
rote:
> > > >
> > > > Currently, the behavior of zswap.writeback wrt.
> > > > the cgroup hierarchy seems a bit odd. Unlike zswap.max,
> > > > it doesn't honor the value from parent cgroups. This
> > > > surfaced when people tried to globally disable zswap writeback,
> > > > i.e. reserve physical swap space only for hibernation [1] -
> > > > disabling zswap.writeback only for the root cgroup results
> > > > in subcgroups with zswap.writeback=3D1 still performing writeback.
> > > >
> > > > The consistency became more noticeable after I introduced
> > > > the MemoryZSwapWriteback=3D systemd unit setting [2] for
> > > > controlling the knob. The patch assumed that the kernel would
> > > > enforce the value of parent cgroups. It could probably be
> > > > workarounded from systemd's side, by going up the slice unit
> > > > tree and inherit the value. Yet I think it's more sensible
> > > > to make it behave consistently with zswap.max and friends.
> > >
> > > May I ask you to add/clarify this new expected behavior in
> > > Documentation/admin-guide/cgroup-v2.rst?
> > >
> > > >
> > > > [1]
> > > > https://wiki.archlinux.org/title/Power_management/Suspend_and_hiber=
nate#Disable_zswap_writeback_to_use_the_swap_space_only_for_hibernation
> > >
> > > This is an interesting use case. Never envisioned this when I
> > > developed this feature :)
> > >
> > > > [2] https://github.com/systemd/systemd/pull/31734
> > > >
> > > > Signed-off-by: Mike Yuan <me@yhndnzj.com>
> > > > ---
> > >
> > > Personally, I don't feel too strongly about this one way or
> > > another. I
> > > guess you can make a case that people want to disable zswap
> > > writeback
> > > by default, and only selectively enable it for certain descendant
> > > workloads - for convenience, they would set memory.zswap.writeback
> > > =3D=3D
> > > 0 at root, then enable it on selected descendants?
> > >
> > > It's not super expensive IMHO - we already perform upward traversal
> > > on
> > > every zswap store. This wouldn't be the end of the world.
> > >
> > > Yosry, Johannes - how do you two feel about this?
> >
> > I wasn't CC'd on this, but found it by chance :) I think there is a
> > way for the zswap maintainers entry to match any patch that mentions
> > "zswap", not just based on files, right?
> >
> > Anyway, both use cases make sense to me, disabling writeback
> > system-wide or in an entire subtree, and disabling writeback on the
> > root and then selectively enabling it. I am slightly inclined to the
> > first one (what this patch does).
> >
> > Considering the hierarchical cgroup knobs work, we usually use the
> > most restrictive limit among the ancestors. I guess it ultimately
> > depends on how we define "most restrictive". Disabling writeback is
> > restrictive in the sense that you don't have access to free some
> > zswap
> > space to reclaim more memory. OTOH, disabling writeback also means
> > that your zswapped memory won't go to disk under memory pressure, so
> > in that sense it would be restrictive to force writeback :)
> >
> > Usually, the "default" is the non-restrictive thing, and then you can
> > set restrictions that apply to all children (e.g. no limits are set
> > by
> > default). Since writeback is enabled by default, it seems like the
> > restriction would be disabling writeback. Hence, it would make sense
> > to inherit zswap disabling (i.e. only writeback if all ancestors
> > allow
> > it, like this patch does).
> >
>
> Yeah, I thought about the other way around and reached the same
> conclusion.
> And there's permission boundary in the mix too - if root disables zswap
> writeback for its cgroup, the subcgroups, which could possibly be owned
> by other users, should not be able to reenable this.

Hmm yeah, I think I agree with your and Yosry's reasonings :) It
doesn't affect our use case AFAICS, and the code looks solid to me,
so:

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

