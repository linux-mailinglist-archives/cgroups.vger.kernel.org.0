Return-Path: <cgroups+bounces-8365-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C4CAC5F17
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 04:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F55A17FD0A
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 02:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A401B0F33;
	Wed, 28 May 2025 02:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZNiwBun"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C7654764;
	Wed, 28 May 2025 02:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748398290; cv=none; b=Rq7CjD+dyVxz8qcd7T692pAnvM5+pXzxhJMq1kH0HmpyuSA4swug0kh75zD5Nf9DhJKhVWaUjcSa3A9ojcS9ftkm1SKhq4HlnHsmZed7KoSXa32P+8DtuLPa4oEUUH5WnOC/6jgGCdNwNeQHkVrUfN/L1lSd9Isw6q5cbXJvLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748398290; c=relaxed/simple;
	bh=pOkeTJAMxL0EATITKTnUKdNuGMng0EDHbknS08HfamE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjpGlIfiJPCCfj5apOTn7pfnn5sC3Q9r6mXOCy7st8DwWhySK5533ODK1d9/b1glSXuPPAzzzLCFvBqrH8tEZvxqYYrxhZglLS8LYaBQ/tNldEcf+DDodbDY+eO+87FLEWN4el6GgXCZrAqOhhepQHDGI3hJmGUUFfYizQkL/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZNiwBun; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fa9ce24d44so80034366d6.1;
        Tue, 27 May 2025 19:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748398287; x=1749003087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+IW/tbaDggglZV+0MU4J5fQthnAp+Rb913Pmy/jkw0=;
        b=IZNiwBunmYJPuPA2NWDtuureQ5FT7f9YXUA4O6BZKfrCQSa1ya0TdYRKyGxiMNxB43
         GxpKFpTntq0/wKpzT6jNTwop3TvHsGmrBLCfaKdEIybHcO5/JVLjDsOxR/XxoI/jeEw9
         QN4xjBbw+QQZ2HkoBjLVR/pDKjhIbQwfpCjwZ7VMhF68jz/T9BzJaryGjHShD8HBwVGc
         /HyEK+YOFYjEzWe9WoV1rNdvviLtEqfvhsn3YfpXQIzZwzSv+I42MxhkWu7c2k0DyN+7
         CJF9XJBsAZmrta44ZM00aEUhqKkQdKS7O3z30KiJgsUGqYUlQPDvb+MovMuCybcm780R
         wfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748398287; x=1749003087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+IW/tbaDggglZV+0MU4J5fQthnAp+Rb913Pmy/jkw0=;
        b=WbnJlUfBafcg9mhQG8GobHhLlDgQ9pME9JqBgMdsWWHVr6pVBV7ZKb2Gy23da6kUa0
         ghws65OSkZLfTy9iz0SM7eFAWYuPiJ35D6MKeElvBEA1r+G5Q/K44NUwFWuPLj9qdWWc
         ZACKhDvJsaRuHH1sgnjE9m1rfQD8z3SSoY+pDux0XMDCbebmtipHzIToGSwENylaYYk4
         BZiWfGxOJxj+0muIWqisT0WqagYKxFh2kAxnE5m9NEFPvJ9acXo5ewgMl+LNJ/mkRwqi
         U+5wCs9ZAhLF0tjQqf+cAOtuD7I4rNOWf23gNPjvJ6TUdbxv/5At+dU/L/2PboyNnGDj
         HhYw==
X-Forwarded-Encrypted: i=1; AJvYcCU77HCe3Av0R3NRGUVl28OpLxh+YetQ+j6cr8AZO7lvD56eoeSDzVV0tRlr9k2j4D2i3e6s8Dzy@vger.kernel.org, AJvYcCWPyoTparn8Hslscs/5+2hqiLd1MiDFqSVcYWeM6zC50V5jeutKmrM04ekN+jw3DJ5smF0Dq9yuh9MG7nLi@vger.kernel.org
X-Gm-Message-State: AOJu0YzTHcAuRfIESoSYrVItYkQa7D/+mxPlZ4e1e+52YNnQ8VO0AAne
	UKK3OecJDq0jmdLGEnizbi5wZN9LBRsujV9uWY+zYHvZ5A0PQwNOOGjYIpHg10svTPEX6QDbBae
	N5cosdwA4PQiKxwIyUZVIXwBtLgoJ0LA=
X-Gm-Gg: ASbGncv+rerqxHy61Zp6Koh5T/bEJ9RsQzZoQ1Iqt7mRx0PWP5NPRAp695fyR/NuVVH
	UxqFts2vUedynmLNAu7IBjzqgRSXaYGTTjQ3ojzo6ZHsylpgZilfRRbnPutVERml1oYpFnsEwh8
	hhn6G8U571qewbqfQeFyJS6uUWKWgRFg+7xd6Pw/rOUMrX
X-Google-Smtp-Source: AGHT+IFqGoiUYCgGrbA5DxzQtE0trjSe6SrEJmB9sYlmq9AqpiNwyRutGDaPq8aMbxqXgNunrJfRsi8Q2v0lW20nS0o=
X-Received: by 2002:a05:6214:4016:b0:6e8:fa33:2965 with SMTP id
 6a1803df08f44-6fa9d281ceamr245758656d6.14.1748398287548; Tue, 27 May 2025
 19:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511030800.1900-1-laoar.shao@gmail.com> <20250511030800.1900-2-laoar.shao@gmail.com>
 <2e3mby62lswkw454sq4b4wnjmcr6etoug5bazafutb6dbbpozl@juhpci6ebev2>
In-Reply-To: <2e3mby62lswkw454sq4b4wnjmcr6etoug5bazafutb6dbbpozl@juhpci6ebev2>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 28 May 2025 10:10:51 +0800
X-Gm-Features: AX0GCFs-iee39CFIkSuN-rGZvbGheNTuMekcfo6HWdqcULPDoQGXbErWiG2nuok
Message-ID: <CALOAHbBQXSuUmz8C2CKA2o-Menup8uz3qOX34JsZCCG68GhaWg@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] sched: Fix cgroup irq time for CONFIG_IRQ_TIME_ACCOUNTING
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: mingo@redhat.com, peterz@infradead.org, hannes@cmpxchg.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 11:33=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
>
> Hello.
>
> On Sun, May 11, 2025 at 11:07:59AM +0800, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
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
> I think this would go against intention of CONFIG_IRQ_TIME_ACCOUNTING
> (someony more familiar may chime in).

Please refer to the discussion with Ingo :
https://lore.kernel.org/all/aBsGXCKX8-2_Cn9x@gmail.com/

>
> > After a thorough analysis, I discovered that this change in behavior is=
 due
> > to commit 305e6835e055 ("sched: Do not account irq time to current task=
"),
> > which altered whether IRQ time should be charged to the interrupted tas=
k.
> > While I agree that a task should not be penalized by random interrupts,=
 the
> > task itself cannot progress while interrupted. Therefore, the interrupt=
ed
> > time should be reported to the user.
> >
> > The system metric in cpuacct.stat is crucial in indicating whether a
> > container is under heavy system pressure, including IRQ/softirq activit=
y.
> > Hence, IRQ/softirq time should be included in the cpuacct system usage,
> > which also applies to cgroup2=E2=80=99s rstat.
>
> So I guess, it'd be better to add a separate entry in cpu.stat with
> irq_usec (instead of bundling it into system_usec in spite of
> CONFIG_IRQ_TIME_ACCOUNTING).
>
> I admit, I'd be happier if irq.pressure values could be used for
> that. Maybe not the PSI ratio itself but irq.pressure:total should be
> that amount. WDYT?

Thank you for your suggestion. Both methods can effectively retrieve
the container=E2=80=99s IRQ usage. However, I prefer adding a new entry
irq_usec to cpu.stat since it aligns better with CPU utilization
metrics.


--
Regards
Yafang

