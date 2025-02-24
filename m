Return-Path: <cgroups+bounces-6657-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5752A42293
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 15:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593CA441FE0
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 14:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F2C18D621;
	Mon, 24 Feb 2025 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFTmeUIf"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FE318A6B2
	for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405811; cv=none; b=YM949ZwhSG9xlioEJv+JGpJ2C0chYznWKHvpsK5n2efXdYkokEfHuxmyGiyKocuTScHANOlQ74LQc9ObAQCkvSDiIghL8AscZnBLLMJt7EDR74h0KO870otEJh3m/4+NXNnFa7AkqYgDLkA632f/56GNaPUX8aOi0xK1/ImaZ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405811; c=relaxed/simple;
	bh=1JALSei35oMhZvTDfxvtjv7epCXM5mRcWouOYjswpr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxHRoA2BwlmMqN4LET2olpnPAlr6Tmj5C6dbbsI513aooQlBf2ih0jjrdPaRolv3HiErwQg4isY5JRkPG3V8DWnplG5WESy4PbcpVGOAwGf74w/Ll4UiYFycQNv6kuwGEZfDFZOQnhGc/q47z7a88S+OkBG4kSyn0cD7bks+/Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFTmeUIf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740405808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kPlEDzMoCiaFPBFpTObksOw/FBcJf2EMjwPGt2p/nQ=;
	b=AFTmeUIfMIcRJOsqwpNO4Do0H28i6yXN0xKJppRTsmLPQFe/ZSLbs2gL5s7Sqt6t+ljdId
	gkAn8f+BrSjYUsFwtkhyYQlUFOmzHxC91ZTuV9Dyg9qI6gfFYZkBpL9y5VGv9hAXqLJw36
	UVG7OvNzwaPe12eGA8Lp4QMv3AwiqPk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-YpvvZfK3N7ee-cLYiB5cMw-1; Mon, 24 Feb 2025 09:03:25 -0500
X-MC-Unique: YpvvZfK3N7ee-cLYiB5cMw-1
X-Mimecast-MFC-AGG-ID: YpvvZfK3N7ee-cLYiB5cMw_1740405803
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so23142985e9.2
        for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 06:03:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740405803; x=1741010603;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kPlEDzMoCiaFPBFpTObksOw/FBcJf2EMjwPGt2p/nQ=;
        b=CegPrZwJ040IoA93fJCdzxprLSEuXI9H6LN3SQlW3wut3pAqKWoNghaPjhatcjGFg3
         V0h4OEPyeENS1I/uS5bchgfvfqzROGHYpEHKX24Zs4sfRTmAcBlHlNk2c3uDhT1GDXMx
         1OtzGNM84lxWtvcdJBwtS3gLT7WDucsUciV941mBkoB/gGiMtQpte2HYPC1woFqqsPBd
         Av/W5Clv2AQjys4UD2lw7rti4rCvAk/EVznTiZcZLm4J1wQdbPyAHLi7K+ZDvV9szHrS
         nFsC+NQY3rsCpr//4P298H1OSQXpkbLNArAz5eV+wdwrVjHIkAxA5nCwHubTins4L6Pk
         9iTw==
X-Forwarded-Encrypted: i=1; AJvYcCXW7NsHmTxaJ4g0znylENoY+6jrKq1RkJqO6AXrj5M7spfvRLajCW1VuP9Wr/1MtctDTPg1MWhP@vger.kernel.org
X-Gm-Message-State: AOJu0YyUN5QyCbUQN7vsw7NU2auVsnop9sSZR46saobKMM6fio/95mEi
	k0oRToc1T4T6gjLfaq7uIYbTsXEENMjDaJOV8pux7Ia+1G4QKVS2icQ8yoOEsxFOT2YKo8KHXo0
	fYPpBC5CUByNL3rXXN62QKrs0R0rqu+6GViCtBwn66hnpNE2DHmGgKVY=
X-Gm-Gg: ASbGnctrT1JOH2THdmN27lLqWV/yDXv3UFgUF27CixLZgD6WCg5iTqPz83BvW6+JeYt
	2nbMxTmynOLv+mYYmQOftjUW4tBzI0FfVbviUzpIjuo0FGSdykkaqFfWBu/CkQjTxTemOQMp2Yc
	B4RibqT1tRfEBThxCShXMDjdbamyrir7bTt8YFW+msbpYb/ZZgiqvnpf70zG+cRIq/i2fPGB5Nt
	UL7uMbnBvkH79vP6pkOXQc5EyWJdJ5cz2SOz//KImAROPHHoPesU0sfvG67DE4+mCG4gTwN0ROI
	V3uPZVYafk1weWeoICDOYgHw+S0/cM9ark1UPKFHw/Aw
X-Received: by 2002:a05:600c:1c01:b0:439:9f42:8652 with SMTP id 5b1f17b1804b1-439ba176db4mr73098515e9.17.1740405802642;
        Mon, 24 Feb 2025 06:03:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkIfUh6rj4W4zZ1GHJwwLGYv2xuVUgU5uNxKr8b2wUnMTJZBbmIXvQMUKxcjIWDgQJIbI7Zw==
X-Received: by 2002:a05:600c:1c01:b0:439:9f42:8652 with SMTP id 5b1f17b1804b1-439ba176db4mr73097705e9.17.1740405802123;
        Mon, 24 Feb 2025 06:03:22 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d94acsm32198115f8f.75.2025.02.24.06.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:03:21 -0800 (PST)
Date: Mon, 24 Feb 2025 15:03:18 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Thierry Reding <treding@nvidia.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
Message-ID: <Z7x8Jnb4eMrnlOa8@jlelli-thinkpadt14gen4.remote.csb>
References: <Z7SWvr86RXlBbJlw@jlelli-thinkpadt14gen4.remote.csb>
 <a0f03e3e-bced-4be7-8589-1e65042b39aa@arm.com>
 <Z7WsRvsVCWu_By1c@jlelli-thinkpadt14gen4.remote.csb>
 <4c045707-6f5a-44fd-b2d1-3ad13c2b11ba@arm.com>
 <537f2207-b46b-4a5e-884c-d6b42f56cb02@arm.com>
 <Z7cGrlXp97y_OOfY@jlelli-thinkpadt14gen4.remote.csb>
 <Z7dJe7XfG0e6ECwr@jlelli-thinkpadt14gen4.remote.csb>
 <1c75682e-a720-4bd0-8bcc-5443b598457f@nvidia.com>
 <d5162d16-e9fd-408f-9bc5-68748e4b1f87@arm.com>
 <9db07657-0d87-43fc-a927-702ae7fd14c7@arm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9db07657-0d87-43fc-a927-702ae7fd14c7@arm.com>

On 24/02/25 14:53, Dietmar Eggemann wrote:
> On 21/02/2025 15:45, Dietmar Eggemann wrote:
> > On 21/02/2025 12:56, Jon Hunter wrote:
> >>
> >> On 20/02/2025 15:25, Juri Lelli wrote:
> >>> On 20/02/25 11:40, Juri Lelli wrote:
> >>>> On 19/02/25 19:14, Dietmar Eggemann wrote:
> > 
> > [...]
> > 
> >> Latest branch is not building for me ...
> >>
> >>   CC      kernel/time/hrtimer.o
> >> In file included from kernel/sched/build_utility.c:88:
> >> kernel/sched/topology.c: In function ‘partition_sched_domains’:
> >> kernel/sched/topology.c:2817:9: error: implicit declaration of function
> >> ‘dl_rebuild_rd_accounting’ [-Werror=implicit-function-declaration]
> >>  2817 |         dl_rebuild_rd_accounting();
> >>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > This should fix it for now:
> > 
> > -->8--
> > 
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 52243dcc61ab..3484dda93a94 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -954,7 +954,9 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
> >         css_task_iter_end(&it);
> >  }
> >  
> > -static void dl_rebuild_rd_accounting(void)
> > +extern void dl_rebuild_rd_accounting(void);
> > +
> > +void dl_rebuild_rd_accounting(void)
> >  {
> >         struct cpuset *cs = NULL;
> >         struct cgroup_subsys_state *pos_css;
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 9892e6fa3e57..60c9996ccf47 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -2806,6 +2806,8 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
> >         update_sched_domain_debugfs();
> >  }
> >  
> > +extern void dl_rebuild_rd_accounting(void);
> > +
> >  /*
> >   * Call with hotplug lock held
> >   */
> > 
> > 
> 
> Looks OK now for me.
> 
> So DL accounting in partition_and_rebuild_sched_domains() and
> partition_sched_domains()!

Yeah that's the gist of it. Wait for domains to be stable and recompute
everything.

Thanks for testing. Let's see if Jon can also report good news.

Best,
Juri


