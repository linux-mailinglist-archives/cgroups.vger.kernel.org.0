Return-Path: <cgroups+bounces-10660-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 881DBBD322A
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 15:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0817D34BC7C
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 13:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84C92F4A00;
	Mon, 13 Oct 2025 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eiOlibJ5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D742D94B2
	for <cgroups@vger.kernel.org>; Mon, 13 Oct 2025 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760360811; cv=none; b=DC+fHa99CNal7oGAh9Dsuut2nePKOF7fiUtdC12I7os2j07dVTq06nCEsLI9dys+uAgUa6C+H+w/PtRzt/REjEXkf2MVXmyK0PiVPBtOgSkUC4ZUjuSmdq+Y2OdCRoPlCyUj7qtRI9VefNBifzw/rGAHXx47184SzvKCNQcXPt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760360811; c=relaxed/simple;
	bh=+JrAJiQnQesllvCVS422pN9G7kOwYoBJGo6cNnQcMxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJMu3WI/rDpax7vcMP+1eyvQ1nmCYiVOdhkpPcDlvA2fvYwCVrxuIW2NR26fgHDaPBErb1Op7Ua6vT7vfrRKVuuVjvAlyWcq1H3uVmXGwCVRZ4O2C2edjtWFORRaYXXYJnVqZeWzUoqm7+ugt4kAob4ZeEe1iBFIHQqu+bZmgpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eiOlibJ5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so6284168a12.2
        for <cgroups@vger.kernel.org>; Mon, 13 Oct 2025 06:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760360806; x=1760965606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TubnhjRQIQK9VyxP1w8Jz/JseEsSrSwGf9ziOFfYLUk=;
        b=eiOlibJ5/e0rtLpSxXO6zkDLWExpzrnyXewAdxv5R2EcIo/73WXlE1Nvgjv5uhqygr
         NNEabwXoVAxcheT+2hlbAt3Czs9xgE6ZfJIPMzfKPzpconC9lfzW6GDQYaSu0gYyTikP
         WjB5PYP0+8+P+l2jN1Fszo+F4Z4ILnRgeD/iEg20k6c14qy0tYM3vyhODn7N2lgOGSlW
         44nxHyJRG3kbAljXVkc0bN19+neNnsH9N957FxJp005qcFj3N6SJV81VcToqQg9kjiit
         M4nePVHHecvWNupOhC97DyQk/wevl3ZVKB6K3yfcAbjey+9aV7lRgOJ8LUhszN9ZIIXC
         2YRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760360806; x=1760965606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TubnhjRQIQK9VyxP1w8Jz/JseEsSrSwGf9ziOFfYLUk=;
        b=Hm/+zgaKKuQ2fcvtmvQg3VVcgPtXnlzFf8FYDTyDNOzR1Jb+KvbAcrI5WJWf8LFSxV
         8xcX8aWbjohfIFffG4tXNAU3m6WrAdVqP07EmlTJqvn4JB9M4Fk6ZHEgbQHlo9KMwKYf
         L093t1Q57HSereK9nrHA3bRD9Mi0pAbIR1FS9UnThfWkwsoMFg7eAUU4iD/Iut/sf1eO
         XYDITP0TSwEJU66srScJ0vc0lzznVv434myAJ/JqO5HQnb7Zu30yPMABO6SU7AscBy/c
         8OZdx4Sb6dtD3CjYNVLnBiuNQoepjlhmV+iKkgCsuMEuIjdsSBXOC/kMLrxbOqIHkZM7
         W3lA==
X-Forwarded-Encrypted: i=1; AJvYcCUPMjAaDuSXuKVe+mYRFOkNpFRtJIEW7krlI0J90/aEF9r7vIUuQRG9VTZFqgzvQA+//bmLst1D@vger.kernel.org
X-Gm-Message-State: AOJu0YwmszoHJ6wj6jRcn3d0ZgcaEfzV+mf6LSPX/QzT/Jxfwzq3fmIh
	yEtjV+lucZtBrbHfakrTvTrTCMkcy1b0lj1lBMpdtEorKTFUaWHoNW037o5ChC++7ufT//jmzFM
	uKi04fx0tLwBGHUINn0kNmlL/7LEWPqCTku2hCdykEg==
X-Gm-Gg: ASbGncuX4y3XMvYP0hIA34KnqEcriz/g8g8ZR9RyTmoGuJylh8BbSqqqC1x2mxYXRrx
	T17BjiZKpbOjAlw3KQATytk9P2dyYO4Qawpy/FfzM+MeJEta97FRCMP+H3Xj9Myx3HuDSepE3rN
	60DxgINNf9iTIZ7P7ZWZIKf5p8S1qWt8mTo7tN/Hkr743PT0bAMIlzFMMrzV3K6YcZ2XKw18VBo
	QsQL2ONqrWkTR2wK7OOlmfZHbfgvwsuDP42/X0ICTk0BarqfZfJfzSAyBvKqnA=
X-Google-Smtp-Source: AGHT+IEJdl7nKyjjUWp7J9J4Bp6aSrz+/GMs1soPCOuRkAB+TSp97XKDTmI2RGo+buNVNeL9bBaZ2PquGW3ObBFY6yU=
X-Received: by 2002:a17:907:6d25:b0:b45:8370:ef10 with SMTP id
 a640c23a62f3a-b50aaa9c419mr2027646866b.22.1760360806112; Mon, 13 Oct 2025
 06:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006104652.630431579@infradead.org> <20251006105453.648473106@infradead.org>
 <CAKfTPtCC3QF5DBn0u2zpYgaCWcoP2nXcvyKMf-aGomoH08NPbA@mail.gmail.com>
 <20251008135830.GW4067720@noisy.programming.kicks-ass.net>
 <CAKfTPtDG9Fz8o1TVPe3w2eNA+Smhmq2utSA_c6X4GJJgt_dAJA@mail.gmail.com>
 <aObK2MfxPyFcovwr@slm.duckdns.org> <CAKfTPtApJuw=Ad8aX=p3VLvMojyoxVBVRbMG80ADXR-NVL0PTw@mail.gmail.com>
 <20251013110449.GJ4067720@noisy.programming.kicks-ass.net> <20251013110911.GF4068168@noisy.programming.kicks-ass.net>
In-Reply-To: <20251013110911.GF4068168@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 13 Oct 2025 15:06:33 +0200
X-Gm-Features: AS18NWAzGT3q8fm8LwBT4URFj98EAHmqBs8SLH_4hZU7YH6-erXmlA6fCUaV1_I
Message-ID: <CAKfTPtDGsS-+DZEemg6vqbQVV5Xds9TNVnOAOvyeNsw0Kn3Mzw@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] sched: Add support to pick functions to take rf
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, longman@redhat.com, 
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev, 
	liuwenfang@honor.com, tglx@linutronix.de, 
	Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 13:09, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 13, 2025 at 01:04:49PM +0200, Peter Zijlstra wrote:
>
> > Bah; so yeah, this new behaviour is better for indeed always calling
> > newidle when it is needed, but you're also right that in case of ext
> > this might not be ideal.
> >
> > So I have a pile of newidle hacks here:
> >
> >   https://lkml.kernel.org/r/20251010170937.GG4067720@noisy.programming.kicks-ass.net
> >
> > and while I don't particularly like NI_SPARE (the has_spare_tasks thing
> > is fickle); the idea seems to have some merit for this situation --
> > where we know we'll not be having fair tasks at all.
> >
> > I mean, we can always do something like this to sched_balance_newidle():
> >
> >       if (scx_switched_all())
> >               return 0;
> >
> > Not pretty, but should do the job.
>
> Oh, never mind, none of this is needed.
>
> __pick_next_task()
>
>         if (scx_enabled())
>           goto restart;
>
>         ...
> restart:
>         for_each_active_class(class) {
>                 ...
>         }
>
>
> And then we have next_active_class() skip fair_sched_class entirely when
> scx_switch_all().

Ah yes you're right. fair is not called in case of scx_switched_all()

>
> So in the common ext case, we'll not hit pick_next_task_fair() at all.

