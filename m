Return-Path: <cgroups+bounces-8437-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 666A2ACE6CC
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 00:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4F1189A0ED
	for <lists+cgroups@lfdr.de>; Wed,  4 Jun 2025 22:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5793316FF37;
	Wed,  4 Jun 2025 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayzB/0nY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D6917B50F;
	Wed,  4 Jun 2025 22:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749077248; cv=none; b=DY1URyr9FR7K/a6mesA6xkW6UxM82VGjRGsh6pFo5J80523sk7LVFpgH+o1697eK3rTNkQCWnl4gbWCarXjgqZqIrLTeHOT8etyq2vAFYKaTN8h4ZHBgQxHrlEmz0Oy1HXzPLTwsxATZYuw9SN7QkzVmEDyy0+H5L+S91GbSZ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749077248; c=relaxed/simple;
	bh=MS9MhLppLKcfcpEmcrATxZ8g/tCqKaCDKhcnaCJwas4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG/D0kGIb1dK5NYwWnSZIj7Gyi8E8KcmZTunlvVPkFPjFySkzSp61gVSjoWEYC4EhPghSw5uj9+cDWYE+NuTprHz1BaG2APUyICFyIIyEPCvO4f+inCW6ogmCmRWOTc9vaeWrvHbVvtgXCjoAgUflBfUT0tNLKVkMsdF3SaBHKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayzB/0nY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503B9C4CEE4;
	Wed,  4 Jun 2025 22:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749077247;
	bh=MS9MhLppLKcfcpEmcrATxZ8g/tCqKaCDKhcnaCJwas4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ayzB/0nYz4HKTTJN3/MwNxbFV57n8BOybrpAAbBTgRtUO0oL0kr4bI09lTp0nzdOe
	 HvQRrsQou8e+hilGbo2NjLkavgPDDC9Ik8NzUz7kTuG6V8/3+g5u2uCx/pgRKLTuXS
	 GvjvnyTEc2+N7n9U2WipHn6SGqxAwIPh5e5z4a/1xbRwh3A4labv+dA35x7gYftHbC
	 7vBDmZhLoR7qZ4bx5wM1cH2eDoPOZSHbAR5+NnP57dEFR3mwxgbl0vsG4VTP856bhT
	 nJ+Hb13yat+NWj8YQ7mxuTCMa4eCW4k9CHQRWeaLwHk1sYagQq/sULV+IwzOpCII4T
	 TFothl8KGzq2Q==
Date: Wed, 4 Jun 2025 12:47:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	kernel-team@android.com, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chen Ridong <chenridong@huawei.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [RFC PATCH] cgroup: Track time in cgroup v2 freezer
Message-ID: <aEDM_s7y8xMKJHph@slm.duckdns.org>
References: <20250603224304.3198729-3-ynaffit@google.com>
 <aD9_V1rSqqESFekK@slm.duckdns.org>
 <dbx8y0u7i9e6.fsf@ynaffit-andsys.c.googlers.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbx8y0u7i9e6.fsf@ynaffit-andsys.c.googlers.com>

Hello, Tiffany.

On Wed, Jun 04, 2025 at 07:39:29PM +0000, Tiffany Yang wrote:
...
> Thanks for taking a look! In this case, I would argue that the value we
> are accounting for (time that a task has not been able to run because it
> is in the cgroup v2 frozen state) is task-specific and distinct from the
> time that the cgroup it belongs to has been frozen.
> 
> A cgroup is not considered frozen until all of its members are frozen,
> and if one task then leaves the frozen state, the entire cgroup is
> considered no longer frozen, even if its other members stay in the
> frozen state. Similarly, even if a task is migrated from one frozen
> cgroup (A) to another frozen cgroup (B), the time cgroup B has been
> frozen would not be representative of that task even though it is a
> member.
> 
> There is also latency between when each task in a cgroup is marked as
> to-be-frozen/unfrozen and when it actually enters the frozen state, so
> each descendant task has a different frozen time. For watchdogs that
> elapse on a per-task basis, a per-cgroup time-in-frozen value would
> underreport the actual time each task spent unable to run. Tasks that
> miss a deadline might incorrectly be considered misbehaving when the
> time they spent suspended was not correctly accounted for.
> 
> Please let me know if that answers your question or if there's something
> I'm missing. I agree that it would be cleaner/preferable to keep this
> accounting under a cgroup-specific umbrella, so I hope there is some way
> to get around these issues, but it doesn't look like cgroup fs has a
> good way to keep task-specific stats at the moment.

I'm not sure freezing/frozen distinction is that meaningful. If each cgroup
tracks total durations for both states, most threads should be able to rely
on freezing duration delta, right? There shouldn't be significant time gap
between freezing starting and most threads being frozen although the cgroup
may not reach full frozen state due to e.g. NFS and what not.

As long as threads are not migrated across cgroups, it should be able to do
something like:

1. Read /proc/self/cgroup to determine the current cgroup.
2. Read and remember freezing duration $CGRP/cgroup.stat.
3. Do time taking operation.
4. Read $CGRP/cgrp.stat and calculate delta and deduct that from time taken.

Would that work?

Thanks.

-- 
tejun

