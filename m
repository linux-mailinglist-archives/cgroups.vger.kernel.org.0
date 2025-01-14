Return-Path: <cgroups+bounces-6152-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 722CEA1105F
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 19:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E19166FC1
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 18:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908051FCCF2;
	Tue, 14 Jan 2025 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhLsueKz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AB01FC7C8;
	Tue, 14 Jan 2025 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736880151; cv=none; b=XHi9srVE20bSHK+Y5jzLsEQ/8z0cvnkZVZ+cmdyG5f///7GdjXfwixjWN7waX+XS7BdRFIBGcenTBBiBpyPFhLMmfEu6sH+WZ7b7pGpCrsQrWSDWTq6k0eUpyMQOsh8kGI0FiWn5YbWdGutUMSr3v2cn+K027y4MDsHdAjFVxJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736880151; c=relaxed/simple;
	bh=s5XHy7GS3WGeMJh5qpqB6ZPE3LuyXt5cAZB+qzn1hCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLzZGE5pJoLrUkhJSWFfvcnTRtcbR7Kd8qnN9TXD3/f4w9H2OG7K2TjeMT7YM4waatowixP3IQGG/IrwLQri/WAzjGGIuAxUHerDlvX3h1qAT9M89JZfj8MswtR8VSl9uh76B3cvWPMpKpPD7fgmxg7gyxW80MPalUVHu1O+PAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhLsueKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2AEC4CEE3;
	Tue, 14 Jan 2025 18:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736880150;
	bh=s5XHy7GS3WGeMJh5qpqB6ZPE3LuyXt5cAZB+qzn1hCw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rhLsueKzKvYN0LLxLWREYv8Rgsq0gwFjmgK5FLCOnEbnDhMDogsnQZ3l6h6d4fXyO
	 W+AHCQTBgeWnK9xx5UxzOuDJ/AyPw0sSv4XgMTJBfDvrBPG+4CFSruSCUKLu6FkXQp
	 pPt8pM9p5EvhqfuNrks96oSsGaoTXzyp0MG2Jnv+o598VuEgCnkc/8jfyRdqFCOUZe
	 VFljliT1O36nLeriD7azVvYb/wDsjq2r0KEgUg9G/pCvwFd/U9WSs+njpD0f2hL6dR
	 ezxzzHRCI6HOzJiK4/+C8yJ9nrM3KC6ApkgGFwNrs3BcGJNxl7iuoiDNEF/5xlJe05
	 s0JWOkVbjMytQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6B1B9CE13CE; Tue, 14 Jan 2025 10:42:30 -0800 (PST)
Date: Tue, 14 Jan 2025 10:42:30 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, hannes@cmpxchg.org,
	yosryahmed@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, davidf@vimeo.com,
	handai.szj@taobao.com, rientjes@google.com,
	kamezawa.hiroyu@jp.fujitsu.com, RCU <rcu@vger.kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH v3] memcg: fix soft lockup in the OOM process
Message-ID: <81294730-1cd9-4793-b886-9ababe29d071@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241224025238.3768787-1-chenridong@huaweicloud.com>
 <1ea309c1-d0f8-4209-b0b0-e69ad4e986ae@suse.cz>
 <58caaa4f-cf78-4d0f-af31-8a9277b6ebf5@huaweicloud.com>
 <20250113194546.3de1af46fa7a668111909b63@linux-foundation.org>
 <Z4YjArAULdlOjhUf@tiehlicka>
 <aaa26dbb-e3b5-42a3-aac0-1cb594a272b6@suse.cz>
 <0b6a3935-8b6c-4d11-bacc-31c1ba15b349@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b6a3935-8b6c-4d11-bacc-31c1ba15b349@huaweicloud.com>

On Tue, Jan 14, 2025 at 08:13:37PM +0800, Chen Ridong wrote:
> 
> 
> On 2025/1/14 17:20, Vlastimil Babka wrote:
> > On 1/14/25 09:40, Michal Hocko wrote:
> >> On Mon 13-01-25 19:45:46, Andrew Morton wrote:
> >>> On Mon, 13 Jan 2025 14:51:55 +0800 Chen Ridong <chenridong@huaweicloud.com> wrote:
> >>>
> >>>>>> @@ -430,10 +431,15 @@ static void dump_tasks(struct oom_control *oc)
> >>>>>>  		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
> >>>>>>  	else {
> >>>>>>  		struct task_struct *p;
> >>>>>> +		int i = 0;
> >>>>>>  
> >>>>>>  		rcu_read_lock();
> >>>>>> -		for_each_process(p)
> >>>>>> +		for_each_process(p) {
> >>>>>> +			/* Avoid potential softlockup warning */
> >>>>>> +			if ((++i & 1023) == 0)
> >>>>>> +				touch_softlockup_watchdog();
> >>>>>
> >>>>> This might suppress the soft lockup, but won't a rcu stall still be detected?
> >>>>
> >>>> Yes, rcu stall was still detected.
> > 
> > "was" or "would be"? I thought only the memcg case was observed, or was that
> > some deliberate stress test of the global case? (or the pr_info() console
> > stress test mentioned earlier, but created outside of the oom code?)
> > 
> 
> It's not easy to reproduce for global OOM. Because the pr_info() console
> stress test can also lead to other softlockups or RCU warnings(not
> causeed by OOM process) because the whole system is struggling.However,
> if I add mdelay(1) in the dump_task() function (just to slow down
> dump_task, assuming this is slowed by pr_info()) and trigger a global
> OOM, RCU warnings can be observed.
> 
> I think this can verify that global OOM can trigger RCU warnings in the
> specific scenarios.

We do have a recently upstreamed rcutree.csd_lock_suppress_rcu_stall
kernel boot parameter that causes RCU CPU stall warnings to suppress
most of the output when there is an ongoing CSD-lock stall.

Would it make sense to do something similar when the system is in OOM,
give or take the traditional difficulty of determining exactly when OOM
starts and ends?

1dd01c06506c ("rcu: Summarize RCU CPU stall warnings during CSD-lock stalls")

							Thanx, Paul

> >>>> For global OOM, system is likely to struggle, do we have to do some
> >>>> works to suppress RCU detete?
> >>>
> >>> rcu_cpu_stall_reset()?
> >>
> >> Do we really care about those? The code to iterate over all processes
> >> under RCU is there (basically) since ever and yet we do not seem to have
> >> many reports of stalls? Chen's situation is specific to memcg OOM and
> >> touching the global case was mostly for consistency reasons.
> > 
> > Then I'd rather not touch the global case then if it's theoretical? It's not
> > even exactly consistent, given it's a cond_resched() in the memcg code (that
> > can be eventually automatically removed once/if lazy preempt becomes the
> > sole implementation), but the touch_softlockup_watchdog() would remain,
> > while doing only half of the job?
> 
> 

