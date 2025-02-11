Return-Path: <cgroups+bounces-6507-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EE4A31493
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 20:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33F41884791
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 19:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1968262175;
	Tue, 11 Feb 2025 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qHYgq/Vx"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F725A327
	for <cgroups@vger.kernel.org>; Tue, 11 Feb 2025 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739300669; cv=none; b=qimpjv5JfCesrJKtDMdPspIVUmU9FlzgidFK7+XSAXh0SOgn8DzwO1ZTArkvhkUAeALAJN3HMVGRW16kml4YTUQRRQoB+lWiNGiJRjD33tsHGmCVY9ojI+xlfsoqdEpwZb7RTguKA6eOjG/RrSvhSv4bL7dMZAYV4DL9OSfFi+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739300669; c=relaxed/simple;
	bh=8G/QDmvfkk/MFpi5DXs6uOTymSJfkhTq4MU2B1XPs2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRd0oQng3wtLFcG78JBjDXkNjReGscUtFeef/oXuu2OhXJeGU5AOdLacyE53qpg2Mckun0AswmeEZf0VJ7bTvtD/W6vOqYdVKlGC0xsTgwLMOllFuXSwS+9FHVokwKZHIIBngNwicuUPBL3AguSpebzM6gICNu0akSpVb15GjUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qHYgq/Vx; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 11 Feb 2025 11:04:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739300665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LZcMl8Wvgu43xkeb3Z4P/CBQfkD+2Pi53RCHqGlIMtk=;
	b=qHYgq/Vxdcl2ebxEnHDTf03kI7zycftVvjJeLHsqoj6LJyIUejJohwbUAqUYDXZF6xbGLz
	7yswAXqAjvTIczfpEmO974KhH2s7AAwl5HcK2pJKtzMjoZ4s9jfYStUUWW5ukS0ty+zwNQ
	psLNTRqNDmTy5M0kokpxOIdqSL9xWp8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, chenridong@huawei.com, 
	wangweiyang2@huawei.com
Subject: Re: [PATCH] memcg: avoid dead loop when setting memory.max
Message-ID: <gf5pqage6o7azhzdlp56q6fvlfg52gbi47d43ro7r6n2hys54i@aux77hoig5j2>
References: <20250211081819.33307-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211081819.33307-1-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 11, 2025 at 08:18:19AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> A softlockup issue was found with stress test:
>  watchdog: BUG: soft lockup - CPU#27 stuck for 26s! [migration/27:181]
>  CPU: 27 UID: 0 PID: 181 Comm: migration/27 6.14.0-rc2-next-20250210 #1
>  Stopper: multi_cpu_stop <- stop_machine_from_inactive_cpu
>  RIP: 0010:stop_machine_yield+0x2/0x10
>  RSP: 0000:ff4a0dcecd19be48 EFLAGS: 00000246
>  RAX: ffffffff89c0108f RBX: ff4a0dcec03afe44 RCX: 0000000000000000
>  RDX: ff1cdaaf6eba5808 RSI: 0000000000000282 RDI: ff1cda80c1775a40
>  RBP: 0000000000000001 R08: 00000011620096c6 R09: 7fffffffffffffff
>  R10: 0000000000000001 R11: 0000000000000100 R12: ff1cda80c1775a40
>  R13: 0000000000000000 R14: 0000000000000001 R15: ff4a0dcec03afe20
>  FS:  0000000000000000(0000) GS:ff1cdaaf6eb80000(0000)
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 00000025e2c2a001 CR4: 0000000000773ef0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Call Trace:
>   multi_cpu_stop+0x8f/0x100
>   cpu_stopper_thread+0x90/0x140
>   smpboot_thread_fn+0xad/0x150
>   kthread+0xc2/0x100
>   ret_from_fork+0x2d/0x50
> 
> The stress test involves CPU hotplug operations and memory control group
> (memcg) operations. The scenario can be described as follows:
> 
>  echo xx > memory.max 	cache_ap_online			oom_reaper
>  (CPU23)						(CPU50)
>  xx < usage		stop_machine_from_inactive_cpu
>  for(;;)			// all active cpus
>  trigger OOM		queue_stop_cpus_work
>  // waiting oom_reaper
>  			multi_cpu_stop(migration/xx)
>  			// sync all active cpus ack
>  			// waiting cpu23 ack
>  			// CPU50 loops in multi_cpu_stop
>  							waiting cpu50
> 
> Detailed explanation:
> 1. When the usage is larger than xx, an OOM may be triggered. If the
>    process does not handle with ths kill signal immediately, it will loop
>    in the memory_max_write.
> 2. When cache_ap_online is triggered, the multi_cpu_stop is queued to the
>    active cpus. Within the multi_cpu_stop function,  it attempts to
>    synchronize the CPU states. However, the CPU23 didn't acknowledge
>    because it is stuck in a loop within the for(;;).
> 3. The oom_reaper process is blocked because CPU50 is in a loop, waiting
>    for CPU23 to acknowledge the synchronization request.
> 4. Finally, it formed cyclic dependency and lead to softlockup and dead
>    loop.
> 
> To fix this issue, add cond_resched() in the memory_max_write, so that
> it will not block migration task.
> 
> Fixes: b6e6edcfa405 ("mm: memcontrol: reclaim and OOM kill when shrinking memory.max below usage")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  mm/memcontrol.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8d21c1a44220..16f3bdbd37d8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4213,6 +4213,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>  		memcg_memory_event(memcg, MEMCG_OOM);
>  		if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0))

Wouldn't it be more robust if we put an upper bound on the else case of
above condition i.e. fix number of retries? As you have discovered there
is a hidden dependency on the forward progress of oom_reaper and this
check/code-path which I think is not needed. 

>  			break;
> +		cond_resched();
>  	}
>  
>  	memcg_wb_domain_size_changed(memcg);
> -- 
> 2.34.1
> 

