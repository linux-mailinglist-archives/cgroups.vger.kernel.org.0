Return-Path: <cgroups+bounces-3858-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16069399A2
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2024 08:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBE01F223B8
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2024 06:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0519913C8FB;
	Tue, 23 Jul 2024 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ps302zRg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7FE1E4BE
	for <cgroups@vger.kernel.org>; Tue, 23 Jul 2024 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721715894; cv=none; b=Oy319BPblBNZa0JVGmL953P/HgkGHeohNGequu3EcNJRbgMxX9tz+DFZ+EFSTu4R6NuSwKAkXUoLu7EQwE2jPSSko0o4DxgDuCwfqVKeFLp6prob5ZjQg6qpdlOYyypngKiaXbEAY1nvTZcbVLqDET05XmEvPCyTUXSW3eeP+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721715894; c=relaxed/simple;
	bh=RmN1rRSG3lwxqRwK69yWPotzbJMTuS9ursXBcLAI8R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fR4Lqn7SNczk5F2kvJIw4FGLi8hGZYYgvXNYYxJgo97FmvGB0l+PCiht1zGvIeLYektHC2w6Otn9F0ObH2bFaCm9QAlvQXoB3nj01dL0Xx0J+cHVC/L1lnyUL1/xlI07SrG9h0sEmEOyVJkdXb/xYD8jv92YrILXR2aNyOwHj4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ps302zRg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a843bef98so26886766b.2
        for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 23:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721715891; x=1722320691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuZYvoWq8whgmpL1IFSnglW/V1EXZpX9C/pX5nqTQxs=;
        b=Ps302zRgsNAIWC+q4lyzGl7qUrmx549VMneWI5u08c8NgRDhyISQv5mMHPTPdaPtHn
         j5QpcXMpi7TwMHPTJecUNnAV1Vzj6RaOBGHcqbMK8S5g6VX9u+UzW/Iy9XDj3QT90ZSy
         5QclUW1RGmx3RIQW9Fb1forCiGCPC1A5jf7hS8CawETggMVUki2Zl/GkFoJ9iXr2i3Bm
         Xfce52O9gDR3twrwEdKKZgPwaJff2MvL71PV4DJnR/Xd1WdaWE+2MGDNgadJbahH3F2M
         8SFe/hH8gKdmwSbUspydE1A8XwhSJ5C/DZ37O/zhuVD2uY38fuKyVlqy+j+e5wiMrw0/
         xoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721715891; x=1722320691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuZYvoWq8whgmpL1IFSnglW/V1EXZpX9C/pX5nqTQxs=;
        b=wFKS49UCt/Q06oTycJcxBs7/BHdYsXzTkiXC9r64MvhkSihX21Mjx4a+wRh/Kw3pAc
         gmlXhYx5Ais8OAnKZWMRsuZh8TOjlev5r6EFmAhz1eVVe/zngyz2WYDICLiMoV4jIWK3
         rWMXqw+QNukwCeLghTSQNF0T809SwURc+7cXRIuInSC+FHzuzv0pOPpcSwhFA04/qKlD
         RlbhEpjfTMa+yTj/tGWcuE6QxQgcrcg+2giR/kdViCX4l+14VHvelezlGg4AnU85PmY1
         bmfWeqsFYUbxG70lUX0JfG4tsGZBN3ynSMweA1/FlJfiW8dP/VaHM/DLFI29euKxYPU0
         +wZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6WbWRXI4osU0cb6JUaMBMnsq6u++DkHKhdjQKv3YZiTto6wu94j9yWtTHVKaYVfnRgY3Y066Nhhf/El0KnRCGQH89x8EY5Q==
X-Gm-Message-State: AOJu0YwUPcVffztCHUgGk7euvXpgZnEJFa+ud5KKypCHm/SnAL7AkgWs
	uSuDaN8B+QHKTvoYA7wFsvXhBHutEwMnyjmD8SDb/Hqe5A29/3S0m+NLXFGv9AToeLV1W3EPi++
	H6TM/937Vp6jHV7fTe1kULt0q9+7L+wK30xbbzjJ/PXo4w1+LHg==
X-Google-Smtp-Source: AGHT+IGiQyOg6jtQNoklz56+z3NglFn5Y42p/i72Wp48qUQKGIwp/zuniQZ48JW9nBcy3wageNryev5duikJU+EPMvY=
X-Received: by 2002:a17:907:7296:b0:a79:8149:966e with SMTP id
 a640c23a62f3a-a7a4bfe6355mr623341266b.1.1721715890808; Mon, 22 Jul 2024
 23:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org>
 <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org> <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
 <5ccc693a-2142-489d-b3f1-426758883c1e@kernel.org> <iso3venoxgfdd6mtc6xatahxqqpev3ddl3sry72aoprpbavt5h@izhokjdp6ga6>
 <CAJD7tkYWnT8bB8UjPPWa1eFvRY3G7RbiM_8cKrj+jhHz_6N_YA@mail.gmail.com>
 <t5vnayr43kpi2nn7adjgbct4ijfganbowoubfcxynpewiixvei@7kprlv6ek7vd>
 <CAJD7tkZV3PF7TR2HWxXxkhhS8oajOwX1VG7czdTQb8tRY9Jwpw@mail.gmail.com>
 <x45wrx26boy2junfx6wzrfgdlvhvw6gji5grreadcrobs6jvhu@o5bn2hcpxul3> <ujfbtpvs6lpsuasz5dxvvcgyv2xorlhs2wjpjnpdyeicukwevx@2qj642cgn2ie>
In-Reply-To: <ujfbtpvs6lpsuasz5dxvvcgyv2xorlhs2wjpjnpdyeicukwevx@2qj642cgn2ie>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 22 Jul 2024 23:24:14 -0700
Message-ID: <CAJD7tkY1B9M6A8jHRuw4H8R95S9V4j_BkSQkDnr87_Tir+7VAA@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 3:59=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Jul 22, 2024 at 02:32:03PM GMT, Shakeel Butt wrote:
> > On Mon, Jul 22, 2024 at 01:12:35PM GMT, Yosry Ahmed wrote:
> > > On Mon, Jul 22, 2024 at 1:02=E2=80=AFPM Shakeel Butt <shakeel.butt@li=
nux.dev> wrote:
> > > >
> > > > On Fri, Jul 19, 2024 at 09:52:17PM GMT, Yosry Ahmed wrote:
> > > > > On Fri, Jul 19, 2024 at 3:48=E2=80=AFPM Shakeel Butt <shakeel.but=
t@linux.dev> wrote:
> > > > > >
> > > > > > On Fri, Jul 19, 2024 at 09:54:41AM GMT, Jesper Dangaard Brouer =
wrote:
> > > > > > >
> > > > > > >
> > > > > > > On 19/07/2024 02.40, Shakeel Butt wrote:
> > > > > > > > Hi Jesper,
> > > > > > > >
> > > > > > > > On Wed, Jul 17, 2024 at 06:36:28PM GMT, Jesper Dangaard Bro=
uer wrote:
> > > > > > > > >
> > > > > > > > [...]
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Looking at the production numbers for the time the lock i=
s held for level 0:
> > > > > > > > >
> > > > > > > > > @locked_time_level[0]:
> > > > > > > > > [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  =
             |
> > > > > > > > > [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@@@@@@@|
> > > > > > > > > [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                      =
             |
> > > > > > > > > [32M, 64M)   275 |@@@@@@@@@@@@@@@@                       =
             |
> > > > > > > > >
> > > > > > > >
> > > > > > > > Is it possible to get the above histogram for other levels =
as well?
> > > > > > >
> > > > > > > Data from other levels available in [1]:
> > > > > > >  [1]
> > > > > > > https://lore.kernel.org/all/8c123882-a5c5-409a-938b-cb5aec9b9=
ab5@kernel.org/
> > > > > > >
> > > > > > > IMHO the data shows we will get most out of skipping level-0 =
root-cgroup
> > > > > > > flushes.
> > > > > > >
> > > > > >
> > > > > > Thanks a lot of the data. Are all or most of these locked_time_=
level[0]
> > > > > > from kswapds? This just motivates me to strongly push the ratel=
imited
> > > > > > flush patch of mine (which would be orthogonal to your patch se=
ries).
> > > > >
> > > > > Jesper and I were discussing a better ratelimiting approach, whet=
her
> > > > > it's measuring the time since the last flush, or only skipping if=
 we
> > > > > have a lot of flushes in a specific time frame (using __ratelimit=
()).
> > > > > I believe this would be better than the current memcg ratelimitin=
g
> > > > > approach, and we can remove the latter.
> > > > >
> > > > > WDYT?
> > > >
> > > > The last statement gives me the impression that you are trying to f=
ix
> > > > something that is not broken. The current ratelimiting users are ok=
, the
> > > > issue is with the sync flushers. Or maybe you are suggesting that t=
he new
> > > > ratelimiting will be used for all sync flushers and current ratelim=
iting
> > > > users and the new ratelimiting will make a good tradeoff between th=
e
> > > > accuracy and potential flush stall?
> > >
> > > The latter. Basically the idea is to have more informed and generic
> > > ratelimiting logic in the core rstat flushing code (e.g. using
> > > __ratelimit()), which would apply to ~all flushers*. Then, we ideally
> > > wouldn't need mem_cgroup_flush_stats_ratelimited() at all.
> > >
> >
> > I wonder if we really need a universal ratelimit. As you noted below
> > there are cases where we want exact stats and then we know there are
> > cases where accurate stats are not needed but they are very performance
> > sensitive. Aiming to have a solution which will ignore such differences
> > might be a futile effort.
> >
>
> BTW I am not against it. If we can achieve this with minimal regression
> and maintainence burden then it would be preferable.

It is possible that it is a futile effort, but if it works, the memcg
flushing interface will be much better and we don't have to evaluate
whether ratelimiting is needed on a case-by-case basis.

According to Jesper's data, allowing a flush every 50ms at most may be
reasonable, which means we can ratelimit the flushes to 20 flushers
per second or similar. I think on average, this should provide enough
accuracy for most use cases, and it should also reduce flushes in the
cases that Jesper presented.

It's probably worth a try, especially that it does not involve
changing user visible ABIs so we can always go back to what we have
today.

