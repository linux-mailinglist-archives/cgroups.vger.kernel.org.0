Return-Path: <cgroups+bounces-11400-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1FAC1CAAF
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 19:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8930E34CB5B
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 18:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8222773E5;
	Wed, 29 Oct 2025 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYbmijtr"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879B2E7BA2
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761126; cv=none; b=OKsclWcPCKJMOvhbp+ZxxCtlXMCvW2HdgV+d23LGL2fL6gUrCnoDynD7n0FRT/+wY0KZGugmICZao9nzCu4c/4qM4tLE74AXEdn5uMvA0TV+8gi6YsWSPrcvMqRCyxhqE5QDKfVuDDqv4YyBx6ftOTEyP45KqaYiYxPZL4H24V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761126; c=relaxed/simple;
	bh=aab43vnKM1ss0I9X3ZkZ8BKt0Ft4cLo8wB19nB+wzAE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tR1OaomGdMLJ+BLBTAdfCNmjHRoMBMVTfViXlW9Ad3Zam4jUIK7CzC16Az7F8Ky2QlfHWD7QiujsvlCs+ufgLJ4WmFIauYUqmrgXIzZccY2PAZCoGnjJ2MZO1jxX72SdEai0OK7re4rG57lH4n30hQ1IoeKcUqn5NNz1HU4wWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYbmijtr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761761123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNxXxUzXoqQQT9w5Yf9S20ddLNixsnFzdxWTN/CN8Uk=;
	b=gYbmijtrB+zF98TRvYLLyXqmeAG2wKMF2urZ4vjIWmwfyW04zy1akasjPDakkSnJmw77eR
	7X4MPp/gWggKTFJiZvYDuY7Qv5vOAUBKLREwIy2KGeENW/5j6EjTPwF0kLRIa+sTh7lJ47
	egI47aML4SikhRaZrfMi9AjfqYq4UM0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-lq7Sdw7YO4y-75X9Sm1Kfg-1; Wed, 29 Oct 2025 14:05:21 -0400
X-MC-Unique: lq7Sdw7YO4y-75X9Sm1Kfg-1
X-Mimecast-MFC-AGG-ID: lq7Sdw7YO4y-75X9Sm1Kfg_1761761120
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-89f7a8b9775so37154985a.1
        for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 11:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761120; x=1762365920;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNxXxUzXoqQQT9w5Yf9S20ddLNixsnFzdxWTN/CN8Uk=;
        b=ULTrZLZDDwDHvTk6hReBZxPPlrdNIwUdDpokFCxaio+DRjYkxCnl/991UX764DwS13
         +DnXKn9hxusZHnk1WoWasAHpYJVzLcZkIwVnunOLu0DlH99RHcgricEN2JzRduUadymN
         XUkgQgOjWCNNUb+XRAZLtjzv5YcrhpDxrmNtUemhBzg/cEwrwRQhVT1FCnlJ4A1OlGXk
         X56wswCOwoqpLGjDm8ucimjxkCMYz6KD9NK3vVvASKwT7P4jM9v0ievWoFS7ff0cY3q4
         LpMrzCjw1gA3DsPcihjm0AYANsDNM3RuD4hinANe/pixzb7v+MokfSWmwtcWwMB+ALeB
         LBNw==
X-Forwarded-Encrypted: i=1; AJvYcCU7r+b6Co60XAKC1Mp64r+PujZhlIL+Wz3oil+D1kgdxwESpke7SFm3WPfJRxZJfZ/n/3M54m4j@vger.kernel.org
X-Gm-Message-State: AOJu0YxPu/ATjcA/AzQMiN7ejVii79QBxdsyB56ZDjfITFTeSp2qXmVD
	QYpLl6tIitIg4R0JzQp0nCmLE/4x4vjqiL9IGZOYoW0K1IDM5XO6Jc9LaKwWJUw7O+wb2UbOwUS
	P3lZ/ELJy/viKbecF+s+FuS5iUx4oQ6koGuRHzNcSRqcNtt2Ymhw3983AAZ4=
X-Gm-Gg: ASbGncukaTRGioW+lgdNP4PaBZGJFXEuSCMMaSVHnH5yruvmG2k3jarXJBf11caMLTO
	BZYcFiGJLskSUolXmWJ1XIQ4ilHbBfefA7mSumBkjBxFAuBmr/Wv71LEB9yGdydfBfZ3m9xUts1
	c6PGGMDZEIBgnL3i9im1/h++Asby5MmyB9resLeNksV+wbxlW3mALaUkEDXnLM3a0heC80U/U0I
	aM4KkkxJbHrELYxPrqoDHyZrF4YSgpYngQ4evhjAv0ED8H4hVYAFncXZlxq4tYF10RUsIqfwmld
	UfGm2o8M4ON4JEFWA9u9xIDrgkjiF1/z32kSQmH+XhD/zz17D3PFPO2dG/Wx/Gl2masQzWMUn43
	ZuMUOgxbeTRIC/x2YE1tXQOexmNuVsNKYFRlNKId9RUYoRQ==
X-Received: by 2002:a05:620a:29cd:b0:8a6:92d1:2db5 with SMTP id af79cd13be357-8a8e473a6e6mr573643185a.24.1761761120449;
        Wed, 29 Oct 2025 11:05:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE6iTF4BqCkm725oJpB//2W/KjYfs5LBPrMdbtexGrXjP/dhJ17Z6sn/BKCKYXRH3K32fmkA==
X-Received: by 2002:a05:620a:29cd:b0:8a6:92d1:2db5 with SMTP id af79cd13be357-8a8e473a6e6mr573635985a.24.1761761119960;
        Wed, 29 Oct 2025 11:05:19 -0700 (PDT)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2421f6a5sm1111574885a.5.2025.10.29.11.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 11:05:19 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <7821fb40-5082-4d11-b539-4c5abc2e572c@redhat.com>
Date: Wed, 29 Oct 2025 14:05:17 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/33] cpuset: Remove cpuset_cpu_is_isolated()
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Danilo Krummrich
 <dakr@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-19-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251013203146.10162-19-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> The set of cpuset isolated CPUs is now included in HK_TYPE_DOMAIN
> housekeeping cpumask. There is no usecase left interested in just
> checking what is isolated by cpuset and not by the isolcpus= kernel
> boot parameter.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/cpuset.h          |  6 ------
>   include/linux/sched/isolation.h |  3 +--
>   kernel/cgroup/cpuset.c          | 12 ------------
>   3 files changed, 1 insertion(+), 20 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 051d36fec578..a10775a4f702 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -78,7 +78,6 @@ extern void cpuset_lock(void);
>   extern void cpuset_unlock(void);
>   extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
>   extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
> -extern bool cpuset_cpu_is_isolated(int cpu);
>   extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
>   #define cpuset_current_mems_allowed (current->mems_allowed)
>   void cpuset_init_current_mems_allowed(void);
> @@ -208,11 +207,6 @@ static inline bool cpuset_cpus_allowed_fallback(struct task_struct *p)
>   	return false;
>   }
>   
> -static inline bool cpuset_cpu_is_isolated(int cpu)
> -{
> -	return false;
> -}
> -
>   static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
>   {
>   	return node_possible_map;
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 94d5c835121b..0f50c152cf68 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -76,8 +76,7 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
>   static inline bool cpu_is_isolated(int cpu)
>   {
>   	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
> -	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK) ||
> -	       cpuset_cpu_is_isolated(cpu);
> +	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
>   }
>   

You can also remove the "<linux/cpuset.h>" include from isolation.h 
which was added by commit 3232e7aad11e5 ("cgroup/cpuset: Include 
isolated cpuset CPUs in cpu_is_isolated() check") which introduces 
cpuset_cpu_is_isolated().

Cheers,
Longman



