Return-Path: <cgroups+bounces-8101-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DB8AB0714
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 02:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249531BC7D1A
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 00:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5506ABE5E;
	Fri,  9 May 2025 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYB7COfb"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8F184E
	for <cgroups@vger.kernel.org>; Fri,  9 May 2025 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746750608; cv=none; b=Zu3CkR2Vj6OX5OYMKfuf6fywL/mxYscJhbTNYSFtCSKKLmdBmuHBwTi1rhAvgfCCDa7W0eTxtbz6q2f63dp/gMZpLoqP5V8z9Dreobwn/duEXKSjzd06HK4t3mS9zaJRvmzBkeJa7tJ577eNoBkYoJDVwujfbglQWlPohS34VGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746750608; c=relaxed/simple;
	bh=srKSFCt8dXzpNvcx+Mfkk2nS0/9E2PUqq9PjwP45xLI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VRunl2Mnlo3VRljlceHcf9RYLT3IOg0yPPnxOWbUIY/CYuzkSAmgwa1l55pMG2M3Cv/5Zx9ErMuxzXHV2pJM2cYFYW30k5Le3RP1Xm9VBTqa1xYoZW0jTRau4YGgALkZ2WWBT6Iln+z5Ogy51yzhxtkN287GrS05WEPKfpKW0ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYB7COfb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746750605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ue5c2emr3m3aNcwZc5Oc60ct3D7/MWmqWjmTJfwbfSw=;
	b=TYB7COfbJSXAtL2ZsBSM6FZS2KV93EATOLzqdAB6GUZd0tiweMb3j0NvZZWCK5gbCJ82I8
	4DX1qo/19LPKYAsa3XtlrEzHklEdp63Xy7+mRtVQMlf9H2qCD755+j/jmcurVAu1yscjJs
	QnSHBKO4CijB8eYgLIUV7Ky2rx2FluA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-FclilUsRMkKAcVRLmsjQ7A-1; Thu, 08 May 2025 20:30:04 -0400
X-MC-Unique: FclilUsRMkKAcVRLmsjQ7A-1
X-Mimecast-MFC-AGG-ID: FclilUsRMkKAcVRLmsjQ7A_1746750603
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6f53d2613easo31497286d6.0
        for <cgroups@vger.kernel.org>; Thu, 08 May 2025 17:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746750603; x=1747355403;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ue5c2emr3m3aNcwZc5Oc60ct3D7/MWmqWjmTJfwbfSw=;
        b=mpwHOWPcXDAQ/yfmYG23xzpzWrCmWaos+wJNyPYqoaKBkSvu5YK0+cDEqVc/ZpcItH
         QWfwzU6Ckto1XnbhpJ1YBDXyeeHGuv8S1x9o2GakYL6j1Bj3Vn2JcJXrc+3aSfgvIoS+
         pWEQzDH/Dpx4i19wZCXDjMiu8a71JHl/bv5SXvlvbkHJ8vdelldSxpiytiV+eb9nwBCd
         rxfb5w0wgLSlOnRuNC8gAn/2s9sBiMa5+UPHD47hoPpCcqPJFT3APVVbilazweVVEaDH
         uNBflyRzmZEJZCQ2hXMoN2v7QWwYCWXzd2KjqeB0Oq255C81rS0gSLOY0s88XnuofVu5
         q3OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbDfP0Un9aXeh3q46XaC0/uHvv1lG34jYk4CgSiisVzGuDa1APZCFwSGfI8ZJv3Aryvw1tE8/r@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3D5Inv02iepwsTtPjVj4rz/WkZetTKmEJEwoJAf4gEiRTmlGz
	H1gYvAkyVk6Ems/9wj2ZX5eHOBjeg7NWrVWcx5TnTDQACYxXjYtOi17UoWi+OxbMfPH5yH+IJAl
	2zTvQYJE+X8wiqmKnatZZkYXqDQcb8x+jGQ3zNiwGpv+ABmwhC96Ft6k=
X-Gm-Gg: ASbGncuX6AdMjShcn5UrRNzr0RkvW8IQekpFh36hdJ3YLhVV9ftSwrR67J2khcG/plm
	AQ+lHtq2FyaWZt+cob90goLpmod7L3Upiw8m/nj2WlJ9Z2PIpzo5pASBSy6hzuGxx6HndssR6LF
	9sr6xj8rzO2ZUsdfVYnje6tUau3EFJ+HWwoDmAPKH/PqY+frIyOwkkOItAxAiAtyl7iqb45CAyp
	zWqnrSXnJDR1GwnkCUmu0VjIk/B8IzdW4wxbAY0HkNXMynCQk5p5e/LmVNecnZbWs4NfHI5aihU
	CSegNA8ZaPtIvNNw461ZP08gOV/KFifZzjTt35u397rYgqGpW6HzlydEcw==
X-Received: by 2002:a05:6214:19ce:b0:6e2:4da9:4e2d with SMTP id 6a1803df08f44-6f6e4753c2cmr20966776d6.9.1746750603503;
        Thu, 08 May 2025 17:30:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrELbzIvp5ZPe5pUR82LbHWROM35oAnLLcF+C35U9WGdHUMiL5IEqzPyDidk82XIXZi2ablQ==
X-Received: by 2002:a05:6214:19ce:b0:6e2:4da9:4e2d with SMTP id 6a1803df08f44-6f6e4753c2cmr20966286d6.9.1746750603114;
        Thu, 08 May 2025 17:30:03 -0700 (PDT)
Received: from ?IPV6:2601:188:c102:9c40:1f42:eb97:44d3:6e9a? ([2601:188:c102:9c40:1f42:eb97:44d3:6e9a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e39f482csm6369236d6.34.2025.05.08.17.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 17:30:02 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9fdad98e-9042-4781-9d73-19f00266711b@redhat.com>
Date: Thu, 8 May 2025 20:30:01 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH] sched: Support moving kthreads into cpuset cgroups
To: Xi Wang <xii@google.com>, Waiman Long <llong@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Tejun Heo <tj@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 David Rientjes <rientjes@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
 Dan Carpenter <dan.carpenter@linaro.org>, Chen Yu <yu.c.chen@intel.com>,
 Kees Cook <kees@kernel.org>, Yu-Chun Lin <eleanor15x@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, jiangshanlai@gmail.com
References: <20250506183533.1917459-1-xii@google.com>
 <aBqmmtST-_9oM9rF@slm.duckdns.org>
 <CAOBoifh4BY1f4B3EfDvqWCxNSV8zwmJPNoR3bLOA7YO11uGBCQ@mail.gmail.com>
 <aBtp98E9q37FLeMv@localhost.localdomain>
 <CAOBoifgp=oEC9SSgFC+4_fYgDgSH_Z_TMgwhOxxaNZmyD-ijig@mail.gmail.com>
 <aBuaN-xtOMs17ers@slm.duckdns.org>
 <CAOBoifiv2GCeeDjax8Famu7atgkGNV0ZxxG-cfgvC857-dniqA@mail.gmail.com>
 <aBv2AG-VbZ4gcWpi@pavilion.home>
 <CAOBoifhWNi-j6jbP6B9CofTrT+Kr6TCSYYPMv7SQdbY5s930og@mail.gmail.com>
 <b7aa4b10-1afb-476f-ac5d-d8db7151d866@redhat.com>
 <CAOBoifjzJ=-siSR=2=3FtKwajSgkXsL40XO2pox0XR4c8vvkzg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOBoifjzJ=-siSR=2=3FtKwajSgkXsL40XO2pox0XR4c8vvkzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/8/25 6:39 PM, Xi Wang wrote:
> On Thu, May 8, 2025 at 12:35 PM Waiman Long <llong@redhat.com> wrote:
>> On 5/8/25 1:51 PM, Xi Wang wrote:
>>> I think our problem spaces are different. Perhaps your problems are closer to
>>> hard real-time systems but our problems are about improving latency of existing
>>> systems while maintaining efficiency (max supported cpu util).
>>>
>>> For hard real-time systems we sometimes throw cores at the problem and run no
>>> more than one thread per cpu. But if we want efficiency we have to share cpus
>>> with scheduling policies. Disconnecting the cpu scheduler with isolcpus results
>>> in losing too much of the machine capacity. CPU scheduling is needed for both
>>> kernel and userspace threads.
>>>
>>> For our use case we need to move kernel threads away from certain vcpu threads,
>>> but other vcpu threads can share cpus with kernel threads. The ratio changes
>>> from time to time. Permanently putting aside a few cpus results in a reduction
>>> in machine capacity.
>>>
>>> The PF_NO_SETAFFINTIY case is already handled by the patch. These threads will
>>> run in root cgroup with affinities just like before.
>>>
>>> The original justifications for the cpuset feature is here and the reasons are
>>> still applicable:
>>>
>>> "The management of large computer systems, with many processors (CPUs), complex
>>> memory cache hierarchies and multiple Memory Nodes having non-uniform access
>>> times (NUMA) presents additional challenges for the efficient scheduling and
>>> memory placement of processes."
>>>
>>> "But larger systems, which benefit more from careful processor and memory
>>> placement to reduce memory access times and contention.."
>>>
>>> "These subsets, or “soft partitions” must be able to be dynamically adjusted, as
>>> the job mix changes, without impacting other concurrently executing jobs."
>>>
>>> https://docs.kernel.org/admin-guide/cgroup-v1/cpusets.html
>>>
>>> -Xi
>>>
>> If you create a cpuset root partition, we are pushing some kthreads
>> aways from CPUs dedicated to the newly created partition which has its
>> own scheduling domain separate from the cgroup root. I do realize that
>> the current way of excluding only per cpu kthreads isn't quite right. So
>> I send out a new patch to extend to all the PF_NO_SETAFFINITY kthreads.
>>
>> So instead of putting kthreads into the dedicated cpuset, we still keep
>> them in the root cgroup. Instead we can create a separate cpuset
>> partition to run the workload without interference from the background
>> kthreads. Will that functionality suit your current need?
>>
>> Cheers,
>> Longman
>>
> It's likely a major improvement over a fixed partition but maybe still not fully
> flexible. I am not familiar with cpuset partitions but I wonder if the following
> case can be supported:
>
> Starting from
> 16 cpus
> Root has cpu 0-3, 8-15
> Job A has cpu 4-7 exclusive
> Kernel threads cannot run on cpu 4-8 which is good.
There will still be some kernel threads with PF_NO_SETAFFINITY flag set.

>
> Now adding best effort Job B, which is under SCHED_IDLE and rarely enters kernel
> mode. As we expect C can be easily preempted we allow it to share cpus with A
> and kernel threads to maximize throughput. Is there a layout that supports the
> requirements below?
>
> Job C threads on cpu 0-15

A task/thread can only be in one cpuset. So it cannot span all the CPUs. 
However, if there are multiples threads within the process, some of the 
threads can be moved to a different cpuset as it is threaded. With 
proper thread setting, you can have a job with threads spanning all the 
CPUs.

Cheers,
Longman

> Job A threads on cpu 4-7
> No kernel threads on cpu 4-7
>
> -Xi
>


