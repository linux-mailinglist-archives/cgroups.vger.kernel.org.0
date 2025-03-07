Return-Path: <cgroups+bounces-6886-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F54A5640D
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 10:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8BE17841A
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8B820DD7E;
	Fri,  7 Mar 2025 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaAWHSjU"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636BE20B209
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741340043; cv=none; b=T6wiLl9wrIILeqpbNMW8HdDzRd0ZIA5/0L8quw6074VAtdyjnC0DLKeUOrMLZD839bLIZceEaoCPueyX0idetmy/us8g0tbDMIIVnuC77s6hMbDo5Mh9exyTNLLJWgAfbstOauwaNCQi3ohBZYyYJyy+Bo6ARGXJjMlPJfz30L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741340043; c=relaxed/simple;
	bh=Ypb9lH57vm+WjVbRerOzUIkxUzGc7i5IMTgs/vJz0zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASIaHzIiJ7/xo8fmjicD3jPU9yaLcvwYPi41cEgFCmScUZI7bp3VbO1cwDX6u54wAQh0jCSEvFXx39oJBU2NszYe89a1JfZD74AOjtSDhN4qYv6kzUhXAK9ea3Alw28jb44pHw+npK8PWmiVncJ1EoyNkz8pCyN9A9p5B+RHTy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UaAWHSjU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741340040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jVEOIfEn4WDZ5RzbzaumI6wBZHn7khG5qOmcjQFY/34=;
	b=UaAWHSjU0Q8ulYb2mycdhFtmRU4xYKRh4rcpiwrq1zaQM6sF9SDkCjGhmE7WOm9lUmPsE2
	0alucV5kCDu2EAIClaHw+AUArZTOjT2Jmmu1Z+ymPngE4ESOFTuAThqnv6PUU7JsPwMbj+
	o9nzhNbO2qR5Z1KEhzrLe8C0Q0i1cDk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-CDROTf8tNv66BW9y_JipiQ-1; Fri, 07 Mar 2025 04:33:56 -0500
X-MC-Unique: CDROTf8tNv66BW9y_JipiQ-1
X-Mimecast-MFC-AGG-ID: CDROTf8tNv66BW9y_JipiQ_1741340036
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8fb5a7183so28214666d6.1
        for <cgroups@vger.kernel.org>; Fri, 07 Mar 2025 01:33:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741340036; x=1741944836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVEOIfEn4WDZ5RzbzaumI6wBZHn7khG5qOmcjQFY/34=;
        b=phqDW6nb+76wBSEscAh9BltQq89T1rcl8oxTpWnPCp0hvFaGCGhVnpkDPmTrxck2p8
         LbXa+OUA/v5ROBUoj0sM8/i/r8cDmDnz3g0bww6Q7wt5D5W3TptZFyDhH1e7UYqbvUFK
         IADv9cCwO2fPwqnAVwTjmJS4Fmw1WZnWje9D6iUM/FjB0vUzQnIeuEr5A4mXnSSebfBO
         7g9EnpNnLDwJlXzN47O+FKpb3yK2MljWPtHLAtiaeRcqqj5ebcskmmRjiZLu+pwcxNS3
         EOUlxKjbe/OuEHqDgork6131kJco5/ctkHTHn8XlmRsYm+BJxGCbVaDRMerdNofCYGjt
         sAeg==
X-Forwarded-Encrypted: i=1; AJvYcCXdwJOunleYx+899q+7Hm7zIcR4/tB9n1Oqza/CUZ8fyTlzhDmSudHy2xyeCm247YWKWGYNCluZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyckA7LIKxUrHwNholVIWYdMdnQ38F9bEzuyICZqMz0P+aXz6k6
	82xHMQPhDTuLguv5MYf2ioD4GbZovudTh8ww3JxuHGQ+9nDzrDuuTu2CcfACvCD9zWB+hxXwBZg
	hYHylPkYZWpQTLGlGoKSOIeiNepZ4zfh6oclh2oMeai2yQbGWtpU+6BI=
X-Gm-Gg: ASbGnctNQ3Ra30eunynLVXaghw4qf3aSmquwg1DsPd5Tno+4bCOMkdt1XVluGEth3mj
	w/IFsxvH2AgzWa+ySDoKW3EPhKoSX3nhA/NdznZWFAERkcGk/BJJwLdYrHrRta7dbumlJGyzTXs
	ASt4dcr4z+E5Bv/+R22RFWY7yoJKyHsa+3UMOHqNOdsOlnQn1CTvhfyAH5e0RmBePLzjV882mL8
	5F7KNVV5leWYoFlPU7j7bL264mvgwaxB3Sb9IyjM95VfeatMhbTqDOH7XNK/mKT64vr/DYUilCQ
	JsuCb7ORAlNEMWF08Fyx6EK0wmlgMhuqSMy5A90TgzzCtgHoW1LCo2qU1VSpXTyo29U6aYMBErw
	t8u7Q
X-Received: by 2002:ad4:5d65:0:b0:6e8:89bd:2b50 with SMTP id 6a1803df08f44-6e900604760mr33987756d6.7.1741340035817;
        Fri, 07 Mar 2025 01:33:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyw0MIlPz6JSxN4+Pj2WN6QeNWdmbKWHxOQqdc5jlEBKq4ZYwIpIMz5BhiL2wU0DVNM6In+g==
X-Received: by 2002:ad4:5d65:0:b0:6e8:89bd:2b50 with SMTP id 6a1803df08f44-6e900604760mr33987556d6.7.1741340035522;
        Fri, 07 Mar 2025 01:33:55 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7090c4csm17736036d6.33.2025.03.07.01.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 01:33:54 -0800 (PST)
Date: Fri, 7 Mar 2025 09:33:49 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>, cgroups@vger.kernel.org,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	linux-kernel@vger.kernel.org, tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 4/8] sched/deadline: Rebuild root domain accounting
 after every update
Message-ID: <Z8q9fY0DDzVsc4Yb@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-5-juri.lelli@redhat.com>
 <2926c843-62e6-419b-a045-e49bdd0b0b97@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2926c843-62e6-419b-a045-e49bdd0b0b97@linux.ibm.com>

On 07/03/25 12:03, Shrikanth Hegde wrote:
> Hi Juri.
> 
> On 3/6/25 19:40, Juri Lelli wrote:
> > Rebuilding of root domains accounting information (total_bw) is
> > currently broken on some cases, e.g. suspend/resume on aarch64. Problem
> > is that the way we keep track of domain changes and try to add bandwidth
> > back is convoluted and fragile.
> > 
> > Fix it by simplify things by making sure bandwidth accounting is cleared
> > and completely restored after root domains changes (after root domains
> > are again stable).
> > 
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > ---
> >   include/linux/sched/deadline.h |  4 ++++
> >   include/linux/sched/topology.h |  2 ++
> >   kernel/cgroup/cpuset.c         | 16 +++++++++-------
> >   kernel/sched/deadline.c        | 16 ++++++++++------
> >   kernel/sched/topology.c        |  1 +
> >   5 files changed, 26 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> > index 6ec578600b24..a780068aa1a5 100644
> > --- a/include/linux/sched/deadline.h
> > +++ b/include/linux/sched/deadline.h
> > @@ -34,6 +34,10 @@ static inline bool dl_time_before(u64 a, u64 b)
> >   struct root_domain;
> >   extern void dl_add_task_root_domain(struct task_struct *p);
> >   extern void dl_clear_root_domain(struct root_domain *rd);
> > +extern void dl_clear_root_domain_cpu(int cpu);
> > +
> > +extern u64 dl_cookie;
> > +extern bool dl_bw_visited(int cpu, u64 gen);
> 
> Is this needed? There is same declaration outside of CONFIG_SMP done in
> patch 3/8.

Nope. Good catch.

Thanks,
Juri


