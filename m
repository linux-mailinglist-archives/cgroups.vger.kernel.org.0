Return-Path: <cgroups+bounces-6041-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA91A009F3
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 14:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083C23A3B47
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8151FA15D;
	Fri,  3 Jan 2025 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CtEHh+Mx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD021CC8AD
	for <cgroups@vger.kernel.org>; Fri,  3 Jan 2025 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735911160; cv=none; b=s/KOfRQl8YmuchqOHOlqjhB27UD8ujhVTJ+YUAM5TvlJ3HrMrSzq5FiJDBJ2BjcZFpLKq7KHPq11sAaZJiMU3K7/qJIKdB7x61yNvjsBKXDKQyQ2nGhc3qY76YDS5Ofht2Uio+oNx3K6+DHNwJk3syu4qe6Zkb2lL5KJEXnCNgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735911160; c=relaxed/simple;
	bh=411FE6wYuiVCu0zud/g7Wy+JWGgXQDsNoe73bCONKxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7h5wpXpecHGLKUz2MrZc7F7pWYsQBZld5BoouBVDUzeX1/yenUnYg0qs9VznOe6E3JjfTgQagQKYbZUIWBg0UytCQeCVuYvAG9eZxKITg6X+i+Ykbx1hajS59iL47NNh6rOM3e+vAxn+KICoqTKKYoPdEv1E2MrjmS335ajwqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CtEHh+Mx; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f4409fc8fdso14618956a91.1
        for <cgroups@vger.kernel.org>; Fri, 03 Jan 2025 05:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735911158; x=1736515958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FYoZq3d9zdweOOSviewMn7sCHFG7N0CI+Xi+w9rKcU=;
        b=CtEHh+MxXFGRPC85gEjSr25XoQlVRlWJkUB8lAZpgQmPdlcVnRbJuTuoCRyd7wOwLu
         sgYaIUa2aSWRbF+nciR0GZz942A1npoNCnxcCJyEY0JRmV+eSsinK1R92cbB5DmiXXNk
         Ka9gPF6612epVt8xp9XQiYUKu9NTVpX6jjh3gSzBV8H9zfcSnaOYyFEVaEIQyNetIAUE
         NqtsGHPBp86xm/6jTQgKo/vbUB865nK/wgkVV+iN1DFG4WQ2NN99zcIHQV8zf53rfe8t
         NDymFgozJaap4H2h4k8bpv4UCfu47RHSgSoGN3C8RzadrpeOVNFJW7z0RgqmjeDbLS4P
         xb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735911158; x=1736515958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FYoZq3d9zdweOOSviewMn7sCHFG7N0CI+Xi+w9rKcU=;
        b=oleZJTJjgwRVN12rjgueg02S8SbXA3HWRCbY5RVTabJG5fYJ9MJlFm/g51I6uq1akz
         3RBQbgeYQXl9KfII9bWNk9mGGTPxvjuJi6ynk26VNqE406aNSPPVgzymj7MrWaXFfwTE
         tBS2QkZUqrXis4bd34P1Fc0VI/il5Ll9YyNlZRiUXDaXcDbViaVqv3FbPFrkjsdyVQoL
         rFqWHrh+cq1nvKYpQ7w41pBtr9o65Pn8clSRAWtJQA4e+rK2Nu73bIBWLo3XNong0UX8
         3tc6Q2Bl7MGjbhursBVkdkV2WrUSEbBwjVTq5wQLV4oH5gAlkVQi6j40EpQr+ZuExmgJ
         AnNg==
X-Forwarded-Encrypted: i=1; AJvYcCXr8+6GVVY3xab149Eka7I3Q4AdSAnjlifYnhDSaWmqVvkL6DKggH6yS0e53bw4EaOCkNycC04Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyN4br4ui50bwR27+g9tHz7EsgBIJ+7y3d2rthEeKVg+dtQeoo7
	mxlqh4ukax1qjkIEolrwSHRnWsoz/ke71lyw/XjcXOkcVmv4A7PxGNA6oTnff6Tfpn9nuDUKBoF
	6dsCyefEigNc1d2bxaakFZUQj02iWKTSuDoiI4A==
X-Gm-Gg: ASbGncsrOpTNmZw1KWGXBTjDRUcpwsa9UVAW8ruRpqG5EPcr68JCY5VhU6DtZFOJ/7N
	vEEogqceo2A2k73QNIypLmn1JNTiw4+IXdOxaF0HGmgzcffImhydGMzyMZaPg7rSee0U=
X-Google-Smtp-Source: AGHT+IGgpoccmei/5iNok99VDx2QL9RzBy5ntmOh5agnn/+QppnDFUQE2tG/64dRjimBEN5+y2Jpdut/Zs38a8zf9VM=
X-Received: by 2002:a17:90b:540c:b0:2f2:e905:d5ff with SMTP id
 98e67ed59e1d1-2f453634cb5mr69986064a91.6.1735911157723; Fri, 03 Jan 2025
 05:32:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103022409.2544-1-laoar.shao@gmail.com> <20250103022409.2544-3-laoar.shao@gmail.com>
In-Reply-To: <20250103022409.2544-3-laoar.shao@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 3 Jan 2025 14:32:26 +0100
Message-ID: <CAKfTPtBXA87V=ZnKxnyku7LWe1+UOzsnkDwCENNxoC3DyTVqcA@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] sched: Don't account irq time if
 sched_clock_irqtime is disabled
To: Yafang Shao <laoar.shao@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, mkoutny@suse.com, 
	hannes@cmpxchg.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Jan 2025 at 03:24, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> sched_clock_irqtime may be disabled due to the clock source, in which cas=
e
> IRQ time should not be accounted. Let's add a conditional check to avoid
> unnecessary logic.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> ---
>  kernel/sched/core.c | 44 +++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 84902936a620..22dfcd3e92ed 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -740,29 +740,31 @@ static void update_rq_clock_task(struct rq *rq, s64=
 delta)
>         s64 __maybe_unused steal =3D 0, irq_delta =3D 0;
>
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
> -       irq_delta =3D irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
> +       if (irqtime_enabled()) {
> +               irq_delta =3D irq_time_read(cpu_of(rq)) - rq->prev_irq_ti=
me;
>
> -       /*
> -        * Since irq_time is only updated on {soft,}irq_exit, we might ru=
n into
> -        * this case when a previous update_rq_clock() happened inside a
> -        * {soft,}IRQ region.
> -        *
> -        * When this happens, we stop ->clock_task and only update the
> -        * prev_irq_time stamp to account for the part that fit, so that =
a next
> -        * update will consume the rest. This ensures ->clock_task is
> -        * monotonic.
> -        *
> -        * It does however cause some slight miss-attribution of {soft,}I=
RQ
> -        * time, a more accurate solution would be to update the irq_time=
 using
> -        * the current rq->clock timestamp, except that would require usi=
ng
> -        * atomic ops.
> -        */
> -       if (irq_delta > delta)
> -               irq_delta =3D delta;
> +               /*
> +                * Since irq_time is only updated on {soft,}irq_exit, we =
might run into
> +                * this case when a previous update_rq_clock() happened i=
nside a
> +                * {soft,}IRQ region.
> +                *
> +                * When this happens, we stop ->clock_task and only updat=
e the
> +                * prev_irq_time stamp to account for the part that fit, =
so that a next
> +                * update will consume the rest. This ensures ->clock_tas=
k is
> +                * monotonic.
> +                *
> +                * It does however cause some slight miss-attribution of =
{soft,}IRQ
> +                * time, a more accurate solution would be to update the =
irq_time using
> +                * the current rq->clock timestamp, except that would req=
uire using
> +                * atomic ops.
> +                */
> +               if (irq_delta > delta)
> +                       irq_delta =3D delta;
>
> -       rq->prev_irq_time +=3D irq_delta;
> -       delta -=3D irq_delta;
> -       delayacct_irq(rq->curr, irq_delta);
> +               rq->prev_irq_time +=3D irq_delta;
> +               delta -=3D irq_delta;
> +               delayacct_irq(rq->curr, irq_delta);
> +       }
>  #endif
>  #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
>         if (static_key_false((&paravirt_steal_rq_enabled))) {
> --
> 2.43.5
>

