Return-Path: <cgroups+bounces-7152-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4870BA689FA
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 11:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35343BE893
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 10:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA588253F23;
	Wed, 19 Mar 2025 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At75imzN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C111420D519;
	Wed, 19 Mar 2025 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381268; cv=none; b=P8Zp823YkY8fzAp0pBON5P1Nzg9m1B+F7wMCjf93zT6NZmZAdnN7F62Tr6iS2m/uVoFgLMKZDBinKptXotP784Uz3nOXLCGV7Muo7ryQkhgz6/Jln901J6PaZgkvd3GOFHNx2Nps097o/ofjFgQB+Pe4owYqyvoX00y8sVjMVLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381268; c=relaxed/simple;
	bh=kHi8Yvnzfz3S+jrMumC+2AWhmfXkEX+V7FSyynl8LlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFmiPMf29gC8Vtse7LJULu81TWjDFtvnjyohohuMUIv2DarREm2YJ3DYo+0GfsrV20f3WBUkPt4kfPw0IXno/pGfy+gAj+Oz8pmowzD0smT316BDdP2xsXbtEAFj4yX4MXdaOT62ZVDIHkga6yfSYMVPdzSNkU8Eu5Od6/4XoJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=At75imzN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39129fc51f8so5949252f8f.0;
        Wed, 19 Mar 2025 03:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742381265; x=1742986065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W26Wk5z7hiFxOE5qJlj+yFWl9XayBRIq0uAxqiX8N3w=;
        b=At75imzNcLh0i+IeN71ncr0FCrSYjuKM/v/YBjEwNPtrvNYaTwS58hL/O/V6f45Q4S
         tIHLi4E90il2s2bSo/QwfVzL5iy6rUtmzZipa9onhV88hQiOz0MAcyNeDgRmum54Pbpw
         Jt4CG50xb3sb9uUenj28rplUmqtxqSmL7HIJMZBVCUFqY0SUj97oRhn3heBTPZ+gzP59
         kuvFnqtHfELJo6EMyl8wKgwoVWM0ZYT4jQUHKc0GkkG1lJvIpPFNvpXzvj/QbX+n1tYq
         NWGQh/dE9MQUflBPGa3iOKsVHjVw/v/4mP5Bv/6DXtWwLF6VsJgabU912K4SnCVeaVqF
         OfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742381265; x=1742986065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W26Wk5z7hiFxOE5qJlj+yFWl9XayBRIq0uAxqiX8N3w=;
        b=vI2ewr1UqIZBx06q9O92Z5Jz4nyt9tgkuUw85jkwTHk1q8OyLn40bCqKx4rR0zsAjD
         3ozMwSx0b0CJrrhbJJRV0iJze7WobpfWO96El+XOr0PKJm+M1JAb5pWYUJEr2LbwaD7D
         lmEsVoRQH8sjvwqoM3MPzT2s0JZfI21b8QaTja0IyrYeC4CNByyjL7hti4w8qfByymo/
         WHAgh6slCwiBoao2AVn4qSlt660mXEyVmGTlVvDL/AlGCmUUQ+R4cLOCu9ufLwQDW2Nw
         aDGA6bQ+XcuIS+X4zhS9bixc8JoUJo7S07SmvgnfzaCSW3kYzm9w7NrZ1Gc5qb1uW1LN
         QDMA==
X-Forwarded-Encrypted: i=1; AJvYcCVr/nzx/qaDoV08ErAKKhdNRDH+YhPxint791jYvGqijXaZqlvJPwKCaWMMD1gaXaSUt6a55Nus@vger.kernel.org, AJvYcCX2TevUuA4k9R79knrobK11IyUl5C7cUSEcDbmSGiRUzDXjkK+oVLYECs5ppHxBAJSZVAwc+T1w1OG50n+y@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq+H0NyVp7sC5PVq4z/mHu2bpx1wz2YCSmUnYU+GeXY0vPu+iX
	P1bK1a+iJXL1336sOrasEgIYGz+8xQZX+DN5elvx2hugfByVdmFo
X-Gm-Gg: ASbGncuYCxRdBijjstKFxqjEAXJh/164DPeto6qMD0SCs06VbQGd/RZ9ltizysyOsLG
	IDMxVytya4RG05h1cUbTAZGnJhQJhVTSRRrBzboCP+J9eQ9u+/7qHHmn+jWMj9lWHuEJj0eIlj3
	IrWArBt+2Gh40WpI58NPGdAr8X3JNly6DeaerEO+nLFx5F9oq+TC9BEDMGF4mQhVpRUhkw2/5Bk
	mFOnkMVDiSmvnAaQILGLOROK5OFAtpjPUYLVM0BPwIEpoc8WN22tMfEs7CDFNpNdoKVaPNDnriG
	+BnWBiR9MUphNdfbFEi8rikxykOuic/nKCdqA/gFrWyNARBw07DCicEY9nYo2I2DXem10KI=
X-Google-Smtp-Source: AGHT+IFeWFBVb117gHRg6qAEPcNELWKw8bczEycMdH3YPjjfnip/JT4VlAY82Ht7iJ8McuMZ7Sag+g==
X-Received: by 2002:a05:6000:184d:b0:391:476f:d3b7 with SMTP id ffacd0b85a97d-39973b1d8d3mr1573400f8f.49.1742381264646;
        Wed, 19 Mar 2025 03:47:44 -0700 (PDT)
Received: from f (cst-prg-67-174.cust.vodafone.cz. [46.135.67.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975bdfsm20320478f8f.49.2025.03.19.03.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:47:43 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:47:32 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Greg Thelen <gthelen@google.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Eric Dumazet <edumzaet@google.com>, Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <u5kcjffhyrjsxagpdzas7q463ldgqtptaafozea3bv64odn2xt@agx42ih5m76l>
References: <20250319071330.898763-1-gthelen@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250319071330.898763-1-gthelen@google.com>

On Wed, Mar 19, 2025 at 12:13:30AM -0700, Greg Thelen wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> cgroup_rstat_flush_locked() grabs the irq safe cgroup_rstat_lock while
> iterating all possible cpus. It only drops the lock if there is
> scheduler or spin lock contention. If neither, then interrupts can be
> disabled for a long time. On large machines this can disable interrupts
> for a long enough time to drop network packets. On 400+ CPU machines
> I've seen interrupt disabled for over 40 msec.
> 
> Prevent rstat from disabling interrupts while processing all possible
> cpus. Instead drop and reacquire cgroup_rstat_lock for each cpu. This
> approach was previously discussed in
> https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/,
> though this was in the context of an non-irq rstat spin lock.
> 
> Benchmark this change with:
> 1) a single stat_reader process with 400 threads, each reading a test
>    memcg's memory.stat repeatedly for 10 seconds.
> 2) 400 memory hog processes running in the test memcg and repeatedly
>    charging memory until oom killed. Then they repeat charging and oom
>    killing.
> 
> v6.14-rc6 with CONFIG_IRQSOFF_TRACER with stat_reader and hogs, finds
> interrupts are disabled by rstat for 45341 usec:
>   #  => started at: _raw_spin_lock_irq
>   #  => ended at:   cgroup_rstat_flush
>   #
>   #
>   #                    _------=> CPU#
>   #                   / _-----=> irqs-off/BH-disabled
>   #                  | / _----=> need-resched
>   #                  || / _---=> hardirq/softirq
>   #                  ||| / _--=> preempt-depth
>   #                  |||| / _-=> migrate-disable
>   #                  ||||| /     delay
>   #  cmd     pid     |||||| time  |   caller
>   #     \   /        ||||||  \    |    /
>   stat_rea-96532    52d....    0us*: _raw_spin_lock_irq
>   stat_rea-96532    52d.... 45342us : cgroup_rstat_flush
>   stat_rea-96532    52d.... 45342us : tracer_hardirqs_on <-cgroup_rstat_flush
>   stat_rea-96532    52d.... 45343us : <stack trace>
>    => memcg1_stat_format
>    => memory_stat_format
>    => memory_stat_show
>    => seq_read_iter
>    => vfs_read
>    => ksys_read
>    => do_syscall_64
>    => entry_SYSCALL_64_after_hwframe
> 
> With this patch the CONFIG_IRQSOFF_TRACER doesn't find rstat to be the
> longest holder. The longest irqs-off holder has irqs disabled for
> 4142 usec, a huge reduction from previous 45341 usec rstat finding.
> 
> Running stat_reader memory.stat reader for 10 seconds:
> - without memory hogs: 9.84M accesses => 12.7M accesses
> -    with memory hogs: 9.46M accesses => 11.1M accesses
> The throughput of memory.stat access improves.
> 
> The mode of memory.stat access latency after grouping by of 2 buckets:
> - without memory hogs: 64 usec => 16 usec
> -    with memory hogs: 64 usec =>  8 usec
> The memory.stat latency improves.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Tested-by: Greg Thelen <gthelen@google.com>
> ---
>  kernel/cgroup/rstat.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index aac91466279f..976c24b3671a 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -323,13 +323,11 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>  			rcu_read_unlock();
>  		}
>  
> -		/* play nice and yield if necessary */
> -		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
> -			__cgroup_rstat_unlock(cgrp, cpu);
> -			if (!cond_resched())
> -				cpu_relax();
> -			__cgroup_rstat_lock(cgrp, cpu);
> -		}
> +		/* play nice and avoid disabling interrupts for a long time */
> +		__cgroup_rstat_unlock(cgrp, cpu);
> +		if (!cond_resched())
> +			cpu_relax();
> +		__cgroup_rstat_lock(cgrp, cpu);
>  	}
>  }

Is not this going a little too far?

the lock + irq trip is quite expensive in its own right and now is
going to be paid for each cpu, as in the total time spent executing
cgroup_rstat_flush_locked is going to go up.

Would your problem go away toggling this every -- say -- 8 cpus?

Just a suggestion.

