Return-Path: <cgroups+bounces-16147-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEAsF3e7DmrBBgYAu9opvQ
	(envelope-from <cgroups+bounces-16147-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 09:59:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BEB5A08A1
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 09:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E694730330BB
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 07:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8832367B99;
	Thu, 21 May 2026 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KWO9+Oex"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA4348C47
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350201; cv=pass; b=Dzl3nq+WV9oewcUY1F57C6MKqRD1bvl7wWhrF1qRLAB5dL53Vu6IMMsgjM1FP6hlyRLnqR87qfwzuZRQM+w9WqzFEXgJZywk7gSvLMoYHepO5K3/clFEKih2bQMep7bwDaIDggf+YdoA8/H4nkw3Qy4lk9ptK48hYcqGAQGBXJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350201; c=relaxed/simple;
	bh=XQfbdkI04bNtAvAH8G5FIAvodLjWR4hiKPhHhTX4mv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDrpKn47oytlmlyWTdJmvIMa7JMohXNBCy0c7uuodF24J8L8Z6GBVU5ckeJLoBo6jHwenx5bQGvqloV5Vsa4hHUJV4DxgCelNQN6ScyojelCc4qhKYKByxB9O0TnTL7+60s5nIelOHVeAraY/73wGQr4G1L+f33HUAwzYMlzQGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KWO9+Oex; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6870ad8072eso4959908a12.0
        for <cgroups@vger.kernel.org>; Thu, 21 May 2026 00:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779350198; cv=none;
        d=google.com; s=arc-20240605;
        b=UeiC+dN1sLTRX+eNLOY9ivrX0O0pq8Yt7NbPrhpOEMULvXLHNQaKWHnOCRLB6w8A0U
         5IuHzaG/nU6am8wPdXCKBUFwSjQP1HZui5QbG07S9We7yESzdHDA9KOhAigQ91uCQ7O4
         b8BotsMmyuBUKdG10kwqEfyHMvPIlelpGL82suRacIk3//yXxLzXwk5oPKTf5bRzo2F4
         ukZgc76WnIwOgYJA2AnHaumvZ7CqmPoRLDxqAMaeI+Gg0JTNa/NnR5xOj52vahQWAi86
         ZMG8NiYt+hQ8f+wNCqO75w/PleOYS35ziSmdpczw6bZUDWQyCIZ/UVNsM7hXnYBvxQW9
         x37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yIxtNd6sa8Cuxn7OK/IdozqI2/z38wcoJdn2nws1cN8=;
        fh=vZvSNc4RkVtZBKO43FjA5tnAq7/Xl6Z5e2T944cTisA=;
        b=FrvpvJnjmwK1uDSFsWtO1YaXcfayN32LGgNLptEhJxTGHblrF39CnJZIolQTY0edkJ
         lnAUDPO75+xsU7DdgagoO3Qp68R5dAgX+YXQYjYIAEwHnghgGct3KXwf2k45hYlPEkiX
         OL41aYdaLp4NRAsSRQJMhsBz+BLCrZjGNtzKjRYZwAGz5xIJLhh9qNKrgGceWcwkR8dU
         TvrqUswcutBN52an6dO4NSLxDF21wmD+471SlBl3tE87qKsn695QjNr7WzT+ufqh550T
         eOoeuIjmZVYX1tIuY5P7r0znpPRtkOps1z98wDR9+i6fcwZe+xNHdyLYspMA5OFfOehg
         wCEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779350198; x=1779954998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yIxtNd6sa8Cuxn7OK/IdozqI2/z38wcoJdn2nws1cN8=;
        b=KWO9+Oexgg45eqEJZXYZoksgV422ZcryvSUPezQDQ3AE9vOGRuj/4+sFCES0XmE52Z
         1Ggby5IOKVEsPh0ba9vpTtJk7Ux8lwmmTpFtrKq0zwjZczmZ5mfRFgHDiS+Af99ZGdKj
         2HsXiqU3K9yX61OUdnOtrR8SFaxUBS+xE3CfwaVCpnipdRcEo+k28f5IJFrW7e3BUqGV
         Fosqj7pTBhvp7NyXWv9KV8qx2HZlb70iYCfh1kjH9L3r3ScwiGgjXObQy4fmEitYwxy9
         ugr7h/k8I9CQ+3JOY+r/TAaecuwbFE/cNXAw6n8nkDYRuKSGXitNObGc5Spm+gX8Iau5
         cbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350198; x=1779954998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIxtNd6sa8Cuxn7OK/IdozqI2/z38wcoJdn2nws1cN8=;
        b=WZ9s0qezUcpZOjWRDvDMIVwDGNvZpIXdvwgpC6MY/N2CTbDbiUnOhiV4NNvHN2HM1y
         bb1U8wJHp+KM+FPS1NWqR1r7CYPagfltf2cRCAEH/NQgiojVavkvwoA0QqxN10dlXbRb
         SZn/rxdAY1LkC5yqOH9bTkKagbz9SfO9o2XPSkA8wTDXVfI0nmO+/p7R4Zrdfshp/oLM
         9+jLwVmbgRk7KBwIERF48kbmSjRw9OCS1Ym1CCpz545m8EU15a2AUu2NXv3j2jnKKoNF
         uZcar6qudXVn+7kM+Ge6UF9sJrywfxOeBN+i3nj3TtBarDzhgWvEJDhjqOt1JyMSYVug
         wouA==
X-Forwarded-Encrypted: i=1; AFNElJ+M5YdSM5iqaAN6CxNQvQPG6hc9FBSNQdHw8Ngb7CV+HqOIr3xFH1F1Gi4TjgZYJ/nvwJZBMLIX@vger.kernel.org
X-Gm-Message-State: AOJu0YwZIV1muTXRviYJxEs3ltBBQkH3LmdMchT5Xn8A6corGUrccbTV
	2PCuo3qhxCzphamyORxBHU+3fML2hawFc9VODRr9Zv4UPod0JvrpGgvgw40b6WoyYBcZ7B2PRfv
	w/4QracWXJRrXEWk6Ruf3j9HlMkvLU9w6dzPxCTf6jw==
X-Gm-Gg: Acq92OElFDzXJKKCg8VSS5Nag0J5aV8q95CqG6PzhmA8+rROeMbA3WCjtxwvCpoL2ji
	iYIfk9u2JC6GGtQkUnnl4wHsweGSVgyAlwy2rE6w2Ohsx1y3j/iNAkM5g21B1lObZlPfpbT6a0z
	qMc5Y5VL5YxMyfu62Y/mhyK4Ihz6VB+w+RnVDOLm79uW4SxzciH0v/LBxTVkBRuO5kw1RHVasub
	+e8P3lZMwPeejdEUy1l1nWD2D4NLeBZZI5SGWoYygFithpavV8RN+5en1kRBMh8AYb+FIdOO3p8
	cfD4KjWaFLQMhAPCKwI6TswTT0/ZJx53lpGT
X-Received: by 2002:a05:6402:a541:10b0:67c:89f2:ae27 with SMTP id
 4fb4d7f45d1cf-6882eedd881mr591827a12.9.1779350198176; Thu, 21 May 2026
 00:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511113104.563854162@infradead.org> <20260511120628.206700041@infradead.org>
 <CAKfTPtCc=pBKe9eRbA5B0zhaXJKVjN4N74AT0BFyRK39cS4c5Q@mail.gmail.com>
 <ag3iC-jH6HPoWKGo@vingu-cube> <eb61103c-3dca-4032-90af-d472b26d2dbe@amd.com>
In-Reply-To: <eb61103c-3dca-4032-90af-d472b26d2dbe@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 21 May 2026 09:56:24 +0200
X-Gm-Features: AVHnY4JuUqSq5ehKGjncLKlTK2jrXzgkvz7nt_sLxnUqzIBKQxWS0iKl5s5e_0o
Message-ID: <CAKfTPtD=b9hkL6jCDicdu=bWLUBrq40vVUxHcor6MDN4XCj4KA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org, longman@redhat.com, 
	chenridong@huaweicloud.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jstultz@google.com, qyousef@layalina.io
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
	TAGGED_FROM(0.00)[bounces-16147-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:dkim]
X-Rspamd-Queue-Id: B4BEB5A08A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 at 04:57, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Vincent,
>
> On 5/20/2026 10:02 PM, Vincent Guittot wrote:
> > I finally fount the root cause of regression: the update of entity lag happened
> > after the task has been dequeued which screwed update_entity_lag():
>
> Great catch!
>
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
>
> Ah! The curr->on_rq indicator changes here and we'll start ignoring it
> for avg_vruntime() calculation afterwards! Makes sense.
>
> >       account_entity_dequeue(cfs_rq, se);
> >
> > @@ -7423,6 +7426,7 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> >               if (sched_feat(DELAY_DEQUEUE) && delay &&
> >                   !entity_eligible(cfs_rq, se)) {
>
> Does this need a update_curr() before checking entity_eligible()?

Yes we need to update curr first

>
> Currently these bits reside in dequeue_entity() and is always done after
> a update_curr(cfs_rq) but here we may need a:
>
>     update_curr(task_cfs_rq(p)); /* to catch up h_curr's vruntime */
>
> Just doing it for task_cfs_rq(p) should be fine since we only have to
> catch up curr's vruntime - sum_w_vruntime and sum_weight at root cfs_rq
> should be stable for all the tasks on rb-tree.
>
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
>
> If we decide to do a update_curr(task_cfs_rq(p)) at the beginning of
> __dequeue_task(), we can just move this to above dequeue_hierarchy()
> before se->on_rq indicators are modified.
>
> Thoughts?

yes it's doable, we will have a spurious update_curr in
dequeue_hierarchy but that will be a nop because of a null delta_exec

With flat hierarchy, vruntime and deadline are no longer linked to the
cfs hierarchy. A possibility could be to move the update of vruntime
and deadline outside but this is more complex because of delta_exec

The same apply for dl_server


>
> >       if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
> >               se->deadline -= se->vruntime;
> >               se->rel_deadline = 1;
>
> --
> Thanks and Regards,
> Prateek
>

