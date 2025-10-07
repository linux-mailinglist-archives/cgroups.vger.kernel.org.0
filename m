Return-Path: <cgroups+bounces-10585-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A983BC1E93
	for <lists+cgroups@lfdr.de>; Tue, 07 Oct 2025 17:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C981897A6F
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ABC2E54BE;
	Tue,  7 Oct 2025 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wO8XthGL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3D92E425E
	for <cgroups@vger.kernel.org>; Tue,  7 Oct 2025 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850540; cv=none; b=TQgzZLv9b9XtmKoZWgZx3K7agQXnlb3vP0/T4SN1Vbb67tW05kykYXHez2Mt4u24/7us01wX+iY5mra5CCTFka2gnQ7J9GFIfMzPkSL9mPL8NRu9IkXBe/Rf9VY+DIkqE5yeyddM2wUH2gj9CDRTeXddsPjx0+qB61lEAzT/f5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850540; c=relaxed/simple;
	bh=WM6hgH1P8GcEwnp4CSHs/x3JAUOpqZrrbyxYf6RpLPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhhYBvjj9CRAloX9a5CivWBcsPFI01p/HO0xn0UpPTRJfJtEc9fHkE8HnpUq3v5hA9RMBe4nyBpQqsk/YHM76EvmesEZmZTPKIlK6i40dqwsnUwyWyF0lOXqcCKYlCpw33Bx6evQ37HNdm6Ujd9J4fOGqle6xWVJftb1M0Cj614=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wO8XthGL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-637e74e9104so6893925a12.1
        for <cgroups@vger.kernel.org>; Tue, 07 Oct 2025 08:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759850536; x=1760455336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sj+6bWQslfiTLa+4PHpgmn9y75LNrAViNjvut2qJSfk=;
        b=wO8XthGL35u6RE8lkR0BfynLTnhfGc6/rgRNe+bnhgSmdkI/kFRkN5IfcVgCto+LH7
         baSN3GG9ysRtO4fNqYB7PNk0s3rKrDsO1JCqJCp1tlZhT1jsWRWLDCnxi3modDwQ9LOy
         E5n6zxVanXafssMd7KliGOGFyTLGCMJAaWIjsEKfPOTojxCoEMenQ5BqgZX59hRhL/9F
         Vq5ffCRXrhigDtMcJgqxZPvlnVmY4ZhPO/op4eFSTxK9Jz1wTPxeZA6RpjI9DOsTumKa
         nWQTUnhVzrcz38xC5Ls5NixPAluosxOkflQbpiykWMFyjddVtFCmle3X7jvuYBWIivKI
         erSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759850536; x=1760455336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sj+6bWQslfiTLa+4PHpgmn9y75LNrAViNjvut2qJSfk=;
        b=ub/1qSUTnUj0WpICP0C3jdzEdi7tisOe7Zj1WfXiTJ6docQMfYCQPvhORVQwfVuchX
         j/sXQsCi9dP/i5OObMyDCvDEEJFSTVifon6ocyf04uyUa5yBbSY/8dWpwFby+rc0q+//
         ABR10l6iyH5vntVhTrACI5/v6chzVCEtuVUI58RveY8dWCqgS1xmCEHywxL79OoaaG3u
         HlV0NCIk90ytuMEAqDuJLSJT3a0ykEJyRHA4PezsCziyyi5RvcXVCvZMun06ex6+ce9N
         UgSZRK1QcZcZq2WUyvi8UHQqBeHUfJVAzKlUOsf2GaWPjfaAn3oLJn6rlEzG0I8ZXnnQ
         IXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMvzygjLQmcfefxYWBa6nMklyliMFN52+W1W60UXriaxyfxDUBNpTn5M4Cl8I6w/AVPAXiXa6V@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm+76XaAXUoNM4V28J1I1cgZTcgvMMvar61wkS6fqg0MOVG+B+
	Z1oO3Ktuv9eF1NIJc4tWF3YDqg1MYz8yACr1suBl3QFXGnim0a9EwMNlUvJhnyUP8C697ahFS1u
	zUzB3PO81ODANEL6RjG+sjaqpUmit2otwiEb3sL719Q==
X-Gm-Gg: ASbGnctPeSAKSVeJZiY3jVIJSKlR79PbSjxTuqRMYT1nwvP0S6TVRhL6UdNnW6kZvsd
	PFM6P3o7fJljxsbsxB2xxPb0H1X9RB0PI/EUA0z/AsEl5/UZg7LszP3bejw/W0QbBgVfVzbtPCh
	GaCVlrd7NQNXfBBEd8MxTJDZFN3igYBg+54i3bAS/NSy8z6P1gMKHqrWN4Qkk4RHf49IVwVxwvC
	MQV32XywCmORaMoep1b9+xq8kG2tMtv05QMlAYnftJ3mWq0AfaeI1HBY2HcKPw=
X-Google-Smtp-Source: AGHT+IEOLX7r/tKzGoeeZy9wOj+XUlBEOxx8L5IKIwy+J8iOESDBaK6+dbXRpt6rG0Ux0Pp6UBfDLtppzsDqp59rsPk=
X-Received: by 2002:a17:907:dac:b0:b49:5103:c0b4 with SMTP id
 a640c23a62f3a-b49c32554f5mr2167080366b.56.1759850536235; Tue, 07 Oct 2025
 08:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006104402.946760805@infradead.org> <20251006104526.964100769@infradead.org>
In-Reply-To: <20251006104526.964100769@infradead.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 7 Oct 2025 17:22:05 +0200
X-Gm-Features: AS18NWBp67oekCA5wJuqsWfMSlc_Mr63BTHm_H8SM2ppgSw678wieZ4yFPZoLog
Message-ID: <CAKfTPtAY5Py=rmzbT+e7p5Em2eU0Do25ZKfcKZ2ZTjf6jFFOCg@mail.gmail.com>
Subject: Re: [PATCH 04/12] sched: Cleanup sched_delayed handling for class switches
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, longman@redhat.com, 
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev, 
	liuwenfang@honor.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 12:45, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Use the new sched_class::switching_from() method to dequeue delayed
> tasks before switching to another class.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/core.c     |   12 ++++++++----
>  kernel/sched/ext.c      |    6 ------
>  kernel/sched/fair.c     |    7 +++++++
>  kernel/sched/syscalls.c |    3 ---
>  4 files changed, 15 insertions(+), 13 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7368,9 +7368,6 @@ void rt_mutex_setprio(struct task_struct
>                 queue_flag &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
>         }
>
> -       if (prev_class != next_class && p->se.sched_delayed)
> -               dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
> -
>         scoped_guard (sched_change, p, queue_flag) {
>                 /*
>                  * Boosting condition are:
> @@ -10845,8 +10842,15 @@ struct sched_change_ctx *sched_change_be
>                 if (WARN_ON_ONCE(flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)))
>                         flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
>
> -               if (p->sched_class->switching_from)
> +               if (p->sched_class->switching_from) {
> +                       /*
> +                        * switching_from_fair() assumes CLASS implies NOCLOCK;
> +                        * fixing this assumption would mean switching_from()
> +                        * would need to be able to change flags.
> +                        */
> +                       WARN_ON(!(flags & DEQUEUE_NOCLOCK));
>                         p->sched_class->switching_from(rq, p);
> +               }
>         }
>
>         *ctx = (struct sched_change_ctx){
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3924,9 +3924,6 @@ static void scx_disable_workfn(struct kt
>                         queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
>                 }
>
> -               if (old_class != new_class && p->se.sched_delayed)
> -                       dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
> -
>                 scoped_guard (sched_change, p, queue_flags) {
>                         p->sched_class = new_class;
>                 }
> @@ -4677,9 +4674,6 @@ static int scx_enable(struct sched_ext_o
>                         queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
>                 }
>
> -               if (old_class != new_class && p->se.sched_delayed)
> -                       dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
> -
>                 scoped_guard (sched_change, p, queue_flags) {
>                         p->scx.slice = SCX_SLICE_DFL;
>                         p->sched_class = new_class;
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -13237,6 +13237,12 @@ static void attach_task_cfs_rq(struct ta
>         attach_entity_cfs_rq(se);
>  }
>
> +static void switching_from_fair(struct rq *rq, struct task_struct *p)
> +{
> +       if (p->se.sched_delayed)
> +               dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
> +}
> +
>  static void switched_from_fair(struct rq *rq, struct task_struct *p)
>  {
>         detach_task_cfs_rq(p);
> @@ -13638,6 +13644,7 @@ DEFINE_SCHED_CLASS(fair) = {
>
>         .reweight_task          = reweight_task_fair,
>         .prio_changed           = prio_changed_fair,
> +       .switching_from         = switching_from_fair,
>         .switched_from          = switched_from_fair,
>         .switched_to            = switched_to_fair,
>
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -689,9 +689,6 @@ int __sched_setscheduler(struct task_str
>                 queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
>         }
>
> -       if (prev_class != next_class && p->se.sched_delayed)
> -               dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
> -
>         scoped_guard (sched_change, p, queue_flags) {
>
>                 if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
>
>

