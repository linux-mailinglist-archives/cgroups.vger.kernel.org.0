Return-Path: <cgroups+bounces-5164-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3739A4603
	for <lists+cgroups@lfdr.de>; Fri, 18 Oct 2024 20:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD86284137
	for <lists+cgroups@lfdr.de>; Fri, 18 Oct 2024 18:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104CC204018;
	Fri, 18 Oct 2024 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImtIdi5g"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EAB2038C8;
	Fri, 18 Oct 2024 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729276745; cv=none; b=FkLahP4CC0aTUs/Xs9P74BNLjW/3F41LjoYOgpNoP1h+Ja3xgohrx3vyA9J0Sa6CHPfKzA9mJpsOOY4K/VpWzRisbaEyuDIw1Hk0MO0hn4rHAjHpBPxP6bAz0xnAnqLTEso97DqOAKuxL7D2sBJ+6g/mrpq0Q55i9K6kmXpZAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729276745; c=relaxed/simple;
	bh=uXj2vblEs/WlhkDdzuqJptgAkmHLF67IfskPKZMxe1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZi/+QVXl8LNv5rABkoycto1EHOcRKAOJZ2ZC0R7VG/9JYcMepQPpmEUFRyXBCndwVWHVGNp2F1zw5RminUMHTs1IATXORFc0yIekq61QoXnQomQwgbfx0bLVLbeY80FCRRCrC5wSg0OAizRACiKI4uo5FL+TK775PeIJoOAkrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImtIdi5g; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so1790187f8f.1;
        Fri, 18 Oct 2024 11:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729276742; x=1729881542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXj2vblEs/WlhkDdzuqJptgAkmHLF67IfskPKZMxe1c=;
        b=ImtIdi5g3AMkeSSvwRSEcejvAtgWTDRnhRXxSIKIxm2JVMHMeMUPVvdsuTRdeZEXtB
         gUxYQJCv4Whd4tChU729ls+Kew/GYsJErkusjQv2Ur6D6E9jV8qVUZjS4Uxhq9yxq1wg
         vXqk1QeGvesC16HnVfCzYHMR9JLWjA8HsxSc5zw0SGLZZ/WNe1apiNU4QnPLsZvxjGAB
         p/uCzmw3MRaGx+16sapniKWh8lERWSjI+u3P7GTRfewZT7lZBEoOlysPULAJFIJSdoY5
         b9maHvCeyWcyTb6oUgIAjtzTyQdqwSVxHQzCPPD8pocN0XjGI1Zis8NOOB9UMBxOzoSf
         o1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729276742; x=1729881542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXj2vblEs/WlhkDdzuqJptgAkmHLF67IfskPKZMxe1c=;
        b=NGSvjSqoKPxnGHF8yQrxpP7stky+GYEXONq/1YbmqL/mAOCXbMxu/bvsA40AUELNCT
         ifODpVrLDCr1j1terxBTcaimD164iJupqJdIzhbJneXL4wKkCHZbcTJXsH9R4+0Wr90h
         qC1/ZM7UjA6F9cdpQTcxmjSiwhc6nd7+X15PE71b+Nl9M2mP/s66oC+kI5IC/3C3UtpJ
         WKMPST+t+rqCIkpUtXiUstMUzqtnSmmJbyyTSNd+NJUv/RUvosDxn8Wox4jIoK+dbZKc
         k+V6riBKUH48r4MU6PhcWUQBp756fE423PA7P/+6dX/L3uwlqDZQCeYNla0WJu7EgYp6
         qlXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVch6ToByzLpPQh9XfdiVe/ACWfRdmH8nEM9sDz0K6fMH8iUDfA9DWY5vukc7IDSWVEJbTpTRgBvS/6yPYg@vger.kernel.org, AJvYcCWh9IdbZIVOFbyqQz+CD+waR59lUzyPgeWTKBuuaAYduFwikXSGhEjXi+2mtZdtx834n4HBd621@vger.kernel.org
X-Gm-Message-State: AOJu0YyCyW1mNv7kD3sVfaZvzOHsg+xy5C5mhjcK81nL5GXW6I8oFoXR
	7pSCo4z+Oqz/LaATGpSAGgd119klbpwV801DY2Jzse2ct4F5+OzNtMdZ/pO8aUSrPYOFoMsm6Rq
	a+woR9PGAEOPg7rUtRBnMMg/oX3M=
X-Google-Smtp-Source: AGHT+IHiniw7KI+UuesyYI7EYwpugwCS8A1Mtubu3dtGbo4lqnm5fBpFsbLFNoaq9R957MjbjAdI4P+f2ngpcZpnkpc=
X-Received: by 2002:a5d:4983:0:b0:37d:33a3:de1c with SMTP id
 ffacd0b85a97d-37eb486ad19mr2477676f8f.38.1729276741686; Fri, 18 Oct 2024
 11:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>
 <ZxI0cBwXIuVUmElU@tiehlicka> <20241018123122.GB71939@cmpxchg.org>
 <ZxJltegdzUYGiMfR@tiehlicka> <il346o3nahawquum3t5rzcuuntkdpyahidpm2ctmdibj3td7pm@2aqirlm5hrdh>
In-Reply-To: <il346o3nahawquum3t5rzcuuntkdpyahidpm2ctmdibj3td7pm@2aqirlm5hrdh>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Fri, 18 Oct 2024 14:38:48 -0400
Message-ID: <CAN+CAwOHE_J3yO=uMjAGamNKHFc7WXETDutvU=uWzNv5d33zYg@mail.gmail.com>
Subject: Re: [PATCH 0/1] memcg/hugetlb: Adding hugeTLB counters to memory controller
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, nphamcs@gmail.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	lnyng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 2:11=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
> On Fri, Oct 18, 2024 at 03:42:13PM GMT, Michal Hocko wrote:
> > On Fri 18-10-24 08:31:22, Johannes Weiner wrote:
> > > On Fri, Oct 18, 2024 at 12:12:00PM +0200, Michal Hocko wrote:
> > > > On Thu 17-10-24 09:04:37, Joshua Hahn wrote:
> > > > > HugeTLB usage is a metric that can provide utility for monitors h=
oping
> > > > > to get more insight into the memory usage patterns in cgroups. It=
 also
> > > > > helps identify if large folios are being distributed efficiently =
across
> > > > > workloads, so that tasks that can take most advantage of reduced =
TLB
> > > > > misses are prioritized.
> > > >
> > > > This seems really confusing because memcg controller is not respons=
ible
> > > > for the hugetlb memory. Could you be more specific why enabling hug=
etlb
> > > > controller is not really desirable when the actual per-group tracki=
ng is
> > > > needed?
> > >
> > > However, we now have potentially a sizable portion of memory in
> > > memory.current that doesn't show up in memory.stat. Joshua's patch
> > > addresses that, so userspace can understand its memory footprint.
> > >
> > > I hope that makes sense.
> >
> > and it would be great to have an explanation why the lack of tracking
> > has proven problematic. Also the above doesn't really explain why those
> > who care cannot really enabled hugetlb controller to gain the
> > consumption information.
>
> Let me give my take on this. The reason is the ease and convenience to
> see what is happening when I see unexpectedly large memory.current
> value. Logically I would look at memory.stat to make sense of it.
> Without this I have to remember that the user might have hugetlb memcg
> accounting option enabled and they are use hugetlb cgroup to find the
> answer. If they have not enabled hugetlb cgroup then I am in dark.
>
> >
> > Also what happens if CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING is disabled.
> > Should we report potentially misleading data?
>
> I think with what Johannes has suggested (to use lruvec_stat_mod_folio),
> the metric will only get updated when hugetlb memcg accounting is
> enabled and zero otherwise.

Hi Michal, Johannes, and Shakeel,

Thank you all for taking the time to review my patch.

I was writing my response when Shakeel responded, and I think it includes
an important point. I am sending out this message in the hopes that I can
gather insight on what direction would make most sense for everyone.

Michal -- You brought up several points in your response, so I'll do my
best to answer them below.

1. Why is the lack of tracking hugeTLB problematic?

The biggest problem that I see is that if CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTI=
NG
is enabled, then there is a discrepancy between what is reported in
memory.stat and memory.current, as Johannes explained in his response above=
.

As Shakeel expanded as well, it is just convenient to have the value
explicitly there, so users don't have to go through and remember where
hugeTLB pages might be used and where they might not be used.

Aside from consistency between the two files, we can see benefits in
observability. There are many reasons userspace might be intersted in
understanding the hugeTLB footprint of cgroups. To name a few, system
administrators might want to verify that hugeTLB usage is distributed as
expected across tasks: i.e. memory-intensive tasks are using more hugeTLB
pages than tasks that don't consume a lot of memory, or is seen to fault
frequently. Note that this is separate from wanting to inspect the
distribution for limiting purposes (in that case, it makes sense to use
the controller)

2. Why can't you enable the hugeTLB controller, if tracking is so important=
?

By turning on the hugeTLB controller, we gain all of the observability
that I mentioned above; users can just check the respective hugetlb files.
However, the discrepancy between memory.stat and memory.current is still
there. When I check memory.current, I expect to be able to explain the usag=
e
by looking at memory.stat and trying to understand the breakdown, not by go=
ing
into the various hugetlb controller files to check how/if the memory is
accounted for.

But even if we are okay with this, I think it might be overkill to
enable the hugeTLB controller for the convenience of being able to inspect
the hugeTLB usage for cgroups. This is especially true in workloads where
we can predict what usage patterns will be like, and we do not need to enfo=
rce
specific limits on hugeTLB usage.

3. What if CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING is disabled?

This is a great point. The way the patch is currently implemented, it
should still do the accounting to memory.stat, even if
CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING is disabled. This would give us the rev=
erse
problem where hugeTLB usage that is reported in the statistics are no longe=
r
accounted for in current...

I think it makes sense to show hugeTLB statistics in memory.stat only if
hugeTLB is accounted for in memory.current as well (i.e. check if
CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING is enabled before doing the accounting,
or move the accounting from hugeTLB alloc/free --> hugeTLB charge/uncharge,
which should only happen if hugeTLBs are accounted for in memory.current).

What do you think?

Joshua

