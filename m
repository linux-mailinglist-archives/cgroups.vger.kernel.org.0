Return-Path: <cgroups+bounces-2748-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B104D8B922B
	for <lists+cgroups@lfdr.de>; Thu,  2 May 2024 01:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508E01F2233E
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2024 23:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FEF16ABD5;
	Wed,  1 May 2024 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sT0Eez54"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58E17C6B
	for <cgroups@vger.kernel.org>; Wed,  1 May 2024 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605546; cv=none; b=N3koT9bSsl1QBlgv1xwAfJkGhSALg4RWTBaEZYmfwlU/bNnd+TXqISFXCeIQgjBTiC6ZoBX6Le3oIiEQf5dMzphvghzTZUfwfGeBxdVSEH5k4jWpKYto+xLtD7OvfmO17a4mrCNOXrDc6wdbp+SUlraQKtUepqfUNZbqEqB8t0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605546; c=relaxed/simple;
	bh=RVX6CWee9Et4secAL4eq9G6Zu+mOoI+QY67WAZDE8E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+WwJVdD+kWUdY4xeUBXYFwU9fX96L1AHO/2aOkcNKZ1nSzBHju8QCN9ZbwRgRRn09DiEfNwWxYTEgqizd1LOTz7bZ+B4m/LB7k/cZtM9ILNs5lg0PLkFOBv8jtUOrhQXlKV+HjlrdXcV53lqom14pNzDpm6E0Q/UTxURsEw1zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sT0Eez54; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 1 May 2024 16:18:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714605542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RHAt9ryWcPi6r2+Mi2K4KwgaN6ilqj66ygb1ZhC0eWM=;
	b=sT0Eez54kn5LXckYJgvnME+XvNbRTMK9yBJj9F8KcSEPZEt8zfhE/VofpK8jFd0lHvGqUk
	alZaUuT1i0JMSjV7KhPdjAwZ+m5HI8mZ3x1oxjNe15zrz/psBqoekqvPdbZccKxgsOvtus
	u/pG3K25JeP1Xw5D55xtgd6NAzYHsng=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Breno Leitao <leitao@debian.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <linux-mm@kvack.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memcg: use READ_ONCE()/WRITE_ONCE() to access
 stock->nr_pages
Message-ID: <ZjLN4eWVwr9W-pk8@P9FQF9L96D>
References: <20240501095420.679208-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501095420.679208-1-leitao@debian.org>
X-Migadu-Flow: FLOW_OUT

On Wed, May 01, 2024 at 02:54:20AM -0700, Breno Leitao wrote:
> A memcg pointer in the per-cpu stock can be accessed by drain_all_stock()
> and consume_stock() in parallel, causing a potential race.
> 
> KCSAN shows this data-race clearly in the splat below:
> 
> 	BUG: KCSAN: data-race in drain_all_stock.part.0 / try_charge_memcg
> 
> 	write to 0xffff88903f8b0788 of 4 bytes by task 35901 on cpu 2:
> 	try_charge_memcg (mm/memcontrol.c:2323 mm/memcontrol.c:2746)
> 	__mem_cgroup_charge (mm/memcontrol.c:7287 mm/memcontrol.c:7301)
> 	do_anonymous_page (mm/memory.c:1054 mm/memory.c:4375 mm/memory.c:4433)
> 	__handle_mm_fault (mm/memory.c:3878 mm/memory.c:5300 mm/memory.c:5441)
> 	handle_mm_fault (mm/memory.c:5606)
> 	do_user_addr_fault (arch/x86/mm/fault.c:1363)
> 	exc_page_fault (./arch/x86/include/asm/irqflags.h:37
> 		        ./arch/x86/include/asm/irqflags.h:72
> 			arch/x86/mm/fault.c:1513
> 			arch/x86/mm/fault.c:1563)
> 	asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:623)
> 
> 	read to 0xffff88903f8b0788 of 4 bytes by task 287 on cpu 27:
> 	drain_all_stock.part.0 (mm/memcontrol.c:2433)
> 	mem_cgroup_css_offline (mm/memcontrol.c:5398 mm/memcontrol.c:5687)
> 	css_killed_work_fn (kernel/cgroup/cgroup.c:5521 kernel/cgroup/cgroup.c:5794)
> 	process_one_work (kernel/workqueue.c:3254)
> 	worker_thread (kernel/workqueue.c:3329 kernel/workqueue.c:3416)
> 	kthread (kernel/kthread.c:388)
> 	ret_from_fork (arch/x86/kernel/process.c:147)
> 	ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
> 
> 	value changed: 0x00000014 -> 0x00000013
> 
> This happens because drain_all_stock() is reading stock->nr_pages, while
> consume_stock() might be updating the same address, causing a potential
> data-race.

Btw there is an actual data race, which is periodically causing a needless
draining of a per-cpu stock.

> 
> Make the shared addresses bulletproof regarding to reads and writes,
> similarly to what stock->cached_objcg and stock->cached.
> Annotate all accesses to stock->nr_pages with READ_ONCE()/WRITE_ONCE().
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

