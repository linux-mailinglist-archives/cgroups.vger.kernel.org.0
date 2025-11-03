Return-Path: <cgroups+bounces-11520-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52672C2C43E
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 14:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E21294F1EB5
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26982749EA;
	Mon,  3 Nov 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTFCP23O";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSAsfMRY"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB1269D17
	for <cgroups@vger.kernel.org>; Mon,  3 Nov 2025 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177823; cv=none; b=CLLjs9FpngnCMZvGjgkE6rSes1EvUXCTV04c8df1fBLuxLaCa5u8Rw8s/R6BI00qwd26pf+9GCOr9BxtuW0aYz7guq6U/m17hvAm2rqUoaxMFPfTGW1B21X77+JP6AFpMAGxHXD4L8Om1WUgwUuW83sxdjtMsDi0JNnPv764Wro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177823; c=relaxed/simple;
	bh=ohJeMw0OCJJD0F2l1gW4Fy3Y3zG1SiD8cjcPlLbmCiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyPJNZsgqQRFw45ipGP+kOZiI2wgJyObeebh7e138o9MPkXhM0PbPUiTVujtRDNI9P1EORrw7pBs43w/p6DXlyVVEpF7a+SP2Zu9DxN18baz59c3Sbn412QnDdv2EoDG7MUWRWCIKKv1zaPc9r3RIVk2Nf7pG0xavUxtEh9V+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTFCP23O; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSAsfMRY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762177821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DeCW7EBrUwZA713FmQXR6wEfB/uUnNKUpWTNflayAhw=;
	b=hTFCP23OGY57HzkN+e08Do7yW4Os3+idFxRfakNnuQx7QK0uwI7XvTH7rAyMoPHEQ4KRhl
	l/5ppXRN1SJs2DPng9+3swrRNLEiWJS/eA9c85J6E25EX8jQFfMGeJ3mT6ZTEwvlOpc3HV
	etKL1S49ZOPKGqdHo6FUNW5lcknuoSo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-Haeyg2ncPCOrjDFIHGZsIw-1; Mon, 03 Nov 2025 08:50:19 -0500
X-MC-Unique: Haeyg2ncPCOrjDFIHGZsIw-1
X-Mimecast-MFC-AGG-ID: Haeyg2ncPCOrjDFIHGZsIw_1762177819
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-475de1afec6so14983685e9.1
        for <cgroups@vger.kernel.org>; Mon, 03 Nov 2025 05:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762177818; x=1762782618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DeCW7EBrUwZA713FmQXR6wEfB/uUnNKUpWTNflayAhw=;
        b=jSAsfMRYgXwwPF4pG5kdFNL4l2RsdQEngykvdnnWWkIGbKGO9pS4xJCZ4pLQM3vddB
         A2BfdEAiSFnaQiCCluQg36CR75nlzs/tKIDprmHS6aUgvzNE0DZyapkG0o8ww5ciEypV
         VYyPBTCmXSzM/q3fk3Hp8v/fc/MfoT5o669UtvI3bsHqajpUjauX0rD/Fws/kYuk5BXx
         Qh5gK3AXBUfDr6/dK/3Dv8EPcsH1Jxt5saog4wnEQRyue6kNSm1xXYWSOEKl5WTKa36D
         /3kC4bdc0/pme/+Y95eBrdKjjc8AyKSJx82xvOjjuHuC9QhZ/SHe6xMe9e8cFobBGCDs
         xhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762177818; x=1762782618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeCW7EBrUwZA713FmQXR6wEfB/uUnNKUpWTNflayAhw=;
        b=V+wo+CQznP/3DtWX7s1wLtzZa+rZnwR+oyWS9x+w90dGt3y9LJrh/hdd56KpxKvk9z
         KXBmZduOu72z7bQX+ohETM7p6Kcy9vI5dIUbYa4RyNnqpYizgjDpKDKJFP1m68LGV4UX
         pOc1l4ViWGSAGaVTBt6kXneZNglqouhrRFRMrius0DS4pSm4d+gdm8avKEtPdSkVphmi
         nOfeZwgSkJkLOkB8joi4FoKMBXPKsF5ybeKbWRJBco25a9aDkMQm0n2X+NwXaUzfp7Gp
         PEDb+QapceEjXJSEMkr9Tc+ulxkoR5K2sf2SCMFQyV9ENegVnl5OLkkrPpfB0FtK6nU8
         uu3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXohGAMyEB6aweerQoF8xu59oKmD/cQHiW89IzY7k8LR2WMf+lb9bi4xb7dGJ18/OVCsni/KgsG@vger.kernel.org
X-Gm-Message-State: AOJu0YzW5QoBiAO8aEMzs4wPniuKMaxIP+QvAz/PvDSmMiWJwZ7UiBYy
	8P/RY9PJOQsfGn4ysCPOq84htVuQGG4oCK8Di1eGqmZ4OFUsOsB2KTCA3m2OPwdljUnuzJYudLy
	eoyKSI8+8RTH6/Pe9Gp4TJWJbpHak4JD2K+K/Uw6GgHIvixPA1Dp/8Y2+l3c=
X-Gm-Gg: ASbGncvvcgNpB0nX94RNME9ztMFRybOC6e9MAFmn4T5V5bCA9Ci0a2el6OtqVNhO+bI
	Df/E6cEKflq5D8Jd7rl5VT6NOhTt8hJ2X4LzgmEgx5B03fOKJQK7dMeFHct5VSXmF+iJXso6XjI
	4tPpuoTeSWKI+0tCKbkEIVLrSHWb9h6EXgB4eve8auojOX8LUisvB9ELbvY2XcGCapqDWRvUwds
	2rrKVi+Zh9DObpaJ9G1VCPIuFBf3On/WfVTESlcr+jRmqzL9ZxTJUyn0MRQqt7kdjBl7SEKQnrQ
	GZQy2uh5+lXvEtymZNi6X/LYmgo4pWkbL+7WgVeZj2Hl59lVO77lHtPibfZY4SPlg3xIba1UBPP
	2mVWee0L7Tkz7QJ/Kak+ne3y7hVw5Og==
X-Received: by 2002:a05:600c:600f:b0:477:3fcf:368c with SMTP id 5b1f17b1804b1-4773fcf392amr48151395e9.9.1762177818540;
        Mon, 03 Nov 2025 05:50:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHprfIQvR4JLgoHXRWh95iDbOYRS6dB1U8J8sEltQRqMZFbSOioWRJ4TfMwWwgGiqflgfqM6g==
X-Received: by 2002:a05:600c:600f:b0:477:3fcf:368c with SMTP id 5b1f17b1804b1-4773fcf392amr48151155e9.9.1762177818098;
        Mon, 03 Nov 2025 05:50:18 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fbc32d9sm90361805e9.1.2025.11.03.05.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 05:50:17 -0800 (PST)
Date: Mon, 3 Nov 2025 14:50:15 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Pingfan Liu <piliu@redhat.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCHv4 2/2] sched/deadline: Walk up cpuset hierarchy to decide
 root domain when hot-unplug
Message-ID: <aQizF0hBnM_f1nQg@jlelli-thinkpadt14gen4.remote.csb>
References: <20251028034357.11055-1-piliu@redhat.com>
 <20251028034357.11055-2-piliu@redhat.com>
 <52252077-30cb-4a71-ba2a-1c4ecb36df37@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52252077-30cb-4a71-ba2a-1c4ecb36df37@redhat.com>

On 29/10/25 11:31, Waiman Long wrote:
> On 10/27/25 11:43 PM, Pingfan Liu wrote:

...

> > @@ -2891,16 +2893,32 @@ void dl_add_task_root_domain(struct task_struct *p)
> >   		return;
> >   	}
> > -	rq = __task_rq_lock(p, &rf);
> > -
> > +	/* prevent race among cpu hotplug, changing of partition_root_state */
> > +	lockdep_assert_cpus_held();
> > +	/*
> > +	 * If @p is in blocked state, task_cpu() may be not active. In that
> > +	 * case, rq->rd does not trace a correct root_domain. On the other hand,
> > +	 * @p must belong to an root_domain at any given time, which must have
> > +	 * active rq, whose rq->rd traces the valid root domain.
> > +	 */
> > +	cpuset_get_task_effective_cpus(p, &msk);
> > +	cpu = cpumask_first_and(cpu_active_mask, &msk);
> > +	/*
> > +	 * If a root domain reserves bandwidth for a DL task, the DL bandwidth
> > +	 * check prevents CPU hot removal from deactivating all CPUs in that
> > +	 * domain.
> > +	 */
> > +	BUG_ON(cpu >= nr_cpu_ids);
> > +	rq = cpu_rq(cpu);
> > +	/*
> > +	 * This point is under the protection of cpu_hotplug_lock. Hence
> > +	 * rq->rd is stable.
> > +	 */
> 
> So you trying to find a active sched domain with some dl bw to use for
> checking. I don't know enough about this dl bw checking code to know if it
> is valid or not. I will let Juri comment on that.

So, just to refresh my understanding of this issue, the task was
sleeping/blocked while the cpu it was running on before blocking has
been turned off. dl_add_task_root_domain() wrongly adds its bw
contribution to def_root_domain as it's where offline cpus are attached
to while off. We instead want to attach the sleeping task contribution
to the root domain that once comprised also the cpu it was running on
before blocking. Correct?

If that is the case, and assuming nobody touched the sleeping task
affinity (p->cpus_ptr), can't we just use another online cpu from
current task affinity to get to the right root domain? Somewhat similar
to what dl_task_offline_migration() is doing in the (!later_rq) case,
I'm thinking.


