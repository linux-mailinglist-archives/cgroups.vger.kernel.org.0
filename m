Return-Path: <cgroups+bounces-16157-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFp1AUv3DmoSDwYAu9opvQ
	(envelope-from <cgroups+bounces-16157-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 14:15:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 503FA5A4A00
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 14:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53EF0301AD1B
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 12:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D713C415C;
	Thu, 21 May 2026 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pq0oZeES"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025FD352024
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365647; cv=pass; b=aVVNwWVBJLlgCEn1cN+ENV3pwGgLsdP8/TAKkizNQ1BDTrvk/4zCacXVHq2XrTbedfFL8YDC3rUs3Mrdm0nljzdYhg0jnOkpVu/WxfFqUh9i0aiChVFpAmmBueQRWPyjjz86OpDVDrhkmC9E0AhI0SfCQmEbt/IZ3+dj4n7z4Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365647; c=relaxed/simple;
	bh=1r33KX3obNuNZ37YSfOapxGIQrD3n6NRhhss/Al5VRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=canXh0m3uIJSCwMIdlwL7HrUq37ELXbhcDELkzdpvWHGLP6p5m+ikx2XsvjSrxnety6UOFzF6FWM0ywI1YzwAlxyoPky2SRQSneoa2RBTjbHpShFTClrZqKvhLYaoGNEqvTovZsZIIrvHVIjW65FQvjQ+GjgmLgIcc1MRuXhf8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pq0oZeES; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67e43a8996fso7556629a12.0
        for <cgroups@vger.kernel.org>; Thu, 21 May 2026 05:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779365644; cv=none;
        d=google.com; s=arc-20240605;
        b=ItaBmqbtTA+yvIvtH0lT29N5/J/VWkaoXk8BS5OEvhd2uZQvPA3NqgzDVEkcWO6hZE
         alsi8m0VqdQu2VhvllnWiEATvQmbUqHfl8/OIaAwV5CVLGYY4zueivKl2gqKc4xU7JZ2
         kCVD+M1HPAZNxuUITKPSpB4P5kGB9FkxjL1TiJP+8HGAGbG1gkKWOC1u83uzI4eu19X2
         E0yfCRuYE+zKpEv8uwczURRXap/Wbjpl1vNmVijp4SbD43hvwnllM6Ra5RtuDTngswxZ
         P9WaEJ8OV/jF6IJ4w+1a/5Qu661vW0lsQiFQMHZJwoPlt/k1mbJI5u292to+ZWKsIYKP
         w36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FGaQvF3zgbGyxUzwbtatjry/hkOBC1DU0hiuU2RP8/g=;
        fh=AKFrto7mqf1Hdy5tPtqiK0H1xHIdVVSe2VGmScGvQ8c=;
        b=WSjNx/eZwQ0bvuzK/1UzUW9erIVYAxQiXX1cVsmQZiEbMqumgRJgoGhV7lKfd2O0SN
         vrFEg2WFBFRFhXTUvnxD03qS297FTGg9nJAc0PClqg1EGTwQ2bAsjDNCdrJv3bMZHGgb
         +hkjSbTS7Uu9h0zwmmcKnTd7EI+CR0taA5CFVmZ6vE38RmS0wCQWL6XWn/AuDbTKkdAQ
         3g582ThfuGn84oV5VqzU92ajjODnNer0V3PJUtQoeBt0/0CrZwaHlDQkGhoFRjS+SEqv
         JMf9scmUDIlsdHOlKxi6GWbbFp97yVY/3RBH/CbX3DNUPd9J5odTxXFxDxB3hHlAFLZJ
         SOQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779365644; x=1779970444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FGaQvF3zgbGyxUzwbtatjry/hkOBC1DU0hiuU2RP8/g=;
        b=Pq0oZeESwvUmPkGFB9gaWp1DOOssqy8VbtGI9vDHS5NpBhkmbp87Q+Ru3HloYCulxn
         INMB+QYLCFWgvC+qcQv2jZ8UqyoJ/XAIPo9a7dNjsSp1hIiuOtCISb6IxqNwfmDUl1n8
         pni6SErNyBzVVIGEmEcF4knMRq9t0lZ8Mo8S+60++JjEqoUG9tMd+xHsd1kyXTkDEGRI
         WxXKVG6xt8r1Dhc8FI8IO+9SYelwwx8XWZmouPArjapCmSiaVoDJbvwoQMrUTux5k8Ii
         ZmojD7v5VRlNx/+R46VhhjBxIj5b4TX/GiXP8Y1f+UNIn2bZfKEB9Ap/0hFdgwZlMFP0
         iCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779365644; x=1779970444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGaQvF3zgbGyxUzwbtatjry/hkOBC1DU0hiuU2RP8/g=;
        b=S1HFzlT1hMeNxBkTPH+Gjmq/4Y+JzlAmy1Sk3HuJxeBMNWWn93oepzvXo85syqp5R/
         Ni02p9IvsomzzfDgfDrGLE5Gb8+J1q23ouINq7O3QSoxiHi0CJtMyObc+O6libjDhi2l
         oUddGrm96w4zPead3Kpztbj6UMWRrgRWzWuWJwcjA+vYmOstDXVPUhcjDwPb6a2nSWli
         vTG6GbVaYUS1yEKzTnUP8VTiFXF1kvaMkQUAsTDndRuoZ7QCYr5gKur1KMTqkgzujdkj
         u1DoHcpGOM8JgRb6U2o9PXKs7PO7rAmLR2953kMSA1Z3wNLHxUexNDKebmmfsQJ6exkn
         Kweg==
X-Forwarded-Encrypted: i=1; AFNElJ9qKoJwYNdJuEl2bq0959Dej2ULxaEgFllVS6z448x2ptHUBZl1Vl3qCJuF3me4jNrUTFy13Pu6@vger.kernel.org
X-Gm-Message-State: AOJu0YwF2AQq5joGKfi2ALQHRiXjDshPKS/REBBekxNehKOk1P0kWt90
	GX8ZxZBNnWKZtQvgDrnCEmvnHK4AUD4+OMapHyWsjsOv+ydUYAANSJeZzYmECb/NnF6TsO5KNqX
	VGHz35uKGoeTxB7lplaN8wWiWNZNNzXYSd/iMCdI2BA==
X-Gm-Gg: Acq92OFl1hSo8/OF4g29KvVUT/3TxzcC9P8ySP0SOAeMXgQHxqeiHTlXDortZJRe+GL
	1ovNsgztoOylIqA0t9pJMFAdvA2Fnu0Ow/Y/qRtru7h3u7mUJoqyorsWSnyuFKYke/P+1PhtkoJ
	06xEkB446QnRJqqZ76DjoDlzS4qBr+iCb1lefAlF1tXKINJfiKYHm2ipl3f9ptrAxWNrwPAFdWw
	gbz0k0Ci3GotWJPkV0it7osbmi6MrJepXod0OqzUSYP6rU18YeGg0nMgrUlqWJXn+x8jZEQ7xhN
	fLUt3CQUvlQNndJ/YbCOKhV8uNy348dgmNfL
X-Received: by 2002:a17:906:cc10:b0:bd5:5e7:ae6d with SMTP id
 a640c23a62f3a-bdc11bcd781mr111193766b.3.1779365644262; Thu, 21 May 2026
 05:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511113104.563854162@infradead.org> <20260511120628.206700041@infradead.org>
 <CAKfTPtCc=pBKe9eRbA5B0zhaXJKVjN4N74AT0BFyRK39cS4c5Q@mail.gmail.com>
 <ag3iC-jH6HPoWKGo@vingu-cube> <20260521103117.GC3102624@noisy.programming.kicks-ass.net>
In-Reply-To: <20260521103117.GC3102624@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 21 May 2026 14:13:48 +0200
X-Gm-Features: AVHnY4JIwHjBKA_qaNKJDK8bkMi3ngGSApGClfPu44RRCta33Y-FDPElRuP45i0
Message-ID: <CAKfTPtCpt7jYSPF5-wE8jjVPMBJrp_SGUV4brpbF9tASaJFp5g@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16157-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linaro.org:dkim,infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 503FA5A4A00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 at 12:31, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, May 20, 2026 at 06:32:11PM +0200, Vincent Guittot wrote:
>
> > I finally fount the root cause of regression: the update of entity lag happened
> > after the task has been dequeued which screwed update_entity_lag():
> >
> > update_entity_lag must be called after updating curr and cfs_rd and before
> > clearing on_rq
> >
> > With the fix below I'm back to original hackbench figures and maybe even a bit better.
> > I haven't checked shceduling latency yet
> >
> > ---
> >  kernel/sched/fair.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 77d0e1937f2c..32fe57004f27 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5753,6 +5753,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >
> >       update_stats_dequeue_fair(cfs_rq, se, flags);
> >
> > +     if (entity_is_task(se))
> > +             update_entity_lag(&rq_of(cfs_rq)->cfs, se);
> > +
> >       se->on_rq = 0;
> >       account_entity_dequeue(cfs_rq, se);
> >
> > @@ -7423,6 +7426,7 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> >               if (sched_feat(DELAY_DEQUEUE) && delay &&
> >                   !entity_eligible(cfs_rq, se)) {
> >                       update_load_avg(cfs_rq_of(se), se, 0);
> > +                     update_entity_lag(cfs_rq, se);
> >                       set_delayed(se);
> >                       return false;
> >               }
> > @@ -7430,7 +7434,6 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> >
> >       dequeue_hierarchy(p, flags);
> >
> > -     update_entity_lag(cfs_rq, se);
> >       if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
> >               se->deadline -= se->vruntime;
> >               se->rel_deadline = 1;
>
> Argh!!! Thank you! I've gone blind staring at all this :/
>
> Would it not be simpler to just move the update_entity_lag() call up a
> bit, like so?
>
> ---
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7999,6 +7999,9 @@ static bool __dequeue_task(struct rq *rq
>
>         clear_buddies(cfs_rq, se);
>
> +       update_curr(cfs_rq);

I agree it's simpler although we will call update_curr twice for one
level, but the 2nd call should be nop because of delta_exec being null

Prateek proposed update_curr(task_cfs_rq(p)). Using task_cfs_rq(p)
will ensure that we keep the same ordering as for_each_sched_entity


> +       update_entity_lag(cfs_rq, se);
> +
>         if (flags & DEQUEUE_DELAYED) {
>                 WARN_ON_ONCE(!se->sched_delayed);
>         } else {
> @@ -8022,7 +8025,6 @@ static bool __dequeue_task(struct rq *rq
>
>         dequeue_hierarchy(p, flags);
>
> -       update_entity_lag(cfs_rq, se);
>         if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
>                 se->deadline -= se->vruntime;
>                 se->rel_deadline = 1;

