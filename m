Return-Path: <cgroups+bounces-11280-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF608C15CB0
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 17:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F523A15F7
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75B834889A;
	Tue, 28 Oct 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mN8LxUn5"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FA7292936
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668198; cv=none; b=qVrUz1OB4XBY4TB56c66lhSWml3kvdpV6medaSRVSo8zok5EPPQgmpCm6ZuyUIwFn7veBloeR++K1q+9q6tybxHLfw7EPbrS1Ye3YOCirUemkQ+TxjUF0qo+bspsaDwX2bJv5Xb/qxMWRXbwLijk1ZkIPo7063rpmO4icwgLH+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668198; c=relaxed/simple;
	bh=j9ZSlSw6quumBjZ2p2Hyq3PBFvjOYyL0TV4dOFji2xU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X266wvq9okTNJtlGS1f6vl/A7NmyUPwL9VfkAKbXJu9kQM+lCtj4XsbMZN2kN2K0gFdSqezTBoRix26XFBwY3TsO/OR0ppQUJgmEnEgYjdFs7j0SCmEjQygnoteKMZE7MgTJKurwUKp5geInP7iGtk0YW3G54KSCyOecLmAp8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mN8LxUn5; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761668192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ftyXtMKJiXGvCol0LZq8LgVSc8+XJJVccDr9V2Jw64=;
	b=mN8LxUn58/1ZZZ/JYFD69p+VTvbUvckaGk22+fnxe34+5t8PYP10haz/y/SISWoUsxA52i
	u2y1/eANPZbA7rvm3e3BNQsgR1RxKB6lu7ZYWnW4DAGhlmqfK0IzwereJpZoSEIvhmA+1m
	D30KR/rPZMO1xkVGtlPFPmVGFEUYDMw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org,  linux-kernel@vger.kernel.org,
 ast@kernel.org, surenb@google.com, mhocko@kernel.org,
 shakeel.butt@linux.dev, hannes@cmpxchg.org, andrii@kernel.org,
 inwardvessel@gmail.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
 bpf@vger.kernel.org, martin.lau@kernel.org, song@kernel.org,
 memxor@gmail.com, tj@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v2 10/23] mm: introduce BPF kfuncs to access memcg
 statistics and events
In-Reply-To: <45ee5e2e857a2e4022eb380f854d2a7cf27f3ec97d75a0200b46be95ae921d3b@mail.kernel.org>
	(bot's message of "Mon, 27 Oct 2025 23:48:14 +0000 (UTC)")
References: <20251027231727.472628-11-roman.gushchin@linux.dev>
	<45ee5e2e857a2e4022eb380f854d2a7cf27f3ec97d75a0200b46be95ae921d3b@mail.kernel.org>
Date: Tue, 28 Oct 2025 09:16:23 -0700
Message-ID: <87cy6757e0.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

bot+bpf-ci@kernel.org writes:

> ```
> commit 96abfe0549713749f00e32bff919a759db284a58
> Author: Roman Gushchin <roman.gushchin@linux.dev>
>
> mm: introduce BPF kfuncs to access memcg statistics and events
>
> This patch adds four new BPF kfuncs for accessing memory cgroup statistics
> and events, making them available to all BPF program types for implementing
> OOM policies and accelerating memcg data access.
>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 39a6c7c87..b9e08dddd 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>
> [ ... ]
>
>> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>> index 76c342318..387255b8a 100644
>> --- a/mm/bpf_memcontrol.c
>> +++ b/mm/bpf_memcontrol.c
>
> [ ... ]
>
>> @@ -75,6 +75,56 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
>>  	css_put(&memcg->css);
>>  }
>>
>> +/**
>> + * bpf_mem_cgroup_vm_events - Read memory cgroup's vm event counter
>> + * @memcg: memory cgroup
>> + * @event: event id
>> + *
>> + * Allows to read memory cgroup event counters.
>> + */
>> +__bpf_kfunc unsigned long bpf_mem_cgroup_vm_events(struct mem_cgroup *memcg,
>> +						enum vm_event_item event)
>> +{
>> +	return memcg_events(memcg, event);
>> +}
>> +
>> +/**
>> + * bpf_mem_cgroup_usage - Read memory cgroup's usage
>> + * @memcg: memory cgroup
>> + *
>> + * Returns current memory cgroup size in bytes.
>> + */
>> +__bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
>> +{
>> +	return page_counter_read(&memcg->memory);
>> +}
>      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> The documentation says this returns bytes, but page_counter_read() returns
> pages. In mm/memcontrol-v1.c, the existing mem_cgroup_usage() function's
> return value is multiplied by PAGE_SIZE to convert to bytes:
>
>     return (u64)mem_cgroup_usage(memcg, false) * PAGE_SIZE;
>
> Should this function multiply the result by PAGE_SIZE to match its
> documentation, or should the documentation be updated to say it returns
> pages?

Yep, correct, fixed.

