Return-Path: <cgroups+bounces-5372-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CF39B90B7
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 12:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FAE5B21D30
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 11:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DD619B595;
	Fri,  1 Nov 2024 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDTKphDq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3719B5AC;
	Fri,  1 Nov 2024 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462105; cv=none; b=EPMaO2r1N1exmNDONg9JVqIaleQ4Vx6djf1qQJ9C0Ivryhoxd7jrSEG0kYbXg+tglMkpE1A4fDR3VdU40X+hSeYa283oZMCf6Nw6KoFcyquaL3bKW8T8EXP51zHk59n/1b/6jWo2z16Eby9WmhX/PMoH8qzFNuXJ7oGpRUfkark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462105; c=relaxed/simple;
	bh=ypwyCznw+0I9Ity7Kr3pm4mHpnfmcPqIFWVKGUaMBmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6crjigNw/SJyZYQGuwipXCJ0jvoJMcqMaAWUpJF1Dg1J7aBSr6pLjEmDlFBs8nvFKOZ+0ZmVMOhrpC506t+E39qnMiYQ/mqgrdytQtBECGenl9WvZYTFvaD01UBkrW42v8lQntYjkvaFkvvEQmaMjHm4MAR0qY7QhP9ErHhy7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDTKphDq; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbe3e99680so11335756d6.3;
        Fri, 01 Nov 2024 04:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730462103; x=1731066903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0bfOOeDF79b8uUAIkKKfDBYKaKzRXBMsYzk+B5KcUk=;
        b=MDTKphDqHATHiEiQbp386e2/ZnaJKMM3kCj+W/F6ffqJdq4zcpdbBGsAE4jTuQoGXp
         NexxSOAP3+mRLWR/QXcEnz4GMDaQB3J+LtCr96AK6ihpJsFPVaEnyKj40NbbH+OC2qbU
         kiKhGSOUOg7mOdMh6PgOP2YanFfyvbG55FjZa3aS40AqGlkteNXwemNHiE6lVzmiYpJx
         cv+1x0IkqN6YFLFvmKbeZ8Bt0/vnYLi/oTBm3667uvJLuHMFJ5ZpbSedV3t1l6AG5+0y
         jHjWZ1VFqld9nR9fon+wn7HNorSP0WE7ZIAFp6n3jyvyuX4ubc1Z7jiCYUM+a2XSJ8s3
         XCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730462103; x=1731066903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0bfOOeDF79b8uUAIkKKfDBYKaKzRXBMsYzk+B5KcUk=;
        b=PXP6iYF7EPc/cJQa2UJoGm01Gc+OsUTe0iAk1Q+KFX5wsCepyZUNeqzCINcjXA+wOS
         1kn6Qq8ONiqpEjVRDQJtmrzBT7//73QjPuepzx9HZLNkK6jz3oR9wCSpdLY9RCZc7qh2
         65XrwZ2b/73B3FmxCKBLrYw6H+E2pasx+HW2QUsmNDg4fRWVaXFzUMG3DjDp5WFC5vSo
         1TQJ95VYXL66jhEBo5EsN7XobO4sFJqjzFTjicJUNdB/sEqCkP39Wsv56QmxLLnngSht
         w5SKYIrcvDfR72NFqTaurMSTXMw3Kxd6rwxSw/wH0kenkH0xLf5368qsIKnqVXj48NGp
         PXFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeClfQoc4f5tdJ1MO1nVr8Lacq7myb9KcWLydkOaAdC/uvE5USrQE+lZRF8bTA54Dru48zbquW@vger.kernel.org, AJvYcCXdgiaNfAhisU14ywKFfzj2bD/9dnX0IooKjdoHKEmseDOs3t+xs+LQGCC1rcclWnRVz5z2GpGVKZQYNvs2@vger.kernel.org
X-Gm-Message-State: AOJu0YyLCWA9O69BVYLj1XcDBwfjliT39kTqaL0RsTUl9idc7doAw0J/
	iCvDjVxNhcOyg3f//X7eoqBdQOt1pjpT5eyavlEZcGxoUSSwVXJxZtky0vYyatMnRWedRa4ENIL
	UYM9qbK6Di6HCg1ZLW5t7XiTSHnk=
X-Google-Smtp-Source: AGHT+IE4RBthnCH0lF8AuQxKMm+fXm+FdnL+ZnX2nNy4CeqMU79iBHDt9gAbYzQ/vkaup1RqtLyh9bKmUiVIGiss0yo=
X-Received: by 2002:a05:6214:5d0c:b0:6d3:531d:8aa7 with SMTP id
 6a1803df08f44-6d3531d8f5bmr91636106d6.25.1730462102681; Fri, 01 Nov 2024
 04:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101031750.1471-1-laoar.shao@gmail.com> <20241101105426.GX14555@noisy.programming.kicks-ass.net>
In-Reply-To: <20241101105426.GX14555@noisy.programming.kicks-ass.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 1 Nov 2024 19:54:26 +0800
Message-ID: <CALOAHbC9JpLxua-A=rD4AWvWX26wZUJw+UPhOTbx94hNUfPCfA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] sched: Fix irq accounting for CONFIG_IRQ_TIME_ACCOUNTING
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org, surenb@google.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 6:54=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Nov 01, 2024 at 11:17:46AM +0800, Yafang Shao wrote:
> > After enabling CONFIG_IRQ_TIME_ACCOUNTING to track IRQ pressure in our
> > container environment, we encountered several user-visible behavioral
> > changes:
> >
> > - Interrupted IRQ/softirq time is not accounted for in the cpuacct cgro=
up
> >
> >   This breaks userspace applications that rely on CPU usage data from
> >   cgroups to monitor CPU pressure. This patchset resolves the issue by
> >   ensuring that IRQ/softirq time is accounted for in the cgroup of the
> >   interrupted tasks.
> >
> > - getrusage(2) does not include time interrupted by IRQ/softirq
> >
> >   Some services use getrusage(2) to check if workloads are experiencing=
 CPU
> >   pressure. Since IRQ/softirq time is no longer charged to task runtime=
,
> >   getrusage(2) can no longer reflect the CPU pressure caused by heavy
> >   interrupts.
> >
> > This patchset addresses the first issue, which is relatively
> > straightforward.
>
> So I don't think it is. I think they're both the same issue. You cannot
> know for whom the work done by the (soft) interrupt is.
>
> For instance, if you were to create 2 cgroups, and have one cgroup do a
> while(1) loop, while you'd have that other cgroup do your netperf
> workload, I suspect you'll see significant (soft)irq load on the
> while(1) cgroup, even though it's guaranteed to not be from it.
>
> Same with rusage -- rusage is fully task centric, and the work done by
> (soft) irqs are not necessarily related to the task they interrupt.
>
>
> So while you're trying to make the world conform to your legacy
> monitoring view, perhaps you should fix your view of things.

The issue here can't simply be addressed by adjusting my view of
things. Enabling CONFIG_IRQ_TIME_ACCOUNTING results in the CPU
utilization metric excluding the time spent in IRQs. This means we
lose visibility into how long the CPU was actually interrupted in
comparison to its total utilization. Currently, the only ways to
monitor interrupt time are through IRQ PSI or the IRQ time recorded in
delay accounting. However, these metrics are independent of CPU
utilization, which makes it difficult to combine them into a single,
unified measure.

CPU utilization is a critical metric for almost all workloads, and
it's problematic if it fails to reflect the full extent of system
pressure. This situation is similar to iowait: when a task is in
iowait, it could be due to other tasks performing I/O. It doesn=E2=80=99t
matter if the I/O is being done by one of your tasks or by someone
else's; what matters is that your task is stalled and waiting on I/O.
Similarly, a comprehensive CPU utilization metric should reflect all
sources of pressure, including IRQ time, to provide a more accurate
representation of workload behavior.

--=20
Regards
Yafang

