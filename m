Return-Path: <cgroups+bounces-3354-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B06916253
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 11:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E422B24C15
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E411B1494DB;
	Tue, 25 Jun 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pgk/PNtv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0901F1369AE
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307771; cv=none; b=VTLdxIyTbMPrbZFvtKzjrJdufbMWg4AmU3JTQg52NlizMvdhEO0thUooFwrAYLyHji1Z4Y5kT14COcMejGIEsiEStSJ4wxJlgPw+JywllzhM3d0SYU2HIzGxMc+nlMPwAJwIQWUGSAMiY79T9eTRlY8SSy9fINhuanVQ5OjRAsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307771; c=relaxed/simple;
	bh=ZWQ7HJvLKWgkBTAEyKwJ0z6QLKsHWiIBL17mKHi7vdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1DX81zFMSeSI27KXItjVKLAm8Wslduf9DXhDZJ+GEN1GT+ag45/B0iQjO/qJq3Hiy23i7rmMTEvA+GZ42whKR2ORUu8xHE+eKmArNDUOKYY2WwFsr35ErsOvhXftNrtWX6JRYcWwJdZVYGHtOV6DH1EpRkL4q6wFzXzB1DbEQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pgk/PNtv; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7245453319so394616266b.1
        for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 02:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719307768; x=1719912568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCrqk7/36KNOKeis9u3WUIDkXSA8WWdvGSpIDLIGpAA=;
        b=Pgk/PNtvn4qLnN2evC24IOHP3dCVz7WS2TyTq0NM+1mqzEMfsZFsiJanFDliZi1sol
         ZTz/u9ojmHwLOTiVPqZ8NR/Zyk+ePq8BqEiQJ3SWddYBcegVAgIRG2fgeIC9/vUouIRx
         2X7ex0lSwgrzx8Jnx/t8MDy9I8TI+KOud8HxcWTwAD0gCt3Tp7Sj1asn+T0rFHnLlMgG
         xxFzt/HYC3O8LrTGxJ84fWNmzlW48rc7iL2O3H33B4z4efuOQQJis2F3zs1HUp2hrXHM
         4sbicsJ5u/PonflTokOstZ9GkU4/CBsqx8R2YA01Kpz1+U72+BxSTtYz8YDhjudTKPs/
         RgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719307768; x=1719912568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCrqk7/36KNOKeis9u3WUIDkXSA8WWdvGSpIDLIGpAA=;
        b=YpNi1ZU4A0kNPMKbJ9abO3oWW0hmy9VWGWj1n8lvPBOyDvMzG3FPqwlcehO39cN9tB
         pJRA4Z/D73CwLEkJS4JctK2kvM8/prfT6uuQCnGXDplPjT3C1JXSJJCWxJb3rqA+XFWu
         AJ4lpn8GdtVawNKtEGviEHFkG7ZOY64J7qdhgm7nTEAjwTWOB8/oXKQgJXedtl7GvcT4
         QWMwPTMtwZmzEOO+9acF+DKYtJ47W96PNtyneQB2dxVFUDY3CBxLPXqdgPcGM0aEBZVw
         aEaG/qPW68wvdRnGXFtlEAfo1pcb9t4OoZNjkl+L4lzXvv2i2h50wHO1CLc7c2/uG4mE
         wzGw==
X-Forwarded-Encrypted: i=1; AJvYcCWGzc3mMqXkH4NZki8Rfx9RY1d5+PsVjKBwiNiTYza30T4AfXQa7y5GipSn8XCXpkHd0z46aQ2p9sK17FXxfUxoUTf5BBbDxw==
X-Gm-Message-State: AOJu0YxfQCkZ07M4zobeF3XAdfD/weh0xS9tIasSOM8BBO42O5Tv7mAk
	Rn7O3ADdX4zwRsnKy7vcApHJ9KKnOKb1aT7B927mweoEN2tzLllh1gJ08Nh7Apqj0Es9xQTeTuB
	FSoeOmHSAh9KpxY2yqCZDNp0xQnCHKlYqnbfa
X-Google-Smtp-Source: AGHT+IG8hi1q87SLygIpVvmKjC68jfFKU5XC7cTf7o4WTRP/zq9UVCTDndo7oyjPBIDrSoe8mYy31Cg4iEVeMKuKHkk=
X-Received: by 2002:a17:907:a64b:b0:a72:7a71:7f4f with SMTP id
 a640c23a62f3a-a727a718032mr44282766b.7.1719307767940; Tue, 25 Jun 2024
 02:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171923011608.1500238.3591002573732683639.stgit@firesoul>
 <CAJD7tkbHNvQoPO=8Nubrd5an7_9kSWM=5Wh5H1ZV22WD=oFVMg@mail.gmail.com>
 <tl25itxuzvjxlzliqsvghaa3auzzze6ap26pjdxt6spvhf5oqz@fvc36ntdeg4r>
 <CAJD7tkaKDcG+W+C6Po=_j4HLOYN23rtVnM0jmC077_kkrrq9xA@mail.gmail.com>
 <exnxkjyaslel2jlvvwxlmebtav4m7fszn2qouiciwhuxpomhky@ljkycu67efbx>
 <CAJD7tkaJXNfWQtoURyf-YWS7WGPMGEc5qDmZrxhH2+RE-LeEEg@mail.gmail.com>
 <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg>
 <CAJD7tkZT_2tyOFq5koK0djMXj4tY8BO3CtSamPb85p=iiXCgXQ@mail.gmail.com>
 <qolg56e7mjloynou6j7ar7xzefqojp4cagzkb3r6duoj5i54vu@jqhi2chs4ecj>
 <CAJD7tka0b52zm=SjqxO-gxc0XTib=81c7nMx9MFNttwVkCVmSg@mail.gmail.com> <u3jrec5n42v35f3xiigfqabajjt4onh44eyfajewnzbfqxaekw@5x2daobkkbxh>
In-Reply-To: <u3jrec5n42v35f3xiigfqabajjt4onh44eyfajewnzbfqxaekw@5x2daobkkbxh>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 25 Jun 2024 02:28:49 -0700
Message-ID: <CAJD7tkaMeevj2TS_aRj_WXVi26CuuBrprYwUfQmszJnwqqJrHw@mail.gmail.com>
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 5:24=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Jun 24, 2024 at 03:21:22PM GMT, Yosry Ahmed wrote:
> > On Mon, Jun 24, 2024 at 3:17=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Mon, Jun 24, 2024 at 02:43:02PM GMT, Yosry Ahmed wrote:
> > > [...]
> > > > >
> > > > > > There is also
> > > > > > a heuristic in zswap that may writeback more (or less) pages th=
at it
> > > > > > should to the swap device if the stats are significantly stale.
> > > > > >
> > > > >
> > > > > Is this the ratio of MEMCG_ZSWAP_B and MEMCG_ZSWAPPED in
> > > > > zswap_shrinker_count()? There is already a target memcg flush in =
that
> > > > > function and I don't expect root memcg flush from there.
> > > >
> > > > I was thinking of the generic approach I suggested, where we can av=
oid
> > > > contending on the lock if the cgroup is a descendant of the cgroup
> > > > being flushed, regardless of whether or not it's the root memcg. I
> > > > think this would be more beneficial than just focusing on root
> > > > flushes.
> > >
> > > Yes I agree with this but what about skipping the flush in this case?
> > > Are you ok with that?
> >
> > Sorry if I am confused, but IIUC this patch affects all root flushes,
> > even for userspace reads, right? In this case I think it's not okay to
> > skip the flush without waiting for the ongoing flush.
>
> So, we differentiate between userspace and in-kernel users. For
> userspace, we should not skip flush and for in-kernel users, we can skip
> if flushing memcg is the ancestor of the given memcg. Is that what you
> are saying?

Basically, I prefer that we don't skip flushing at all and keep
userspace and in-kernel users the same. We can use completions to make
other overlapping flushers sleep instead of spin on the lock.

A proof of concept is basically something like:

void cgroup_rstat_flush(cgroup)
{
    if (cgroup_is_descendant(cgroup, READ_ONCE(cgroup_under_flush))) {
        wait_for_completion_interruptible(&cgroup_under_flush->completion);
        return;
    }

    __cgroup_rstat_lock(cgrp, -1);
    reinit_completion(&cgroup->completion);
    /* Any overlapping flush requests after this write will not spin
on the lock */
    WRITE_ONCE(cgroup_under_flush, cgroup);

    cgroup_rstat_flush_locked(cgrp);
    complete_all(&cgroup->completion);
    __cgroup_rstat_unlock(cgrp, -1);
}

There may be missing barriers or chances to reduce the window between
__cgroup_rstat_lock and WRITE_ONCE(), but that's what I have in mind.
I think it's not too complicated, but we need to check if it fixes the
problem.

If this is not preferable, then yeah, let's at least keep the
userspace behavior intact. This makes sure we don't affect userspace
negatively, and we can change it later as we please.

