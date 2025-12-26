Return-Path: <cgroups+bounces-12742-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BE7CDE47E
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 04:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8827300C0E0
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 03:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58F431353C;
	Fri, 26 Dec 2025 03:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQKBLgM6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRXDXJvE"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0252E92BA
	for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766719280; cv=none; b=eNOz3Bg2357HKytXKJUo108djrW29EFrUdz6UDK7sl13ZHumLX/hxGQ2nPHJvBtu+mMHEct0BvQ1ooW6FHCjYoHeTD2Sdipz+5R0RkgVocGqPuMevzYDfOrLKwjz9TI1UbRnq6vOTVaxkcMgwJ3QlW1quynrlCy24A9jlMy55qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766719280; c=relaxed/simple;
	bh=y/+bcKUPZ2qPkgiB+TP48kY5Y7VCKR6l2NOE4CGOIto=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dNw0t6dr4QvKePYsM3IBYopNAc5XtgcQ08qKZpvBqClyMHg5kVDoPWZqyZIcy+Jm1YfnbVTbxVEvDnUo/ZaN9dn1xJbcfhrFW1aCXGZrtc0+w3NaiXe/nH1ZgGT6jY5TP6Ve4yXD1hwOpDHZNUKXHgc4KPJ4t0s3NYGCEeXgbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQKBLgM6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRXDXJvE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766719277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKHp6uC5zNb3gZSMB9BQPFV3o9H0iVs2RJyYgnJbrKc=;
	b=SQKBLgM6bKLYePxUlnJJS61R+Ob/e76i8C5+xTjJmXm43xJ1Ohx/HBC/iP7t9KBJTWTXhl
	U2ARbSZrwzh5kLIN6xxb+UO6Ezo8mGlWOvU1xCX5GhaEgDAVQVZOlye5xkHuGUITtJ2iNN
	2q3cjoDHQnzUv4I+XW4ougj1IICB3yE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-C6h6swHVOnKasNBXEwvwZQ-1; Thu, 25 Dec 2025 22:21:15 -0500
X-MC-Unique: C6h6swHVOnKasNBXEwvwZQ-1
X-Mimecast-MFC-AGG-ID: C6h6swHVOnKasNBXEwvwZQ_1766719274
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b99f6516262so18853472a12.3
        for <cgroups@vger.kernel.org>; Thu, 25 Dec 2025 19:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766719274; x=1767324074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dKHp6uC5zNb3gZSMB9BQPFV3o9H0iVs2RJyYgnJbrKc=;
        b=PRXDXJvEwPCO/NDTuBO+Sy8aPSc3/ThqX//r9y9c+0Sc5GuZ7Pch/T1vn6saYxhAgB
         baUWlEnY2ZwgybqcuP2u+GauFfXsW86cHdc3XekFVW2WbOvQ7gd2LQWLyjEDsTG9fkFf
         RRqcmoloU7VBqhkh4EkUU5imUs3Gld+N2hf8xMlXhcVtktoHgXgX4k56PDF1CGGNFfbh
         NV/YjcQwO0vHdvn3oFCGihDFuIf1h8cJB1gGrJ5EuzWD/Sc5kpD02mjjMHLx50NuOPj2
         pPZRd4qnktx0QVjRF1PDfP8uO1iXqceo3slvUPrE9Y3GT/XdBzQ7kZGsG35eG0qW4qCm
         HpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766719274; x=1767324074;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKHp6uC5zNb3gZSMB9BQPFV3o9H0iVs2RJyYgnJbrKc=;
        b=aMyyNhkVUwiCPr6U4R2gpU4gksWW6HY+bW7OBX+kGiho0ubMcTB0woIy187Eg+4m1v
         H5ehX4fobh7LmKTu5cK4SneLia3gCA+9gC2Ptzo4P5qGZNWjSj39ImvBuC5dQeYWEa2Y
         hzQ+UI19CSAYMRR5VpxU5fIdQf9UaN8iCVI8UfMrB0suw5zK7lTibEG+jtOu8azvgxfq
         lNoLHRXYy5IIkTfQWw2ZXnALSj01Bw6Y5xWVKce47nXSLVGFFfg44MY9I4Zq9U0CiaDR
         ZijLzGMzboATVguPZRWWVuRXQrS34hLMAqTMjSIyKEWavt2g2WE/3VtZFW2GHfISdVTp
         9AXw==
X-Forwarded-Encrypted: i=1; AJvYcCVvn7ezPyGIdIY+RgD/Nr2ZKBVdoLHgyeTKYdof02pN0ZLv8JQox5dDbUm3lrNnsk+Hdqdq+W9A@vger.kernel.org
X-Gm-Message-State: AOJu0YyK7Frozzj7VUa60IvOTngnGOscgT6iLZLLjjj/7z3HLj74uiPz
	aIogo1GyR1y5d/o3Yu8515rsWP3Di6HeLml2Et+cp32WZTuNHhVPaY4elrc4Szs0/U9RRZwL08E
	1EbXJP7gHO2n9uVDxGEBjzFeeOpCXuiAsxQCTTYDq6RM42A5BFzu/fmKfFO0=
X-Gm-Gg: AY/fxX5kaywBssiWgEk1ECB9HBRqyjErB/TXxiBojBPGJzuVs1LnKG+AkMph03XaQaW
	9B4MuQ/l1p///nipO08ILHb73a9UCJ+g2TNAZzDQNtyd1ufgOSKKAzUDx+3mc2jxmxiPX5JgKAC
	Rt/vpoKJHJyYkeUAeILQEDkGDjjObtYTMj5RI2R/qwKL8OURAi2vKnxbBYjR/3By4b1/Y4TTGPB
	BMYamQZ6Cj+R/+aPuKXvyMpT6uk/qqqwGrlvWnMy9M5MOI7yZ1dk7BTd67poult9kFxj61NlVAu
	8OwcqtPhL2kW8I3pLrRQE1pe5BXusJUq8/vBt6SHw73rKdv/lzyjqTuJ9Ol5/ZvPSGdTMXOlGyB
	cFrPPP0q+7/5wXQDsy3HDgVtQb9d9vj05qnte4JSF7euMrt9+H/YUBDWA
X-Received: by 2002:a05:7022:f902:20b0:11c:b3ad:1fe1 with SMTP id a92af1059eb24-121722b1a7bmr20901003c88.11.1766719274184;
        Thu, 25 Dec 2025 19:21:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrRbO/uTv2AgLdwLaHgNpsWrHMXpzUWqpTKYvMicj4UtKVHtP6aAiwD9wbO4xGgVHronC7tQ==
X-Received: by 2002:a05:7022:f902:20b0:11c:b3ad:1fe1 with SMTP id a92af1059eb24-121722b1a7bmr20900963c88.11.1766719273695;
        Thu, 25 Dec 2025 19:21:13 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm80252105c88.1.2025.12.25.19.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 19:21:13 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5b019a5c-1db4-41d9-aca9-2e3eaf1cece9@redhat.com>
Date: Thu, 25 Dec 2025 22:20:59 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
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
 <20251224134520.33231-15-frederic@kernel.org>
 <17aadc7e-7dd6-4335-a748-e66f0239df85@redhat.com>
Content-Language: en-US
In-Reply-To: <17aadc7e-7dd6-4335-a748-e66f0239df85@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/25/25 9:24 PM, Waiman Long wrote:
> On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
>> Until now, HK_TYPE_DOMAIN used to only include boot defined isolated
>> CPUs passed through isolcpus= boot option. Users interested in also
>> knowing the runtime defined isolated CPUs through cpuset must use
>> different APIs: cpuset_cpu_is_isolated(), cpu_is_isolated(), etc...
>>
>> There are many drawbacks to that approach:
>>
>> 1) Most interested subsystems want to know about all isolated CPUs, not
>>    just those defined on boot time.
>>
>> 2) cpuset_cpu_is_isolated() / cpu_is_isolated() are not synchronized 
>> with
>>    concurrent cpuset changes.
>>
>> 3) Further cpuset modifications are not propagated to subsystems
>>
>> Solve 1) and 2) and centralize all isolated CPUs within the
>> HK_TYPE_DOMAIN housekeeping cpumask.
>>
>> Subsystems can rely on RCU to synchronize against concurrent changes.
>>
>> The propagation mentioned in 3) will be handled in further patches.
>>
>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>> ---
>>   include/linux/sched/isolation.h |  7 +++
>>   kernel/cgroup/cpuset.c          |  3 ++
>>   kernel/sched/isolation.c        | 76 ++++++++++++++++++++++++++++++---
>>   kernel/sched/sched.h            |  1 +
>>   4 files changed, 81 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/sched/isolation.h 
>> b/include/linux/sched/isolation.h
>> index 109a2149e21a..6842a1ba4d13 100644
>> --- a/include/linux/sched/isolation.h
>> +++ b/include/linux/sched/isolation.h
>> @@ -9,6 +9,11 @@
>>   enum hk_type {
>>       /* Revert of boot-time isolcpus= argument */
>>       HK_TYPE_DOMAIN_BOOT,
>> +    /*
>> +     * Same as HK_TYPE_DOMAIN_BOOT but also includes the
>> +     * revert of cpuset isolated partitions. As such it
>> +     * is always a subset of HK_TYPE_DOMAIN_BOOT.
>> +     */
>>       HK_TYPE_DOMAIN,
>>       /* Revert of boot-time isolcpus=managed_irq argument */
>>       HK_TYPE_MANAGED_IRQ,
>> @@ -35,6 +40,7 @@ extern const struct cpumask 
>> *housekeeping_cpumask(enum hk_type type);
>>   extern bool housekeeping_enabled(enum hk_type type);
>>   extern void housekeeping_affine(struct task_struct *t, enum hk_type 
>> type);
>>   extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
>> +extern int housekeeping_update(struct cpumask *isol_mask, enum 
>> hk_type type);
>>   extern void __init housekeeping_init(void);
>>     #else
>> @@ -62,6 +68,7 @@ static inline bool housekeeping_test_cpu(int cpu, 
>> enum hk_type type)
>>       return true;
>>   }
>>   +static inline int housekeeping_update(struct cpumask *isol_mask, 
>> enum hk_type type) { return 0; }
>>   static inline void housekeeping_init(void) { }
>>   #endif /* CONFIG_CPU_ISOLATION */
>>   diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 5e2e3514c22e..e13e32491ebf 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1490,6 +1490,9 @@ static void update_isolation_cpumasks(void)
>>       ret = tmigr_isolated_exclude_cpumask(isolated_cpus);
>>       WARN_ON_ONCE(ret < 0);
>>   +    ret = housekeeping_update(isolated_cpus, HK_TYPE_DOMAIN);
>> +    WARN_ON_ONCE(ret < 0);
>> +
>>       isolated_cpus_updating = false;
>>   }
>>   diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
>> index 83be49ec2b06..a124f1119f2e 100644
>> --- a/kernel/sched/isolation.c
>> +++ b/kernel/sched/isolation.c
>> @@ -29,18 +29,48 @@ static struct housekeeping housekeeping;
>>     bool housekeeping_enabled(enum hk_type type)
>>   {
>> -    return !!(housekeeping.flags & BIT(type));
>> +    return !!(READ_ONCE(housekeeping.flags) & BIT(type));
>>   }
>>   EXPORT_SYMBOL_GPL(housekeeping_enabled);
>>   +static bool housekeeping_dereference_check(enum hk_type type)
>> +{
>> +    if (IS_ENABLED(CONFIG_LOCKDEP) && type == HK_TYPE_DOMAIN) {
>
> To be more correct, we should use IS_ENABLED(CONFIG_PROVE_LOCKING) as 
> this is the real kconfig that enables most of the lockdep checking. 
> PROVE_LOCKING selects LOCKDEP but not vice versa. So for some weird 
> configs that set LOCKDEP but not PROVE_LOCKING, it can cause 
> compilation problem. 

I think I get confused too. The various lockdep* helpers should be 
defined when CONFIG_LOCKDEP is enabled even if they may not do anything 
useful. So using IS_ENABLED(CONFIG_LOCKDEP) should be fine. Sorry for 
the noise.

Reviewed-by: Waiman Long <longman@redhat.com>


