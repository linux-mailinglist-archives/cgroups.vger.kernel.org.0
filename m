Return-Path: <cgroups+bounces-8294-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FA7ABFF84
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 00:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFFE8C7F8A
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 22:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF6923A9A5;
	Wed, 21 May 2025 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us1NdNuG"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1E2192E1;
	Wed, 21 May 2025 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866570; cv=none; b=syMLPEPhP5mbVbAbKLI6nwOMyc8HgjzN6p5z93oLc70ExuAgjie6FH2GHcNy82NkRL5d3waxToa8HKjVwQwLoSSDtsn26G6gOyv58qXpI8tFYooXnLO2oVb4ZHamyt2eOmASWf8350pz7JpQ6HmFCG/eZUYrk4/LoSIoieex+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866570; c=relaxed/simple;
	bh=irtON5WVDbBr8vPwyUpf52o7P4PNK2U+tXDUgO9fTeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=If3jqZwHnEgWALtyeuBp+DgRJRPoVlOGHugF3njI+dDxE2T8SLA4Pc4COCB8YJNrcJW1o7XzvXkrINhTieFN8f9eFVl0fdgX1WGeBIYjvxOiwb3xGTagiQgFku2kJbQOKIV76rn7so+R+P47mR5cvi32vRXvKNkSBB/xzzIvfGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us1NdNuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7901C4CEE4;
	Wed, 21 May 2025 22:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747866569;
	bh=irtON5WVDbBr8vPwyUpf52o7P4PNK2U+tXDUgO9fTeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Us1NdNuGllr1erLQCBtBkuiCS/5KRytN1mL91L27ybi0x6d2g4ZbP7AVldzrVqPbV
	 vZZzBVk+ovgqODZudOn+uG800PKGUnjMvgPVVBB5RibrMVZSSg0Xyz/XqiFPXq6HsO
	 59t9IuyqVXfg5fJTwGM7iZJxjyHKjmNinDFeIcSfekp5JSOBTZb/TS2yogmVtLQOzg
	 kO+yBt6U1duXCa+DdjsDVtIGV7B3hFyx15TPAHxFlNxrT93yAvZTw1VUPyZ8FdY5SP
	 5OX/gF+C7nsolxkrdEJ7sbZz2oQZ+RzOxmVDq0/vT2AWMoFlWcrNUEr4PvGRQV6PZb
	 sEyc8ZU+FOC1Q==
Date: Wed, 21 May 2025 12:29:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	JP Kobryn <inwardvessel@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [OFFLIST PATCH 2/2] cgroup: use subsystem-specific rstat locks
 to avoid contention
Message-ID: <aC5TyFvjdLCSosaG@slm.duckdns.org>
References: <20250428174943.69803-1-inwardvessel@gmail.com>
 <20250428174943.69803-2-inwardvessel@gmail.com>
 <ad2otaw2zrzql4dch72fal6hlkyu2mt7h2eeg4rxgofzyxsb2f@7cfodklpbexu>
 <gzwa67k6i35jw5h3qfdajuzxa2zgm6ws2x5rjiisont4xiz4bp@kneusjz5bxwb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gzwa67k6i35jw5h3qfdajuzxa2zgm6ws2x5rjiisont4xiz4bp@kneusjz5bxwb>

On Thu, May 22, 2025 at 12:23:44AM +0200, Klara Modin wrote:
> Hi,
> 
> On 2025-04-28 23:15:58 -0700, Shakeel Butt wrote:
> > Please ignore this patch as it was sent by mistake.
> 
> This seems to have made it into next:
> 
> 748922dcfabd ("cgroup: use subsystem-specific rstat locks to avoid contention")
> 
> It causes a BUG and eventually a panic on my Raspberry Pi 1:
> 
> WARNING: CPU: 0 PID: 0 at mm/percpu.c:1766 pcpu_alloc_noprof (mm/percpu.c:1766 (discriminator 2)) 
> illegal size (0) or align (4) for percpu allocation
> CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.15.0-rc7-next-20250521-00086-ga9fb18e56aad #263 NONE
> Hardware name: BCM2835
> Call trace:
> unwind_backtrace from show_stack (arch/arm/kernel/traps.c:259) 
> show_stack from dump_stack_lvl (lib/dump_stack.c:122) 
> dump_stack_lvl from __warn (kernel/panic.c:729 kernel/panic.c:784) 
> __warn from warn_slowpath_fmt (kernel/panic.c:815) 
> warn_slowpath_fmt from pcpu_alloc_noprof (mm/percpu.c:1766 (discriminator 2)) 
> pcpu_alloc_noprof from ss_rstat_init (kernel/cgroup/rstat.c:515) 
> ss_rstat_init from cgroup_init_subsys (kernel/cgroup/cgroup.c:6134 (discriminator 2)) 
> cgroup_init_subsys from cgroup_init (kernel/cgroup/cgroup.c:6240) 
> cgroup_init from start_kernel (init/main.c:1093) 
>  start_kernel from 0x0
> ...
> kernel BUG at kernel/cgroup/cgroup.c:6134!
> Internal error: Oops - BUG: 0 [#1] ARM
> 
> Reverting resolved it for me.

This posting was a mistake but direct postings from JP weren't. This being
pretty close to the merge window, unless the problem is trivial, the right
thing to do probalby is reverting the series. JP, what do you think?

Thanks.

-- 
tejun

