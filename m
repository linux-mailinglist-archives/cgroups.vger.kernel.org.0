Return-Path: <cgroups+bounces-5750-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA439E3151
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 03:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4B728747A
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 02:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BF94EB51;
	Wed,  4 Dec 2024 02:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+Q5Q/lh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949E62207A;
	Wed,  4 Dec 2024 02:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278714; cv=none; b=WZF59pDpGF2l1jzLp8wuJyJOlLX1C4NBiJksgWTnmhyB3+gvvIfwYadTKoCiW3g61+mg1V5mjv6ATf6N2oPINsh7fKAcMfqeyb19Zb9IzD2xUZCpYZefBLPmZn/DuPITP+RaPMrsPK1PyKxtK3NBDrd6RHgmcnvYhn4uGGTYAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278714; c=relaxed/simple;
	bh=a0Bu9rksufnsC4TmSv2GlG7C+X9KP7+t7rn0T3X5jJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBKUFsuTiJz0qowyjxnLgJIo/L6n3/XFHJar4t/9OLxNUFJroMawnqoI/h/x4wLGt1ZoTYCm09zDIOj0yP4FyFyjt0sfp+I+3gspyxL//F8IdMo406t18tx8SoTstjatNX/bTWobcfUJw56hl36c66FcaDCQRf5XH/KPfqfj1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+Q5Q/lh; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d8843c44cfso38771716d6.3;
        Tue, 03 Dec 2024 18:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733278711; x=1733883511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=921iFcZNiyLxlZsenifClJ5i3QMrxCT5CBYEvG5L/hA=;
        b=P+Q5Q/lhXeFDsereSbDrk43CdB2+NkAAW0Krohq7XKmlGiKvI19tu6Iu0jsGd0o0Ex
         MYRdyJPH/u6A4WjdTxBlhFpV2MOe3cIsyX5vAtHMxLxGDP2thJDOJUBqtLKxUvbm0hrS
         oh3bp2C46iQiNTRrLgNQ4Vm/9bUL12exCgv6Rskz3OXoyoBmANMvUBJlirpJ+a8cMyKz
         DumRCW9o6Z/odQcatMvoReAVdut4Rzqohs00ZfB4yBuWXFTBSmsQhYXxift0y7gcsntQ
         tPk3DxuqpYML4fIi+FEVpbGb/HzGvyv34J142oK2ngL2q3UYDycWoSrKATxcgmbSrq5I
         LZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733278711; x=1733883511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=921iFcZNiyLxlZsenifClJ5i3QMrxCT5CBYEvG5L/hA=;
        b=oIvHfSXCGukd+jc491Vfl2vEeRhz++lJ/eaSFIXWgu0f1VeKATd+DU8xPKPLDE7ac4
         h+ZCR+nLzLR2NjDFF1o1oE4VEXq8sfpwjaOR2ugl9+wA20i7X8o0Y1tgk8D7Jc5je67C
         MS/nsB7cw6q9ZIaOWsE6mfiMvZHKdnu3UwHPm50yjkGtZEX//rmp7fymRV6iFbimstow
         VnU+hHbQ1Ph6R8xwLY/+hrLrslqYSSdaUV0xTmuZsLHaLOiU7pEYs0h6LSla8wrXz3y5
         lKz1bo+NgbLb52//YCrdVKvJZlCg9ed/TWZ0hmWNYudEciEVFAygqjRnfJ9LQBYsQoZs
         atxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaJ0td7KQc1RMCqo6O1L9dvz8RvHHOr0AZ9V98u3iRr6cCU0wZMIS6DFrJROqeQztzGraAGWfsEAvrkc3g@vger.kernel.org, AJvYcCWZM7U6ECYqEfnkUTOgPdHYgEU2PocwuLR62o//BOCaChF2G1M6UtNyLAci8ywXOxDXfsDwT+b2@vger.kernel.org
X-Gm-Message-State: AOJu0YxfwS/hExlfS2GjSpqSvcTLEgDb5/oVi7ex67us2VKtkhtUfG1M
	VtypRvGgWdBw6j7rXRRYgifAQ4hKzgfEIP5VIY9KMCDYNRo8yLxpmoo6bFuw2tfAx75TZld3CYh
	dMoQ43KNfVZ0S8/Q4dx48UV61EO0=
X-Gm-Gg: ASbGncuZbO259C2s0oGbV/lOyILE1WIJvJB4OqY1rywn0GG5qG13tyqwqGFLHj4mlLU
	WY8zSdDVPZdhVwyEGbNobRvgwJqWT3rJZ8A==
X-Google-Smtp-Source: AGHT+IEL+W7xOVc87A3x0bzwCX3ANnSN8X7bvCIVQR0YcB3PiNo/ti7TJSBIMqmvrgNi9FHyr6ZDySa9Cn9EVCQ7+pQ=
X-Received: by 2002:a05:6214:4001:b0:6d8:899e:c3be with SMTP id
 6a1803df08f44-6d8b741cd6dmr65750856d6.49.1733278711440; Tue, 03 Dec 2024
 18:18:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108132904.6932-1-laoar.shao@gmail.com> <20241108132904.6932-5-laoar.shao@gmail.com>
 <os5wmuytn2hg2bhbb2x4j3zzj6cpqropgop6lhwlxwqh2ufise@2pbrsxjyt6ct>
In-Reply-To: <os5wmuytn2hg2bhbb2x4j3zzj6cpqropgop6lhwlxwqh2ufise@2pbrsxjyt6ct>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 4 Dec 2024 10:17:55 +0800
Message-ID: <CALOAHbCSo3qcbPwGQBxc0dY=aTHLd6pw-Lpva0tS+gkU+x0K8Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] sched: Fix cgroup irq time for CONFIG_IRQ_TIME_ACCOUNTING
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org, 
	surenb@google.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 6:01=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> On Fri, Nov 08, 2024 at 09:29:04PM GMT, Yafang Shao <laoar.shao@gmail.com=
> wrote:
> > The system metric in cpuacct.stat is crucial in indicating whether a
> > container is under heavy system pressure, including IRQ/softirq activit=
y.
> > Hence, IRQ/softirq time should be included in the cpuacct system usage,
> > which also applies to cgroup2=E2=80=99s rstat.
>
> (snipped from cover letter thread)
>
> On Mon, Nov 18, 2024 at 08:12:03PM GMT, Yafang Shao <laoar.shao@gmail.com=
> wrote:
> > The key issue here is determining how to reliably get the IRQ. I don't
> > believe there is a dependable way to achieve this.
> >
> > For example, consider a server with 16 CPUs. My cgroup contains 4
> > threads that can freely migrate across CPUs, while other tasks are
> > also running on the system simultaneously. In this scenario, how can
> > we accurately determine the IRQ to subtract?
>
> I understand there's some IRQ noise which is a property of CPU (noise is
> a function of cpu).
>
> Then there're cgroup workloads, on a single CPU impact per-cgroup
> depends how much that given cgroup runs on the CPU (it's more exposed).
> Whole cgroup's impact is sum of these (i.e. it's kind of scalar product
> between that IRQ noise per-cpu and cgroup's CPU consuption per-cpu).
>
> (In your usage, there's some correlation of IRQ noise with CPU
> consumption).
>
> > That is precisely what the user wants. If my tasks are frequently
> > interrupted by IRQs, it indicates that my service may be experiencing
> > poor quality. In response, I would likely reduce the traffic sent to
> > it. If the issue persists and IRQ interruptions remain high, I would
> > then consider migrating the service to other servers.
>
> If I look at
>         52b1364ba0b10 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ press=
ure")
> (where it's clearer than after
>         ddae0ca2a8fe1 ("sched: Move psi_account_irqtime() out of update_r=
q_clock_task() hotpath")
> )
>
> the IRQ pressure accounting takes into account the task (its cgroup) vs
> IRQ time (~multiplication) and then its summed a) over time
> (psi_account_irqtime()), b) over CPUs (collect_percpu_times()) so it's
> the scalar product (squinting) I mentioned above.
>
> Therefore I think irq.pressure provides exactly the information that's
> relevant for your scheduling decisions and the info cannot be fit into
> cpuacct.stat.
>
> Or what is irq.pressure missing or distorting for your scenario?

irq.pressure is a metric that operates independently of CPU
utilization. It can be used to monitor whether latency spikes in a
cgroup are caused by high IRQ pressure=E2=80=94this is exactly how we utili=
ze
it in our production environment.

However, this metric alone doesn=E2=80=99t provide clear guidance on whethe=
r
to add or reduce CPUs for a workload. To address this, we=E2=80=99ve attemp=
ted
to combine irq.pressure with CPU utilization into a unified metric,
but achieving this has proven to be challenging.

--
Regards
Yafang

