Return-Path: <cgroups+bounces-6290-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C99A1BF22
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 00:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA143ACD02
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 23:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E57D1E990F;
	Fri, 24 Jan 2025 23:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhluxOqI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92CF29406;
	Fri, 24 Jan 2025 23:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762550; cv=none; b=hZclu/O+P33J6P6KjHIii3M5rDMVRgmyoM49ruUeGJ7896H7V3JrazbFY/yCYQE+LQGjwdcyGo78i5z0ltoJ2rIUIvIqYG57F5migsUc0JCeVgbQ4/sLHcMYifbqzrzBoWIHixhvJaiLq/qYXASbrgYVTRRP//4p4L06ChoESNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762550; c=relaxed/simple;
	bh=47nLu+gh4Pfvvo3iBdftodxWw7LcI5ceO5NYpid1mvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=da+lQ8uEYtfFMQxLqtEIQe1SvTARCmbqHtFi/vunSlFPAYwij0ciLC3+ws7eXAsEgT9PaG7mslYppd85oDCUOC7xkBG876N9hw/kZZW0fhy7t1XU+k3G5HiITfi7J3qZg2Z5Ylr3zHX5mZfsVBOfXWrAsq8Kpn8WW+SfQP1jFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhluxOqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75670C4CED2;
	Fri, 24 Jan 2025 23:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737762550;
	bh=47nLu+gh4Pfvvo3iBdftodxWw7LcI5ceO5NYpid1mvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AhluxOqIiR1+uTPfrYT6D52bPVtqyFrhHybWMxLaD1xZ6ju5PeBNrMalT+f1iUi00
	 F/C1Mo6T+161vbd8Vho5MC1cMhItFba8cR5lvigZrPbn/3XiXnkclDxr2NFEnPagxe
	 4LOlPLzUwxTUCKZ52ENzP2q5SaGOqCE5RoBO/Xha+3WR1dTLJAkLwClpLKlOy4yJRC
	 Bq7IJKQbCLd4+dkA6aEbC/D4ojtce4rn0qc6p/opE1HOxKfF0LIeM6+toe7zbk3MD9
	 sGruxIGmOZz2zR5wl7TQ7U6TGqPGoIVddxB48QT8ODrZbmTjT8lS11tk5HVulBPa1A
	 JVXVCt+cD3Smg==
Date: Fri, 24 Jan 2025 13:49:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: chenridong <chenridong@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yury Norov <yury.norov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH 1/3] cgroup/rstat: Fix forceidle time in cpu.stat
Message-ID: <Z5Qm9aXwZhwjBEfy@slm.duckdns.org>
References: <20250123174713.25570-1-wuyun.abel@bytedance.com>
 <20250123174713.25570-2-wuyun.abel@bytedance.com>
 <853d2669-e05b-435e-9ac1-86311ead56e5@huawei.com>
 <2bba87cf-69aa-4fac-ae1a-c50e2f376e2a@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bba87cf-69aa-4fac-ae1a-c50e2f376e2a@bytedance.com>

On Fri, Jan 24, 2025 at 03:49:16PM +0800, Abel Wu wrote:
...
> > > --- a/kernel/cgroup/rstat.c
> > > +++ b/kernel/cgroup/rstat.c
> > > @@ -613,36 +613,33 @@ static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat
> > >   void cgroup_base_stat_cputime_show(struct seq_file *seq)
> > >   {
> > >   	struct cgroup *cgrp = seq_css(seq)->cgroup;
> > > -	u64 usage, utime, stime, ntime;
> > > +	struct cgroup_base_stat bstat;
> > >   	if (cgroup_parent(cgrp)) {
> > >   		cgroup_rstat_flush_hold(cgrp);
> > > -		usage = cgrp->bstat.cputime.sum_exec_runtime;
> > > +		bstat = cgrp->bstat;
> > 
> > Thank you for finding that.
> > In my version 2, I used to assign cgrp->bstat to bstat.
> > This is Tj's comment:
> > https://lore.kernel.org/linux-kernel/ZoQ2ti7nnz9EJSc3@slm.duckdns.org/

I wasn't saying that memcpy() should be used instead of assignment. I was
saying that if a non-trivial struct can be pointed to instead of being
copied, it should be pointed to. If all the fields need to be snapshotted,
assigning is fine.

Thanks.

-- 
tejun

