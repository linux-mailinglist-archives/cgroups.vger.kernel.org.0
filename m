Return-Path: <cgroups+bounces-12839-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA37CEC18B
	for <lists+cgroups@lfdr.de>; Wed, 31 Dec 2025 15:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE5753015867
	for <lists+cgroups@lfdr.de>; Wed, 31 Dec 2025 14:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F922737E3;
	Wed, 31 Dec 2025 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug55uySx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706B22301;
	Wed, 31 Dec 2025 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767191859; cv=none; b=sA5OI5p8MJy399ekL2md0pGAUDZZMgT6aKC3VD4dyzZ1Vub5YeZMUpyNdTX/hTWZEpDRjdjsEnmd1/9eUU7kWy6Kw5o5lOh3i/67ZTpgM9pS2il+Ea8QNBVhOIZ6w/RGGbccr/7By766fLViuQr412CMAi7k4Yx1Gd2oeJz0DVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767191859; c=relaxed/simple;
	bh=rnNQxQRICVG0/bRCHLds18VIp4MhYcD23gBS1k4tm4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJowfv9iyzS7T3MX6qCTSABf04wQXRi662Ev0eEEHuoQF/RPyUF1J/CZCWBYybu/QOi+GWlpRMdWfqfQ/IUACY8YzBRhUq9TkeG5SC/C2+WYbKmGPeGCjVMP2rfc2hWUR2RYvgb2FQfcil3ez9imdwhwC0AVUEl9Fusm7kB9Luc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ug55uySx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE058C113D0;
	Wed, 31 Dec 2025 14:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767191859;
	bh=rnNQxQRICVG0/bRCHLds18VIp4MhYcD23gBS1k4tm4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ug55uySx/TS9I8SDIbLCqdWvgFFvx7oQBG42eNACAkO9SMq2ggXfcXb2F44FGN50K
	 13mXv2fVVQh7P1dXLSg7Da7qFtZegjEtOHHfMgKfursGukFoc8GLy67UuFkBND8bmu
	 1hRTfjdoq07zNV+R2kWXv/+mIgcBQN7SPKkBEeQau5EEWxacetnIh3vIMdssmjat6M
	 H/l2aL8FQsS9UnMjZ/iiQf9qUG5o98tjDOaHYOou4DExuKYBxNh8n29IIOMSCteAyX
	 9Xsvmkd6qooprztWFYZy7sLZa63PRgX3T04lKq3mgg7JBGjIe3B//fShIC1zjPD6kx
	 ojzdtaOi8ppWA==
Date: Wed, 31 Dec 2025 15:37:36 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 17/33] PCI: Flush PCI probe workqueue on cpuset isolated
 partition change
Message-ID: <aVU1MIyJ3VH4V80O@localhost.localdomain>
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-18-frederic@kernel.org>
 <c724aac7-5647-4253-bf7b-4ea92ea5d167@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c724aac7-5647-4253-bf7b-4ea92ea5d167@huaweicloud.com>

Le Fri, Dec 26, 2025 at 04:48:10PM +0800, Chen Ridong a écrit :
> > @@ -145,6 +146,7 @@ int housekeeping_update(struct cpumask *isol_mask, enum hk_type type)
> >  
> >  	synchronize_rcu();
> >  
> > +	pci_probe_flush_workqueue();
> >  	mem_cgroup_flush_workqueue();
> >  	vmstat_flush_workqueue();
> >  
> 
> I am concerned that this flush work may slow down writes to the cpuset interface. I am not sure how
> significant the impact will be.

First, writing to cpuset is not something that should be considered as a fast
path. It is a preparation work at configuration time that can tolerate a few
milliseconds of delay, which I expect to be what we should encounter most
of time here.

Second, this is not a "usual" cpuset partition write. CPU isolation is a niche
usecase (real time or Data plane). User must expect tradeoffs against the offer.

Third, about this very patch, most pci probe should happen at boot time before
cgroup is even accessible to userspace.

> I'm concerned about potential deadlock risks. While preliminary investigation hasn't uncovered any
> issues, we must ensure that the cpu write lock is not held during the work(writing cpuset interface
> needs cpu read lock).

That's what we have lockdep for :-)

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

