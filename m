Return-Path: <cgroups+bounces-8310-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC24AC0311
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 05:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8EC1BA76EA
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 03:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DD27E105;
	Thu, 22 May 2025 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Dl1hPn9D"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D0B35958
	for <cgroups@vger.kernel.org>; Thu, 22 May 2025 03:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747885104; cv=none; b=lGRQ6q/8lc3nrebWmiHbdkN4ZdBMPi8YRMH9vqGzB91ubbeiQxdb+5IXo7+o7uoesWD5P8C/m66jOunIWzenkZT1Kz/Jnd/YvOJOBwwmCgJpOhiS5kLdqoVv1P64uuyz6yCzwLnvSrKkuVFgPV7gK39CjxHjQ194UBBxaP30fRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747885104; c=relaxed/simple;
	bh=B7veKucd9havkmICdUO03JBu9TGnzFuhn52QBIcZg2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubBudhXlu0FxC269Y+LtyrJlw4iqzZMIJvuFGGqW7jfOhwhwKH2sTJLVrj5vb4Dp/JsUXn8l1euI9XyhrZasY0vIJvQS+QZnhPl/dCPOogUHmIemfpQ+Qh0M4oPe09+rEjd+iyi3loFetbdDcqkf8bebFyVQbNLNgvT39VltIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Dl1hPn9D; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54d98aa5981so11222605e87.0
        for <cgroups@vger.kernel.org>; Wed, 21 May 2025 20:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747885100; x=1748489900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FgYPmyylCiukNuFzG8jcow5rsM4M/8YB+FTfMVmi2A=;
        b=Dl1hPn9Dj4YEJXQ/50MTKV7RFktuQ4Ko7OIs/pYVTgngmcDAvoZdi9KBtIcX9EMoEs
         emp1fSTY3wFXua7PISLfVCr6lZwjFgt6X1lNR49Wsj8UC/C7m4yKT/gfgfgt0vz2M1Wu
         myGgZg0eIqeV1efQPoLbk9Yxwd5qWVlmSBnmwn8HuQsMGgrbk30PDnH91CAxQWWuVGSa
         IsPO7JzayPwmYL/WLHMWkFv4DkZT8ZKfaQgu9MidsQa34glbwp6cQkCT68KglGJn2Px6
         lx/sYDmIaPVy/6xyVFMfr5fPJXtKZ7Tt0qUe/icYO+HhfoXMJzBdAHaOHJxVamaYh2n3
         H0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747885100; x=1748489900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FgYPmyylCiukNuFzG8jcow5rsM4M/8YB+FTfMVmi2A=;
        b=pxVgbzCRvcx1J7JxqpeHnWKPjaOtQMXqvcvrgXxMHmCuUJhm867s2u5U4bfzw3M6Hj
         XiJn5uAWOiCskjTfHRg/mshLF1MrH2ZOsq7juFWPI44hm1wXSGmfKMV+JihKZqxcIHrE
         q6+ddIo4w/KO2HEJTvLVUSQG2F/pA1W8+dtFyYPpl2ydF29AYwq3Ov/GB2mAPNiU0jDd
         S8T32U3re8Q5FcTIEon4RqId3AkzctXvJ3X2qF5Am35yhmBPXqerIuflaoOGVs4aZzIA
         rIVZEQ1z1ubVgTrwg1x4gvwWMMEw5YN/fCoPYEEIRvpPt5Bwtamc7mwN/vwKETJLpy4K
         zpwA==
X-Forwarded-Encrypted: i=1; AJvYcCUAApZcV6MWNu+yX0YymVMOuVZ3lpFdFELoNw4RCzInbjS+0hKn7cvQNO3/6JCdBwzCZoqya0Qw@vger.kernel.org
X-Gm-Message-State: AOJu0YxXuFIxdoYD7fljEr6HrRxQZ/3B5gQrc3NHF1N5dBx4SyVvMreG
	hijd/zowspvgZTaY5T7+H37wMVWkYNhS82KyR+TVeNKkcEfbFXfkk1FzIs6x0Ft3Dwns8WO8u1+
	tLQDbW+3VCJh1uNfambUGNLZZnT8aJJvUz0U2aZ7giA==
X-Gm-Gg: ASbGncsrPwcqp2T3haASV0DcDnc760sCfx5pha98ZX+C5ozDGeNKDoISIoPIc8Sbir6
	tSckOomD61YHO39Nd66rJDnDCeCAYHlvw8uYzqwIQIDFfJkfDI838tiqiiYbOIQzB4ejaJlPV5O
	c0khhaGYjgcloVGErPOWCOw2z68r0EqGzg46OIUgAOCCx19rE=
X-Google-Smtp-Source: AGHT+IF9pLUs8HjwlKgRVSQA4mmWk60xpv0iX/NLctG2+/Dc+wR3LVfXEJ6FzL7+WmaoR92DNaEX25NmjAdG0hdpY4k=
X-Received: by 2002:a05:6512:39c9:b0:545:bf4:4bd4 with SMTP id
 2adb3069b0e04-550e7198388mr7508382e87.7.1747885100412; Wed, 21 May 2025
 20:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520031552.1931598-1-hezhongkun.hzk@bytedance.com>
 <8029d719-9dc2-4c7d-af71-4f6ae99fe256@redhat.com> <CACSyD1Mmt54dVRiBibcGsum_rRV=_SwP=dxioAxq=EDmPRnY2Q@mail.gmail.com>
 <aC4J9HDo2LKXYG6l@slm.duckdns.org>
In-Reply-To: <aC4J9HDo2LKXYG6l@slm.duckdns.org>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 22 May 2025 11:37:44 +0800
X-Gm-Features: AX0GCFs--DX027QWdS7jsTmrtgmMk3uqrLDCbttLoN2No5GjE7lXZtnGmyZlnvU
Message-ID: <CACSyD1MvwPT7i5_PnEp32seeb7X_svdCeFtN6neJ0=QPY1hDsw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking cpuset.mems
 setting option
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <llong@redhat.com>, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 1:14=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, May 21, 2025 at 10:35:57AM +0800, Zhongkun He wrote:
> > On Tue, May 20, 2025 at 9:35=E2=80=AFPM Waiman Long <llong@redhat.com> =
wrote:
> > >
> > > On 5/19/25 11:15 PM, Zhongkun He wrote:
> > > > Setting the cpuset.mems in cgroup v2 can trigger memory
> > > > migrate in cpuset. This behavior is fine for newly created
> > > > cgroups but it can cause issues for the existing cgroups.
> > > > In our scenario, modifying the cpuset.mems setting during
> > > > peak times frequently leads to noticeable service latency
> > > > or stuttering.
> > > >
> > > > It is important to have a consistent set of behavior for
> > > > both cpus and memory. But it does cause issues at times,
> > > > so we would hope to have a flexible option.
> > > >
> > > > This idea is from the non-blocking limit setting option in
> > > > memory control.
> > > >
> > > > https://lore.kernel.org/all/20250506232833.3109790-1-shakeel.butt@l=
inux.dev/
> > > >
> > > > Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> > > > ---
> > > >   Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
> > > >   kernel/cgroup/cpuset.c                  | 11 +++++++++++
> > > >   2 files changed, 18 insertions(+)
> > > >
> > > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentatio=
n/admin-guide/cgroup-v2.rst
> > > > index 1a16ce68a4d7..d9e8e2a770af 100644
> > > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > > @@ -2408,6 +2408,13 @@ Cpuset Interface Files
> > > >       a need to change "cpuset.mems" with active tasks, it shouldn'=
t
> > > >       be done frequently.
> > > >
> > > > +     If cpuset.mems is opened with O_NONBLOCK then the migration i=
s
> > > > +     bypassed. This is useful for admin processes that need to adj=
ust
> > > > +     the cpuset.mems dynamically without blocking. However, there =
is
> > > > +     a risk that previously allocated pages are not within the new
> > > > +     cpuset.mems range, which may be altered by move_pages syscall=
 or
> > > > +     numa_balance.
>
> I don't think this is a good idea. O_NONBLOCK means "don't wait", not "sk=
ip
> this".

Yes, I agree.  However, we have been experiencing this issue for a long tim=
e,
so we hope to have an option to disable memory migration in v2.

Would it be possible to re-enable the memory.migrate interface and
disable memory migration by default in v2?

Alternatively, could we introduce an option in cpuset.mems to explicitly
indicate that memory migration should not occur?

Please feel free to share any suggestions you might have.

>
> Thanks.

>
> --
> tejun

