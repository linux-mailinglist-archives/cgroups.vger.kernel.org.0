Return-Path: <cgroups+bounces-4096-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1062C9481F3
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 20:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC34228B768
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 18:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EDE15F418;
	Mon,  5 Aug 2024 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="toRI6xnh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA3215E5BE
	for <cgroups@vger.kernel.org>; Mon,  5 Aug 2024 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722883902; cv=none; b=XyAgLhyEeO/55vRVuGe44k7vUTnrPTMru8127GmzzK/lcb7E2Pd5qYSXy6xg+NHKPScCuaZLOWs17A1U1fQXDEhpX6BEVtSqo1elMsLH9qVenCi2jcS9vnMuwpeHPpKBOx0Qof964v4imqgnY93t3cjZpsy0KpwjCz8ub4++Zkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722883902; c=relaxed/simple;
	bh=XUNBVdRu82qhkjmoWjq/FDLz55z9+9+gFi6fUvzxQLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIMoK0uxX2EHoA26p0U9A35aStIgbt2ZRGzQyZwXlGl+nRHUxSLxw/LXqlKqgs+FRczz70lDC4HQW/NVc+crPFYoaEUZWRNdGzGRbdlrhiXmrVrTGGaw2DWBRcyb2t0gSUskaY64gcaV6HIXB3+xcKwmgX+zFvqTSVpv/pIDvT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=toRI6xnh; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-530ae4ef29dso11647765e87.3
        for <cgroups@vger.kernel.org>; Mon, 05 Aug 2024 11:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722883898; x=1723488698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zX73mTG4pcwMAjmlvY0/Y+DmA7ujKlG2GvsuKR4ZF4c=;
        b=toRI6xnhXHQQx7IhZ3OF45AJSV27EjLOzcJHlD7IG3ipv9mleODFHGbdW7uepr4OeC
         hDqodljvkEW8NKZpp5GcOgDIeWockS2CTMMq/fjee7+PqbwJOU/ppvUug82XOvYKgzEl
         bUbHbakoCIM05anrFLivtssHp0jC4TxCj88+FFTduk85kCSOc+I42eNEMTVRLol3Brkx
         EfgzAzeslAfmiJ96Sl1MB5taZi/+BcaFqrS44iL389JheZprSyHQn0N18XHJEqCg7drT
         ZrReP94w5vdkWYxa/yPMsOw/xpDBqhE2CEXFgxjm+pMnXusrYVjD5om1+TWBjzMPVTYv
         Injg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722883898; x=1723488698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zX73mTG4pcwMAjmlvY0/Y+DmA7ujKlG2GvsuKR4ZF4c=;
        b=niR4KzsunGG9j0Ybi8J6UYG8jshvTNC0QoFrqIGxFhrdszCd8w8ki4yCt8HssAnB3G
         rVtmtKAfM1IPIh8apWg4D0tA7jz8KGeN+3D7SU0sBshIAbLfDsjMpJdZA2/EPZcQRPKV
         VwXmWwqjcDI4ZthEk0hyQRos2xXbaba1ctdIygEQxOCjs3yO9o/Q+0q/pwx0qdmqMif6
         G9Ezl41om6Scivg5jBi1xyklvBBWWthayT7yVnj14DCmgr/mcHIOZzNLV+xjpfonK1JV
         qHmQSigw+oo/2R8wRePXL9l7l2+Bvx/gHwtDyB7MbNwDTq7VBtpanilUWzYXEtx9q7Rq
         EjIA==
X-Forwarded-Encrypted: i=1; AJvYcCUhcDQifzVeyRynZq2pT/jsaioBUZiZwsk3xl+Kp3FXQGtpSmIoXbfYnmZUrX2VdtUEfXVEOqqDpfcG4SKT0IWWjxjtk5Lc5Q==
X-Gm-Message-State: AOJu0YyoyKGVUGLSCruKU3snA2Zq8S0xyyN7snzKPPVIti0bllSD6oEB
	aBzGvYto2MpUgWbd8v9PUhknHENsCHKll81jMmjb4YAHryhSrDBTyxYgLGPwgH4mEkDgrSTteXC
	aSnal5UsXkOuPGkAiD3yuUU/pNF5RwdHRUSxy
X-Google-Smtp-Source: AGHT+IE/sthJa9woVQs/VxN/0k7SdSe1WSEegFQyAFsfnWxXYHSAr3iFGKf1qkAZH0DCQxNnjakEwf+pGoTSthFNq54=
X-Received: by 2002:a05:6512:2399:b0:52c:9877:71b7 with SMTP id
 2adb3069b0e04-530bb3bd153mr11647817e87.59.1722883897453; Mon, 05 Aug 2024
 11:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172139415725.3084888.13770938453137383953.stgit@firesoul>
 <CAJD7tkaVwpYWu_c+vgr7mJiWzFofq9jmx-hyOx1i5kkHWc62dg@mail.gmail.com>
 <c55f852b-39b7-4bf9-a054-0e7933912730@kernel.org> <CAJD7tkaZuiSCj4RZ2v6jOCtwiv++YNQxA0x6MEp-HrHaYO6_9g@mail.gmail.com>
 <ee0f7d29-1385-4799-ab4b-6080ca7fd74b@kernel.org> <CAJD7tkYL-az+bSXH-CYBLJS2FQ6WtNDOSsxnUZhkixHeBrBmbg@mail.gmail.com>
 <ef58d81c-6266-4999-ac1e-04d330196f9a@kernel.org>
In-Reply-To: <ef58d81c-6266-4999-ac1e-04d330196f9a@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 5 Aug 2024 11:50:59 -0700
Message-ID: <CAJD7tkb6ug3JpPi6s1+xHf=1K6-vVOH-8wPTzWbG8v6CJ0MT6Q@mail.gmail.com>
Subject: Re: [PATCH V8 1/2] cgroup/rstat: Avoid flushing if there is an
 ongoing overlapping flush
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 7:24=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
>
>
> On 02/08/2024 18.10, Yosry Ahmed wrote:
> > On Fri, Aug 2, 2024 at 4:43=E2=80=AFAM Jesper Dangaard Brouer <hawk@ker=
nel.org> wrote:
> >>
> >>
> >> On 30/07/2024 20.54, Yosry Ahmed wrote:
> >>> [..]
> >>>>
> >>>> Well... I'm still not convinced that it makes sense to have level >=
=3D 2
> >>>> be the ongoing flusher.
> >>>>
> >>>> E.g. if a level 2 cgroup becomes ongoing flusher, and kswapd starts =
12
> >>>> NUMA flushes at the same time, then the code will have these 12 kswa=
pd
> >>>> threads spin on the lock, until ongoing flusher finishes. That is li=
kely
> >>>> what happened above (for a level 1).  These 12 spinning (root) flush=
ers
> >>>> will not recheck ongoing_flusher and will all flush the root
> >>>> (unnecessarily 11 times).
> >>>
> >>> Hmm regardless of whether or not the level-2 cgroup becomes the
> >>> ongoing flusher, the kswapd threads will all spin on the lock anyway
> >>> since none of them can be the ongoing flusher until the level-2 cgrou=
p
> >>> finishes. Right?
> >>>
> >>> Is the scenario you have in mind that the level-2 cgroup starts
> >>> flushing at the same time as kswapd, so there is a race on who gets t=
o
> >>> be the ongoing flusher? In this case as well, whoever gets the lock
> >>> will be the ongoing flusher anyway.
> >>>
> >>> Not allowing whoever is holding the lock to be the ongoing flusher
> >>> based on level is only useful when we can have multiple ongoing
> >>> flushers (with lock yielding). Right?
> >>>
> >>> Perhaps I am missing something here.
> >>>
> >>>>
> >>>> So, I don't think it is a good idea to have anything else that the r=
oot
> >>>> as the ongoing flusher.
> >>>>
> >>>> Can you explain/convince me why having sub-cgroups as ongoing flushe=
r is
> >>>> an advantage?
> >>>
> >>> I just don't see the benefit of the special casing here as I mentione=
d
> >>> above. If I missed something please let me know.
> >>>
> >>
> >> I do think you missed something. Let me try to explain this in another
> >> way. (I hope my frustrations doesn't shine through).
> >>
> >> The main purpose of the patch is/was to stop the thundering herd of
> >> kswapd thread flushing (root-cgrp) at exactly the same time, leading t=
o
> >> lock contention. This happens all-the-time/constantly in production.
> >>
> >> The first versions (where ongoing was limited to root/level=3D0) solve=
d
> >> this 100%.  The patches that generalized this to be all levels can
> >> become ongoing flush, doesn't solve the problem any-longer!
> >>
> >> I hope it is clear what fails. E.g. When a level>0 becomes ongoing
> >> flusher, and 12 kswapd simultaneously does a level=3D0/root-cgrp flush=
,
> >> then we have 12 CPU cores spinning on the rstat lock. (These 12 kswapd
> >> threads will all go-through completing the flush, as they do not
> >> discover/recheck that ongoing flush was previously became their own le=
vel).
> >
> > I think we may be speaking past one another, let me try to clarify :)
> >
> > I agree with your assessment, all I am saying is that this restriction
> > is only needed because of lock yielding, and can be removed after that
> > IIUC.
> >
> > The problem when we allow non-root ongoing flushers now is that when
> > the kswapd thread are woken up and the first one of them gets the lock
> > and does the flush, it may be find that the ongoing_flusher is already
> > set by another non-root flusher that yielded the lock. In this case,
> > the following kswapd flushers will spin on the lock instead of waiting
> > for the first kswapd to finish.
> >
> > If we remove lock yielding, then the above scenario cannot happen.
>
> I think, this is where we disagree/talk-past-each-other.  Looking at the
> code, I do believe the the situation *also* occurs without any lock
> yielding involved.  Yes, the situation if far-worse when we have lock
> yielding, but it also happens in the default case.
>
> > When the lock/mutex is held by a flusher, it is guaranteed that
> > ongoing_flusher is NULL and can be set by the flusher. In this case,
> > we should allow any cgroup to be the ongoing_flusher because there can
> > only be one anyway.
> >
>
> With current patch proposal [V8 or V9].
> Assuming we have no lock yielding.
>
> Do we agree that 12 kswapd threads will be waiting on the lock, when a
> level>0 were ongoing flusher when they were started?
> Then level>0 finishes being ongoing flushed.
> Then kswapd0 gets lock, observe NULL as ongoing, and becomes ongoing.
> Then kswapd1 gets lock, observe NULL as ongoing, and becomes ongoing.
> Then kswapd2 gets lock, observe NULL as ongoing, and becomes ongoing.
> Then kswapd3 gets lock, observe NULL as ongoing, and becomes ongoing.
> Then kswapd4 gets lock, observe NULL as ongoing, and becomes ongoing.
> Then kswapd5 gets lock, observe NULL as ongoing, and becomes ongoing.
> Then kswapd6 gets lock, observe NULL as ongoing, and becomes ongoing.
> [etc]

How does preventing the level>0 cgroup from becoming the
ongoing_flusher change the above scenario? kswapd threads will still
observe NULL as ongoing and spin on the lock, right?

(Still assuming no lock yielding)

>
> Please, let me know if I misunderstood my own code, and you believe this
> scenario cannot happen.
>
> When above happens, then patch didn't solve the kswapd thundering herd
> issue that we observe in production.
>
> The point/problem is that once kswapd is waiting on the lock, then code
> doesn't re-check the ongoing flusher, and every kswapd thread will be
> spinning and every kswapd thread will need to go through the flush.
> When a kswapd thread gets the lock, then it will observe ongoing as
> NULL, so it cannot detect that another level=3D0 just were the ongoing.
>
> --Jesper

