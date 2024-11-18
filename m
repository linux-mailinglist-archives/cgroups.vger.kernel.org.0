Return-Path: <cgroups+bounces-5612-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7079D106A
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 13:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E9428365E
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4D01991B4;
	Mon, 18 Nov 2024 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDGuTZPc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B80213A89A;
	Mon, 18 Nov 2024 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731931962; cv=none; b=rdhI2Y7/hYn3dZ16AFSfsjyuYoEBldv9+JaKWarA/9a3tTJRHLn+pxnW1l6sfo7VIelv/d0GVGn6nJ0w1b4W2BQsG1Yq+OJ22/ox2gswOXKqRM/tj7sN8EZh1Ucn0dW7lbXerBAebCYVYyiuBsKvszavotgxhiwtaatliKQdTpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731931962; c=relaxed/simple;
	bh=T6Q+nXARivglHsvGHeBPk9iFZbpmIxxAASYhY3OWCZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haTd/Pm6M9E4Q/IsQEJrNqFDtOi6sBLyYSAOf+sqAMERdDo99KCqyqDAbF8rXulAPK4UYN5DGVmMYpgkRrMkQkSmuIWb8rN6D5qo8EUeSruocC2MoHEwsiEOzTW/Zwggz86GkHlhAQgMw09oaYVedcvldu42lo6VTfpjHeQdzDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDGuTZPc; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e619057165so2142729b6e.1;
        Mon, 18 Nov 2024 04:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731931959; x=1732536759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/olhmA/cAyzIED08CJMv1lbWYqEKq8K1fPAedpvt5Xc=;
        b=SDGuTZPc8UJfjjgqsk/sXIvb80LZO/5Hwrh+6LyxgXeCFjoWuAXC810Rk74h/3C+dS
         0bp/Wu1DAZ0cXfW9oEUVeny4kruojcFTb9KdshqoB6LGTv20WkDT3tWloR5EX5rFBYV6
         MsJwaeFRZ75S9wqFc+VSxfffnv3OCb8neADYlWLyZWKCbGq2msXqkL53qMdIl+vFtJwV
         kLi1IxCdmsTvo+93oFVByXBgenhmXxWS90I1F3W1/MqEzkr5qXt1hTZ228daD01jdH0Y
         WBZxX2CRBu6/XhozuG7OD1vmpgj+4EWV5at0Q5tIa1cFGRvnC0Au+LPgom1Fzx3sZurt
         jHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731931959; x=1732536759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/olhmA/cAyzIED08CJMv1lbWYqEKq8K1fPAedpvt5Xc=;
        b=ppTHJgpAjFKvYy5nz8qhxl0GeaX/ViovMdOO3Dsb7gIYdqNw9FADRzP8kVeRjxmAhS
         LhiCCIJ7rz9oTgk1q363HOHYCh9ys/xUVC6i/x4iy8WPyu0EHqFz8pKqh4gJSxmZMTNy
         f0Zj9uLjS1XzX+0JJkbfGlGd7yS2E8fdOjvvRQ7yjsvhSiL6uYECJo/wHb7Tn9UL7KjX
         VlP4CspmfKDd5zwwywNJgAq9Jjl/jgkjfVrycptwG7QFKv3oHoFRZGxB1JTc8fXIDXS5
         iX553BTFqrJIQOo+p/FablqMrcI/+2jv/HQza2ct4YR9a/l7MYR0ODU6ZhbyZ9rO3Lxj
         zfLg==
X-Forwarded-Encrypted: i=1; AJvYcCXI2CwFOhiMsF5sCqZnXcK1EGpBRVRXAmTWuX1z/xhLBFTr9ZH3fLaRaMos+P7ttqb2n2KNn3iVvSYYrkV9@vger.kernel.org, AJvYcCXM7pqaEH21p/hc//PVtY6AFIKX+NQH3wF7CNpGLzvw901930YR8Raoe2WWiL8dBnK0a15jo5k0@vger.kernel.org
X-Gm-Message-State: AOJu0YyU1SM+OjM7G/ghP6o8fSQ0WF0TeJ9oPEntY84A35fDoOP5ccu2
	bC9BPxVivSRATHtlvPg/r2cQFi+uoOK3Mwi9YVVjZgV//OOa/MsGmk5X0kB7ypHyao29JgkgXfm
	KDUGquhVDG1I1Ch5pDhSL+YAJ7lo=
X-Google-Smtp-Source: AGHT+IFO19vZxD55Hjt3qfUJDbjiruvU6huL3TsuJuYAYyRtuhKWKRry1+SUR8gDPK7UPKBSFRmZms8myzeig3cDfF4=
X-Received: by 2002:a05:6808:1302:b0:3e6:5358:5385 with SMTP id
 5614622812f47-3e7bc7a8f4fmr10012219b6e.6.1731931959605; Mon, 18 Nov 2024
 04:12:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108132904.6932-1-laoar.shao@gmail.com> <dmibxkog4sdbuddotjslmyv6zgyptgbq5voujhfnitdag2645m@bl4jphfz3xzg>
 <CALOAHbC54QZ6ZrRBHHKKz8F79C1J8fYcA1q59iwotuBBKtFGmA@mail.gmail.com> <20241118101023.GI39245@noisy.programming.kicks-ass.net>
In-Reply-To: <20241118101023.GI39245@noisy.programming.kicks-ass.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 18 Nov 2024 20:12:03 +0800
Message-ID: <CALOAHbCX7YaKNddUmkCvEAejqsvDSM7-HXv1jdHEw0oS9xgBaA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] sched: Fix missing irq time when
 CONFIG_IRQ_TIME_ACCOUNTING is enabled
To: Peter Zijlstra <peterz@infradead.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	hannes@cmpxchg.org, surenb@google.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 6:10=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sun, Nov 17, 2024 at 10:56:21AM +0800, Yafang Shao wrote:
> > On Fri, Nov 15, 2024 at 9:41=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@sus=
e.com> wrote:
>
> > > > The load balancer is malfunctioning due to the exclusion of IRQ tim=
e from
> > > > CPU utilization calculations.
> > >
> > > Could this be fixed by subtracting (global) IRQ time from (presumed
> > > total) system capacity that the balancer uses for its decisions? (i.e=
.
> > > without exact per-cgroup breakdown of IRQ time)
> >
> > The issue here is that the global IRQ time may include the interrupted
> > time of tasks outside the target cgroup. As a result, I don't believe
> > it's possible to find a reliable solution without modifying the
> > kernel.
>
> Since there is no relation between the interrupt and the interrupted
> task (and through that its cgroup) -- all time might or might not be
> part of your cgroup of interest. Consider it a random distribution if
> you will.
>
> What Michael suggests seems no less fair, and possible more fair than
> what you propose:
>
>  \Sum cgroup =3D total - IRQ

The key issue here is determining how to reliably get the IRQ. I don't
believe there is a dependable way to achieve this.

For example, consider a server with 16 CPUs. My cgroup contains 4
threads that can freely migrate across CPUs, while other tasks are
also running on the system simultaneously. In this scenario, how can
we accurately determine the IRQ to subtract?

>
> As opposed to what you propose:
>
>  \Sum (cgroup + cgroup-IRQ) =3D total - remainder-IRQ
>
> Like I argued earlier, if you have two cgroups, one doing a while(1)
> loop (proxy for doing computation) and one cgroup doing heavy IO or
> networking, then per your accounting the computation cgroup will get a
> significant amount of IRQ time 'injected', even though it is effidently
> not of that group.

That is precisely what the user wants. If my tasks are frequently
interrupted by IRQs, it indicates that my service may be experiencing
poor quality. In response, I would likely reduce the traffic sent to
it. If the issue persists and IRQ interruptions remain high, I would
then consider migrating the service to other servers.

>
> Injecting 'half' of the interrupts in the computation group, and missing
> 'half' of the interrupts from the network group will get 'wrong'
> load-balance results too.
>
> I remain unconvinced that any of this makes sense.

If we are uncertain about which choice makes more sense, it might be
better to align this behavior with the case where
CONFIG_IRQ_TIME_ACCOUNTING=3Dn.

--=20
Regards
Yafang

