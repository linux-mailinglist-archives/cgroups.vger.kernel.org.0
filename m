Return-Path: <cgroups+bounces-6080-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC55A07826
	for <lists+cgroups@lfdr.de>; Thu,  9 Jan 2025 14:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEA33A8494
	for <lists+cgroups@lfdr.de>; Thu,  9 Jan 2025 13:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A588472;
	Thu,  9 Jan 2025 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAn4a3m7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82101217F4A;
	Thu,  9 Jan 2025 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430422; cv=none; b=ht6XDZVuz9f7qQv8DhO+iN/eWgNV5ES1FEcp2QD5/OQUjBSlS7t9ODEe+ueXm5XZp29A3vc1seB3yuiipMFpxr790ajpQDTt4ZdEKNlFj/0ju/FGdlGOo5tFLey8LEaE0Rech/Y58KbYQ91pgUFsvLy/VxOMbp6hBkrLs5aFfoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430422; c=relaxed/simple;
	bh=79rl6nUkFLG/k6QDfglEjS9SOFbewyC8BM3IQiT7eTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwErOsu1JIpk/ARz/poPS1VbfgH+GWVOPwThivGxPiX3ahqBtAHTo5wdByliszVCS7jS6Ci2pqVkdKJ7k7K6NULaH7Y06agA8QhOAph9yzGjK1PUSDN8AQQZLsIbAgA97dG9y55rlmwqQIzjL9Ei5XRDehRGaOp9lml49OcqAlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAn4a3m7; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467a17055e6so9073661cf.3;
        Thu, 09 Jan 2025 05:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736430419; x=1737035219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4O+9dMQs9z1mpZvLCXy3eE+9C/pTlYhQ/Ut88jMwoo=;
        b=iAn4a3m7ayS+W2ntjeJVoy4yNo/ENdKW292bi1yem5dI0U25MJFGgsWDuW4X6HEdlw
         2wp6+E+WoTzsWuz6DYGmkppz/rulzZoItuoiT7jtv303Wt76X6rYPh52paGl7hL4/paz
         uAgcQ5ST3c0hHhd3rJPzaDrZGhVGKiYdG1sBgNLNg4ZTLndl5jekuO3Lg0lTStgOKJne
         HYKhb4QncVERdz4X0rMWL4oXzMPAQUVO9G7IHzGbIq8ye8ftAO15zqghBBejmhpNziYl
         Y1nrYBIi6C3VBy/7iBY1ZujaGQiOiGUDOR1kjoy0t2e3VTIPhb+tQsSpaoKQto68okyR
         Q6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736430419; x=1737035219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4O+9dMQs9z1mpZvLCXy3eE+9C/pTlYhQ/Ut88jMwoo=;
        b=msVcy/n/mVcoqM2VTDiUNttxU7RTyqlCteK0hQD0ZpwM6Rj5zwB7MCA2ejOD4XA4Vz
         qy/IL4cSiIO0/cSDEY92/bCMjkzS9d13jmh2lycZKzB6T7ApyRQfBBJrHGY6LyDH0MSa
         nTTo+A+mXWt3PiO59mzzooSNlmg5aMzYbpNnEnbzX/dUS7lj9WE5tuMMi6mBqDvGt6bT
         YfLovZeVj/+NVOb7vdWyj29rOYA/Ikv9sDSicdzd/8gdh3OLaQDKjMqMj1e96+oI22Tp
         MbMDBIz/h/3ojJXraLiN4eB6xmO0agwqW+JMMcFIUE4A8WaHYMFp3hlDGYYLL67mJ1TB
         rmrw==
X-Forwarded-Encrypted: i=1; AJvYcCW/GFBosgL00yn47K+iLPsrRxr0At9an6g4JHnK17VCWnwht96Fbt4q5I23BTYvn/xHpm1RgcuL@vger.kernel.org, AJvYcCXM2FIpkSg/sMmnY8p2rMQzjml3gFfkp/MjyssMfXvX7ml6K2AzXlBIWdmNRpOfDFXgy2hWx+QLhLMPG9J/@vger.kernel.org
X-Gm-Message-State: AOJu0YygbP8QA/gNrA9ZJLEFFE9aqAZqFf4SnSCmrdROAQz6SUMb1Zm0
	p+Z2UaC5382TR126Wt7hgfjcL7bINRZ9UpPg6GPP8lSH0E2In1treQfb6eNwcj4IY3UCqxFBd0/
	FLPEN748cib1h5UJ6piBgtBGIfKc=
X-Gm-Gg: ASbGncu0LcxeFKeq4EdPQ/gshf0Y+vzQ2+MLtZysXN3V9VXN8cM2OwE6EW3YvhG5sBK
	YmZH6+fP16Op86usIwdRH90f/QuYXKSzAYtlE36VJ
X-Google-Smtp-Source: AGHT+IFT+CJdtfPBKnXp1lIzBMT3rgy5V8stNsAzlOOJg2YwcRJh81yx++tNno/y9rDBXbgCwuxfImfsc/hM7Bck2zY=
X-Received: by 2002:a05:6214:3008:b0:6d4:2646:109c with SMTP id
 6a1803df08f44-6df9b1cf3c5mr80749856d6.3.1736430419404; Thu, 09 Jan 2025
 05:46:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103022409.2544-1-laoar.shao@gmail.com> <20250103022409.2544-5-laoar.shao@gmail.com>
 <z2s55zx724rsytuyppikxxnqrxt23ojzoovdpkrk3yc4nwqmc7@of7dq2vj7oi3>
In-Reply-To: <z2s55zx724rsytuyppikxxnqrxt23ojzoovdpkrk3yc4nwqmc7@of7dq2vj7oi3>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 9 Jan 2025 21:46:23 +0800
X-Gm-Features: AbW1kvaKkMqpK8mxw4zFIk501IQjsHJbKsFT45M0lYhNKse3TYJHGv23jTDCv1Q
Message-ID: <CALOAHbAY8MLDT=EdzY6TzQv3ZF4OGXTWoWBEs45zQijZH4C0Gw@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] sched: Fix cgroup irq time for CONFIG_IRQ_TIME_ACCOUNTING
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, hannes@cmpxchg.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, surenb@google.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 6:47=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> Hello Yafang.
>
> I consider the runtimization you did in the first three patches
> sensible,

The first three patches can be considered as a separate series and are
not directly related to this issue.

Hello Peter,

Since the first three patches have already received many reviews,
could you please apply them first?

> however, this fourth patch is a hard sell.

Seems that way. I'll do my best to advocate for it.

>
> On Fri, Jan 03, 2025 at 10:24:09AM +0800, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > However, despite adding more threads to handle an increased workload,
> > the CPU usage could not be raised.
>
> (Is that behavior same in both CONFIG_IRQ_TIME_ACCOUNTING and
> !CONFIG_IRQ_TIME_ACCOUNTING cases?)

No, in the case of !CONFIG_IRQ_TIME_ACCOUNTING, CPU usage will
increase as we add more workloads. In other words, this is a
user-visible behavior change, and we should aim to avoid it.

>
> > In other words, even though the container=E2=80=99s CPU usage appeared =
low, it
> > was unable to process more workloads to utilize additional CPU
> > resources, which caused issues.
>
> Hm, I think this would be worth documenting in the context of
> CONFIG_IRQ_TIME_ACCOUNTING and irq.pressure.

Document it as follows?

"Enabling CONFIG_IRQ_TIME_ACCOUNTING will exclude IRQ usage from the
CPU usage of your tasks. In other words, your task's CPU usage will
only reflect user time and system time."

If we document it clearly this way, I believe no one will try to enable it =
;-)

>
> > The CPU usage of the cgroup is relatively low at around 55%, but this u=
sage
> > doesn't increase, even with more netperf tasks. The reason is that CPU0=
 is
> > at 100% utilization, as confirmed by mpstat:
> >
> >   02:56:22 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %st=
eal  %guest  %gnice   %idle
> >   02:56:23 PM    0    0.99    0.00   55.45    0.00    0.99   42.57    0=
.00    0.00    0.00    0.00
> >
> >   02:56:23 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %st=
eal  %guest  %gnice   %idle
> >   02:56:24 PM    0    2.00    0.00   55.00    0.00    0.00   43.00    0=
.00    0.00    0.00    0.00
> >
> > It is clear that the %soft is excluded in the cgroup of the interrupted
> > task. This behavior is unexpected. We should include IRQ time in the
> > cgroup to reflect the pressure the group is under.
>
> What is irq.pressure shown in this case?

$ cat irq.pressure ; sleep 1; cat irq.pressure
full avg10=3D42.96 avg60=3D39.31 avg300=3D17.44 total=3D66518335
full avg10=3D42.96 avg60=3D39.31 avg300=3D17.44 total=3D66952730

It seems that after a certain point, avg10 is almost identical to
%irq. However, can we simply add avg10 to the CPU utilization? I don't
believe we can.

>
> > The system metric in cpuacct.stat is crucial in indicating whether a
> > container is under heavy system pressure, including IRQ/softirq activit=
y.
> > Hence, IRQ/softirq time should be included in the cpuacct system usage,
> > which also applies to cgroup2=E2=80=99s rstat.
>
> But this only works for you where cgroup's workload induces IRQ on
> itself but generally it'd be confusing (showing some sys time that
> originates out of the cgroup). irq.pressure covers this universally (or
> it should).

It worked well before the introduction of CONFIG_IRQ_TIME_ACCOUNTING.
Why not just maintain the previous behavior, especially since it's not
difficult to do so?

>
> On Fri, Jan 03, 2025 at 10:24:05AM +0800, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > The load balancer is malfunctioning due to the exclusion of IRQ time fr=
om
> > CPU utilization calculations. What's worse, there is no effective way t=
o
> > add the irq time back into the CPU utilization based on current
> > available metrics. Therefore, we have to change the kernel code.
>
> That's IMO what irq.pressure (PSI) should be useful for. Adjusting
> cgroup's CPU usage with irq.pressue (perhaps not as simple as
> multiplication, Johannes may step in here) should tell you info for load
> balancer.

We=E2=80=99re unsure how to use this metric to guide us, and I don't think
there will be clear guidance on how irq.pressure relates to CPU
utilization. :(


--=20
Regards
Yafang

