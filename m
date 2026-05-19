Return-Path: <cgroups+bounces-16086-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDFwD++FDGoniwUAu9opvQ
	(envelope-from <cgroups+bounces-16086-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 17:46:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FFF581B41
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 17:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A02B3266C67
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218C93ED3C2;
	Tue, 19 May 2026 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXBwTdI/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02127403EAB
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203636; cv=pass; b=eMxPPlmxUFzP6jltdvoq5V8+E8tviZat3jd8VNw8xSzbI3bG3toDFrAKmrG/6O0QZNctPDOw7yii90itsd7VM8GIAJ+1nuWOk8Bui3S1GcuTVF/f2EU2AIYX6ALLkz2V815iyfzVqwhXJN01VFZcu9eewPIs+Fynxh/EfDn+1qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203636; c=relaxed/simple;
	bh=qt7mRCe3W8LWJX/ykLXf7sJXkXTi0OBtx9fWGMlE/k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ry9npIKhtkhcDoXdXmFlQg9tcFr7DNuSlz5ISw9ZOAmF9CDYxQNyBkewBNUY++GbxPJxYH9Ea4WHnKH1oNcJPWt1a/e+UyT2Vw7tWcOZvYkMq8CzzunR6fe8w+1uElUMOXDzmWQdPPHpMf7xbPJCgDZmqFUEaFWsC6yp3IGdvRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bXBwTdI/; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso8535317a12.2
        for <cgroups@vger.kernel.org>; Tue, 19 May 2026 08:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779203633; cv=none;
        d=google.com; s=arc-20240605;
        b=iZkXAiuQ8HfyCM6OmUJKctwD+XdZTCe0gnkh54ufTrPecDMS0zfJ71QeGUGAS/lqlO
         RzZTjfJAklKp25HfWzEp/FgPKNNWvz0Oeg6dGoUWMmkJCjuAhUyjObyOCYJCScdgBanF
         4/HO6Kvooz0LXAl01f3PCYHNCLYjFiQ1k3043MgWd/u0tZq0Dp/thW72pbOWsDLP+Wpn
         XunYKtZIXB+5DbeFK7/kiq1ybdhp3ulAit7+BQm4W6TWUCbhjL0pLbejJEtYYeZxOBds
         X6qMVtCynoa94PuaIVq5bOm+gUCVZxZKpDMaSa52HEHbjIv6/Gr7ETxWPTLi6meYe6v6
         8iiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/ntDQDAFXEiIAEKc8+SQdLOl2n46zxFQzSK1l6/XS7I=;
        fh=XTDpDn8cnRioZo8BT5LZ7Z2KE3lJCNdRD9gy0QG9fNk=;
        b=fq73rT1SznERjZrlzPHzKDExpZbpDA/0V+kCuKu8AxE16SUFnbA2xGnff7DDjW3IM9
         L4ibb2+CcoHXNDpdWBE7m4XRTvx/3WjEGRn6gFAvTuvu/8Wi77yIXNIHLXMItHbhWyFf
         CxoSgKV+p9KW0bfc3bBGoYt+CsOWKslde2p9B2OFPG743EWn7a7ov3Thf7cgI98lPySP
         0CJI5qDboF7NUAwRcHGuEH8giqoOdhFtZpf9Uy1OQJorpT3xeWyRW6PMlzGO7Iu+7fXx
         zA7KJTuh90HLPkhKtFByFQDH6qhIf1PclpwiMnsKvubMiJh9FYP1BdnI1jRLoqFX26I7
         ZVaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779203633; x=1779808433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ntDQDAFXEiIAEKc8+SQdLOl2n46zxFQzSK1l6/XS7I=;
        b=bXBwTdI/O78kuRgZW3mzP/jTx6OkOf9G5YGl9rQOgLb91bncXk2GqRWHx1IWAjemUP
         su3pFucXJTGgu+avSLlA2ZeQchyaiPoHuDpFbpl23qz6immxhRjJR3yjFeGj/55cToLP
         ycoza2++5uzwwiEJwHsJebD5JWUKNDVZCL1hMI1ZGt4BW62BJMpSulHiQucecJfMgMkx
         oaamELfTOPpnogqpCTDxBg80DJNDYKegZ9UEop0KbtSqYwxhoj4RusYrO3gQdMhX3tRD
         ZZAgMpX97E2XArMVbIRFgljxd+49FgT4Kfjf2Kn1rm1G9WeTZTnkgoz248qTPYehl8Wr
         +zJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203633; x=1779808433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ntDQDAFXEiIAEKc8+SQdLOl2n46zxFQzSK1l6/XS7I=;
        b=o7/xYIObd6dKxrx7B0WRHZ8ow7t6Jar0l1fcU1qLtqJnDQFjpQstsw7hZEIpacwOh0
         r4/PwjIt5bsdjmAmegsC8XK10Av8P1sOHRXjkWGIMlLKeJ8M+gu+uuimdOU4b28K2idO
         ZVby2Ewt+QA5BU/fmrBh0FgwuNpblbKGC5q6nVECpiehlrhn0N973uB454+fBznNu9Pj
         N1lMtTKnpqB/niTWvplZEEYSWf2A8JO1mqiopM5peWPNx6F74uNbBB7uHVCU26jDM6fY
         Uwl7Q+yMwwW1ofKTG7DYlERMCX2W9hoPdKx2DCfs4Xf3lD8+4KcpsyBhPl6yNOYrepmn
         ADdg==
X-Forwarded-Encrypted: i=1; AFNElJ+27toTJhRoHjCxGv7zmlL/vO8UyzjpiLnBc+OcQJjnJZrHOvfJrStlbm40rzzFD+w6+9nshSJB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OUXb10AbLRG3kXsSShhXK77X31FL+PONPwrOaPO3l2bQYNq7
	lezxtE2ifS8NZrqyAwGMzEwc5a63Y1Pbn3N6205A+XsG2y/aENeFKKatiopUxLSWaekwMLOw50Z
	TTPbICc3AksHfdbksFFOfgJsOAJUl6Qdyg6aMzBsRyg==
X-Gm-Gg: Acq92OEZE73AWb3q0DGFPQwPCb7/IKo9cC/KxZfhYZEJz9qqvEE0w9GMps2EqBHaXDY
	HpqBJLqBt5AaMUKaGZZb7s8Cqf4rmk+rHGkndORQvXe3WQmA33Wj/7PRfmPQ9tyCZG8a4kAdl89
	LUwPCkHkxIrxLE7+H4Js6/R6qUgm/XeXuNfC1h7nmJoH4+DHQfNpoO42PgF9pcMoku3Gp6UIVPJ
	m/j5/rOcvx1XX72lyjMJxh1skt262jiQqVR3xhHSUI6WxvB5cmlo1Mf7vTopVHjbauHTdak5Ah/
	cbXxHaFYj4qvoqC7HYuu0oWVZDLK/RNVWN9aK3L9g1ERiQ4=
X-Received: by 2002:a05:6402:3494:b0:683:c72:44c9 with SMTP id
 4fb4d7f45d1cf-683bc8ac2f4mr12626053a12.11.1779203633253; Tue, 19 May 2026
 08:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511113104.563854162@infradead.org> <20260511120627.944705718@infradead.org>
In-Reply-To: <20260511120627.944705718@infradead.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 19 May 2026 17:13:40 +0200
X-Gm-Features: AVHnY4Ics_QrAdlmhL-xdhqOhd0_chqx07XdmseSEmg8J2xY-zo2vOOTfZSP3h4
Message-ID: <CAKfTPtDSLOvk1kNstN429rVNf4hYhzBBgy4f=RKqdyztX8PsWQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] sched/fair: Add newidle balance to pick_task_fair()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, 
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jstultz@google.com, kprateek.nayak@amd.com, 
	qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16086-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,linaro.org:email,linaro.org:dkim,infradead.org:email];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Queue-Id: 92FFF581B41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 11 May 2026 at 14:07, Peter Zijlstra <peterz@infradead.org> wrote:
>
> With commit 50653216e4ff ("sched: Add support to pick functions to
> take rf") removing the balance callback, the pick_task() callback is
> in charge of newidle balancing.
>
> This means pick_task_fair() should do so too. This hasn't been a
> problem in practise because pick_next_task_fair() is used. However,
> since we'll be removing that one shortly, make sure pick_next_task()
> is up to scratch.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> ---
>  kernel/sched/fair.c |   38 +++++++++++++++-----------------------
>  1 file changed, 15 insertions(+), 23 deletions(-)
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9215,16 +9215,18 @@ static void wakeup_preempt_fair(struct r
>  }
>
>  static struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
> +       __must_hold(__rq_lockp(rq))
>  {
>         struct sched_entity *se;
>         struct cfs_rq *cfs_rq;
>         struct task_struct *p;
>         bool throttled;
> +       int new_tasks;
>
>  again:
>         cfs_rq = &rq->cfs;
>         if (!cfs_rq->nr_queued)
> -               return NULL;
> +               goto idle;
>
>         throttled = false;
>
> @@ -9245,6 +9247,14 @@ static struct task_struct *pick_task_fai
>         if (unlikely(throttled))
>                 task_throttle_setup_work(p);
>         return p;
> +
> +idle:
> +       new_tasks = sched_balance_newidle(rq, rf);
> +       if (new_tasks < 0)
> +               return RETRY_TASK;
> +       if (new_tasks > 0)
> +               goto again;
> +       return NULL;
>  }
>
>  static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool first);
> @@ -9256,12 +9266,12 @@ pick_next_task_fair(struct rq *rq, struc
>  {
>         struct sched_entity *se;
>         struct task_struct *p;
> -       int new_tasks;
>
> -again:
>         p = pick_task_fair(rq, rf);
> +       if (unlikely(p == RETRY_TASK))
> +               return p;
>         if (!p)
> -               goto idle;
> +               return p;
>         se = &p->se;
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> @@ -9311,29 +9321,11 @@ pick_next_task_fair(struct rq *rq, struc
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>         put_prev_set_next_task(rq, prev, p);
>         return p;
> -
> -idle:
> -       if (rf) {
> -               new_tasks = sched_balance_newidle(rq, rf);
> -
> -               /*
> -                * Because sched_balance_newidle() releases (and re-acquires)
> -                * rq->lock, it is possible for any higher priority task to
> -                * appear. In that case we must re-start the pick_next_entity()
> -                * loop.
> -                */
> -               if (new_tasks < 0)
> -                       return RETRY_TASK;
> -
> -               if (new_tasks > 0)
> -                       goto again;
> -       }
> -
> -       return NULL;
>  }
>
>  static struct task_struct *
>  fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
> +       __must_hold(__rq_lockp(dl_se->rq))
>  {
>         return pick_task_fair(dl_se->rq, rf);
>  }
>
>

