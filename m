Return-Path: <cgroups+bounces-2901-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755E58C5CC9
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 23:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F051F22853
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 21:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B72181CE9;
	Tue, 14 May 2024 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="oA3G1sZz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD6181B93;
	Tue, 14 May 2024 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722131; cv=none; b=TXr/rVyYM4FTxZ9swnsnEDBrUSg0l7ys9WwOUuWSx81NpXwL1xWHQrotz9nP0GWZouTq0kyNBK3AIfmpiErQjFMB/qpF8VyAQKvRArt2vwA2cvnJ9PaehKntNlP0M2jZpFAqufTKfo1yVjBSz21mLladiGGtjakRxAVat+vxhyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722131; c=relaxed/simple;
	bh=HlmV3fYfS862Gw2Y44V0T78NlarxsqVus5X9aOaYhbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=IBwoMkmdklGneIfTo2OGspfr/D/0AuUXgPuiEt1rFcQ/SiLZwzM+W4AxjB4PvsME2I/hC6FkDjCCNTCe582Yh25bu9I0fiZXTyk38ib2t42ZKXEZHCxOthva1bZK65W87ezr8Sfcwb9yQI1908gLxaA51HzYsx7dnEpxwW6rhco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=oA3G1sZz; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 6z8usemhMGAMZ6z8us6Qwc; Tue, 14 May 2024 22:53:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715719986;
	bh=aLWlgahzJcaRGqUoakghQCTDX9EaszXl5pn3yfSS5as=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=oA3G1sZzCQhftt1mEv+keu25rsjPFSjtCQ9ned9HKtiM/yL6JVkKpoW45o0E5f2fj
	 gEWLKMW/7Q692b2/vVAB6IM5e1mJVg79qaNCceq17RnEe7omto1u3Ow+d4RG4RoipT
	 Aq5qqZFnOKLd/bMiho/vkF4OweOFJqOwVInw8+OaKmI9ibR34aEiB6QccmWTAj+RZC
	 rIexraXe7uHNGSbE2ojyX4a+47UjKENSXbOvPVULZsGemzPGs86vjgZdnBw0tTDYRs
	 6nkW+MuNc0b+dOWDRbJlJGlGnkmNTRX1EW7Pcpu6teGxXF6/7h248i2jbyzIeJ6EEg
	 TJYe7foJbHwCA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 14 May 2024 22:53:06 +0200
X-ME-IP: 86.243.17.157
Message-ID: <9fb7adfc-701b-427c-a08e-a007e3159601@wanadoo.fr>
Date: Tue, 14 May 2024 22:53:00 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] sched/topology: optimize topology_span_sane()
To: Yury Norov <yury.norov@gmail.com>
References: <20240513220146.1461457-1-yury.norov@gmail.com>
 <20240513220146.1461457-3-yury.norov@gmail.com>
Content-Language: en-MW
Cc: anna-maria@linutronix.de, bristot@redhat.com, bsegall@google.com,
 cgroups@vger.kernel.org, dietmar.eggemann@arm.com, frederic@kernel.org,
 gregkh@linuxfoundation.org, hannes@cmpxchg.org, imran.f.khan@oracle.com,
 juri.lelli@redhat.com, leobras@redhat.com, linux-kernel@vger.kernel.org,
 lizefan.x@bytedance.com, longman@redhat.com, mgorman@suse.de,
 mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
 rafael@kernel.org, riel@surriel.com, rostedt@goodmis.org,
 tglx@linutronix.de, tj@kernel.org, vincent.guittot@linaro.org,
 vschneid@redhat.com
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240513220146.1461457-3-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/05/2024 à 00:01, Yury Norov a écrit :
> The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
> even though cpu != i. In such case, cpumask_equal() would always return
> true, and we can proceed to the next CPU immediately.
> 
> Signed-off-by: Yury Norov <yury.norov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   kernel/sched/topology.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 99ea5986038c..eb9eb17b0efa 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2360,7 +2360,7 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
>   	 * breaks the linking done for an earlier span.
>   	 */
>   	for_each_cpu(i, cpu_map) {
> -		if (i == cpu)
> +		if (i == cpu || tl->mask(cpu) == tl->mask(i))
>   			continue;
>   		/*
>   		 * We should 'and' all those masks with 'cpu_map' to exactly

Hi,

does it make sense to pre-compute tl->mask(cpu) outside the for_each_cpu()?

CJ

