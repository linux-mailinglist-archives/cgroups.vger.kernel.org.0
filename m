Return-Path: <cgroups+bounces-7940-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB524AA3FA6
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 02:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D637B188F9E0
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 00:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE8D881E;
	Wed, 30 Apr 2025 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+HUEtDP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058AD5383
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972954; cv=none; b=N6s0EEo94ycW4djsm/GU1XfEhcCEv8dSBaaZgJoDtxDuyyTAF4ek3JRGIVaA0adNrvhY71Zo2/OhtV63kDx3Tn3i006fyjMx4ooiOGksBXf0okxseeyTh1k/LBwtbs6MGUPWFrMe3uunPI7LC4hG1rj0BCAdYlP52yDxsKhhw9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972954; c=relaxed/simple;
	bh=rckdEsw4LI+2Q4VYEsNzqiOS7xxyq/0EBJvPBWu9bjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRoFp0v2QWTdfGpmbGDxrcoAbYN6A+iXA0Z0k5KLUW4GLmrUwKfyRP5+4KDQmpzgmNlGKC/3QjvRMiyAe/NCgxaTB44nTSZ0vy/saq8Zwwj3i78FkPl4oRAO94AWLMjXRW09XFOqpqvyJxpmOg9GwSSk7SibtldD158cVxVDcHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+HUEtDP; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47681dba807so135861cf.1
        for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 17:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745972952; x=1746577752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SET8sA9iAqxjHw6Ms59eY6Brr42Gs60ohd9HvBlI7Ok=;
        b=B+HUEtDPnbQRVIZj2INCuc0Qeqf0iXm5Zn1bBgA1QDnMi4YJ+oELctz9VPs9HHM5dL
         HtNo343gEFXv3Tlikn+CPejXj5Ia/4C8OQpxoiP2kuL1qJNttSFNXbvHlDnI0wlwPVJV
         aL3JVvr9ewpnseJdudlCHvHm7Ws5WbVES000+6GVed7i7dmGDYKRCffL5U4aGjrpfrT8
         0aPRhlKlFKS4IwcxjG5B4TZco4VJHFGbpFamYDlX8OPpaDZzsDcFocdh2sstzZgxkPoR
         tSDCRrPhw3fe0Z21J6sFte7ZveqerUo1X8eUjbXcjv59cIPOBc/snPtXvODu+XjmODil
         tv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972952; x=1746577752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SET8sA9iAqxjHw6Ms59eY6Brr42Gs60ohd9HvBlI7Ok=;
        b=peiPBJL50eXxh8HH3HW8ZKH8/EpayZoFFKUw47MORq16atTFucZOkrcS2xT8ZBOkfa
         FnKN+2GwJXsOHXstQplEXURnPaReIen9bQDYAGOW0+hZwQf01hTEV2Xr2S/q91N/fGYm
         fDcBAWL/DXGdrEl/pKXGD8Qb56KsWj16j703ARsUwC70plFVfY3xWFk1ijU26GGlLGhl
         zJA8+HIX5qa7B4+cdl/8nVYlnFX9RONLx1zUZYTuW9S31xkt+iP92fUQJszAw31nPSho
         G/lMwqnOr4P8RdGEEzR8xCfKqsvVCwvqdpadDAkrq1mXgrfooFM4G46Qs3etbftmJTGJ
         89yg==
X-Forwarded-Encrypted: i=1; AJvYcCUTNb8ynJSTKcluferBuwiD4jWxtdB4OcG8y3O09lwsILE12TXe4nkyOVwt/Fy1h9ONVP5AO8WS@vger.kernel.org
X-Gm-Message-State: AOJu0YyR079U114uhVsWWXPCT3OI/++uzLeP+7fFRq8sxCXDPUonVoNg
	LpIgUPTtl93U4j5NmzOhu5cST5EYRjYpCU/x75YK1EKfhAMNVfin06RVD3CUNJI7QeuFYu9AG5s
	nIkNRFZLSUcobO729TQkE/aTKM0faoO0zQcP7
X-Gm-Gg: ASbGncvylHLaI0urq+xpF82nscAfp5uC0muaZzEXVtFHEsBp3YxDEvH6tI5IOazvVgn
	KTeIr/wM6zmxeChUVhQDTcGzBsqpc9/hv+ntK4PZIaDs2w896LxjG1kzr8IjKYTJfHLZqAUa7xj
	TZ3Xs4NnpyNi0G1Ug+ZY74mh7S2H9jUvTc0Wzl7BK4vGZOS6Lc1WO9QVjqhF9q+Ck=
X-Google-Smtp-Source: AGHT+IGYYwIA/2/5KM/ug1jcPdIS8qPi3fGg3w/31Max0dqI27BtipvLcMKHWDfaI1D8DwJd48fBi1Tpym4pkltqpto=
X-Received: by 2002:ac8:7e83:0:b0:486:9b6e:dd46 with SMTP id
 d75a77b69052e-489b993a5b3mr2073341cf.10.1745972951520; Tue, 29 Apr 2025
 17:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428033617.3797686-1-roman.gushchin@linux.dev> <20250428033617.3797686-10-roman.gushchin@linux.dev>
In-Reply-To: <20250428033617.3797686-10-roman.gushchin@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 29 Apr 2025 17:28:59 -0700
X-Gm-Features: ATxdqUHFz_05fXYir2rslhYlMwSd6Gi_vbBqhLqf6_eQZAIUdoejhM82LlPFoTU
Message-ID: <CAJuCfpEdyZWac7diTUYV7JjkpAPDuy9hwT5sfE2AC2zDVPA9ZA@mail.gmail.com>
Subject: Re: [PATCH rfc 09/12] sched: psi: bpf hook to handle psi events
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Rientjes <rientjes@google.com>, 
	Josh Don <joshdon@google.com>, Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 8:37=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Introduce a bpf hook to handle psi events. The primary intended
> purpose of this hook is to declare OOM events based on the reaching
> a certain memory pressure level, similar to what systemd-oomd and oomd
> are doing in userspace.

It's a bit awkward that this requires additional userspace action to
create PSI triggers. I have almost no experience with BPF, so this
might be a stupid question, but maybe we could provide a bpf kfunc for
the BPF handler to register its PSI trigger(s) upon handler
registration?


>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  kernel/sched/psi.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 1396674fa722..4c4eb4ead8f6 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -176,6 +176,32 @@ static void psi_avgs_work(struct work_struct *work);
>
>  static void poll_timer_fn(struct timer_list *t);
>
> +#ifdef CONFIG_BPF_SYSCALL
> +__bpf_hook_start();
> +
> +__weak noinline int bpf_handle_psi_event(struct psi_trigger *t)
> +{
> +       return 0;
> +}
> +
> +__bpf_hook_end();
> +
> +BTF_KFUNCS_START(bpf_psi_hooks)
> +BTF_ID_FLAGS(func, bpf_handle_psi_event, KF_SLEEPABLE)
> +BTF_KFUNCS_END(bpf_psi_hooks)
> +
> +static const struct btf_kfunc_id_set bpf_psi_hook_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set   =3D &bpf_psi_hooks,
> +};
> +
> +#else
> +static inline int bpf_handle_psi_event(struct psi_trigger *t)
> +{
> +       return 0;
> +}
> +#endif
> +
>  static void group_init(struct psi_group *group)
>  {
>         int cpu;
> @@ -489,6 +515,7 @@ static void update_triggers(struct psi_group *group, =
u64 now,
>
>                 /* Generate an event */
>                 if (cmpxchg(&t->event, 0, 1) =3D=3D 0) {
> +                       bpf_handle_psi_event(t);
>                         if (t->of)
>                                 kernfs_notify(t->of->kn);
>                         else
> @@ -1655,6 +1682,8 @@ static const struct proc_ops psi_irq_proc_ops =3D {
>
>  static int __init psi_proc_init(void)
>  {
> +       int err =3D 0;
> +
>         if (psi_enable) {
>                 proc_mkdir("pressure", NULL);
>                 proc_create("pressure/io", 0666, NULL, &psi_io_proc_ops);
> @@ -1662,9 +1691,14 @@ static int __init psi_proc_init(void)
>                 proc_create("pressure/cpu", 0666, NULL, &psi_cpu_proc_ops=
);
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
>                 proc_create("pressure/irq", 0666, NULL, &psi_irq_proc_ops=
);
> +#endif
> +#ifdef CONFIG_BPF_SYSCALL
> +               err =3D register_btf_fmodret_id_set(&bpf_psi_hook_set);
> +               if (err)
> +                       pr_err("error while registering bpf psi hooks: %d=
", err);
>  #endif
>         }
> -       return 0;
> +       return err;
>  }
>  module_init(psi_proc_init);
>
> --
> 2.49.0.901.g37484f566f-goog
>

