Return-Path: <cgroups+bounces-6825-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0630A4E7D8
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 18:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DEE8C5F9B
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 16:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43C0280CC2;
	Tue,  4 Mar 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qs2ytRZO"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3AE207E0F
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103867; cv=none; b=cKly1iIrkFxnwRdPq77AD9uJWcreZza/OkoF8l5uZEN1gAVKXo1ez4Apy6R/US4r/zgv3UJ0nxYRNjke0eXicB7mBCPuPO+h4N1aAb6SSFN9I6//U7xdcVIypaxfslNfFBRPZX4u0Cqb7jdSCUkhRHC1dFGMkqZ74ZIjmAhN9sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103867; c=relaxed/simple;
	bh=0A5RzxULdn6BnG/wUjI8HXWCUR1CnoyxE7bNXv0lXO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPbzT+rTM83P9VEjXZuirqtSB0HL5spadN5VCwgbsAIvZ9dPhVFMY8hucDqw3826D8MPfBxl1Hs9uOmRHpU4Mi2UNoLW6bO65wmyYfgZ3RPFf0omE8eBOppK5N6PCN+UT5k0dUYTWhsGBiLOr39N9KO1ThUxbOoCju3/6Cic4jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qs2ytRZO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741103864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I5c+TIt92FxB8qVNIe2L0vIj1KttGJBjP8IGbM1VlN8=;
	b=Qs2ytRZOj1EPEfadvVkzEPDU3NeoL8TNZMqG0o4aSHYXCjr4W2Au6CtSAS0BqSu0SFyaJ1
	esoW6q7Jc8kUZNKHhci1IYPsuSRD16cD+0nsdTqboi6V72biIDUe83gb8WzwR3J1frzq2q
	yXOaaJQtsgbUouxEDHwr/iaOuSsByZc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-mJJIiP5nOtufYmjX9CtFUw-1; Tue, 04 Mar 2025 10:57:26 -0500
X-MC-Unique: mJJIiP5nOtufYmjX9CtFUw-1
X-Mimecast-MFC-AGG-ID: mJJIiP5nOtufYmjX9CtFUw_1741103845
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43935e09897so42263765e9.1
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 07:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103845; x=1741708645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5c+TIt92FxB8qVNIe2L0vIj1KttGJBjP8IGbM1VlN8=;
        b=tRfMcW+/k1BK7XknQoJgrPhStqDlnWi6s7tjlepCDafrUcxIPqK4SNGmdn+lRvvUIb
         vUjgq9Ukf4eOvriAFEtZk3XqfI4QjRRYVItXA/FmeoNYH4A0ZsszwJAT8xRKuNUoV01d
         d0GIEYBTwaYDTy0GXcaDtFGyYiRORwC9EXokK/MwMzTxTBceQdLnBDF00zmPZdDg0szt
         j3tpXXf8GgF6m8/NVCsizwmjCfBJ8WgwJzQemjnldd1B8ApMxYwy4Xdp94UJqQC1Jr8J
         2DgfPN0NxaQU8+gOvLVU2aBq5GjBKuPhH8Hhrozc9XnT2c/YZC/GBx8VEHwu+N6Fe3jv
         SOuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6mOxAY1nhHVTmF1DYAZjOr2XbBbUX0Xbc9lEGyqpMLBP4ALGyoYQzdNjMtBYpStTbyi7Ml3nU@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy7A49PYn19WsOmmxIKjhw1AVjOPoZHPBgVCBF2sHHswDmp2T+
	qrkr7pJ6frZpaabQinglpBOFmI/J2+L5Q/TFamX0DZZPyh5aGWxPe9sw8h0I2rflg9ekke3NzTJ
	6d7VDecOK2h0ARgl8/M0gv8gxMVkK3No8KxnaxhOpckj3AYptBN0ITuI=
X-Gm-Gg: ASbGnctmQgRTbyMi4G3GknJnArgEZ64nx6VpI1Gb4BwUc2DUzc98vd4wRKzEfIXqBJm
	dvr/QLpzDLeYOWFKYkkBOXBm+l+OXl2krW57+P0QazHrButiTEEOMhHo1Eh4lEB7KsUpGsMbugc
	OAB+5ggPu2+VIDLTfRYvH23MTOzOKBy21DzSSwm5uuG59B37Ad0KQS+L5O3HwVsbQdwrfHr1Eao
	Le7TLrq4sG2nf0jXj2RgoNnzNNc6p5KWdNlyyOTWuEUKAlxyRW5iQymjpyE+HiYdOLpDLJzWESu
	bNPhKTsm8gSE4i5kbR6zqedeOg+dPHRhp/V02UrA9SreTaWfj9d/nqIrGmFtORZ6oZMzotLMhaQ
	xom/b
X-Received: by 2002:a05:600c:4f86:b0:43b:ca39:a9ca with SMTP id 5b1f17b1804b1-43bca39ac88mr48531965e9.16.1741103845263;
        Tue, 04 Mar 2025 07:57:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF551Hnt03L5tmeixMOfNScnGLbQ9obdAPDfAXfF76/qxOEU3+vZ2la9fN5VW2oCHpNIfsibg==
X-Received: by 2002:a05:600c:4f86:b0:43b:ca39:a9ca with SMTP id 5b1f17b1804b1-43bca39ac88mr48531665e9.16.1741103844801;
        Tue, 04 Mar 2025 07:57:24 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcbb82074sm29324895e9.28.2025.03.04.07.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:57:24 -0800 (PST)
Date: Tue, 4 Mar 2025 15:57:22 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 2/5] sched/topology: Wrappers for sched_domains_mutex
Message-ID: <Z8ci4jq5IhYGkxtk@jlelli-thinkpadt14gen4.remote.csb>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <20250304084045.62554-3-juri.lelli@redhat.com>
 <c02dd563-7cfc-404d-80d1-cec934117caf@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c02dd563-7cfc-404d-80d1-cec934117caf@redhat.com>

Hi Waiman,

Thanks for the review!

On 04/03/25 10:05, Waiman Long wrote:
> On 3/4/25 3:40 AM, Juri Lelli wrote:
> > Create wrappers for sched_domains_mutex so that it can transparently be
> > used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
> > do.
> > 
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > ---
> >   include/linux/sched.h   |  2 ++
> >   kernel/cgroup/cpuset.c  |  4 ++--
> >   kernel/sched/core.c     |  4 ++--
> >   kernel/sched/debug.c    |  8 ++++----
> >   kernel/sched/topology.c | 17 +++++++++++++++--
> >   5 files changed, 25 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 9632e3318e0d..d5f8c161d852 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -383,6 +383,8 @@ enum uclamp_id {
> >   extern struct root_domain def_root_domain;
> >   extern struct mutex sched_domains_mutex;
> >   #endif
> > +extern void sched_domains_mutex_lock(void);
> > +extern void sched_domains_mutex_unlock(void);
> 
> If all access to sched_domains_mutex is through the wrappers, we may not
> need to expose sched_domains_mutex at all. Also it is more efficient for the
> non-SMP case to put the wrappers inside the CONFIG_SMP block and define the
> empty inline functions in the else part.
> 
> 
> >   struct sched_param {
> >   	int sched_priority;
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 0f910c828973..f87526edb2a4 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -994,10 +994,10 @@ static void
> >   partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> >   				    struct sched_domain_attr *dattr_new)
> >   {
> > -	mutex_lock(&sched_domains_mutex);
> > +	sched_domains_mutex_lock();
> >   	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> >   	dl_rebuild_rd_accounting();
> > -	mutex_unlock(&sched_domains_mutex);
> > +	sched_domains_mutex_unlock();
> >   }
> >   /*
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 9aecd914ac69..7b14500d731b 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8424,9 +8424,9 @@ void __init sched_init_smp(void)
> >   	 * CPU masks are stable and all blatant races in the below code cannot
> >   	 * happen.
> >   	 */
> > -	mutex_lock(&sched_domains_mutex);
> > +	sched_domains_mutex_lock();
> >   	sched_init_domains(cpu_active_mask);
> > -	mutex_unlock(&sched_domains_mutex);
> > +	sched_domains_mutex_unlock();
> >   	/* Move init over to a non-isolated CPU */
> >   	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_DOMAIN)) < 0)
> > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > index ef047add7f9e..a0893a483d35 100644
> > --- a/kernel/sched/debug.c
> > +++ b/kernel/sched/debug.c
> > @@ -292,7 +292,7 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
> >   	bool orig;
> >   	cpus_read_lock();
> > -	mutex_lock(&sched_domains_mutex);
> > +	sched_domains_mutex_lock();
> >   	orig = sched_debug_verbose;
> >   	result = debugfs_write_file_bool(filp, ubuf, cnt, ppos);
> > @@ -304,7 +304,7 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
> >   		sd_dentry = NULL;
> >   	}
> > -	mutex_unlock(&sched_domains_mutex);
> > +	sched_domains_mutex_unlock();
> >   	cpus_read_unlock();
> >   	return result;
> > @@ -515,9 +515,9 @@ static __init int sched_init_debug(void)
> >   	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
> >   	debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_migrate);
> > -	mutex_lock(&sched_domains_mutex);
> > +	sched_domains_mutex_lock();
> >   	update_sched_domain_debugfs();
> > -	mutex_unlock(&sched_domains_mutex);
> > +	sched_domains_mutex_unlock();
> >   #endif
> >   #ifdef CONFIG_NUMA_BALANCING
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index c49aea8c1025..e2b879ec9458 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -6,6 +6,19 @@
> >   #include <linux/bsearch.h>
> >   DEFINE_MUTEX(sched_domains_mutex);
> > +#ifdef CONFIG_SMP
> > +void sched_domains_mutex_lock(void)
> > +{
> > +	mutex_lock(&sched_domains_mutex);
> > +}
> > +void sched_domains_mutex_unlock(void)
> > +{
> > +	mutex_unlock(&sched_domains_mutex);
> > +}
> > +#else
> > +void sched_domains_mutex_lock(void) { }
> > +void sched_domains_mutex_unlock(void) { }
> > +#endif
> >   /* Protected by sched_domains_mutex: */
> >   static cpumask_var_t sched_domains_tmpmask;
> > @@ -2791,7 +2804,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
> >   void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> >   			     struct sched_domain_attr *dattr_new)
> >   {
> > -	mutex_lock(&sched_domains_mutex);
> > +	sched_domains_mutex_lock();
> >   	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> > -	mutex_unlock(&sched_domains_mutex);
> > +	sched_domains_mutex_unlock();
> >   }
> 
> There are two "lockdep_assert_held(&sched_domains_mutex);" statements in
> topology.c file and one in cpuset.c. That can be problematic in the non-SMP
> case. Maybe another wrapper to do the assert?

Yes, makes sense. Will modify as you suggest here and above.

Best,
Juri


