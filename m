Return-Path: <cgroups+bounces-6040-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C6EA009F2
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 14:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3E217A1D64
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 13:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4221FA241;
	Fri,  3 Jan 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3ubtEJG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB34155C97
	for <cgroups@vger.kernel.org>; Fri,  3 Jan 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735911146; cv=none; b=ZFoHPsLoOmIV/v0rqVyMwdXXcH0MrGahz1/MGV0y6LoNGpBk4wyudBqpFcJd8HF0vjcdsRP/tLayxZLbeKB1RGqnu7yaJIeu/hrx28uv7gYdtxULrIU+C9RZdVTQ3nyi09s5/mmGG7esMQDVrAx8zRn1q1u7/n5tG3tf7nbT+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735911146; c=relaxed/simple;
	bh=Ch2Nzc5xG7vQZ4N0HN8Ag0H0hp7ZIS55jjjOJ2OCI0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QH9sIxnPvmDpyvSmVWZmCotin37o5cqEUHCWgTJThmLw+Qxbiex7HE6CkL2HLT3fCvQHf7kYCI5Qbh/kHTSqgbvjqJLo6VmXMlSV0OP8XddEYF8vkmb4wBr5DfIzJwg3ehR2QEWKfxd6KDcj0iOwDFC1iqJe8D05ChHl5thJ6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T3ubtEJG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216401de828so159844715ad.3
        for <cgroups@vger.kernel.org>; Fri, 03 Jan 2025 05:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735911143; x=1736515943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HmC6mo2XJnAhe91eL2MiQ7qbXZOJ7/SwlkA9SALJ7o=;
        b=T3ubtEJGEpqsbJymC/beGfXQ5y/KmAWeG4QWZXylJ5uVFeq21DWrizVKsb9D/TVPko
         WfG0bIJ9R5RJNUQy/as9XKL0AM5jeBM6v4PEwTrmUCZXT6lCGEa2HCZhgPG6U649Je9q
         qcJN1SshRuSmE5AgdYuhoxhtAprqIa+uVmKOqhq7W13mzq7dPQDaLjR7vvq5lJ9t1TOb
         WKwhvYmm6wql8kQ4V1FwJSs/URA31F8i5sJ+CK5+VyF5A+jwFmngknBPejpNrTbQhiJz
         QAT8XJwoRm8bXp2rapq5hvbEhb0NgWJB6TbUoO+Xh+WCgjS9EErAvmlKIC4ImResKO/y
         IPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735911143; x=1736515943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HmC6mo2XJnAhe91eL2MiQ7qbXZOJ7/SwlkA9SALJ7o=;
        b=UZiKjtfbu/NDUIfcNVwgvJDA+s/EfLsfzl7cYHY05PNwjZd6ZEwYybDXChi2Lz8bgY
         0Y+fCO69hmh1DVBxetyowfAK/CsBXSaVJiqmkJi4LOUZqdlHVIXJ0+JGkEKkQTo7cAOB
         ssDp7+YJ6ZFGykhBPsQ/ccmH/2iUUxLzwxT7EcuhmcCsuE5f5qv9m1RBGPTjW0M0U71Z
         R9e19kYuSE4F7vxZoT89PCcQxkYv80o3HqUOg2mFGmi3HuaLJR8hhj5/UBrSSXZNEB30
         T5Usb3HyXYwtmF5FgTLj5DqvaveyJ029rg8WWRkXq0YoZ7MERABOEZa9DngMAA3WPSER
         VTow==
X-Forwarded-Encrypted: i=1; AJvYcCVHPr9Prol7wMHefNBdUQBa21xD/y45xfrUqVM6/Dgh1mbv7ueiRxhEFjaMFsRi72YzW3g2hUGV@vger.kernel.org
X-Gm-Message-State: AOJu0YxNUgtJLZkR1mCkmBil8aNd/7wZeexv0DVXwd03AErNEDFMWTml
	iEXDlv+N+aruE5rJXJ0VxwuOswrfB0dCrI55NBYCn02lV1h6AvQyehIn8BmQhG9/GUpDSGw7wqW
	b0oaU1PRxTH2jZt4glJ26k+vU0IHS+Jh4ekR5vA==
X-Gm-Gg: ASbGncv3s6RWC5obsuXmqeCDU5c6JGwoJ5RwF+iVZes/GqKgHvQx/HNXdE/mB1f6RHU
	zSwTXMUAgV7fb5/nwq4fcipvSDpkRD/QHdMJZnxQqOpcwZSubijNHaCPGUbP8SRzq/lE=
X-Google-Smtp-Source: AGHT+IH1wCsymQMtwKVXgUBQ0ZAuvPv6hitvnf3cpPZ3ziLG9mfhFhbdhlf5mTzFbje07oj1UXfxC6DeaeGxme5AWdc=
X-Received: by 2002:a17:903:2acb:b0:215:9470:7e82 with SMTP id
 d9443c01a7336-219e6e88179mr618440755ad.4.1735911143024; Fri, 03 Jan 2025
 05:32:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103022409.2544-1-laoar.shao@gmail.com> <20250103022409.2544-2-laoar.shao@gmail.com>
In-Reply-To: <20250103022409.2544-2-laoar.shao@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 3 Jan 2025 14:32:11 +0100
Message-ID: <CAKfTPtBpnj+A5btGitYD1Pn6B8PG3qPP=UzACpAkB+c=4Ak-gw@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] sched: Define sched_clock_irqtime as static key
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
> Since CPU time accounting is a performance-critical path, let's define
> sched_clock_irqtime as a static key to minimize potential overhead.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> ---
>  kernel/sched/cputime.c | 16 +++++++---------
>  kernel/sched/sched.h   | 13 +++++++++++++
>  2 files changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 0bed0fa1acd9..5d9143dd0879 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -9,6 +9,8 @@
>
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
>
> +DEFINE_STATIC_KEY_FALSE(sched_clock_irqtime);
> +
>  /*
>   * There are no locks covering percpu hardirq/softirq time.
>   * They are only modified in vtime_account, on corresponding CPU
> @@ -22,16 +24,14 @@
>   */
>  DEFINE_PER_CPU(struct irqtime, cpu_irqtime);
>
> -static int sched_clock_irqtime;
> -
>  void enable_sched_clock_irqtime(void)
>  {
> -       sched_clock_irqtime =3D 1;
> +       static_branch_enable(&sched_clock_irqtime);
>  }
>
>  void disable_sched_clock_irqtime(void)
>  {
> -       sched_clock_irqtime =3D 0;
> +       static_branch_disable(&sched_clock_irqtime);
>  }
>
>  static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
> @@ -57,7 +57,7 @@ void irqtime_account_irq(struct task_struct *curr, unsi=
gned int offset)
>         s64 delta;
>         int cpu;
>
> -       if (!sched_clock_irqtime)
> +       if (!irqtime_enabled())
>                 return;
>
>         cpu =3D smp_processor_id();
> @@ -90,8 +90,6 @@ static u64 irqtime_tick_accounted(u64 maxtime)
>
>  #else /* CONFIG_IRQ_TIME_ACCOUNTING */
>
> -#define sched_clock_irqtime    (0)
> -
>  static u64 irqtime_tick_accounted(u64 dummy)
>  {
>         return 0;
> @@ -478,7 +476,7 @@ void account_process_tick(struct task_struct *p, int =
user_tick)
>         if (vtime_accounting_enabled_this_cpu())
>                 return;
>
> -       if (sched_clock_irqtime) {
> +       if (irqtime_enabled()) {
>                 irqtime_account_process_tick(p, user_tick, 1);
>                 return;
>         }
> @@ -507,7 +505,7 @@ void account_idle_ticks(unsigned long ticks)
>  {
>         u64 cputime, steal;
>
> -       if (sched_clock_irqtime) {
> +       if (irqtime_enabled()) {
>                 irqtime_account_idle_ticks(ticks);
>                 return;
>         }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index aef716c41edb..7e8c73110884 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3233,6 +3233,12 @@ struct irqtime {
>  };
>
>  DECLARE_PER_CPU(struct irqtime, cpu_irqtime);
> +DECLARE_STATIC_KEY_FALSE(sched_clock_irqtime);
> +
> +static inline int irqtime_enabled(void)
> +{
> +       return static_branch_likely(&sched_clock_irqtime);
> +}
>
>  /*
>   * Returns the irqtime minus the softirq time computed by ksoftirqd.
> @@ -3253,6 +3259,13 @@ static inline u64 irq_time_read(int cpu)
>         return total;
>  }
>
> +#else
> +
> +static inline int irqtime_enabled(void)
> +{
> +       return 0;
> +}
> +
>  #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
>
>  #ifdef CONFIG_CPU_FREQ
> --
> 2.43.5
>

