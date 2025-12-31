Return-Path: <cgroups+bounces-12835-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2A6CEC055
	for <lists+cgroups@lfdr.de>; Wed, 31 Dec 2025 14:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E6D43007287
	for <lists+cgroups@lfdr.de>; Wed, 31 Dec 2025 13:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE2A322C73;
	Wed, 31 Dec 2025 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqJJ3lmV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5691EEA55;
	Wed, 31 Dec 2025 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767187143; cv=none; b=I/B6lw2pr9m8qFA8/sbIoztjV2rPOBhx2wB0tdGlcNsnm2k/fnP7JWenXoDNkPHqzqDoFvR4F8pUxVZ3qVX43OWXmXy0NAt3ea5ekLv4aGo8tECb5f4xzoASz3kmNb1pgrWQfVrD9gs+gLmwihfpPNZCgp64xNefLNvW1OMRq7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767187143; c=relaxed/simple;
	bh=ypn/q+ILRrt5uVnU9TRkKLrfFM5tQxriCjP5mEvYBRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NU/kSGWG3Khlkv3+V0KPP92OszZEySzGg/x8qFJKB5ke3V/MD02AP79C4j9ioGyMIbP5zmbfTyJtSUwIDemOin1VcL3Mw6iWjv1IePAPp/3BjLY+Wqal/XUyyZ7L3UIDIfgUtoTpoW1+EfKXrbNF+UXXpyvcNWGuiIwVwmkYbck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqJJ3lmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1A3C113D0;
	Wed, 31 Dec 2025 13:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767187142;
	bh=ypn/q+ILRrt5uVnU9TRkKLrfFM5tQxriCjP5mEvYBRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sqJJ3lmVMf3teCNuAdVsjiRVupecIds4UPxN86Cxl9KA2fwWuX6h3c50j+Jw9b3mL
	 rCqKrw8OoWIjhaI2tYqbnk0gExYsfn3LbQAa2vQj8o+hbrwPOWtDg6Rjm1DLv13mVm
	 MC5ly2S3u2zhzuY4tSWXwxE7HNPL6YBvMCjC2ff3u3MG+mlfHFcuf6gr5p6k5L4qp8
	 bvHV9dc+xaGru5y/5nJGRRHHaf+Pq3JYeutXzbOGpqsuTFm28PzP8lX+UrxPZuRxh1
	 Xj8ccKa6cuxj20i6EcP4HOb8zAbp0t8x44gLAREO+hbs10vbn7IRasxXyGloGJMJVS
	 suVKTc9BXvBtg==
Date: Wed, 31 Dec 2025 14:18:59 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Zhang Qiao <zhangqiao22@huawei.com>,
	LKML <linux-kernel@vger.kernel.org>,
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
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 01/33] PCI: Prepare to protect against concurrent
 isolated cpuset change
Message-ID: <aVUiw34NAG3OfOV8@localhost.localdomain>
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-2-frederic@kernel.org>
 <e01189e1-d8ef-2791-632c-90d4d897859b@huawei.com>
 <81f201cc-395a-48d7-a1b0-db8c62b93c9e@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81f201cc-395a-48d7-a1b0-db8c62b93c9e@redhat.com>

Le Sun, Dec 28, 2025 at 10:53:41PM -0500, Waiman Long a écrit :
> On 12/28/25 10:23 PM, Zhang Qiao wrote:
> > >   	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
> > >   	    pci_physfn_is_probed(dev)) {
> > > -		cpu = nr_cpu_ids;
> > > +		error = local_pci_probe(&ddi);
> > >   	} else {
> > >   		cpumask_var_t wq_domain_mask;
> > > +		struct pci_probe_arg arg = { .ddi = &ddi };
> > > +
> > > +		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
> > >   		if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
> > >   			error = -ENOMEM;
> > If we return from here, arg.work will not be destroyed.
> > 
> > 
> Right. INIT_WORK_ONSTACK() should be called after successful cpumask_var_t
> allocation.

Doing that, thank you both!

-- 
Frederic Weisbecker
SUSE Labs

