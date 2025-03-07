Return-Path: <cgroups+bounces-6885-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE490A56409
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 10:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34E2188FBED
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 09:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56839215066;
	Fri,  7 Mar 2025 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7BNYTep"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64238214A93
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339937; cv=none; b=NftVIUCnYpXoLC8v/cwaknU89LuE+mj6xfGl7Cu/ANdhF0CAFrVx1Prx+kcBhKFyYfDlcIKVs1X5Ex7LtccyXVUh57dMvrRVcndpUjtgjiXOwqDqzQdNqC8IUrEUX+CXQtaj/e82gfE3PZF7l35uV78W16zCfElxGFIj29wICqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339937; c=relaxed/simple;
	bh=ZN91VVIiE49rxzpSN14jkta0VDEUkNiiJiOjKTsR1UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByJVnGWwR8GKoNmx0Jx5dC31V2T8LjqRYAohqi3GcvxA4ZaPThUlgexy7Nj1mD1rVwWOow+roQ3sRoDliczM6K9LKXsWY1dP98BvpFAuPGTWZf4EspsKVQsaAuxA3kxjrJ93rrp6TmgOtnQGn0rYdMuwCIvPVRg8qVMJF2d66b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7BNYTep; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741339933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1OGWeLhD/3SKHmtpXLwJR/pWSWE9QtQB2+RWYuvjzU=;
	b=L7BNYTeped/Ib59q1tMNhiFdo+xdWjf64V1fxoKjJcsz1inoSMht4wN9tdZloUcYmSNE3Q
	nsLV7OjMlgyETYEkTqNM3Vzhb3lNCzHHuPU9uImpYFbwzXXe5Wn4/Os8G3ix20Q7Nqwpkp
	O4dVSzWj2BUHRG11NfigdOVsHrYLte4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-lhO4-XTiMxSFBTcUMB2_OQ-1; Fri, 07 Mar 2025 04:32:12 -0500
X-MC-Unique: lhO4-XTiMxSFBTcUMB2_OQ-1
X-Mimecast-MFC-AGG-ID: lhO4-XTiMxSFBTcUMB2_OQ_1741339931
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4751dc2e881so18523961cf.1
        for <cgroups@vger.kernel.org>; Fri, 07 Mar 2025 01:32:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339930; x=1741944730;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1OGWeLhD/3SKHmtpXLwJR/pWSWE9QtQB2+RWYuvjzU=;
        b=ek1ojyVEksxpun0WLkcHzRkqx/hJtik7Whuutby4GgY1YjDbT2i1+CPHDP7uXpP7bn
         VyvssGoOmHUKzZA4sxm9V13wfXK5zJhBYh0tC+48uk1lkYtE8JcOxc1gykLOMXM/7WQl
         GyuJoa9wm0+vIl9CxdmzItbznvE3BH0ftKS+Mf+AvPTm952tDhIEgCnIBwHzo6tHSzEC
         ZhpbqQQTB6MaMmzgoQZwZjnhR1CsgxBHw6AQHKabf1ppfwow7RoCqkSs6RpSyOmwtIaM
         /c79t72CEvwz2AbEKaOKImb7sh3UOrOVVHm2URYLGlItlNoUp3hRYQi280jEjX5Ano/9
         mi1w==
X-Forwarded-Encrypted: i=1; AJvYcCXg7Vgs7kxfLxvfKKkZxjDimhxAxepZiN9GSWJmCt8stwnzI58GcEHD0lyST/4AYz9gnqk1Tf4L@vger.kernel.org
X-Gm-Message-State: AOJu0YxKiuax8m3C+DV9hbd9USZRqY0JtZvX2xLSqBAY/QdW/Q7mWQEb
	QWQCTWthDY4hfBF+ukNqVJMHG3Vn1wdEOG19cf0lWl9kJvbjtlNJDV4bqGTluU3mTrBI82x9aim
	28wCUilStAGWsyc9hNjWyu7r3XIF6RmGIP1uw2z5m/b37b8Dwn0Rqo5RM9ux4YJEgbs5W
X-Gm-Gg: ASbGncsMULMjmKoI0UCgi+Xn6wpEqhR3xHPBrdtoQNFGL3djh6mngIXSt8mGjr56cel
	I59SRj4W38HA5yWAWTHB3cxz/8ZVTtHSAUednhIXndZouDT8aUKHlvqQgdA3BA/uyk00wS+hUgS
	nmCO+1GPz19YuROlWiqNL+n0EwfGdFlz23wtH9LRpe/AVJfdjzeG269mSvNklDVAL4XC7eHvXOd
	ew02/iB5DU4SHk12HzoZVNJPpjj0+tGtxjyO2JPIUzooPPboh9IWt0LEUZ/XrmdiqBZh3cvzJM4
	7qBK9k5TO3POjxnbhRJYtTvFDTyVZlb2bh/CVLP4lgw3WE6xQbjBs2EB41aTR6HfD/QB/24xqms
	U4ijH
X-Received: by 2002:a05:622a:118e:b0:475:7c0:9390 with SMTP id d75a77b69052e-47618af3564mr29595701cf.48.1741339929905;
        Fri, 07 Mar 2025 01:32:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFerUMJmzuZeGRv0gplglLVFFk6MAamjLT9/4AYtJqbxasFWs3PcPJWi/IBIlpqfSSTNZ3vGQ==
X-Received: by 2002:a05:622a:118e:b0:475:7c0:9390 with SMTP id d75a77b69052e-47618af3564mr29595571cf.48.1741339929550;
        Fri, 07 Mar 2025 01:32:09 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751d96b568sm18673441cf.25.2025.03.07.01.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 01:32:08 -0800 (PST)
Date: Fri, 7 Mar 2025 09:32:03 +0000
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
Message-ID: <Z8q9E6j6cMX3jTi8@jlelli-thinkpadt14gen4.remote.csb>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <20250304084045.62554-3-juri.lelli@redhat.com>
 <c02dd563-7cfc-404d-80d1-cec934117caf@redhat.com>
 <0abc29ee-df9c-4c00-a7f9-d55ab5dd90c4@redhat.com>
 <Z8gs-but1oFcwEn0@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8gs-but1oFcwEn0@jlelli-thinkpadt14gen4.remote.csb>

On 05/03/25 10:52, Juri Lelli wrote:
> On 04/03/25 11:01, Waiman Long wrote:
> > On 3/4/25 10:05 AM, Waiman Long wrote:
> > > > --- a/kernel/sched/topology.c
> > > > +++ b/kernel/sched/topology.c
> > > > @@ -6,6 +6,19 @@
> > > >   #include <linux/bsearch.h>
> > > >     DEFINE_MUTEX(sched_domains_mutex);
> > > > +#ifdef CONFIG_SMP
> > > > +void sched_domains_mutex_lock(void)
> > > > +{
> > > > +    mutex_lock(&sched_domains_mutex);
> > > > +}
> > > > +void sched_domains_mutex_unlock(void)
> > > > +{
> > > > +    mutex_unlock(&sched_domains_mutex);
> > > > +}
> > > > +#else
> > > > +void sched_domains_mutex_lock(void) { }
> > > > +void sched_domains_mutex_unlock(void) { }
> > > > +#endif
> > > >     /* Protected by sched_domains_mutex: */
> > > >   static cpumask_var_t sched_domains_tmpmask;
> > > > @@ -2791,7 +2804,7 @@ void partition_sched_domains_locked(int
> > > > ndoms_new, cpumask_var_t doms_new[],
> > > >   void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> > > >                    struct sched_domain_attr *dattr_new)
> > > >   {
> > > > -    mutex_lock(&sched_domains_mutex);
> > > > +    sched_domains_mutex_lock();
> > > >       partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> > > > -    mutex_unlock(&sched_domains_mutex);
> > > > +    sched_domains_mutex_unlock();
> > > >   }
> > > 
> > > There are two "lockdep_assert_held(&sched_domains_mutex);" statements in
> > > topology.c file and one in cpuset.c. That can be problematic in the
> > > non-SMP case. Maybe another wrapper to do the assert?
> > 
> > Ignore that as both topology.c and cpuset.c will only be compiled if
> > CONFIG_SMP is defined. IOW, you don't need the the "#ifdef CONFIG_SMP"
> > above.
> 
> Indeed!

Ah, actually I believe next patch (3/5) introduce usage for the !SMP
case in sched_rt_handler()

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b8e33c615b1..8cebe71d2bb1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2910,6 +2910,7 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
        int ret;

        mutex_lock(&mutex);
+       sched_domains_mutex_lock();
        old_period = sysctl_sched_rt_period;
        old_runtime = sysctl_sched_rt_runtime;

@@ -2936,6 +2937,7 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
                sysctl_sched_rt_period = old_period;
                sysctl_sched_rt_runtime = old_runtime;
        }
+       sched_domains_mutex_unlock();
        mutex_unlock(&mutex);

        return ret;

So, I will need to add the ifdef back I guess (I removed it on v2). Do
you agree?

Thanks,
Juri


