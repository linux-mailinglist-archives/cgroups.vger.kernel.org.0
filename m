Return-Path: <cgroups+bounces-11599-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDC5C36CA4
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 17:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F2768269A
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2C233B6EA;
	Wed,  5 Nov 2025 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0hjf0Ui"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C00332EAD;
	Wed,  5 Nov 2025 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359440; cv=none; b=GIrFyVF9d5PEQVTKoghwXOuMtoWPzwYqEZ07HRoQDNJFwY9duSQtiKyRULVHu24X4GX2aoEYGuuRP1MvXTK46VlmLqzjjzEaHFA2s8uyKP4+ARkNz1n05RCQUuQWTkwosLMgMkDJqVuHCtY5rmGMdzdsrL6IqJ66ittSRKd2LOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359440; c=relaxed/simple;
	bh=m0WmoCYyOXZpK7uUlcvblqPFNrYVzKYbQ3i1eOPl5Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3Y8vJElT6nXBeOy+IIxYX8pPs6LsJlXWqIkqDPpTvNNiBCGmRZ+xCZDMZnlTTgbAPSQ2/rbO8U60cDAdn2MqLeME6ZjmqZHz6cy3kYv4xktfhkev38oZWhn1+frdJFIjl0ert1jevqIs6SS9xzzuXDUwJ+b1MzMgnvYQxF9YP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0hjf0Ui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA00C4CEF5;
	Wed,  5 Nov 2025 16:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762359439;
	bh=m0WmoCYyOXZpK7uUlcvblqPFNrYVzKYbQ3i1eOPl5Zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0hjf0UiodG9bvlzR0teTF7/EOA6sdH3lJdRLlau9I8A/DseQMnymKV6dDPaF700i
	 /GM4BkXlPH1RycuSsw1W8H9JlsG+Bpucpt9ON/Yb5Lp8BhsF0xHuIPaLrfAj2uEL5x
	 FGHRWbLzd0GHQgdJxbcv9AuCCM02jjoLln2tMRrhAU4O51K57/fzGeuubEOv9trZh9
	 vwOscUOROGk2lS5YeTqltie7TWPT1TVeiQnqH89qkQQHLnjKNmuhBQSCx2JZFrhqQw
	 s6AEiUIsphHx7/SDFAYdbTpJoHq3d0onR71up8dRK9b/ZyB8C1jktq8jhvlYW0LWY/
	 sPiObTTJWLXrA==
Date: Wed, 5 Nov 2025 17:17:17 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH 14/33] sched/isolation: Flush memcg workqueues on cpuset
 isolated partition change
Message-ID: <aQt4jT9qqP_l_ZSF@localhost.localdomain>
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-15-frederic@kernel.org>
 <364e084a-ef37-42ab-a2ae-5f103f1eb212@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <364e084a-ef37-42ab-a2ae-5f103f1eb212@redhat.com>

Le Tue, Oct 21, 2025 at 03:16:45PM -0400, Waiman Long a écrit :
> > @@ -5134,6 +5141,9 @@ int __init mem_cgroup_init(void)
> >   	cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
> >   				  memcg_hotplug_cpu_dead);
> > +	memcg_wq = alloc_workqueue("memcg", 0, 0);
> 
> Should we explicitly mark the memcg_wq as WQ_PERCPU even though I think
> percpu is the default. The schedule_work_on() schedules work on the
> system_percpu_wq.

Good catch, percpu is the default but that behaviour is scheduled for
deprecation. I'm adding WQ_PERCPU.

Thanks!

-- 
Frederic Weisbecker
SUSE Labs

