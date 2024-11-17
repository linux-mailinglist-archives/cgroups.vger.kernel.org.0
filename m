Return-Path: <cgroups+bounces-5600-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 334809D01C5
	for <lists+cgroups@lfdr.de>; Sun, 17 Nov 2024 01:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78AB31F23BA6
	for <lists+cgroups@lfdr.de>; Sun, 17 Nov 2024 00:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC999454;
	Sun, 17 Nov 2024 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lvKNNRYv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B6E33E7
	for <cgroups@vger.kernel.org>; Sun, 17 Nov 2024 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731804874; cv=none; b=jP9KOdKbCFJlCzAha6hyN6yZFs7xmX93lFhhCuuWsHj8Wcx5iiRWxOjyi1z5hXmbBs9dFMC56oVq+CID5qGSvQTJ3K6e8B1L6w0Q+PNthQBYuBppc+1qiK6g/tkW13wxH97U3xkVDdj9BiFTv1nLl6NeNX0XGu1jRChKGQ4+i4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731804874; c=relaxed/simple;
	bh=AahsvNCgqe0CD0EnglmUffluAVhGeJsO5JRnNswTG70=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=mRdHkjzglrDszV+IWD5mK9YZ8dNNNbHTJqz2BKdBGKxesGFmd3TJJrOx0vKjln3uBJIxW8qDwsU0XVu1934Q/QOmYKZJiUI+xR4RlFg30ar5NiG+kytY2xEapwCdYaaetO0y1nY2je7dcMeDetDFRTljN0ql9IGU7wTSBr3XeSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=lvKNNRYv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ea45dac86eso415023a91.3
        for <cgroups@vger.kernel.org>; Sat, 16 Nov 2024 16:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1731804871; x=1732409671; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLyW0SjepbIQoNpxN2g8xJsS2oPVOfF+dT7/t6HOJl0=;
        b=lvKNNRYvX0SEwV0qihqUpBidmOnYSkIQCkjl04LwXjIHUrgDnLlYTTMDoisrnNoWsD
         k3cFnAxkp9ATzCJ8WZDU2mP8SEUx0DpB6GHQsWyhOMn/PQSPOohXalxTagcDqQKvn0rW
         uQJd+bXkpYgsTffh7m5yMHOwWhWa1vt91UZkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731804871; x=1732409671;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLyW0SjepbIQoNpxN2g8xJsS2oPVOfF+dT7/t6HOJl0=;
        b=sc6Owes9GFFXUZcQgXgZyBJIy2wG6b6252bvClH6h8uFow7PpW3WNxAbk8Z1OJUlm7
         iMVWdSZ/fBQ02eMC016o9QsfN2Gssj2ER6wdCcBgeLib3TZlexE21buUFbfT3FbRhc+5
         XwCpZ9awPYssHsyUrt783TNMoDgV6sd1acdWcxseA7+JDfiXU6DIzBDYFOabuDgti6eG
         vplFnnvwF3l3jYsvecX5z1eNmuXNXuQL0DPRRULGRbojt9bLWUWV/Io0zvS9+KmTr8N5
         QiqcBpoFWaGUlyUROSdZBRc8YtXgmqUagl552hRc4xahwMQKvOBhhcdgMv0XhUEfrBXY
         ZbKA==
X-Forwarded-Encrypted: i=1; AJvYcCVfHMciSy8nKNVEirI3h9uu/h3i6wxNbZlMvCEpZAYWIhBdZDomumv4C5TClsyUhTfWFtPIS57V@vger.kernel.org
X-Gm-Message-State: AOJu0YyH9zyNQYAOKwe5ppsQxH9CuuAjWT8Z5hS0Eyy2aYF/MZunXwya
	unFhj4LNMmvdKJi9CR88gerCVWVudy4+qkkNEypaATbFE5Im0RujN0EpUQR12M4=
X-Google-Smtp-Source: AGHT+IFdlt9nj0MlfNaq4/78E+AUaLriuYkxiXzLxLe2azaL5+HmZDqvU3XBAxk5cIyY50DMroZ9RA==
X-Received: by 2002:a17:90b:5346:b0:2ea:498d:809f with SMTP id 98e67ed59e1d1-2ea498d8345mr2637634a91.26.1731804871469;
        Sat, 16 Nov 2024 16:54:31 -0800 (PST)
Received: from smtpclient.apple ([194.195.89.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06f1a508sm5035659a91.18.2024.11.16.16.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 16:54:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] sched/deadline: Restore dl_server bandwidth on non-destructive root domain changes
Date: Sun, 17 Nov 2024 09:54:19 +0900
Message-Id: <3F3A1712-6F87-444D-A2FA-B009D30CF1BF@joelfernandes.org>
References: <20241113125724.450249-2-juri.lelli@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Suleiman Souhlal <suleiman@google.com>,
 Aashish Sharma <shraash@google.com>, Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
In-Reply-To: <20241113125724.450249-2-juri.lelli@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
X-Mailer: iPhone Mail (21G93)



> On Nov 13, 2024, at 9:57=E2=80=AFPM, Juri Lelli <juri.lelli@redhat.com> wr=
ote:
>=20
> =EF=BB=BFWhen root domain non-destructive changes (e.g., only modifying on=
e of
> the existing root domains while the rest is not touched) happen we still
> need to clear DEADLINE bandwidth accounting so that it's then properly
> restore taking into account DEADLINE tasks associated to each cpuset
> (associated to each root domain). After the introduction of dl_servers,
> we fail to restore such servers contribution after non-destructive
> changes (as they are only considered on destructive changes when
> runqueues are attached to the new domains).
>=20
> Fix this by making sure we iterate over the dl_server attached to
> domains that have not been destroyed and add them bandwidth contribution
> back correctly.
>=20
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks,

 - Joel




> ---
> include/linux/sched/deadline.h |  2 +-
> kernel/cgroup/cpuset.c         |  2 +-
> kernel/sched/deadline.c        | 18 +++++++++++++-----
> kernel/sched/topology.c        | 10 ++++++----
> 4 files changed, 21 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline=
.h
> index 3a912ab42bb5..82c966a55856 100644
> --- a/include/linux/sched/deadline.h
> +++ b/include/linux/sched/deadline.h
> @@ -33,7 +33,7 @@ static inline bool dl_time_before(u64 a, u64 b)
>=20
> struct root_domain;
> extern void dl_add_task_root_domain(struct task_struct *p);
> -extern void dl_clear_root_domain(struct root_domain *rd);
> +extern void dl_clear_root_domain(struct root_domain *rd, bool restore);
>=20
> #endif /* CONFIG_SMP */
>=20
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 142303abb055..4d3603a99db3 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -954,7 +954,7 @@ static void dl_rebuild_rd_accounting(void)
>     * Clear default root domain DL accounting, it will be computed again
>     * if a task belongs to it.
>     */
> -    dl_clear_root_domain(&def_root_domain);
> +    dl_clear_root_domain(&def_root_domain, false);
>=20
>    cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
>=20
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 9ce93d0bf452..e53208a50279 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2968,13 +2968,21 @@ void dl_add_task_root_domain(struct task_struct *p=
)
>    task_rq_unlock(rq, p, &rf);
> }
>=20
> -void dl_clear_root_domain(struct root_domain *rd)
> +void dl_clear_root_domain(struct root_domain *rd, bool restore)
> {
> -    unsigned long flags;
> -
> -    raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
> +    guard(raw_spinlock_irqsave)(&rd->dl_bw.lock);
>    rd->dl_bw.total_bw =3D 0;
> -    raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
> +
> +    if (restore) {
> +        int i;
> +
> +        for_each_cpu(i, rd->span) {
> +            struct sched_dl_entity *dl_se =3D &cpu_rq(i)->fair_server;
> +
> +            if (dl_server(dl_se))
> +                rd->dl_bw.total_bw +=3D dl_se->dl_bw;
> +        }
> +    }
> }
>=20
> #endif /* CONFIG_SMP */
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..e9e7a7c43dd6 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2721,12 +2721,14 @@ void partition_sched_domains_locked(int ndoms_new,=
 cpumask_var_t doms_new[],
>=20
>                /*
>                 * This domain won't be destroyed and as such
> -                 * its dl_bw->total_bw needs to be cleared.  It
> -                 * will be recomputed in function
> -                 * update_tasks_root_domain().
> +                 * its dl_bw->total_bw needs to be cleared.
> +                 * Tasks contribution will be then recomputed
> +                 * in function dl_update_tasks_root_domain(),
> +                 * dl_servers contribution in function
> +                 * dl_restore_server_root_domain().
>                 */
>                rd =3D cpu_rq(cpumask_any(doms_cur[i]))->rd;
> -                dl_clear_root_domain(rd);
> +                dl_clear_root_domain(rd, true);
>                goto match1;
>            }
>        }
> --
> 2.47.0
>=20

