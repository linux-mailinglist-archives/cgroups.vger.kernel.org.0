Return-Path: <cgroups+bounces-10615-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 366F1BC7A77
	for <lists+cgroups@lfdr.de>; Thu, 09 Oct 2025 09:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 256DD4E6A24
	for <lists+cgroups@lfdr.de>; Thu,  9 Oct 2025 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920DB2BE048;
	Thu,  9 Oct 2025 07:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+rSQLlp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DCB24E01D
	for <cgroups@vger.kernel.org>; Thu,  9 Oct 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759994280; cv=none; b=PJgR4q/W762igct4fDcHIIUo7O6o+wNp4B25Qwprb2J4LDZB9ukKLWsiFB6J0OefHddQ/MK2KXDVUlw8AjYly2F4RKViqHPgVk/1LhO+JF8Br4q4b8kIDAXHHSoexxCn0FXLl/tPLK5HvK06PI8Xrtn7hfcC92IC3+PcTj/qQaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759994280; c=relaxed/simple;
	bh=MzaggMkgox+f14ZSjk/4xD4ogb/SfsQXZLmM6Zz0BCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfHAHqd/ytOcvK8GyW8Y/FXNAI9ztuuCwLrCHKv4uwoMxFEYwAXI4nNO0bfcgnHbme6R2pCDJnnRXXk2N9w5vvth0emm9U4eGFm8cwC2nkpy9+mljaVdnNDBcumuHzn6RR/2l2pGcPLL6UTaBZhb8cAGmhub5OAKXZw+0oJ1Z30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q+rSQLlp; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b593def09e3so397200a12.2
        for <cgroups@vger.kernel.org>; Thu, 09 Oct 2025 00:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759994278; x=1760599078; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KnDpl448KmBm7jRg+IaWZK8mGbwV+iXH8p9YGyGuQWE=;
        b=Q+rSQLlphyJbr0AXy78m/ar9FaN3KjHqa8IIQeKIp+1gjsv9p7Jglqdmxr2xfB4NlN
         HStaCkPMwNvtEjMXMbi9FfKmIlYHGAR1fTeV38GyN6tP9SK6IZuKBcy6Ao0jraWk+uWC
         yMP+0fmz7CFr/DNAkyG9SvYZ/j5IATZ/alk01f6uJkSQUtzVPGzLgDCSBA6By544JZoR
         4wJjkV2dYBuJeyr2ATD6xI4Q/OPD42z0epys9IyWu4Qi7ewpRII3YyKqElSAYI4tF0FG
         bheH/kXsWeO9Z4P+IbD5GLEYXKRQZzmRTt9m6C72Wgz5ShPT4FXuEyjTqExrGkvPNnIW
         eX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759994278; x=1760599078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnDpl448KmBm7jRg+IaWZK8mGbwV+iXH8p9YGyGuQWE=;
        b=DGW/YX3KN5Kk8xAJBTP34HJz6uv974rk0rt+X62guX2mgF9NJpDO/YLpaeRlF3TZmx
         AQXPw/y/axHzj4/B25FICl+NDo5HK+TyftRtyyrt6VsX1+EAgqj+WfZ3xSv8h9NoZccY
         v/8qzuKzGrrDTqY0wjJCOA22zncdlyVRfKxG3ZOpYpfKnlg+jOunMIAVJc74RXxOlQ7G
         o4DF3bfT7K+HdMIgSTnkFeBs9VuEeQaJ+BsdB7gv22fVvC95DGvKV/kWmTVsZ5KKNoh9
         eaXeCxVnueJe66QVIzy5Bu0URVeAcGNFii4xqYlWVOTclREdTF3uwuti/k3RsStxKOPs
         KzcA==
X-Forwarded-Encrypted: i=1; AJvYcCXLJWVw6seYv6Fhek22RwW62TvpYa1w9q9vW5HGjxY7+HGp7GQxWPYqiDW4u86bi2J4D5B+YdAx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5JnklXEKb5MdPxiaOlT8PmCLIk+plCrOk/WhREaEbWERWxXa6
	p80GLrdZZ8Hg01OIbz8K2LaieR1y6N12XXaojKWMG89rE8TFb0yWjE1QXWXJt5/A93BPT/rflwO
	dyxss0yyqLq1VaTTWACBzuR6gDThlOIzZ6+OjVPBTIQ==
X-Gm-Gg: ASbGncsbsKpGL97IlhzI5EvNf8IyRhV7O43nx9NjJY+TpK9ixTTZKXef301nz74k9VL
	6dc4qPgH3BkHSuBCgg+QmnnCYFAi6EJb+uDXvAZ8cIIRLMpKQlUBQmDkfbak6X096D7zhT/vH0y
	znJzJafOR04/+nzLYw98G4mcQb3VpFfsBEBBZEYR3gEHJdvkisvZGH3BqlcXbO3WBIwQvewuuBt
	okoxmrAwIbS0rIPxMsb4QPIXTSLrKr7MW1BCFIi5w6ykC+iUdKAicJjx7KMaPXN
X-Google-Smtp-Source: AGHT+IFn9r8crdkPQsk70/0LPQo6O8jmgoxx0cOasKw14vHSrY8R2tzadEUxcInhoqfSRDPYYjYKGZ+AUFL0QoR/aCs=
X-Received: by 2002:a17:902:ce81:b0:250:b622:c750 with SMTP id
 d9443c01a7336-290272d7330mr91020805ad.27.1759994278066; Thu, 09 Oct 2025
 00:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006104652.630431579@infradead.org> <20251006105453.648473106@infradead.org>
 <CAKfTPtCC3QF5DBn0u2zpYgaCWcoP2nXcvyKMf-aGomoH08NPbA@mail.gmail.com>
 <20251008135830.GW4067720@noisy.programming.kicks-ass.net>
 <CAKfTPtDG9Fz8o1TVPe3w2eNA+Smhmq2utSA_c6X4GJJgt_dAJA@mail.gmail.com> <aObK2MfxPyFcovwr@slm.duckdns.org>
In-Reply-To: <aObK2MfxPyFcovwr@slm.duckdns.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 9 Oct 2025 09:17:44 +0200
X-Gm-Features: AS18NWCFFG2jZlx24PTDm78yxWfINpT0vMvRGNXbx1D6IurrdBPCv36qDUVfa-g
Message-ID: <CAKfTPtApJuw=Ad8aX=p3VLvMojyoxVBVRbMG80ADXR-NVL0PTw@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] sched: Add support to pick functions to take rf
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, longman@redhat.com, 
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev, 
	liuwenfang@honor.com, tglx@linutronix.de, 
	Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 22:34, Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Oct 08, 2025 at 05:22:42PM +0200, Vincent Guittot wrote:
> > On Wed, 8 Oct 2025 at 15:58, Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Wed, Oct 08, 2025 at 03:16:58PM +0200, Vincent Guittot wrote:
> > >
> > > > > +static struct task_struct *
> > > > > +fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
> > > > >  {
> > > > > -       return pick_next_task_fair(rq, prev, NULL);
> > > >
> > > > The special case of a NULL rf pointer is used to skip
> > > > sched_balance_newidle() at the end of pick_next_task_fair() in the
> > > > pick_next_task() slo path when prev_balance has already it. This means
> > > > that it will be called twice if prev is not a fair task.
> > >
> > > Oh right. I suppose we can simply remove balance_fair.
> >
> > That was the option that I also had in mind but this will change from
> > current behavior and I'm afraid that sched_ext people will complain.
> > Currently, if prev is sched_ext, we don't call higher class.balance()
> > which includes the fair class balance_fair->sched_balance_newidle.  If
> > we now always call sched_balance_newidle() at the end
> > pick_next_task_fair(), we will try to pull a fair task at each
> > schedule between sched_ext tasks
>
> If we pass in @prev into pick(), can't pick() decide whether to newidle
> balance or not based on that?

The problem is that with dl_server, you can has a prev of a lower prio
but still want to run a newidle balance :
-cfs task preempted by dl server
-cfs task migrates to another cpu
-we want to run newidle balance when cpu become idle

>
> Thanks.
>
> --
> tejun

