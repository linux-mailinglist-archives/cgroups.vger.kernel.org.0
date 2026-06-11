Return-Path: <cgroups+bounces-16848-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JuTMMr11Kmq0pgMAu9opvQ
	(envelope-from <cgroups+bounces-16848-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 10:45:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2357E66FFB3
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 10:45:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=DRiGWwQ6;
	dkim=pass header.d=redhat.com header.s=google header.b=Nd9Id4w+;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16848-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16848-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B330F31EE3F7
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 08:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CAF3911B6;
	Thu, 11 Jun 2026 08:43:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E3372B50
	for <cgroups@vger.kernel.org>; Thu, 11 Jun 2026 08:43:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167383; cv=none; b=qWRcbyoZKhv4ggYtDJvW56v2XFwUxs7/jUUzlbcN7O/ISmMmHcJHbnlB0JnnpLBFZCmxBSgVN9AA7whsfnUalajnnLgiOIe/gahQeovHRVh5XoB5JPyfo1zgQVEad4Py+wfEdD+k7uTMTQXMugQSFru/1K9+Jll/4omYCuB57Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167383; c=relaxed/simple;
	bh=5kEugBllbOr9R1CSEvKxlF21Q03x528w9hHM2AMXfgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9OmxlRINDL7SJoJML8yHi9eQmnTKLP3VeumRgq1DAdTbPLTOAk0W9M27XzxFCKO934m0HCPIiu0Jn+eCf+ovXk1VdPKrfD/+sp11UJ4hlZgHV42w4ltvb6WnaM/fpf1kK5jrpADtNJXM4xYl7edqaP2JipjYS/DJpFn7Q18NZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRiGWwQ6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nd9Id4w+; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781167381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ajL9Euat9wcoKLrUzak1GVazOOJHvH1s4ex9MFY1kDA=;
	b=DRiGWwQ6KkujmDJZgsHVM8Ww3+5yrMLTG2smkCXk5ZsoHfao3QCmwXDpPKByge5jl+p16o
	EDv3EcP+rkEsf2UHGv0S2wY8Y0XTgU2t7jAE96T7cIzeA31sjqWxSMlCjaqEVhtJaMUfPA
	MX6wCltiXPMGECFRI5cT55aqi7jQxT4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-YD7haxUxNA2YZyyuYwnaIw-1; Thu, 11 Jun 2026 04:42:59 -0400
X-MC-Unique: YD7haxUxNA2YZyyuYwnaIw-1
X-Mimecast-MFC-AGG-ID: YD7haxUxNA2YZyyuYwnaIw_1781167378
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45f3d008865so456455f8f.0
        for <cgroups@vger.kernel.org>; Thu, 11 Jun 2026 01:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781167378; x=1781772178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajL9Euat9wcoKLrUzak1GVazOOJHvH1s4ex9MFY1kDA=;
        b=Nd9Id4w+wTIYaVwRl306SE+2n1vg2SBj4KkJwjTl0M9Q7owDmVL0OKMw5P7YZvXpU1
         IKXrocFdxIIignU8xXCsj+v5t0paXU2j6Jmf/WtEcmDwFU6i9zFuVBBblCTlir+7pefT
         KSSv8y0KuMZJumChQ1Pj4GCnV2pgnU8HlNRG7qPo7VqH3JVYtf4qXwIiFIlNr/mXk6et
         PhJyYV+hfzcMSKnzyl1OhEWWG+EkS3BLkXbNP8kqyo5M0ph75bmNOwMKXpuHvF53Y+jd
         POw+xr/+4y8LZ85CRsZYVjl7rO6ta9elgUiawgQO/Cw0YDDVrN56x0L5N9WEjIxnP0Gu
         sAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781167378; x=1781772178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajL9Euat9wcoKLrUzak1GVazOOJHvH1s4ex9MFY1kDA=;
        b=KicGeARt4Xq2E1PdKi0qMafji7tkMreLghluLqPYdx2yKh1vO2zpXTaU83QYJHgcKV
         /dpKRemAJ/KCIXVGtO7KTeRXDHNLR68f97YymUOmMJ+RLP97u5opLvn+qThX1kCZoHTH
         OZj98FtTT1tTMQOsfFQwCBp9Eprl/np1WciovoiVqv6ykimKgVywmpnM9rHAGL0uS8jY
         Im+sn13PN0sJogsuXh1Xy1PnFRKoXJrQS9VwhnUvHYNujpRuFYYuBebOwp2MeVzuna2I
         A9JxWwHGWJERR6QZLSFdCluTeX9cyIfA6qRvGbiLo3+BGJBle6RNNfn0qAb+bC1zup1r
         NmWQ==
X-Forwarded-Encrypted: i=1; AFNElJ++6pY4fW+d9Ba7snxzYS7mJKQj983EWZxxIR6PdE4fKAdN4Jy1beT2o6CKMsY3+UcE1anXB9X2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7mhkH7fZBXZC/EB/0Lu62O7lwQ+0f5GGzXXbavKBevu7+d6Am
	t37nnNYZ7XmqXQm2dOx7H3WnOnq9rD1+nqVUZG/XDkmvLqnZggeruoZMkJEznliNHI3+fQ0Dx4+
	9wdtH3OnPSKGkQb7VC+f2m2QiTDRS2DFZK35RXNcmv7aq7EsM0qc+TaSBGMQ=
X-Gm-Gg: Acq92OGOl6ZfPxkLCwXd0BpLvif4T1QtTlbWRhEzVcXkalYT116NklZQvFSat6K40ug
	aP88etaxoabRbrXGLCKpAZCPLktzJ1nYlSB/Rcx3FLdDmJ+uDQN0be63BBDMmqgHPBjg745ReoA
	euxmMVe38AQKV7V5xNwevwv4qzFRWYqTXxFt1ucjnd5XQAit8Ib7yDs3yMFyex4fa8zIe7bEtdv
	WmEy110Nc7M2nQF0BuISO/AxDx9IBMVCEFLvoewUkPqaUNceEDDpyWue+oCGSgEygb5Wxv7YuWR
	L5PA1Wcbl8jTVwmvwB/KCOMN3G+C/CwsG9LmQJzZtTzA5RkBZm8SYvLt3WQGcW3ABCGWOS8bOX0
	Dl3oItbQEgHim7jZ7d5S7B5qaxkET3C+bi9e/GKHjQ31MuaDYRe62kbYfeSWPyOE=
X-Received: by 2002:a05:6000:2085:b0:460:1c93:6eb6 with SMTP id ffacd0b85a97d-46067c21fa4mr2083256f8f.20.1781167378150;
        Thu, 11 Jun 2026 01:42:58 -0700 (PDT)
X-Received: by 2002:a05:6000:2085:b0:460:1c93:6eb6 with SMTP id ffacd0b85a97d-46067c21fa4mr2083211f8f.20.1781167377778;
        Thu, 11 Jun 2026 01:42:57 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.95.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f5612sm77250977f8f.15.2026.06.11.01.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:42:57 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:42:55 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v6 12/25] sched/rt: Add
 {alloc/unregister/free}_rt_sched_group
Message-ID: <aip1DyMmTDjbB6Kp@jlelli-thinkpadt14gen4.remote.csb>
References: <20260608121546.69910-1-yurand2000@gmail.com>
 <20260608121546.69910-13-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608121546.69910-13-yurand2000@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16848-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yurand2000@gmail.com,m:mingo@redhat.com,m:peterz@infradead.org,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[juri.lelli@redhat.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juri.lelli@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[santannapisa.it:email,jlelli-thinkpadt14gen4.remote.csb:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sssup.it:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2357E66FFB3

Hello,

On 08/06/26 14:15, Yuri Andriaccio wrote:
> Add allocation and deallocation code for rt-cgroups.
> 
> Declare dl_server specific functions (only skeleton, but no
> implementation yet), needed by the deadline servers to be called when
> trying to schedule.
> 
> Initialize a cgroup's active context to that of its parent.
> 
> Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
> Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
> Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Co-developed-by: luca abeni <luca.abeni@santannapisa.it>
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> ---

...

>  void free_rt_sched_group(struct task_group *tg)
>  {
> +	int i;
> +	unsigned long flags;
> +
>  	if (!rt_group_sched_enabled())
>  		return;
> +
> +	if (!tg->dl_se || !tg->rt_rq)
> +		return;
> +
> +	for_each_possible_cpu(i) {
> +		if (!tg->dl_se[i] || !tg->rt_rq[i])
> +			continue;
> +
> +		/*
> +		 * Shutdown the dl_server and free it
> +		 *
> +		 * Since the dl timer is going to be cancelled,
> +		 * we risk to never decrease the running bw...
> +		 * Fix this issue by changing the group runtime
> +		 * to 0 immediately before freeing it.
> +		 */
> +		if (tg->dl_se[i]->dl_runtime)
> +			dl_init_tg(tg->dl_se[i], 0, tg->dl_se[i]->dl_period);
> +
> +		raw_spin_rq_lock_irqsave(cpu_rq(i), flags);
> +		hrtimer_cancel(&tg->dl_se[i]->dl_timer);
> +		raw_spin_rq_unlock_irqrestore(cpu_rq(i), flags);

Why do we need to grab rq lock here? I actually fear this can deadlock
with the timer callback.

> +		kfree(tg->dl_se[i]);
> +
> +		/* Free the local per-cpu runqueue */
> +		kfree(rq_of_rt_rq(tg->rt_rq[i]));
> +	}
> +
> +	kfree(tg->rt_rq);
> +	kfree(tg->dl_se);
>  }
> 
> +static inline void __rt_rq_free(struct rt_rq **rt_rq)
> +{
> +	int i;
> +
> +	for_each_possible_cpu(i) {
> +		kfree(rq_of_rt_rq(rt_rq[i]));
                            ^^
Can this result in NULL pointer deref if __alloc_rt_sched_group_data()
fails for some reason midway in the CPU loop?

> +	}
> +
> +	kfree(rt_rq);
> +}
> +
> +DEFINE_FREE(rt_rq_free, struct rt_rq **, if (_T) __rt_rq_free(_T))
> +
> +static inline void __dl_se_free(struct sched_dl_entity **dl_se)
> +{
> +	int i;
> +
> +	for_each_possible_cpu(i) {
> +		kfree(dl_se[i]);
> +	}
> +
> +	kfree(dl_se);
> +}
> +
> +DEFINE_FREE(dl_se_free, struct sched_dl_entity **, if (_T) __dl_se_free(_T))
> +
> +static int __alloc_rt_sched_group_data(struct task_group *tg) {
> +	/* Instantiate automatic cleanup in event of kalloc fail */
> +	struct rt_rq **tg_rt_rq __free(rt_rq_free) = NULL;
> +	struct sched_dl_entity **tg_dl_se __free(dl_se_free) = NULL;
> +	struct sched_dl_entity *dl_se __free(kfree) = NULL;
> +	struct rq *s_rq __free(kfree) = NULL;
> +	int i;
> +
> +	tg_rt_rq = kcalloc(nr_cpu_ids, sizeof(struct rt_rq *), GFP_KERNEL);
> +	if (!tg_rt_rq)
> +		return 0;
> +
> +	tg_dl_se = kcalloc(nr_cpu_ids,
> +			   sizeof(struct sched_dl_entity *), GFP_KERNEL);
> +	if (!tg_dl_se)
> +		return 0;
> +
> +	for_each_possible_cpu(i) {
> +		s_rq = kzalloc_node(sizeof(struct rq),
> +				    GFP_KERNEL, cpu_to_node(i));
> +		if (!s_rq)
> +			return 0;
> +
> +		dl_se = kzalloc_node(sizeof(struct sched_dl_entity),
> +				     GFP_KERNEL, cpu_to_node(i));
> +		if (!dl_se)
> +			return 0;
> +
> +		tg_rt_rq[i] = &no_free_ptr(s_rq)->rt;
> +		tg_dl_se[i] = no_free_ptr(dl_se);
> +	}
> +
> +	tg->rt_rq = no_free_ptr(tg_rt_rq);
> +	tg->dl_se = no_free_ptr(tg_dl_se);
> +
> +	return 1;
> +}

...

Thanks,
Juri


