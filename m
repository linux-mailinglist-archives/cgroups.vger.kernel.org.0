Return-Path: <cgroups+bounces-9769-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3385B46A3C
	for <lists+cgroups@lfdr.de>; Sat,  6 Sep 2025 10:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD5D5C17A1
	for <lists+cgroups@lfdr.de>; Sat,  6 Sep 2025 08:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D691521255E;
	Sat,  6 Sep 2025 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHOMNemF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2996727D77A
	for <cgroups@vger.kernel.org>; Sat,  6 Sep 2025 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757148254; cv=none; b=JYoasLvX0Vj63vVE2wnP7SLDP//4DpczraHMVPhZqqkEMQaH4R3hhnhRq4H8oqs/H6yMMBI7bcqQlIy5v0MhmDr7ib9X6evS/35CF/0RS9yrvCvO2eDcn9tDrl3GbiQ7WTTVw1F4AzaHbJeUHL/aUvuqqEemzYt/SHr2EUpAaoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757148254; c=relaxed/simple;
	bh=ioBMi4/eFSTZR/gwR4miHwSmbvpNL7DYm9ThLt7uKdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhLgQNarBE1ThvVNhiy0KeDNNZtw9ERGps5f5n1iyojXR+SQ2yz1Ns2Qgjck4FARzIGV/Kg4xSzn1hu27y8EeiIQExBJNRGk1CxDOhetYC88fty05xpkagqm2wBsea5tl/S0+BpWKW6ACsf6WjWNyqpr8giBsAYsc/LENADFi3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XHOMNemF; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4f8bf49aeaso2503908a12.1
        for <cgroups@vger.kernel.org>; Sat, 06 Sep 2025 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757148252; x=1757753052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ew5mxc5caN5gcDtxTwu7IwmhCpTzTpkvaeyIZ+j1bkQ=;
        b=XHOMNemF/8sYH/D18TbUO8uFwC0m7wBJwVycT0ANqt3VXAWbx12GO0acw+aikZFrn+
         jcEHPIZHiLOFc99bb1qEl6ASCBNWJzCtRPgKQzVtPBYRpq6F4kOh6QW0i9HFjy+ALp/D
         TrEY3/4aRDiNDuG5TsWvynSP5Aax6DNYNSI2BWl1wTZ89Va2ZsUhdAxqjcER5JjrYTmX
         Dco+RK5qBbqnvMRcUCkBG23jOUuvqR0RMV9Pb/TY4B8wZ6dt/lDYrDNuShxArGMbIjXQ
         VItfgYhG1PzejJNYty+qawXp3AWOEWIIbV7NZqfPkPlyEp560AvKME9Y0zAS3LARYJdW
         9wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757148252; x=1757753052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ew5mxc5caN5gcDtxTwu7IwmhCpTzTpkvaeyIZ+j1bkQ=;
        b=M30bRyqEJ0hNe/KSCUbhxoqKFo903VmGNHslGLLf88+YIOdOu7qTYflJxjhIJ7kzt4
         0CONNgf62i+GCg1/0Goo//xNPcrH91p4PCVaa5NkgqjkA/rtgH4wT52trbb2qEnWqEtK
         YLPLi/qDBvw78NWDgIrvcoHE582xmgqpQ2R+tFbuSc3+yic4YO5rdd9itViZR8FFOT3n
         SySGWr+AgBy9t56l5w/YEZlBeEEJr2K98zAs/vzPxl4mK61pRJnq4Y8/3aaJIdmz+4Gx
         eoBNAndZq++Vk9+f4kU4mnoIvzdv/q3eZ9gbE6pJa9jB0403VCtKFqvjapDZOO6izqIb
         yxlA==
X-Forwarded-Encrypted: i=1; AJvYcCXfUfHFu5Gt3K4dmUZ5mXrAyW6Ca3BtuxYwLnXUiOjuyDXhD08NoNkAypQ/n3cSLvVDqNKIH8X0@vger.kernel.org
X-Gm-Message-State: AOJu0YyCLlZRck6NxDN1Y1HhLwZLk3wDy/fGGJL18TBrdtVxyVOaKHU6
	iCGgb7+fk2iOjRaC8X4aT7U3Va/dURloOWdzJu1tP4Hb3o4R/cS0WKgBI9IBOie4A6mm5JcBvSk
	PyrWjSqWcYv9+2kZkMjLmhcAx8ziN3h5pK0Ne9DE9jw==
X-Gm-Gg: ASbGncv0eT/W7q4IuFtgBg5DXMhRKfimsM0mOYa4xsHCdi56ZDLBU5h0VliFrTcPEK2
	ZlLMcdHINfBkxQMwZIu3KweYO0ZnpI2IM7eZc79WqkPritMRh1gPXSftNlxcKcXoxW7Yj1fodrc
	xfFW88zflL17KcFA9U2Gf+2+oGyW5pc8C4NQTz8HmuWP1fBm+u3OJTKDemYRM+4ELI69FiSwO3Y
	mCkE14IjOnm94O0kqkScyTZB7HcPqVvHD0tP4kHPOJkcwwnVA==
X-Google-Smtp-Source: AGHT+IFWY6ZjZ54pmmCwZjzjcEHYHuEaPv0XvwL3Eflpm/wFl4W2+BYv03gcg0aI3CC8OEM/T3fJ+UI2CYpLLpEbOeM=
X-Received: by 2002:a17:90b:3852:b0:329:e729:b2a1 with SMTP id
 98e67ed59e1d1-32d440d9ff0mr2516690a91.35.1757148252335; Sat, 06 Sep 2025
 01:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv0mbEBVs0oTiM+H4X-y7ZCwYpfa0hGCQCeVkW2ufGD_w@mail.gmail.com>
 <CANDhNCpWWNpBQfeGq_Bj1pEWTYULJGaubTuPJ2Yxjg4_ESzgBw@mail.gmail.com> <CANDhNCrJYMcK+dak8ASX6uoVFkNSHMf3Bn1kOXDtqNqFb7LkJQ@mail.gmail.com>
In-Reply-To: <CANDhNCrJYMcK+dak8ASX6uoVFkNSHMf3Bn1kOXDtqNqFb7LkJQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 6 Sep 2025 14:14:00 +0530
X-Gm-Features: Ac12FXyDB-xmFe72rMp4oqEaC6ssFIEBHl2K-2wenWmXDkTJZrm_JyQxx_K7VTs
Message-ID: <CA+G9fYuhDU=5b0my6yMy+ni=K_SFCRxncWJFvj0DVuLftTWYUA@mail.gmail.com>
Subject: Re: arm64/juno-r2: Kernel panic in cgroup_fj_stress.sh on next-20250904
To: John Stultz <jstultz@google.com>
Cc: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, Cgroups <cgroups@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 6 Sept 2025 at 02:50, John Stultz <jstultz@google.com> wrote:
>
> On Fri, Sep 5, 2025 at 10:50=E2=80=AFAM John Stultz <jstultz@google.com> =
wrote:
> >
> > On Fri, Sep 5, 2025 at 6:21=E2=80=AFAM Naresh Kamboju <naresh.kamboju@l=
inaro.org> wrote:
> > >
> > > Kernel warnings and a panic were observed on Juno-r2 while running
> > > LTP controllers (cgroup_fj_stress.sh) on the Linux next-20250904 with
> > > SCHED_PROXY_EXEC=3Dy enabled build.
> > >
> > > Regression Analysis:
> > > - New regression? yes
> > > - Reproducibility? yes
> > >
> > > First seen on next-20250904
> > > Bad: next-20250904
> > > Good: next-20250822
> > >
> > > Test regression: next-20250904 juno-r2 cgroup_fj_stress.sh kernel pan=
ic
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Thank you for the testing and the report here!
> >
> > > Juno-r2:
> > >  * LTP controllers
> > >    * cgroup_fj_stress.sh
> > >
> > > Test crash:
> > > cgroup_fj_stress_net_cls_1_200_one:
> > > [  365.917504] /usr/local/bin/kirk[402]: cgroup_fj_stress_net_cls_1_2=
00_one:
> > > start (command: cgroup_fj_stress.sh net_cls 1 200 one)
> > > [  374.230110] ------------[ cut here ]------------
> > > [  374.230132] WARNING: lib/timerqueue.c:55 at
> > > timerqueue_del+0x68/0x70, CPU#5: swapper/5/0
> >
> > This looks like we are removing a timer that was already removed from t=
he queue.
> >
> > I don't see anything obvious right away in the delta that would clue
> > me into what's going on, but I'll try to reproduce this.
>
> So far I've not been able to reproduce this in my environment.  If you
> are able to reproduce this easily, could you try enabling
> CONFIG_DEBUG_OBJECTS_TIMERS to see if it shows anything?

I have been running in CI loop for these tests to reproduce and did not
find this again.

I will add this extra Kconfig CONFIG_DEBUG_OBJECTS_TIMERS
and re-run to reproduce this reported regression.

- Naresh

>
> thanks
> -john

