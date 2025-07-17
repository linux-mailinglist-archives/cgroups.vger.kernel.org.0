Return-Path: <cgroups+bounces-8759-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4580B093E6
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 20:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1D65A369A
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 18:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59B32FE395;
	Thu, 17 Jul 2025 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsXE1T+R"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B99A2FCFE8;
	Thu, 17 Jul 2025 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752776798; cv=none; b=ZKlT9++KeaAodiY1wdt1m1UyU8X/Py5G7SxvymPsPerZiaVJJvV/hdHiEmx6zMmk0A124bpCSjjUXC1JfaqmA6nNZYIgBEDJqCX+s4+si1b/SmII09n2pibmf9oZ07bRjheeUvBxBwx5oY61be41a9FrGE7CaLVu9xEdK7lUbVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752776798; c=relaxed/simple;
	bh=sIaEI3QKyhGiHm9BT17modllQDCCAdBVVmgWiD1n1Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFUgTSvCh/+siX+hpZ9DOvMSMBacchQcuMSVXV3RTUEGo9pSe3x7nNzafb3Ab3xqzBTLhPyACqoGMHl87aVxm8VLuspoJOx7Gi4EU5It0pBLpWoPqB74ZutACirJ93626+nxOo61n3VCnccK4RSYBDOsgbfsIYyjXxe5/Cn07kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsXE1T+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA0BC4CEE3;
	Thu, 17 Jul 2025 18:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752776798;
	bh=sIaEI3QKyhGiHm9BT17modllQDCCAdBVVmgWiD1n1Uc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lsXE1T+RYTDrAixIUax18MCVUeVevFEOx5yHmJA1EPyxo8K/zFW3jw4aPRsmjB+aC
	 UNCcrDoSxtxsazw46E9lYCS9iZ7yN9mWpwCu6yzU4OzRtL9gAUF43MMgPHFYcISbtd
	 JGJRomnDBfnlrch7Bn+UyoPGVD3B9YBjVzJu9sAIW4mhY6pe34gKC1Vrk6uoTYMmCo
	 Bd9ZTsnb2LkJlbIg0iufKF3dzmnxJrIAA0B5k3ponV6ShT2ZNOdhdgg9mwNh6XIU+6
	 PTL9CtJtCYIywZUmhg6su6qLtQqW2nC3TyRg8A5+Wzx1TrVlIZBgNKJQhgO7R0GFAR
	 7pavt/OyRfwdQ==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-40b99490728so866865b6e.0;
        Thu, 17 Jul 2025 11:26:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVOU+rB9PwhgP16nrdPBy/y5UkCD7uX5nERZXcp2yr2s4YnOS+ilXpiBxsbaN7vgErh4HRas23XA8=@vger.kernel.org, AJvYcCWg8o4NvX/uQaeIWPMNShO/ZH/EBJ2mMkL3M9gJOCjecJSrfR9YT9a7z5vNI7uOW+R81zFDBZZJ@vger.kernel.org, AJvYcCXIGYbeo1gmGuKZzPN0cRDXiaSS8Q0Tm8s95toeb1BcDipWKjDqA9bSZFqXeaAgbHPFg5QMLhtI9K3Y6K/I@vger.kernel.org
X-Gm-Message-State: AOJu0Yz685Y125f32lucPH57T/blw3HDmfnD8Z/dbHEf6SJlEVa27qKs
	zaWa5RqsGJmaYhi/xykq3dtzs6Naaby48umjFhc/F3ujcDBIcaFvyUnDyT/nmbpTRMhIQpL0xta
	ABWMzN2nzS4tbaj6GBPSxjq5xLmWaUFc=
X-Google-Smtp-Source: AGHT+IFDkmaelRZAE0GR6xnrVKf+/REscmRBYvlwNn0SKrzRn0KVwrhQv+PhOelstpfUJtCqxGeKx8YZZJ2+yxHUj1A=
X-Received: by 2002:a05:6808:138a:b0:408:fe75:419f with SMTP id
 5614622812f47-41f61562740mr762233b6e.13.1752776797386; Thu, 17 Jul 2025
 11:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717085550.3828781-1-chenridong@huaweicloud.com> <20250717085550.3828781-2-chenridong@huaweicloud.com>
In-Reply-To: <20250717085550.3828781-2-chenridong@huaweicloud.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Jul 2025 20:26:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jnUQJSBbYWfmGb6wr_CY3j61TSq_cR9KBMqtvxWrmsaA@mail.gmail.com>
X-Gm-Features: Ac12FXxUGPpoenlQbkxY4uXiuqLarCL0wopKTv7pVmK_6ukDbitAZ9XMx3q7zdE
Message-ID: <CAJZ5v0jnUQJSBbYWfmGb6wr_CY3j61TSq_cR9KBMqtvxWrmsaA@mail.gmail.com>
Subject: Re: [PATCH v2 -next 1/2] sched,freezer: Remove unnecessary warning in __thaw_task
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, rafael@kernel.org, 
	pavel@kernel.org, timvp@google.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lujialin4@huawei.com, 
	chenridong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 11:09=E2=80=AFAM Chen Ridong <chenridong@huaweiclou=
d.com> wrote:
>
> From: Chen Ridong <chenridong@huawei.com>
>
> Commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if not
> frozen") modified the cgroup_freezing() logic to verify that the FROZEN
> flag is not set, affecting the return value of the freezing() function,
> in order to address a warning in __thaw_task.
>
> A race condition exists that may allow tasks to escape being frozen. The
> following scenario demonstrates this issue:
>
> CPU 0 (get_signal path)         CPU 1 (freezer.state reader)
> try_to_freeze                   read freezer.state
> __refrigerator                  freezer_read
>                                 update_if_frozen
> WRITE_ONCE(current->__state, TASK_FROZEN);
>                                 ...
>                                 /* Task is now marked frozen */
>                                 /* frozen(task) =3D=3D true */
>                                 /* Assuming other tasks are frozen */
>                                 freezer->state |=3D CGROUP_FROZEN;
> /* freezing(current) returns false */
> /* because cgroup is frozen (not freezing) */
> break out
> __set_current_state(TASK_RUNNING);
> /* Bug: Task resumes running when it should remain frozen */
>
> The existing !frozen(p) check in __thaw_task makes the
> WARN_ON_ONCE(freezing(p)) warning redundant. Removing this warning enable=
s
> reverting commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if
> not frozen") to resolve the issue.
>
> This patch removes the warning from __thaw_task. A subsequent patch will
> revert commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if
> not frozen") to complete the fix.
>
> Reported-by: Zhong Jiawei<zhongjiawei1@huawei.com>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  kernel/freezer.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index 8d530d0949ff..6a96149aede9 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -201,18 +201,9 @@ static int __restore_freezer_state(struct task_struc=
t *p, void *arg)
>
>  void __thaw_task(struct task_struct *p)
>  {
> -       unsigned long flags;
> -
> -       spin_lock_irqsave(&freezer_lock, flags);
> -       if (WARN_ON_ONCE(freezing(p)))
> -               goto unlock;
> -
> -       if (!frozen(p) || task_call_func(p, __restore_freezer_state, NULL=
))
> -               goto unlock;
> -
> -       wake_up_state(p, TASK_FROZEN);
> -unlock:
> -       spin_unlock_irqrestore(&freezer_lock, flags);
> +       guard(spinlock_irqsave)(&freezer_lock);
> +       if (frozen(p) && !task_call_func(p, __restore_freezer_state, NULL=
))
> +               wake_up_state(p, TASK_FROZEN);
>  }
>
>  /**
> --

I can apply this one, but I'll need an ACK for the [2/2].

Thanks!

