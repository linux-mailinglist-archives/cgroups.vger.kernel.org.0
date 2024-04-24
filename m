Return-Path: <cgroups+bounces-2693-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4808B081E
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 13:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BE71F22D0B
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 11:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303C9159900;
	Wed, 24 Apr 2024 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTjHQZDe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C31715959F;
	Wed, 24 Apr 2024 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957165; cv=none; b=fhNOgNNtXicjkL1WmE3M7hRN/anJUaqZqhenEYy09CRDApkQzktQzdRpfO5+YqiRXk4k4QcpGoUqi+GHnN+DJqGqelOoZkEm1y+GJFD0J3zmqi96ZuGCT5sX5hxuLB6ocnu40reCgl5zLqFe/1Fm54ZoV+pgeyb1wJvhEHVuFJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957165; c=relaxed/simple;
	bh=Capoar0JcgEEWJZHUFEG+h+Mq07L06tFTQf1pF2TJ/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGCgBUy0cIw6p1KbJaX0/viPJUczixW2wK6wM1xio11T28VU4VFlhG6DiUrT8qwILu21Vbv+HGVDqLcU5WODnOmrzckFfehVb3irwPIVIf68vFGo/rEzG3IoovOSlwUAR4zPGsX3SpXvMO91BzSNwu55veoXvwnyEnE9B0+PxOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTjHQZDe; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5196fe87775so7595915e87.3;
        Wed, 24 Apr 2024 04:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713957161; x=1714561961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9moSbURQqGL8bMH7TAUq09FfsHi6dxjYFhtOBIYbTTE=;
        b=XTjHQZDegr8lPGxqJzG5wAI45eLDyoNXEYU7itMf5owtmhL88vZ7/qqJikChYHOOlh
         Re7pjOBdNRZgHh0PmmWJNTE8ysVxKb1dFuMdV52xsKtQMGOT/M8N0p1ExSOVbkTimH7X
         r0IjvoOb6C6DxKTfVK48P4PVzQ2uiDpeyjjaNHUwJ+4XkA8jlq1VuWbOP8SL4QFa12iE
         FeKyNaMnSH/2gH0AWhEtiCO2i0joa+owQXxsPRe6RdOq9TrFUJhIrSYWMf3aPxEKxAKE
         zmL+Mv987hWFd6gh2bno/Zd0TcTqh2fxipTZ+rpGPS4Fyo6QS+giRLFbc7sk3W6XWMLQ
         pwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713957161; x=1714561961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9moSbURQqGL8bMH7TAUq09FfsHi6dxjYFhtOBIYbTTE=;
        b=wOwVpo6gWPu49O6rj7mcU3mYmqPZSTqaaeivl70VCY7+TnON1reUT+KXwfripR+0TW
         HIQVbMY4rUl5y2tzHpZeDX/BBXF8cqhTXurh8VDJL8jCWfMzCSr3axl+qpiojLlQFiTy
         gLVazYSj/O8RETS5GIQBCjQsNfanE2Dg+33r7AebdvKqI6jTQ7bqU/SOEmAwsbrCOEox
         GOVq1MSLQXj47bfU0MYLe8o+lQWzxNwMgVw7se437pxrc7UDIxtqYQUEiJryxdM3g3Uh
         jXJ/PByHkCrHGs6iLbppGLXIJDIR184zvquKDoDxptcP517mc6ej7KiJkYi8b1XmiXM+
         Pqpg==
X-Forwarded-Encrypted: i=1; AJvYcCVKbqCvwdO9bxAbzZSsAxHcUfeFo7jSkWV/efdfWaHJNQ6C6Egp8fpuOTaqOL2fqydqrVVCR9DfZjSpcKafLsFhMjCOACtswg==
X-Gm-Message-State: AOJu0YyPA/Frkc1JVqUOsEnN0Jh4bgpXepl27ln5RjJKYbmVcVyLhe52
	fXsgKIhG1IvCUdwo0enVVfEOLrOZ9xSWoJz2ZbmUgRLl92jWz4gJ
X-Google-Smtp-Source: AGHT+IE7URul0a2ErvggWgeKQb58UM48vJOunFG/fZWrOLZNlW5Eak6Ls56r51ivk2ioElOZxgvUJQ==
X-Received: by 2002:ac2:58fa:0:b0:51c:1201:c056 with SMTP id v26-20020ac258fa000000b0051c1201c056mr294998lfo.53.1713957161166;
        Wed, 24 Apr 2024 04:12:41 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:2659:d6e4:5d55:b864? (soda.int.kasm.eu. [2001:678:a5c:1202:2659:d6e4:5d55:b864])
        by smtp.gmail.com with ESMTPSA id y32-20020a0565123f2000b00518ac6f0a31sm2361506lfa.18.2024.04.24.04.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 04:12:40 -0700 (PDT)
Message-ID: <843bc3d3-5032-4913-84fb-dc2107f0b554@gmail.com>
Date: Wed, 24 Apr 2024 13:12:39 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup] cgroup/cpuset: Fix incorrect top_cpuset flags
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20240424010020.181305-1-longman@redhat.com>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20240424010020.181305-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-24 03:00, Waiman Long wrote:
> Commit 8996f93fc388 ("cgroup/cpuset: Statically initialize more
> members of top_cpuset") uses an incorrect "<" relational operator for
> the CS_SCHED_LOAD_BALANCE bit when initializing the top_cpuset. This
> results in load_balancing turned off by default in the top cpuset which
> is bad for performance.
> 
> Fix this by using the BIT() helper macro to set the desired top_cpuset
> flags and avoid similar mistake from being made in the future.
> 
> Fixes: 8996f93fc388 ("cgroup/cpuset: Statically initialize more members of top_cpuset")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e70008a1d86a..b0a97efa5f20 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -368,8 +368,8 @@ static inline void notify_partition_change(struct cpuset *cs, int old_prs)
>   }
>   
>   static struct cpuset top_cpuset = {
> -	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
> -		  (1 << CS_MEM_EXCLUSIVE) | (1 < CS_SCHED_LOAD_BALANCE)),
> +	.flags = BIT(CS_ONLINE) | BIT(CS_CPU_EXCLUSIVE) |
> +		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>   	.partition_root_state = PRS_ROOT,
>   	.relax_domain_level = -1,
>   	.remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),

I saw this made its way into today's next and can confirm it fixes the 
issue I reported in [1].

Thanks,
Tested-by: Klara Modin <klarasmodin@gmail.com>

1. 
https://lore.kernel.org/lkml/f2edf788-6ff3-43b1-9445-ac237e7910ac@gmail.com


