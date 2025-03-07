Return-Path: <cgroups+bounces-6896-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AF2A56CE0
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 17:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BB518844DC
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 16:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E1522154D;
	Fri,  7 Mar 2025 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkwWbOWS"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3592B2206A8
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363184; cv=none; b=llaYRdjol00CuHOTZn1ENsx81ee6OTUgeOGx+Qxy3HnGJ30jtuud5rdnkg9P/1SeoUtyiSM1v2qKFEOmmCeKJkugmtFfRyg+n5bI0HCGiAh1PKcqBvxye3K0jUEUWs/ARYFn8mfDvRuou7rbGiUQYXRZuPNLptPofrifCBdJxI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363184; c=relaxed/simple;
	bh=xYH7LSHm5j/GWwqF2OYbRbZazYDy7WN0+uBsOZUgbug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ql2xs5HnkRGNivYT298SewLf5bCr2Gqz2Z7Nc8gKV244vAtDcwFudqbs7uCKRFZCQuB0HYtivUBaC1Yr63znKdX03tRvlL+PzhA1L98YAOhPFg3UXIwi51Mer/cB0E6Gr5+ZvaDrzbkt2pL4DWS4ZfMKn62GFO37d6LxYntj7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkwWbOWS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741363182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPYw1VLtMSRwN0ZfuUC08MZa+lggggv7LW9ZP7kVzVw=;
	b=FkwWbOWSdIC/+9uDluxTBXyQB/hOdYn6J9RE6qn7Xv5e44cLqa7REhlNt/g6r+7y9SwA+H
	KTjYFt2RCQG3Lo9GsCRCAoJI90+MUFc47UxobwkrMvQzHd9U53hJq2miIeisExcp2e6Lv6
	y7VR9JO90LPBiMJEoi352kljaS/gqcs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-rbPJ39B2O4OhadUeMErGug-1; Fri, 07 Mar 2025 10:59:40 -0500
X-MC-Unique: rbPJ39B2O4OhadUeMErGug-1
X-Mimecast-MFC-AGG-ID: rbPJ39B2O4OhadUeMErGug_1741363179
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c3b53373f7so522273285a.0
        for <cgroups@vger.kernel.org>; Fri, 07 Mar 2025 07:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363179; x=1741967979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPYw1VLtMSRwN0ZfuUC08MZa+lggggv7LW9ZP7kVzVw=;
        b=eFlNl4zwdNkKzK7RjY7x1zIJIS6W/xrCCCEqVZKqkmGVZQvIruPB3yOYZVchHsBn0a
         DM8/UcL/rroQMbHrmX2wNZX2A0vMhQTFXcCFs5IuOMgItu3YeKJMYvm+H3oHM3haopkQ
         40pRm3HqOpWROS8vGRAEFJPVEYpOpdnMZje9Ys+ZE7ys2gtjHkmOvdUGJkgGemFWGPaZ
         jhsAWJgsf9s2A7Igc9gIx62/xJBBEES0YopA7+cjir0q7f1gZpcKNoAYAdv1LrL1aNNI
         s6/yU2vx9QeWGw1suJjlm/OwnhQpm8+wmySsxbJU+eSp/m7CmQuRocIn55Zj/eicD2aS
         jlEg==
X-Forwarded-Encrypted: i=1; AJvYcCUDA3mXushVNNaWFP585yXhnfLpSx9+GEyVcZxKB3eu9FZHlfqJL+QYwkVLjv98j85P2Qcz95Jm@vger.kernel.org
X-Gm-Message-State: AOJu0YxRQWvFkkl8yRN2qI+cKSXsdXqwJrVZ/t3nsVYiWKFI4EBQlIej
	4XgaThFUKPW2icqXMMzB53R5TtkjNYGX7fDvcZM6qJfYdVmGV/mMUZj6DE4t1H85XAGrekLdjwR
	5AbwAHqoWlz1GghUzKSBQLPwr22XiIPpOG/IH0tLgd53FtXiD4JGMepoewxfgBZC6d31T
X-Gm-Gg: ASbGncujVldrV8HGGncx5JAhm2etdHMXL3ZBubM5MK1tCBCTNYBNQWSnLUsFzxD0qzU
	A/rFHLiRnA+cHX6NrXAC8XaI1hSduuubGrT2lhmaiyogMAddD/aVqVF/mtgixX2MGZWVd6IflJ7
	rAnxihrZQKu74XUTFh9dGJ58s2mBepNiRmf9kTY0aUJYYejy1dh+yaNM6VTAyFnvtbxat7iJ7WQ
	mF+ZuIH2zj0KTO2U4V9BP9LPLtdyIsyQp26bfnTwFBVe46RtTuTO/j5AQcaa2WtcfpSoU+c/hdZ
	oZC1EBirn5fyABHRMYcl1Lk5+GTqVMz3Boy4+Od6Z/73k2sMt2QqAS5Oypi4xBAmgGWXQDbj5RZ
	31gVQ
X-Received: by 2002:a05:620a:2b9c:b0:7c3:d63d:7bd4 with SMTP id af79cd13be357-7c4e61ceb21mr580447385a.42.1741363178890;
        Fri, 07 Mar 2025 07:59:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA/ZRjB9AnIN+nmv5qbFdyJU6rV6EVsRMlJ4pB99IV3rAk4IoB3xl6XoOHWtExb+XmkOBr8g==
X-Received: by 2002:a05:620a:2b9c:b0:7c3:d63d:7bd4 with SMTP id af79cd13be357-7c4e61ceb21mr580443585a.42.1741363178480;
        Fri, 07 Mar 2025 07:59:38 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5511328sm257409685a.105.2025.03.07.07.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:59:37 -0800 (PST)
Date: Fri, 7 Mar 2025 15:59:33 +0000
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
Message-ID: <Z8sX5VtKuBD1BoiB@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-3-juri.lelli@redhat.com>
 <eafef3d6-c5ce-435e-850c-60f780500b2e@redhat.com>
 <4c63551b-4272-45f3-bb6b-626dd7ba10f9@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c63551b-4272-45f3-bb6b-626dd7ba10f9@redhat.com>

On 07/03/25 10:19, Waiman Long wrote:
> 
> On 3/7/25 10:11 AM, Waiman Long wrote:
> > On 3/6/25 9:10 AM, Juri Lelli wrote:
> > > Create wrappers for sched_domains_mutex so that it can transparently be
> > > used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
> > > do.
> > > 
> > > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > > Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow
> > > earlier for hotplug")
> > > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > > ---
> > > v1 -> v2: Remove wrappers for the !SMP case as all users are not defined
> > >            either in that case
> > > ---
> > >   include/linux/sched.h   |  2 ++
> > >   kernel/cgroup/cpuset.c  |  4 ++--
> > >   kernel/sched/core.c     |  4 ++--
> > >   kernel/sched/debug.c    |  8 ++++----
> > >   kernel/sched/topology.c | 12 ++++++++++--
> > >   5 files changed, 20 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 9632e3318e0d..d5f8c161d852 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -383,6 +383,8 @@ enum uclamp_id {
> > >   extern struct root_domain def_root_domain;
> > >   extern struct mutex sched_domains_mutex;
> > >   #endif
> > > +extern void sched_domains_mutex_lock(void);
> > > +extern void sched_domains_mutex_unlock(void);
> > 
> > As discussed in the other thread, move the
> > sched_domains_mutex_{lock/unlock}{} inside the "#if CONFIG_SMP" block
> > and define the else part so that it can be used in code block that will
> > also be compiled in the !CONFIG_SMP case.
> > 
> > Other than that, the rest looks good to me.
> 
> Actually, you can also remove sched_domains_mutex from the header and make
> it static as it is no longer directly accessed.

Apart from a lockdep_assert_held() in cpuset.c, no? Guess I can create a
wrapper for that, but is it really better?

Thanks,
Juri


