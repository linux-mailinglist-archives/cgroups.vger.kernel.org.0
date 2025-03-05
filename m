Return-Path: <cgroups+bounces-6839-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2C9A4FCD3
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 11:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104BD188A3AC
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 10:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4E121507C;
	Wed,  5 Mar 2025 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H07Pd9Et"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53D720D508
	for <cgroups@vger.kernel.org>; Wed,  5 Mar 2025 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171980; cv=none; b=B/RvuVjxiLNuMKqgGkOQk1bf3zakrvYcWTy3R3Xg1uG3spsPSXLDWYe6HxJkxkG/jZLlfs1qloT44u0HLg9UbutjOB+3KPfypnZx5xSV2f3tuG6A1IaNrmXivLTCR70awR58+tBtCv9m0jnuNgsKrP8Hg7COU6P3FEeb7dqpXlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171980; c=relaxed/simple;
	bh=nk+KkRYXUjtSGWWIcw2HfvCEMC1Z4n55lXhVtQL8h9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlVmyHRzot+VTR7GL0xCjr2/rTw3oy/WKNus0n4rQd8DvYFZdh8rWnb4OPcJpVd5YOzhCSMBFykoDDU/LesQuyKOF1+XwPS1d1UI4S1nItYhHjYsFC9+DxXNquKVb1w6rd5r1Gf9ILPCPeR0ta5e7AGieVFpJHvrKt4tEFxBu1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H07Pd9Et; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741171977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78UcZquxL+SEJoDfw96YhTrJfkNqg4zF+abkQ0siliY=;
	b=H07Pd9Et7WFMrgYgxH/pTppTExUgrXKgXjtvFZm5UKhyOv8f59SiBEFNk6P4eAw7pYY0//
	f+hZt2QuTv2PgyRPRWoy1yVx4++JE++XhNSaxo2lFgY8CE9iGdRrEaeYVzZHdosS3hVE46
	UoPWZZfZqXvdAqxqxL05F5dPEw07VKw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-RV2c_GpOMbCtAJ8Fp1RuRg-1; Wed, 05 Mar 2025 05:52:46 -0500
X-MC-Unique: RV2c_GpOMbCtAJ8Fp1RuRg-1
X-Mimecast-MFC-AGG-ID: RV2c_GpOMbCtAJ8Fp1RuRg_1741171965
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394c489babso35747095e9.1
        for <cgroups@vger.kernel.org>; Wed, 05 Mar 2025 02:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741171965; x=1741776765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78UcZquxL+SEJoDfw96YhTrJfkNqg4zF+abkQ0siliY=;
        b=KUdQyanBEKNANlDvj0SN14P1/MtX5cCdqPn6L1zbSx+CPuhWwnXwKfMlcFNnl7f8LY
         nQXxUixJITZ8ZcRm/5fd6Gce+eRNsTFiv/eGvEca5aoGjCb0DS1icPqSDYSL9cQnCLXy
         X/l0tAtBD6f5f88LbKkoC3wUGRJxK2tcWm7Yb0ghtRH6KRAKBVL57tLAQxg7spLUkrSw
         pNUHuu/aKmkRynUEbLXvOvQlIRdF2BHotSshs/U3SpmRTaNcnNZQlyKZ1ySM3JoJq8g3
         ywshXMq/6bXd1aebdBdTQHQ6B23Pd3eWPuC4tmm7X7MkpYQK1qf0Bm6d+H/HcIqGijt1
         O8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVE2zm3jGLFo9YsBKsYT6ABabCSt6tf4YjmP9xBO/QvdbB9neGu5a3UzBGPBJel8Iu9OMhUJDTW@vger.kernel.org
X-Gm-Message-State: AOJu0YxlWhm6jSZdH/q8buRhnXIcguLNNZgTn2tHaXaGOpbPAswOVr44
	Q3S+/E6PfkHFmEKAyU30wIkAkkRL2nFHhZrGBL4GITu7/xyBnXrglGFWeGPgvFT6KCB+g2eppdY
	gClLNBF2chisfm8oYxBQM2eKuX9WlXlOHlba9TI+VlhxOdrZnOv955to=
X-Gm-Gg: ASbGncviwfaqy1Dv71Btyh6nvwgUllv8XygozNxOonPPu/exV4MjJZK3lj883yihu1q
	68j8aSP0xhRWPn6wnJETIQxNYA4duln3+Lz3qu9vHGhlnh+7Bf0C5kp/v9b1ukMrvCY+qQxdlLu
	Kn5gVdiuzXCNV60pFxtvTK/uEJ04+gk2v8MK9nII3VVAAOzcMyjYZvd3Lt1kcVuSKHgNkIc/r1s
	tv1rTBvPqeH2wTeA1mlM6mvQtHc1j6T6aG/9//xg/SjMCCJyfqzsW0DBraQidDtxd2LhQU9beDg
	Jq/LjtwhfUVLbt98LvzXnQDg4hf6XoMrK6BIEaeVnR+LG4DTzsPJsTtHikJAsgGv5b2n6CT2sDO
	owcmD
X-Received: by 2002:a05:600c:5117:b0:439:a6db:1824 with SMTP id 5b1f17b1804b1-43bd29d6c7fmr21882565e9.16.1741171965007;
        Wed, 05 Mar 2025 02:52:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF19cuSbrSvv6USTbmde98zlhhGMHtMbRetjnXV558FvTHe9XzYEm48iwA5rlldmCxfdsnJNg==
X-Received: by 2002:a05:600c:5117:b0:439:a6db:1824 with SMTP id 5b1f17b1804b1-43bd29d6c7fmr21882415e9.16.1741171964658;
        Wed, 05 Mar 2025 02:52:44 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd429370esm13721195e9.14.2025.03.05.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:52:44 -0800 (PST)
Date: Wed, 5 Mar 2025 10:52:41 +0000
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
Message-ID: <Z8gs-but1oFcwEn0@jlelli-thinkpadt14gen4.remote.csb>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <20250304084045.62554-3-juri.lelli@redhat.com>
 <c02dd563-7cfc-404d-80d1-cec934117caf@redhat.com>
 <0abc29ee-df9c-4c00-a7f9-d55ab5dd90c4@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0abc29ee-df9c-4c00-a7f9-d55ab5dd90c4@redhat.com>

On 04/03/25 11:01, Waiman Long wrote:
> On 3/4/25 10:05 AM, Waiman Long wrote:
> > > --- a/kernel/sched/topology.c
> > > +++ b/kernel/sched/topology.c
> > > @@ -6,6 +6,19 @@
> > >   #include <linux/bsearch.h>
> > >     DEFINE_MUTEX(sched_domains_mutex);
> > > +#ifdef CONFIG_SMP
> > > +void sched_domains_mutex_lock(void)
> > > +{
> > > +    mutex_lock(&sched_domains_mutex);
> > > +}
> > > +void sched_domains_mutex_unlock(void)
> > > +{
> > > +    mutex_unlock(&sched_domains_mutex);
> > > +}
> > > +#else
> > > +void sched_domains_mutex_lock(void) { }
> > > +void sched_domains_mutex_unlock(void) { }
> > > +#endif
> > >     /* Protected by sched_domains_mutex: */
> > >   static cpumask_var_t sched_domains_tmpmask;
> > > @@ -2791,7 +2804,7 @@ void partition_sched_domains_locked(int
> > > ndoms_new, cpumask_var_t doms_new[],
> > >   void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> > >                    struct sched_domain_attr *dattr_new)
> > >   {
> > > -    mutex_lock(&sched_domains_mutex);
> > > +    sched_domains_mutex_lock();
> > >       partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> > > -    mutex_unlock(&sched_domains_mutex);
> > > +    sched_domains_mutex_unlock();
> > >   }
> > 
> > There are two "lockdep_assert_held(&sched_domains_mutex);" statements in
> > topology.c file and one in cpuset.c. That can be problematic in the
> > non-SMP case. Maybe another wrapper to do the assert?
> 
> Ignore that as both topology.c and cpuset.c will only be compiled if
> CONFIG_SMP is defined. IOW, you don't need the the "#ifdef CONFIG_SMP"
> above.

Indeed!

Thanks,
Juri


