Return-Path: <cgroups+bounces-4120-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB03B949BB9
	for <lists+cgroups@lfdr.de>; Wed,  7 Aug 2024 01:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27262B21764
	for <lists+cgroups@lfdr.de>; Tue,  6 Aug 2024 23:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A1D173347;
	Tue,  6 Aug 2024 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="mBjtzr0/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465E716D4DD
	for <cgroups@vger.kernel.org>; Tue,  6 Aug 2024 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722985266; cv=none; b=b7EzyeNTLa0vE5hwlUlEXCOJubVSZr81Lz1t4jzDqQcE9d0umVvwvkovK0MSPGAhgwWzorKUoaCbEI+yeBJHY9t/V2Wf0CvvPRnXbkcQCBZQvV+luxAMbuqthItGl64Q5Yy6sDBQopq74pXxskY+cTFi7E20bVOrCrD68vkHQoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722985266; c=relaxed/simple;
	bh=3QmhHNzLVdqCL3bdWzZ7LYa+8zX30H7zX+17oS8ce28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+kdRlWL5qac6AKfRkQDO3PimjF8XcyqHDDOwXo/mnFZ/iGhBG5dQq4HboL6oqSIlb5U49jjbwXR1fcedLHKcDAH2wKDzXfB7XKesu6y2rPTUGq8uD7dlJH8bb7KrLCadTmi3tsxMyicntjo+L26PE4T+95oZ5s1yiyb2MhxbLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=mBjtzr0/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cd34c8c588so799703a91.0
        for <cgroups@vger.kernel.org>; Tue, 06 Aug 2024 16:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1722985263; x=1723590063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPNbLMtMlLLk3ef/8hupZv2oNZsASyGwoL+TsrWxtR8=;
        b=mBjtzr0/RxfPzjs2Bgs1nhEuDYQskqEo0v34J+6sEsDvKgOQtxPhWCdTf1GLTH1Lr1
         Z2BUTcKyY29KHw1XCW0o83i2a4iLlo8/y3nTD7mzXxHJKGXjjVulZK2X8DwzvfdfPvMi
         xAFiCv/SIEldY+m390cUivxYtihx5/sawTDqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722985263; x=1723590063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPNbLMtMlLLk3ef/8hupZv2oNZsASyGwoL+TsrWxtR8=;
        b=PjwWDBpsmGD/gfXUL0bos0lskeQceFIewowIjXL9PA5g8RSlR2j15l/w/2HJk4OJzy
         INe4Gvznx/outrjwEaXTlTcijMgtHbEzGrLdRA0evm4UqxR1UOwY60lzK3xvj54m7CTS
         zOas0JCr8OXa+InK1VlCLVS/qhwdDUWFORjUEeZiet6DrMCkJmUNJPU5Nk1MTYDzpDnC
         jFFyTrf9bRHwQuV07B+X2YBTTYquJiprnxjBPnMj6Krpgr3QvvnfS1t1/K2s87ZfW96c
         27QB51s4g03Oa+wQ8l9N2L/jnWICrgR3d1sSHS6DxfN9/WZUradzbeaqAmxzIW2p4hT1
         KdJw==
X-Forwarded-Encrypted: i=1; AJvYcCV9+qin07QVUyCgB6bFxMsMafWfJ/JKBu9zlavPEuDdgdptxICQ/wO7biQPHJ1NCYNbm86k82fIVMuJeMIwWa6CC3qd4cHu0w==
X-Gm-Message-State: AOJu0YzEGSStyLdbmJ789wJ6/sfOz19svy0SHd5WLCYtPE+XXA0P41gO
	fgw9Ayw4ZzO8UB+dyKYuYiisU6xJtP5l6TUfzG/j8JYIcg34iz/NESsYFj4ZXEOt6QEEm5pV7nU
	JGdBTiCeukopLFW745CBSGmVaO6aRSn5C+8txUg==
X-Google-Smtp-Source: AGHT+IEN2odX5l/+pi6H8JnpGZi2+DwjbVmGTdY2gmufUn0E5fEtEbcCHGIJv7xFQvKm5zmLKFlcZB0qzECMPqVeKCc=
X-Received: by 2002:a17:90a:788a:b0:2cb:51e4:3ed3 with SMTP id
 98e67ed59e1d1-2cff9432e02mr16249465a91.18.1722985263381; Tue, 06 Aug 2024
 16:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730231304.761942-1-davidf@vimeo.com> <CAFUnj5Nq_UwZUy9+i-Mp+TDghQWUX7MHpmh8uDTH790HAH2ZNA@mail.gmail.com>
 <ZrKFJyADBI_cLdX4@slm.duckdns.org> <20240806153637.4549ee6c1d1300042dd01c4c@linux-foundation.org>
In-Reply-To: <20240806153637.4549ee6c1d1300042dd01c4c@linux-foundation.org>
From: David Finkel <davidf@vimeo.com>
Date: Tue, 6 Aug 2024 19:00:52 -0400
Message-ID: <CAFUnj5Nq74s4TVP=Ljmu4L5zUo+eqswfM0y57G5L6wD8wCdZAw@mail.gmail.com>
Subject: Re: [PATCH v7] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, core-services@vimeo.com, 
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 6:36=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Tue, 6 Aug 2024 10:18:47 -1000 Tejun Heo <tj@kernel.org> wrote:
>
> > On Tue, Aug 06, 2024 at 04:16:30PM -0400, David Finkel wrote:
> > > On Tue, Jul 30, 2024 at 7:13=E2=80=AFPM David Finkel <davidf@vimeo.co=
m> wrote:
> > > >
> > > > This revision only updates the tests from the previous revision[1],=
 and
> > > > integrates an Acked-by[2] and a Reviewed-By[3] into the first commi=
t
> > > > message.
> > > >
> > > >
> > > > Documentation/admin-guide/cgroup-v2.rst          |  22 ++-
> > > > include/linux/cgroup-defs.h                      |   5 +
> > > > include/linux/cgroup.h                           |   3 +
> > > > include/linux/memcontrol.h                       |   5 +
> > > > include/linux/page_counter.h                     |  11 +-
> > > > kernel/cgroup/cgroup-internal.h                  |   2 +
> > > > kernel/cgroup/cgroup.c                           |   7 +
> > > > mm/memcontrol.c                                  | 116 ++++++++++++=
+--
> > > > mm/page_counter.c                                |  30 +++-
> > > > tools/testing/selftests/cgroup/cgroup_util.c     |  22 +++
> > > > tools/testing/selftests/cgroup/cgroup_util.h     |   2 +
> > > > tools/testing/selftests/cgroup/test_memcontrol.c | 264 ++++++++++++=
++++++++++++++++++++-
> > > > 12 files changed, 454 insertions(+), 35 deletions(-)
> > ...
> > > Tejun or Andrew,
> > >
> > > This change seems to have stalled a bit.
> > > Are there any further changes necessary to get this patch merged into
> > > a staging branch so it's ready for 6.12?
> >
> > Oh, it sits between cgroup core and memcg, so I guess it wasn't clear w=
ho
> > should take it. Given that the crux of the change is in memcg, I think =
-mm
> > would be a better fit. Andrew, can you please take these patches? FWIW,
>
> I took 'em on Aug 4.

Great!

David, your spam folder beckons?

Oddly, I don't see any email from you on the 4th.
I do see my patches in mm-unstable now.
(I didn't see them there when I looked over the weekend)

With that said, I had a message go similarly mysteriously missing yesterday=
,
so it's possible something's wrong with our mail system.

>
> >  Acked-by: Tejun Heo <tj@kernel.org>
>
> Added, thanks.

Thanks again!

--=20
David Finkel
Senior Principal Software Engineer, Core Services

