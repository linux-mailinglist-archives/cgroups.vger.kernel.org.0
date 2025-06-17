Return-Path: <cgroups+bounces-8575-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972E3ADDD97
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 23:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351C117B417
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 21:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13A72E3B09;
	Tue, 17 Jun 2025 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsLbzwUp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB66115C140;
	Tue, 17 Jun 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194343; cv=none; b=Z5V2avpdASkpg6QCDiovbSjomiT4Gtrrwag3i74+MSrK+qoCckC8OtnUwIR7Ot1LVGqLQOnFhcrNON31InjQ+zKtOKTe8ap8QIFgVjyh+p2fMl3XgGQlgdLV2DqGgHS4yIW+Bnx19gShzpLvZpNlRCN+wVZpj1eQSes21gD6mEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194343; c=relaxed/simple;
	bh=K/e54EAvNiLlkzbiKQYq+G8jP/1PnG8jLy6urW7N7iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NC/lXiInhF5Y2wI1rKrMbi/mNJpDZ7CjLceni92PgSYXG9OfT6zoz2aZbpga/38oH0IGbBwTGNvQ2koH3r5ddILC0mvBF/au3SjqRelxK9m6jD6pKWyFhgXyrpKELjYk2Vm50IgaTKP0HU//tdqiaWlyI++CvKm8chW6tu3xdOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsLbzwUp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23649faf69fso61609515ad.0;
        Tue, 17 Jun 2025 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750194339; x=1750799139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MWZI32CNOnN9IhM9ZQkkMorkMQBTP2lW8bYrpv0gJAY=;
        b=UsLbzwUpDfCDepfRerocs8xr/fJfiIRxEHVw4ZPyj92XN5JoAAZNKdcco5TVaIbZTQ
         Az3Y8zJ0hb9MGGUz3P6xe3pa1/QgpCoIsLa56iMeTH5+fX+4jNaXEyBtz/lQhpxbzVhE
         Dmi9tRD4pljCsYnCJ8srF6RGIJ08k94o4tAyRgyefJvLvsautuv8A++MU9lIqPP+Wtbr
         auuI44IX7emMBjDT4Xx7fLRWh8B7tjwtJKFAy+w7GnEkuGSnf2p1nazENfhmVS4qO0Ax
         mlPJl9+FZ/DqtWXc//rDpq0ORfb5gjaayupL3i5R/zenldTgd0t5NzTkC+MLp+LPm4nW
         rLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750194339; x=1750799139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWZI32CNOnN9IhM9ZQkkMorkMQBTP2lW8bYrpv0gJAY=;
        b=kox4Qaem0bTBi/0WJKW2v8ibTjAVySb58+2BuB+fAoOdm7Dbn4xGy9KJV91qnwzD+M
         0PNcbTtpDAFMhWxrkSelzVqCcdJ2smpUlwPHcp15L0MYX2TiJUGplTSbKyZTwZ25eFX0
         K6glW76zaAnVBz7XqJoGFMaIMcYZXaCNIzjg6mesIIiX+7zYucjWw0QuXbj4eZhvW1/k
         LgJHfhYooOU4fLLnWjsNPsVM826HwMiHvnAh3LLwsdl5MIqOELHipQfo606Be9rjUnhw
         2d0coPwmCKz/GRv1aLnEx1LWX6rfc7qNf7cPxxRPn/zw4UeOwInQ19ZBJbhsD3AkkXrl
         ziTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCk6+M8lk7UBW1mw3LlOAhGbxP7oaTMLKGIpqUWnIhm9HgLEXgWOU8ZfE/o/YWJQhyHFdMPUs+hu5tz+Fk@vger.kernel.org, AJvYcCWuZCZZWQD4gTPntha/5zo52Hx/WLK1zX/3W/+U68+0zhvBv+opaz/FYDLV4bcT6bPcSM2YsM7J@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7FLtW+eckrpcWm1diqO4XVZvtjOZN4HEQuHNfLMvSvFxAMIlS
	MgQ6r1SCCHwMuI7DNfyLHTGgqCkpT2IdPOwQTz9SM568YnmTaz7Le0H8
X-Gm-Gg: ASbGnctbdljFYhZLCHK7ahZ/VjKsm2Qez84RKdilchO9NompxykOIXvUssQOxZ4IGPg
	avs3gY03P7zdZkc9wyWMKuB4B1wkxNHhoIX1ft79cBxSrF0V4EfgTmYKNCpuRV5ArYKl3WXwwEE
	ZvFoqkbU7xkYzEIiknTo/lFmMIxnxF1l8SNlomHjaEM/qd7j1eO3X7pzDCEbOsM2ATQ76LAg/MA
	0/8qUPcfvCc4ig0NgAjir39jO9OknnxAg9vx/5Ozi24DLl6DuAOBDFE3O9Z6S9K9vmIrK3MGJO/
	MtjDWVlVNjkwXRKBsnviIlqt9I5TbH3wIux5TB/Mr1esWt0bZsuVKUlsKtdHIaU8fZUspGrG2aU
	+p2NnCsdCyIWM2BXMbPCGFCldshhXzD4PITc=
X-Google-Smtp-Source: AGHT+IHJ8Zz+Wa41Mi58v0WVUmeQPuLbyqXhrbVushVSr8N5IOiRmInDATrimOPjEYn0atMSm4xAKg==
X-Received: by 2002:a17:902:f652:b0:234:cb4a:bc1b with SMTP id d9443c01a7336-2366b17c593mr237597885ad.49.1750194339137;
        Tue, 17 Jun 2025 14:05:39 -0700 (PDT)
Received: from ?IPV6:2601:648:8100:3b5:c6ef:bbff:fec0:9e95? ([2601:648:8100:3b5:c6ef:bbff:fec0:9e95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365decb5f9sm85041815ad.194.2025.06.17.14.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 14:05:38 -0700 (PDT)
Message-ID: <5f055416-9c49-42c0-9ba0-e45f6aaeac04@gmail.com>
Date: Tue, 17 Jun 2025 14:05:37 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/rstat: change cgroup_base_stat to atomic
To: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250617102644.752201-2-bertrand.wlodarczyk@intel.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <20250617102644.752201-2-bertrand.wlodarczyk@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/25 3:26 AM, Bertrand Wlodarczyk wrote:
> The kernel currently faces scalability issues when multiple userspace
> programs attempt to read cgroup statistics concurrently.
> 
> The primary bottleneck is the css_cgroup_lock in cgroup_rstat_flush,
> which prevents access and updates to the statistics
> of the css from multiple CPUs in parallel.
> 
> Given that rstat operates on a per-CPU basis and only aggregates
> statistics in the parent cgroup, there is no compelling reason
> why these statistics cannot be atomic.

Have you considered the "tearing" that will occur when writes and reads
are happening in parallel?
The existing state is more of a snapshot approach. Changing the fields
involved to atomic and lockless reading/writing can result in
inconsistent values, i.e. fieldA might be more current than fieldB.

> By eliminating the lock, each CPU can traverse its rstat hierarchy
> independently, without blocking. Synchronization is achieved during
> parent propagation through atomic operations.

Even if the tearing scenario mentioned above is acceptable, removing
the lock will break synchronization of flushing non-base stat
subsystems.

> 
> This change significantly enhances performance in scenarios
> where multiple CPUs access CPU rstat within a single cgroup hierarchy,
> yielding a performance improvement of around 50 times compared
> to the mainline version.
> Notably, performance for memory and I/O rstats remains unchanged,
> as these are managed in separate submodules.
> 
> Additionally, this patch addresses a race condition detectable
> in the current mainline by KCSAN in __cgroup_account_cputime,
> which occurs when attempting to read a single hierarchy
> from multiple CPUs.
> 
> Signed-off-by: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
> ---
> Benchmark code: https://gist.github.com/bwlodarcz/c955b36b5667f0167dffcff23953d1da
> 
> Tested on Intel(R) Xeon(R) Platinum 8468V, 2s 48c 2tpc, 377GiB RAM, Fedora 41:
> +--------+-------+
> |Mainline|Patched|
> +--------+-------+
> |369.95s |6.52s  |
> +--------+-------+
> 
[..]
> @@ -820,7 +813,6 @@ struct cgroup_subsys {
>   	 */
>   	unsigned int depends_on;
>   
> -	spinlock_t rstat_ss_lock;

This lock is not used with base stats. The base stats are not a formal
subsystem.

[..]
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index cbeaa499a96a..36af2b883440 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -9,7 +9,6 @@
>   
>   #include <trace/events/cgroup.h>
>   
> -static DEFINE_SPINLOCK(rstat_base_lock);
>   static DEFINE_PER_CPU(raw_spinlock_t, rstat_base_cpu_lock);
>   
>   static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
> @@ -37,14 +36,6 @@ static struct cgroup_rstat_base_cpu *cgroup_rstat_base_cpu(
>   	return per_cpu_ptr(cgrp->rstat_base_cpu, cpu);
>   }
>   
> -static spinlock_t *ss_rstat_lock(struct cgroup_subsys *ss)
> -{
> -	if (ss)
> -		return &ss->rstat_ss_lock;

This was needed for non-base stat subsystems like memory and io.

> -
> -	return &rstat_base_lock;
> -}

