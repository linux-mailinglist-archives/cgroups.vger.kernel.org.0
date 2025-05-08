Return-Path: <cgroups+bounces-8098-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73A1AB03BB
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 21:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80F44C6875
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 19:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EC728B401;
	Thu,  8 May 2025 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1zZE4LC"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB0B28A72C
	for <cgroups@vger.kernel.org>; Thu,  8 May 2025 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732903; cv=none; b=IWNoMhk3ou+pcc4NebuQOua0lSYbJ/TBXDSkG9k95Y8vM127KsCHprrLhqAmwzVvCNUgjzftAtbcGLvRqpowMWY7J07rIH3ZC4yEZCzx+wzheG1OVWkbTGVM6T1AVrRnv8AzfZ33SftrCtDbBeJAyHw4uf8rqBO1dOaQ5LyqHI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732903; c=relaxed/simple;
	bh=VzLB/GExdxNme2u/M2TKv9ScNhEMbkIEp4+dcTvn5Ec=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MDVED8OUO3oxoxqhnKEg+xwQtquoj5+WmzyKyMumlLPefVeFGYr1CBNWziCzJYhCfi8E28Lshev1WQl8ngL+Ldi5g8XU2Bg57dbnmq2wYciZ3K6R5q/Dxz1CYvUJ2ciU8157lfb/6EALyOAmaK1hIl9j5MZrfmdO7VTnl40WxbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V1zZE4LC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746732900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3YwEcBVK3vv4ZwSSNkAmuZNRhaTnJeEktKDr5BfOOfE=;
	b=V1zZE4LChgZ7m/v+hc94d/Zoj5Rk8goTPSt4kkvMK9/E1gNJXUFaEV7DZ+Fhzti7cvZxl8
	d/jlFn51YNittRyrW6ByxEJcRvevy8u/Jgnr1ItT5D+i5ndcjpbuia/AbzyUeOqIV1Vpwy
	/DtqQoMprAY6vHfQqYlIz0g1uKB97lk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-73lEJpqYNFmbo32cYZDmlw-1; Thu, 08 May 2025 15:34:59 -0400
X-MC-Unique: 73lEJpqYNFmbo32cYZDmlw-1
X-Mimecast-MFC-AGG-ID: 73lEJpqYNFmbo32cYZDmlw_1746732899
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6f54fe13562so15145856d6.3
        for <cgroups@vger.kernel.org>; Thu, 08 May 2025 12:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746732899; x=1747337699;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YwEcBVK3vv4ZwSSNkAmuZNRhaTnJeEktKDr5BfOOfE=;
        b=Y74+4QFyAGhodeOUvwh3M6c2iivvZwtSkFlDc/1N5NyyUdMGz5xWvaoNTZy3ebFRAD
         WRJWNmQcu/ap5qcLomoRYPueFFPNFR37FzzVC/vUi8D0HV8xOfEJZMc8mvrcpAlhoqiJ
         HKqEERo1YuHH9EOZjXHGvdq/PYNeF4sO2T+6CNshygCOgNW/uPPEv2Smx+opNQuCP+DO
         i1rzTJfW2H0NoROv6T4dIwLcaR/YsJdUSv+wIukpBra9TkdV8BvTIVmfnyPL0a4C+lJd
         zYSSj5I1oogEZM4EsqsM2CK4Yr1Vg25pBkkfRQ8erxiMOGZQdCoFmysbGxRSdkCV8hWD
         tn1g==
X-Forwarded-Encrypted: i=1; AJvYcCWTg1K+DeMB3tJsaH8A3z5DZuJd/4AlCxVhx8T0+feUDpVAF8PKbnucd3gbOJdQK3Sf/G7QL5HJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwNY8IL16xrhcWhaHX+6FBlA7Arvxx1UTQPxMejBxCtUUuQW62w
	HGLqYj5vczaAWgVlmRpsZADuAf87LftnfiFPb4+adjVF/sE93SUjLI0BUydesij2RYHfQC2uwvs
	6lRyWO+wd0r8QIzaD8t17P8Nq3UnU9YrgX7ft75yjUOYMo6RjCAq0Q7Y=
X-Gm-Gg: ASbGncsna4DAyeakwMcsh0YIpPuiXs/FNUUSJyEqFStJFmVnZeIj6TxABTJwyBSA2nK
	y1nPORaZhIWLIqz4FeZ/oYsi02mU3kv+Ec49lmjGBT0eX2Ew9lSKPUhhoc7EwnsqaPq08ndEsWP
	fSxU+2Ay5pLoEFsvLMSdGFmKmLJ+GujhUEJOwNWisB66at4akcJ/qMnpR6SIfPU7v6p6xQ9tLAB
	x9sNOwmY28qMFxZqH4fHXm/tTchlgCqn83SMZWTIZPDmg4PmmQvqxLr2FpoL1F1XeKRVQADfh7V
	BuN6YDlLwR7UgUXok06LqUgXwUPHoQtSZ0XS8oE2MhXLEQpEc6ICRXaV1A==
X-Received: by 2002:a05:6214:acf:b0:6f5:3e38:612b with SMTP id 6a1803df08f44-6f6e480eb13mr7365726d6.41.1746732898573;
        Thu, 08 May 2025 12:34:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfgnQKNt/xIX+0BJNn1+fbM2SZK1Vg/S9yo7o+l7fcYitVl8JKLyEQF09Q4tOEErio2hQ1DA==
X-Received: by 2002:a05:6214:acf:b0:6f5:3e38:612b with SMTP id 6a1803df08f44-6f6e480eb13mr7365246d6.41.1746732898256;
        Thu, 08 May 2025 12:34:58 -0700 (PDT)
Received: from ?IPV6:2601:188:c102:9c40:1f42:eb97:44d3:6e9a? ([2601:188:c102:9c40:1f42:eb97:44d3:6e9a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a538c5sm3343566d6.108.2025.05.08.12.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 12:34:57 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b7aa4b10-1afb-476f-ac5d-d8db7151d866@redhat.com>
Date: Thu, 8 May 2025 15:34:56 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH] sched: Support moving kthreads into cpuset cgroups
To: Xi Wang <xii@google.com>, Frederic Weisbecker <frederic@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
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
Content-Language: en-US
In-Reply-To: <CAOBoifhWNi-j6jbP6B9CofTrT+Kr6TCSYYPMv7SQdbY5s930og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/8/25 1:51 PM, Xi Wang wrote:
> I think our problem spaces are different. Perhaps your problems are closer to
> hard real-time systems but our problems are about improving latency of existing
> systems while maintaining efficiency (max supported cpu util).
>
> For hard real-time systems we sometimes throw cores at the problem and run no
> more than one thread per cpu. But if we want efficiency we have to share cpus
> with scheduling policies. Disconnecting the cpu scheduler with isolcpus results
> in losing too much of the machine capacity. CPU scheduling is needed for both
> kernel and userspace threads.
>
> For our use case we need to move kernel threads away from certain vcpu threads,
> but other vcpu threads can share cpus with kernel threads. The ratio changes
> from time to time. Permanently putting aside a few cpus results in a reduction
> in machine capacity.
>
> The PF_NO_SETAFFINTIY case is already handled by the patch. These threads will
> run in root cgroup with affinities just like before.
>
> The original justifications for the cpuset feature is here and the reasons are
> still applicable:
>
> "The management of large computer systems, with many processors (CPUs), complex
> memory cache hierarchies and multiple Memory Nodes having non-uniform access
> times (NUMA) presents additional challenges for the efficient scheduling and
> memory placement of processes."
>
> "But larger systems, which benefit more from careful processor and memory
> placement to reduce memory access times and contention.."
>
> "These subsets, or “soft partitions” must be able to be dynamically adjusted, as
> the job mix changes, without impacting other concurrently executing jobs."
>
> https://docs.kernel.org/admin-guide/cgroup-v1/cpusets.html
>
> -Xi
>
If you create a cpuset root partition, we are pushing some kthreads 
aways from CPUs dedicated to the newly created partition which has its 
own scheduling domain separate from the cgroup root. I do realize that 
the current way of excluding only per cpu kthreads isn't quite right. So 
I send out a new patch to extend to all the PF_NO_SETAFFINITY kthreads.

So instead of putting kthreads into the dedicated cpuset, we still keep 
them in the root cgroup. Instead we can create a separate cpuset 
partition to run the workload without interference from the background 
kthreads. Will that functionality suit your current need?

Cheers,
Longman


