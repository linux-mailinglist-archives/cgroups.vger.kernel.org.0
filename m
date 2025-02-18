Return-Path: <cgroups+bounces-6589-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1203CA39E93
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 15:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFC21897256
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 14:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8F32500CD;
	Tue, 18 Feb 2025 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRXlK96h"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3131267F4C
	for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888327; cv=none; b=uDzHK5XGgnw7HFHhesgOOIbQ0aWlrrYY7BCkiIsdhz0m89/gxOqDKuYMJaNyZhlZhEbvRUZUC/uu7Yt2Wm7wCKQKx8Ad3pI0UeNrnXP613FntDAEg8ZQmkoeV5PJD3Hs6Sm+2qB7kALmr8EukPCoVMIT1T7ii+VEqmH151zPGOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888327; c=relaxed/simple;
	bh=Ylh6BzLP55i04wVfiFq0UdGu/ctOqdofDLlmv68+FsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgTrphHSJAnf2s3rFsczQMuhUDJescQj9t7u2Hpfuae2rZUEoNwOeKhIcS+hk5FEslgGoGyBQMzo2HU0mDU3Eq6kTY8WaiXcErGcozWkWzCwuGLzg1zWsWJqFcijgrATa7PWs+4R8AD/BOFE2i33jCEyLDo9zrshX1Ul3kCM4Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRXlK96h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739888324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DBhsPO91wIOuIx7V5POaYr34tBMgM6YIQ+GqBqORH08=;
	b=bRXlK96hUDR5bzmcPbOPpjiXxn2RIpXJlb7bM/p0Aw9YMVXB5V7wKn2n7KRKLLyp7INYLY
	dLpBojmaqZ6GdarV6hRZRp0DqixPpddOWnv5vUkc7SSFfurS4uPzPiVOWTI+qY2IA/U1OQ
	6lRdEjDAmB1rWZbJI3caa+lXYHaBzd4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-TiF4wKIKOCmldA4QnKtepw-1; Tue, 18 Feb 2025 09:18:43 -0500
X-MC-Unique: TiF4wKIKOCmldA4QnKtepw-1
X-Mimecast-MFC-AGG-ID: TiF4wKIKOCmldA4QnKtepw_1739888322
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43942e82719so48519585e9.2
        for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 06:18:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739888322; x=1740493122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBhsPO91wIOuIx7V5POaYr34tBMgM6YIQ+GqBqORH08=;
        b=oTKbciiXHnpAbjDR6KG/9jIrvdDju9KB40wVBWCP2aHAYTV44eZ7jVfZ4JzBSiAvzX
         fSe7GWt9QwuN/OmcCJlbxI0bQINeesOC4MCWD/qmJZSnyQQRx9G/iYtENu+2WVU0Gms0
         spNAp1Av2rZVHgebuOuo7iKgmyQYYAflOeJNnwOJWjdFpZu3nuWvdFECwM6OdUSaBNY9
         X90/QaufOFUMW7prl+Knvl5wRvScKDNvXO9uGUGf5rrtBwArQJHYtpwdte2/BrNwxZ0i
         Yh0d9fu/6zINZTFxcczlMkClNIBHdAd1cStxzx7gbpAkr7yAa4oO6RZ67o4ozDpjfbn3
         2+QA==
X-Forwarded-Encrypted: i=1; AJvYcCWDG0AsqEvXvr7wnfhvv7nz4DBqQo6yIC1yDVOefofwD+IciRslOSvr3585IcYuUvNuwsywlzmb@vger.kernel.org
X-Gm-Message-State: AOJu0YwFoKQsdSRlISzUfNLVttAzNVJkYKYKHfvdEOalI++PvK2RzVPC
	Q1iSKrdsnXLLrwbEHmGFgknMijvJgXLwdQqTixSTeJzCrY2JPZYpwkQoR4SXOqw8CWzP1wuYRl1
	L0kOx1wKKhfmNiu6UxnkiaV5NlWgmkhlAiqS1W/pdYPv4ExDdUPEuBpQ=
X-Gm-Gg: ASbGncvokcMUIGIMSdiDj6jM98X0zUw1FcajQf5OAu3v2/Rs1zsqVCnYFG9a9bq5Wht
	eS66mKp0DMLyCOP4Xd8EIvznVWvsmAP3WJQOjF09azf4HQ+ZmbrE9lS9teN7kfSPUywJYHeisMd
	1IF0bz9iisWwi6wXLZpiz1tVLto0o8IZ72j6N4jFjl6p92QgXu6hyl9yTOgp9RLRjGAGavNnwID
	xKACoYTGv21jjoCDq/r6fw+Nc2G7Ev8QrCtpsGACj1i3ltY5qScBaJ92BwJu+mQmQ2/eYlb5EcB
	S1N4SaDCqWCb6biskZyF2Uc8NDn/oxkdGg==
X-Received: by 2002:a05:600c:4f03:b0:438:a240:c63 with SMTP id 5b1f17b1804b1-4396e6978f1mr108096785e9.2.1739888321824;
        Tue, 18 Feb 2025 06:18:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHz+8srgi2drXTmMyM1NYHrwhlKtyRHpPGxtjZL4L3zCFR0eLaPU7DhmwvLMH2MoF6LIUl/tw==
X-Received: by 2002:a05:600c:4f03:b0:438:a240:c63 with SMTP id 5b1f17b1804b1-4396e6978f1mr108096425e9.2.1739888321363;
        Tue, 18 Feb 2025 06:18:41 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b8471sm185070475e9.37.2025.02.18.06.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:18:40 -0800 (PST)
Date: Tue, 18 Feb 2025 15:18:38 +0100
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
Message-ID: <Z7SWvr86RXlBbJlw@jlelli-thinkpadt14gen4.remote.csb>
References: <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <78f627fe-dd1e-4816-bbf3-58137fdceda6@nvidia.com>
 <Z62ONLX4OLisCLKw@jlelli-thinkpadt14gen4.remote.csb>
 <30a8cda5-0fd0-4e47-bafe-5deefc561f0c@nvidia.com>
 <151884eb-ad6d-458e-a325-92cbe5b8b33f@nvidia.com>
 <Z7Ne49MSXS2I06jW@jlelli-thinkpadt14gen4.remote.csb>
 <Z7RZ4141H-FnoQPW@jlelli-thinkpadt14gen4.remote.csb>
 <d7cc3a3c-155e-4872-a426-cbd239d79cac@arm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7cc3a3c-155e-4872-a426-cbd239d79cac@arm.com>

On 18/02/25 15:12, Dietmar Eggemann wrote:
> On 18/02/2025 10:58, Juri Lelli wrote:
> > Hi!
> > 
> > On 17/02/25 17:08, Juri Lelli wrote:
> >> On 14/02/25 10:05, Jon Hunter wrote:
> > 
> > ...
> > 
> >> At this point I believe you triggered suspend.
> >>
> >>> [   57.290150] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> >>> [   57.335619] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
> >>> [   57.353364] dwc-eth-dwmac 2490000.ethernet eth0: Link is Down
> >>> [   57.397022] Disabling non-boot CPUs ...
> >>
> >> Offlining CPU5.
> >>
> >>> [   57.400904] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4 type=DYN span=0,3-5
> >>> [   57.400949] CPU0 attaching NULL sched-domain.
> >>> [   57.415298] span=1-2
> >>> [   57.417483] __dl_sub: cpus=3 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
> >>> [   57.417487] __dl_server_detach_root: cpu=0 rd_span=0,3-5 total_bw=157284
> >>> [   57.417496] rq_attach_root: cpu=0 old_span=NULL new_span=1-2
> >>> [   57.417501] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DEF
> >>> [   57.417504] __dl_server_attach_root: cpu=0 rd_span=0-2 total_bw=157284
> >>> [   57.417507] CPU3 attaching NULL sched-domain.
> >>> [   57.454804] span=0-2
> >>> [   57.456987] __dl_sub: cpus=2 tsk_bw=52428 total_bw=104856 span=3-5 type=DYN
> >>> [   57.456990] __dl_server_detach_root: cpu=3 rd_span=3-5 total_bw=104856
> >>> [   57.456998] rq_attach_root: cpu=3 old_span=NULL new_span=0-2
> >>> [   57.457000] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0-3 type=DEF
> >>> [   57.457003] __dl_server_attach_root: cpu=3 rd_span=0-3 total_bw=209712
> >>> [   57.457006] CPU4 attaching NULL sched-domain.
> >>> [   57.493964] span=0-3
> >>> [   57.496152] __dl_sub: cpus=1 tsk_bw=52428 total_bw=52428 span=4-5 type=DYN
> >>> [   57.496156] __dl_server_detach_root: cpu=4 rd_span=4-5 total_bw=52428
> >>> [   57.496162] rq_attach_root: cpu=4 old_span=NULL new_span=0-3
> >>> [   57.496165] __dl_add: cpus=5 tsk_bw=52428 total_bw=262140 span=0-4 type=DEF
> >>> [   57.496168] __dl_server_attach_root: cpu=4 rd_span=0-4 total_bw=262140
> >>> [   57.496171] CPU5 attaching NULL sched-domain.
> >>> [   57.532952] span=0-4
> >>> [   57.535143] rq_attach_root: cpu=5 old_span= new_span=0-4
> >>> [   57.535147] __dl_add: cpus=5 tsk_bw=52428 total_bw=314568 span=0-5 type=DEF
> >>
> >> Maybe we shouldn't add the dl_server contribution of a CPU that is going
> >> to be offline.
> > 
> > I tried to implement this idea and ended up with the following. As usual
> > also pushed it to the branch on github. Could you please update and
> > re-test?
> > 
> > Another thing that I noticed is that in my case an hotplug operation
> > generating a sched/root domain rebuild ends up calling dl_rebuild_
> > rd_accounting() (from partition_and_rebuild_sched_domains()) which
> > resets accounting for def and dyn domains. In your case (looking again
> > at the last dmesg you shared) I don't see this call, so I wonder if for
> > some reason related to your setup we do the rebuild by calling partition_
> > sched_domains() (instead of partition_and_rebuild_) and this doesn't
> > call dl_rebuild_rd_accounting() after partition_sched_domains_locked() -
> > maybe it should? Dietmar, Christian, Peter, what do you think?
> 
> Yeah, looks like suspend/resume behaves differently compared to CPU hotplug.
> 
> On my Juno [L b b L L L]
>                 ^^^
>                 isolcpus=[2,3]
> 
> # ps2 | grep DLN
>    98    98 S 140      0   - DLN sugov:0
>    99    99 S 140      0   - DLN sugov:1
> 
> # taskset -p 98; taskset -p 99
> pid 98's current affinity mask: 39
> pid 99's current affinity mask: 6
> 
> 
> [   87.679282] partition_sched_domains() called
> ...
> [   87.684013] partition_sched_domains() called
> ...
> [   87.687961] partition_sched_domains() called
> ...
> [   87.689419] psci: CPU3 killed (polled 0 ms)
> [   87.689715] __dl_bw_capacity() mask=2-5 cap=1024
> [   87.689739] dl_bw_cpus() cpu=6 rd->span=2-5 cpu_active_mask=0-2 cpus=1
> [   87.689757] dl_bw_manage: cpu=2 cap=0 fair_server_bw=52428
> total_bw=209712 dl_bw_cpus=1 type=DEF span=2-5
> [   87.689775] dl_bw_cpus() cpu=6 rd->span=2-5 cpu_active_mask=0-2 cpus=1
> [   87.689789] dl_bw_manage() cpu=2 cap=0 overflow=1 return=-16
> [   87.689864] Error taking CPU2 down: -16                       <-- !!!
> ...
> [   87.690674] partition_sched_domains() called
> ...
> [   87.691496] partition_sched_domains() called
> ...
> [   87.693702] partition_sched_domains() called
> ...
> [   87.695819] partition_and_rebuild_sched_domains() called
> 

Ah, OK. Did you try with my last proposed change?


