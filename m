Return-Path: <cgroups+bounces-13105-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C72D15882
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 23:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94E0E303889C
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 22:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6290734AB03;
	Mon, 12 Jan 2026 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHVmYw6N"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213AC30ACFF;
	Mon, 12 Jan 2026 22:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768255785; cv=none; b=BAjcWQi0Qsxc0xU3he8Tk/ACdpgGJ1AJW6drwM8WERwqH+g4BmAc3SL4ncKOlSaZ9Uu3oPfA73dHn2WorRZPkPLQp+LEM+DA9Hqh0vfKfu7/5R6Yn/OLNC/eah71NakGMrtK46mYpEiDssL18B0WL9uB+swGDMK95//6TWQ8X5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768255785; c=relaxed/simple;
	bh=JxVAg6/16D5kLpXJf8cK2rWDDZ/WNlKo8ozqkYTbqEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/qnfSV+foaBTDbiwGIj5MohZz31SfkLXuCoPLAUW83qUSDqqnhNog4srbfmNutzOg7gMZvFybcx17s1Rx/KyOX30fa0xOAel9VVjZvt+cAPtFiGWO8oe2IkduSgZln29MgqnL3SUNTdtGv158MnXLQieGvCs+BN8De5ewfb5lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHVmYw6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A22C116D0;
	Mon, 12 Jan 2026 22:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768255784;
	bh=JxVAg6/16D5kLpXJf8cK2rWDDZ/WNlKo8ozqkYTbqEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nHVmYw6NZl/tZREwk9G9Iv5iR5Xne4iGKYto91hcu1bIgTvjlMqP9uaM6ySc0IvWD
	 GzwQTYft18Psn6A+Bm+D4w/vKek/yVT7FaibTOHAAloagBn8qak1jjX/wEEcoStPGc
	 OYKkWxAsSAceDzk8dx6fDIlAkg1ncsKO1kqC//f2u6pXkij7dIRCKwde18QYO1M7HP
	 wSyLeSrhK9sEZBOJAHFDO/0Eq+iYPd3s5/bzuXEuFpnApHEnp75LGhg+uc0YNsFytZ
	 rnA2gOsmzObCazuI/eA9GURbG8a1plnKfvXG+Ae88LjklzVw+RPhIIFkqBmQ3LHNw+
	 Wt1qBmrEKBjEg==
Date: Mon, 12 Jan 2026 23:09:41 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
	Phil Auld <pauld@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Michal Koutny <mkoutny@suse.com>, netdev@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>, Michal Hocko <mhocko@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>,
	Chen Ridong <chenridong@huawei.com>, cgroups@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S . Miller" <davem@davemloft.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Simon Horman <horms@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Gabriele Monaco <gmonaco@redhat.com>,
	Muchun Song <muchun.song@linux.dev>, Will Deacon <will@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>
Subject: Re: [PATCH 00/33 v6] cpuset/isolation: Honour kthreads preferred
 affinity
Message-ID: <aWVxJVQYEWQiyO8Q@pavilion.home>
References: <20260101221359.22298-1-frederic@kernel.org>
 <437ccd7a-e839-4b40-840c-7c40d22f8166@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <437ccd7a-e839-4b40-840c-7c40d22f8166@redhat.com>

Le Mon, Jan 12, 2026 at 01:23:40PM -0500, Waiman Long a écrit :
> On 1/1/26 5:13 PM, Frederic Weisbecker wrote:
> > Hi,
> > 
> > The kthread code was enhanced lately to provide an infrastructure which
> > manages the preferred affinity of unbound kthreads (node or custom
> > cpumask) against housekeeping constraints and CPU hotplug events.
> > 
> > One crucial missing piece is cpuset: when an isolated partition is
> > created, deleted, or its CPUs updated, all the unbound kthreads in the
> > top cpuset are affine to _all_ the non-isolated CPUs, possibly breaking
> > their preferred affinity along the way
> > 
> > Solve this with performing the kthreads affinity update from cpuset to
> > the kthreads consolidated relevant code instead so that preferred
> > affinities are honoured.
> > 
> > The dispatch of the new cpumasks to workqueues and kthreads is performed
> > by housekeeping, as per the nice Tejun's suggestion.
> > 
> > As a welcome side effect, HK_TYPE_DOMAIN then integrates both the set
> > from isolcpus= and cpuset isolated partitions. Housekeeping cpumasks are
> > now modifyable with specific synchronization. A big step toward making
> > nohz_full= also mutable through cpuset in the future.
> > 
> > Changes since v5:
> > 
> > * Add more tags
> > 
> > * Fix leaked destroy_work_on_stack() (Zhang Qiao, Waiman Long)
> > 
> > * Comment schedule_drain_work() synchronization requirement (Tejun)
> > 
> > * s/Revert of/Inverse of (Waiman Long)
> > 
> > * Remove housekeeping_update() needless (for now) parameter (Chen Ridong)
> > 
> > * Don't propagate housekeeping_update() failures beyond allocations (Waiman Long)
> > 
> > * Whitespace cleanup (Waiman Long)
> > 
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > 	kthread/core-v6
> > 
> > HEAD: 811e87ca8a0a1e54eb5f23e71896cb97436cccdc
> > 
> > Happy new year,
> > 	Frederic
> 
> I don't see any major issue with this v6 version. There may be some minor
> issues that can be cleaned up later. Now the issue is which tree should this
> series go to as it touches a number of different subsystems with different
> maintainers.

It indeed crosses many subsystems. I would be fine if anybody takes it but
nobody volunteered so far.

The main purpose is to fix kthreads affinity (HK_TYPE_DOMAIN handling cpuset is
a bonus). And since I made the pull request myself to Linus when I introduced
kthreads managed affinity, I guess I could reiterate with this patchset. I
already pushed it to linux-next.

But if anybody wants to pull that to another tree, that's fine, just tell me
so that we synchronize to avoid duplication on linux-next.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

