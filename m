Return-Path: <cgroups+bounces-6891-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A44EA56BAB
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 16:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FAB179ABE
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4F6221715;
	Fri,  7 Mar 2025 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CO+ayTAF"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49925221DBA
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360563; cv=none; b=TdRfzMe8XmvTG491FdST3+IkHJLvnj+PITZ4ZQr0P09IyrE+ZLqUkTuFdESq1DLg4qBS8raUgfC22RRH3OsjbAlRrKGfflxsoBQ3P9jtSXsJHGBvmaKKCt/TfMUZ1Hs2V+IWR+fQM2kKl5DPda9cDCOhgNG/NQQGBTwymBx0uA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360563; c=relaxed/simple;
	bh=c3CH7TGyw7ayKW/y+JIiPgELaX0LllMUxZuFzWkEm4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTpwP/l+qg9DKlFM6fqXPnykkLphT/EMH4jHZ60kS0IOA79AZldAeFhFt6Xp7+YqFmox0/tCQlSJhbEFN9AW9jK4EJFQgnAOSi1R12uWeSMEbkNO5qHKWB7r/77ysjEepkaeOGWV2wtDFMU2h2o6qzxpu6U/fcMUPTzgr9mK8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CO+ayTAF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741360561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qph6zf+ID+ly6xmuaXbG620k26a/5kfcTY2Rgld0WAE=;
	b=CO+ayTAFciPdfQ7GQX5U0tOlZPsE8hhM3131kGeXGug4Is5aioJBr7WWkrV84qNo1dxF3R
	lkVqbh+8b8ifpuDccUaVl/3lD4Q34mHNTZMjpca2t1FK4IWH6KIwCQaz8putz7qJHFMgq4
	oD0/+bcNPRqbTa65qk6RbtWRHxHdQ3A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-CPrN4o2cMKiDmcGrXMAuVg-1; Fri, 07 Mar 2025 10:15:59 -0500
X-MC-Unique: CPrN4o2cMKiDmcGrXMAuVg-1
X-Mimecast-MFC-AGG-ID: CPrN4o2cMKiDmcGrXMAuVg_1741360559
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912aab7a36so808564f8f.0
        for <cgroups@vger.kernel.org>; Fri, 07 Mar 2025 07:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360559; x=1741965359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qph6zf+ID+ly6xmuaXbG620k26a/5kfcTY2Rgld0WAE=;
        b=cfX2A8Or8N3vH5qOdVTpNQ7O/AOwETYn+FLlMsEkiK6LAZ8neIl5Dlb2ggCrvET88N
         fijQ/18RQlAyR9c9HfnyCeyVegUeeR9o70Ddb9KuHVDxZoe/vuVrRkeYT/SrvxbJH8Bh
         O9vK1ekYsNKNXXYtlJzBBJg+v7N8392WKVakcLIN61Xzpf8H5eSFZR4rM6dmtr0HNzsj
         lBZvALBPSRO7uPHbk5zAf5yuFn5avuB4dud/AK+h5zqfkyz+aNAPnbO2azcu+u2vzTtI
         hZL9g6S6MTEY3ukyJ0DEUu4hzzsHpDAxLA50iESAFYlhhr+91mkeXhDVgZbGIQAsGYsM
         bqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1f00Qu+Bf/MJVzUeOw0x7N6vfySU67fCZM9CokIo8f1wl7RZ8D/MSs1y/RMo2M9PttS2wRHDQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwexgMhD7eZPzK0rqkyb+oY2fRUBsB97T2X0iLvF3+ByshmVtz1
	fBwRi33DAc4YQKUdKN1I+4PsMEpfTESYul1YXgJIcEX4hiHHLkl8a3rSI9CdNGgrG24DQG+0xNI
	ULuWBVNzDQGDDtDjYRaWJLyvYTNFAMa6x1TAHXDXuQzW1ikKqPKVEQbw=
X-Gm-Gg: ASbGncsAg0ytob1Zq2H1l/H0mkSbUS9wEOCb6v1uwJqEbcvL3wzal/dz7CzEn/TyC2i
	5V0/kbO8TPAchKpfFQjF3vJQO8xeuwO8KN3BC9Hp1iKhr0UHw//+IuZATRfOrKnUsAt7Hxf8dNU
	xiK9tYyagfXo70wbIhhlPOkbjY2Ys1HzpVsTHs0ubgQppeLx7P/yqT8Egp1O79Xr5rvEKXg/MZ9
	VZu2Gu7UYUBqwBsb6yF5PwkAlIbOkdkiWf3iegf/COezelWDECZORG3DB7TuEt9DSymQoW1GiY/
	rk3VKuccrRP4aPd40x7XmU+DYKAfi2HAgDJs46ZdkAY8X/vZtBXLo1Lf7AIW0IgflV2Gj8nt6On
	M45q7
X-Received: by 2002:a05:6000:1a8e:b0:390:eacd:7009 with SMTP id ffacd0b85a97d-39132da110fmr2004183f8f.42.1741360558638;
        Fri, 07 Mar 2025 07:15:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1tTVUb8fhqvR/i8Dhv36ZU++qT8Rx+xYofykOLwza7hYP0SmxRFCS3D/ymSQcV7dlgT+jiQ==
X-Received: by 2002:a05:6000:1a8e:b0:390:eacd:7009 with SMTP id ffacd0b85a97d-39132da110fmr2004126f8f.42.1741360557941;
        Fri, 07 Mar 2025 07:15:57 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd948cd0sm52773135e9.38.2025.03.07.07.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:15:56 -0800 (PST)
Date: Fri, 7 Mar 2025 15:15:55 +0000
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
Subject: Re: [PATCH v2 2/8] sched/topology: Wrappers for sched_domains_mutex
Message-ID: <Z8sNq6gSuz_PrInW@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-3-juri.lelli@redhat.com>
 <eafef3d6-c5ce-435e-850c-60f780500b2e@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eafef3d6-c5ce-435e-850c-60f780500b2e@redhat.com>

On 07/03/25 10:11, Waiman Long wrote:
> On 3/6/25 9:10 AM, Juri Lelli wrote:
> > Create wrappers for sched_domains_mutex so that it can transparently be
> > used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
> > do.
> > 
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > ---
> > v1 -> v2: Remove wrappers for the !SMP case as all users are not defined
> >            either in that case
> > ---
> >   include/linux/sched.h   |  2 ++
> >   kernel/cgroup/cpuset.c  |  4 ++--
> >   kernel/sched/core.c     |  4 ++--
> >   kernel/sched/debug.c    |  8 ++++----
> >   kernel/sched/topology.c | 12 ++++++++++--
> >   5 files changed, 20 insertions(+), 10 deletions(-)
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
> As discussed in the other thread, move the
> sched_domains_mutex_{lock/unlock}{} inside the "#if CONFIG_SMP" block and
> define the else part so that it can be used in code block that will also be
> compiled in the !CONFIG_SMP case.

Ack. 

> Other than that, the rest looks good to me.

Thanks! I will be sending out a v3 early next week (waiting a few more
hours in case anyone spots something else that needs rework).

Best,
Juri


