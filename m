Return-Path: <cgroups+bounces-12760-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80054CDEFFC
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 21:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B6DA3006593
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 20:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B0630E0D6;
	Fri, 26 Dec 2025 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLnarn3B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7xOBbyA"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C761278753
	for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766782098; cv=none; b=TiWybeig/hKuUnHv51fxaGnCcbpRMiG7/f5F0IyQaS8gf4P296i9dLZGPAeOAc8awQY/FRedrEla1qlKJ083ytwzjfJkQEBpsfrkPjfdVsOLaaZX5MxyhCTj4e8WfdNwoaejzLRurNo1JjnltZfLvaPHkaoBnOXz+lukv+zWpHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766782098; c=relaxed/simple;
	bh=EAgJ3664AENbLI1S3Tf4CRT9521EaZ0GR7ptn4Sh+c8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nXy+aQBeOSYz9ieT7+w41ATxKt+CtIh0xhfawrl/+kbLhmW/CWNUdeIMl5eyr9+BwMDS7KlFag7RPSnoA34AP+M+sjzZIV4VgTsyC4yhJbJHhHbVQr4LHRCqaMRiiwNQi0K75mK0jr2dNfP8apdlcVXOrYCaj28jkYT1Xwij/S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLnarn3B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7xOBbyA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766782095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RM8xUWiPB1W0MgA0qXcU7NgXtzuyc/5Zx2MgNVttglw=;
	b=DLnarn3BH+CkNjBqtnA4PlfQa2pRx452LmsR2yKVfImPgEWqREbr90ajKcY+7/81nTjaDA
	uL+/JfbW+rt0XYmrcJynRB2/Mok5Kw55llN1KMU6PBvuigJAdO2QqZLNDCI87cp1gBSFka
	eHeFdnrh48aRDOfXAN2vcOgsNle5H8A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-U3m6XRunP9iyeV0Y5sXDGA-1; Fri, 26 Dec 2025 15:48:13 -0500
X-MC-Unique: U3m6XRunP9iyeV0Y5sXDGA-1
X-Mimecast-MFC-AGG-ID: U3m6XRunP9iyeV0Y5sXDGA_1766782093
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b55a033a2aso2061349585a.0
        for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 12:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766782093; x=1767386893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RM8xUWiPB1W0MgA0qXcU7NgXtzuyc/5Zx2MgNVttglw=;
        b=H7xOBbyAuo5hdzdfuFjgFSJZ4hdKURvGi1NPWv40M2tg6NlRjrmsFbHhMw3tV5nkjw
         21MC7Yrw3tHLZ9VmUgdyhh7hSvxfxxARpwh+Uk8DJ8DLI7iZx13FAJiE1e9M/95u1U2l
         qwsFbPosRAUX8mrJnU1url6puTKNAhsEHKaJ/4wi5nJLcnwwZxIJxlM12HwnJvDVHQR1
         P6O+1UFWitXQs6PvpkWFB0fxv3TvnT85XCvsEX+WMSClu2r5X2i1UPfdqeADLY1ic7nJ
         p4LDV7zr7XJ23AbLXSIBuuqyzg+DbchTq/ExVWX+NyII7irnnSJ6v5Fzxag8rCGzn0SK
         pG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766782093; x=1767386893;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RM8xUWiPB1W0MgA0qXcU7NgXtzuyc/5Zx2MgNVttglw=;
        b=tqyAOj86V0COsTAYNvc4zYkMX3YORs+3sBWlVZpLRyMGVt5XUQ0GOVdNV5luYqNg0N
         tXvnb41ZyIVomwK1CetpiInEoT7r5K5++Gp1VmejvcQ3DPwlUfd8tBTdDIF9ldALcDWW
         CO7J1ETqCHYB3k1HyBSsRqJ8dnhS4VaWlkCT5xEJkwBx8KqoeUkghaSJ4AddVrlzSmks
         qW0kOqI9vcD7PmysXvhC5uGIFXN+5H2anHsM5TBK+jGUun4jXOqPRpjIFDpa1ddrJNZa
         qUEnUbHJMWGOKoFkB/mmmzOQ9K2Zf2vYXkPVVOERXT46ohSwk4t9e5bDyX5lEGF/g1bh
         33BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfN9tDHcbCbjLahz5kaFCvb2fOl3BBJj4IQRJQWko2W50xLR4sMfNJbo2MMANT+DRLODHIf0Z5@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl1cNWiKcK6ra1YmbahBLIBdHl2Da11rYQdyp6TGWAyvapEZ2L
	pwrk56O4AL9bBIKFIgRjYN5tmB4zdvetRKaUVF2Ed3Omw8ZlcP5pC1dUcfVl/XK0uZeYvlaq029
	S+F+s2hpM5tt24JIfzOxl5kSRETmZP3FQvbTYDPE7zkFRDGs74RPtsqfakxw=
X-Gm-Gg: AY/fxX4omXZrO3B2fVFE7aB8twzDRhzegbweipI2/8SCg6SAU9/MJygxnhU0ZAHAA3H
	9/8tLR4jVXthDxQUCwj2gNfwTqjhhovAMfdPCYUkYupoTYxLTsSjY9KbiisB0/fLwYZSzeOj2Td
	xEzTwtU/FhIgGCD4c8BW5UYeWoJ4cmAR2gmIu2l2AY7RfCbZWGP8vudwM573ac2GHDL7JPnMFNN
	wKKlNlNPP3F/ynPZWPffxDn5kqrOXk9Dnty9xDRADGDYRvS/Gbxm7IbvR/mIPKtNIbylEk1Go+W
	FMGJhh98BgrSwFwaHshH7pruXnAESmOwu5M2WGS5nwkJaofdgL6LMWY3iPFTVH2fhwJWft4aP4X
	Z2mNtUH3mZMJGHT0EDxWWbI6zpO21IuqUMLmeInJaflsjNWf08v65w/Qt
X-Received: by 2002:a05:620a:4450:b0:8b2:f5b5:c9bf with SMTP id af79cd13be357-8bee76c8ecdmr4098090385a.22.1766782093298;
        Fri, 26 Dec 2025 12:48:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5vt35jXazmAlmHnLRQK7CDf0928bdO3E07iE5exs1VnuKt+dhmYfT9Sq8ULHkPw+Z5ZFmhA==
X-Received: by 2002:a05:620a:4450:b0:8b2:f5b5:c9bf with SMTP id af79cd13be357-8bee76c8ecdmr4098087085a.22.1766782092880;
        Fri, 26 Dec 2025 12:48:12 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d96ce4e23sm205030136d6.19.2025.12.26.12.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 12:48:12 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <eb7920d4-bca6-4692-9b8f-7feb715a6ec2@redhat.com>
Date: Fri, 26 Dec 2025 15:48:08 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/33] cpuset: Remove cpuset_cpu_is_isolated()
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
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
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-22-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-22-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> The set of cpuset isolated CPUs is now included in HK_TYPE_DOMAIN
> housekeeping cpumask. There is no usecase left interested in just
> checking what is isolated by cpuset and not by the isolcpus= kernel
> boot parameter.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/cpuset.h          |  6 ------
>   include/linux/sched/isolation.h |  4 +---
>   kernel/cgroup/cpuset.c          | 12 ------------
>   3 files changed, 1 insertion(+), 21 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 1c49ffd2ca9b..a4aa2f1767d0 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -79,7 +79,6 @@ extern void cpuset_unlock(void);
>   extern void cpuset_cpus_allowed_locked(struct task_struct *p, struct cpumask *mask);
>   extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
>   extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
> -extern bool cpuset_cpu_is_isolated(int cpu);
>   extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
>   #define cpuset_current_mems_allowed (current->mems_allowed)
>   void cpuset_init_current_mems_allowed(void);
> @@ -215,11 +214,6 @@ static inline bool cpuset_cpus_allowed_fallback(struct task_struct *p)
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
> index 6842a1ba4d13..19905adbb705 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -2,7 +2,6 @@
>   #define _LINUX_SCHED_ISOLATION_H
>   
>   #include <linux/cpumask.h>
> -#include <linux/cpuset.h>
>   #include <linux/init.h>
>   #include <linux/tick.h>
>   
> @@ -84,8 +83,7 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
>   static inline bool cpu_is_isolated(int cpu)
>   {
>   	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
> -	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK) ||
> -	       cpuset_cpu_is_isolated(cpu);
> +	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
>   }
>   
>   #endif /* _LINUX_SCHED_ISOLATION_H */
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 25ac6c98113c..cd6119c02beb 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -29,7 +29,6 @@
>   #include <linux/mempolicy.h>
>   #include <linux/mm.h>
>   #include <linux/memory.h>
> -#include <linux/export.h>
>   #include <linux/rcupdate.h>
>   #include <linux/sched.h>
>   #include <linux/sched/deadline.h>
> @@ -1490,17 +1489,6 @@ static void update_isolation_cpumasks(void)
>   	isolated_cpus_updating = false;
>   }
>   
> -/**
> - * cpuset_cpu_is_isolated - Check if the given CPU is isolated
> - * @cpu: the CPU number to be checked
> - * Return: true if CPU is used in an isolated partition, false otherwise
> - */
> -bool cpuset_cpu_is_isolated(int cpu)
> -{
> -	return cpumask_test_cpu(cpu, isolated_cpus);
> -}
> -EXPORT_SYMBOL_GPL(cpuset_cpu_is_isolated);
> -
>   /**
>    * rm_siblings_excl_cpus - Remove exclusive CPUs that are used by sibling cpusets
>    * @parent: Parent cpuset containing all siblings
Reviewed-by: Waiman Long <longman@redhat.com>


