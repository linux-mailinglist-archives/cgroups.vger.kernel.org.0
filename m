Return-Path: <cgroups+bounces-11279-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9BDC15B65
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 17:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DDEA4E344B
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 16:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0363446B5;
	Tue, 28 Oct 2025 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SyxgsjzA"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBDF23ABBD
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667862; cv=none; b=mlJiiJEZA7nPiHPpwbcZdgL1PQ3chCQ+ZKdshmwp8JwNMG0r5GyND6VKLh6ETlLtDygNt5aHLOBCVLn2Dt5Vnuo9Yo68ugqAT2xirvlTgfWR9ApVnLXl1L7Hex/6ujrmgP6XY2tIr8hJ6Pn5oHKaf1CTswsuvY+TSGZu0LF1O9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667862; c=relaxed/simple;
	bh=dJBi1SI6KRLdskO7pfO8PR4VwDReQHqZlMyEW6CEiGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aoe6rBwMO8zfHCKQ2qU/Wtfeyb0HPGrMEp7XAvzJkftY/VXBHlU/j9BSDCZV0COxaNaOiIYXPXhuVAiHAp3sEYxC0K7PK1DX779quosCi5hOORq+qR+JHC7LFT+4UvqF2yB4W31hwnxSRbNltTxlftP24FGf1HBmhvUtTrKvxGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SyxgsjzA; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761667858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D4PZj+Z/AUd5TD2H5mliXY1n/lg/WeR66f3O6rTVgL0=;
	b=SyxgsjzAaP3eQ9upztzSYWfJ4WsFRqyGC+WNAlDIHsVjNFkuLy+80+fxZhJbxoF71KM/Sb
	2dXtGFR0Z9YliT37NCbk2o9jgMkSzntlWrQPUd9ujQ4NC2Ewk5O6GCMZUgB8sGf6/K33Ov
	Tv8wxDHZwyaHL5z9MiCmBhWGX4QJh9c=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org,  linux-kernel@vger.kernel.org,
 ast@kernel.org, surenb@google.com, mhocko@kernel.org,
 shakeel.butt@linux.dev, hannes@cmpxchg.org, andrii@kernel.org,
 inwardvessel@gmail.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
 bpf@vger.kernel.org, martin.lau@kernel.org, song@kernel.org,
 memxor@gmail.com, tj@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v2 08/23] mm: introduce BPF kfuncs to deal with memcg
 pointers
In-Reply-To: <2c91977fcab04be6305bf4be57e825f7e84005d16667adcdfad0585be506537c@mail.kernel.org>
	(bot's message of "Mon, 27 Oct 2025 23:48:21 +0000 (UTC)")
References: <20251027231727.472628-9-roman.gushchin@linux.dev>
	<2c91977fcab04be6305bf4be57e825f7e84005d16667adcdfad0585be506537c@mail.kernel.org>
Date: Tue, 28 Oct 2025 09:10:47 -0700
Message-ID: <87ldkv57nc.fsf@linux.dev>
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
> commit ec8e2e1769704b4f69261f36e6aaf035d47c5f0f
> Author: Roman Gushchin <roman.gushchin@linux.dev>
>
> mm: introduce BPF kfuncs to deal with memcg pointers
>
> This commit introduces two new BPF kfuncs for converting css pointers
> to memcg pointers with proper reference counting: bpf_get_mem_cgroup()
> and bpf_put_mem_cgroup().
>
>> diff --git a/mm/Makefile b/mm/Makefile
>> index 051e88c69..2d8f9beb3 100644
>> --- a/mm/Makefile
>> +++ b/mm/Makefile
>> @@ -107,6 +107,7 @@ obj-$(CONFIG_MEMCG) += swap_cgroup.o
>>  endif
>>  ifdef CONFIG_BPF_SYSCALL
>>  obj-y += bpf_oom.o
>> +obj-$(CONFIG_MEMCG) += bpf_memcontrol.o
>>  endif
>>  obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
>>  obj-$(CONFIG_GUP_TEST) += gup_test.o
>> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>> new file mode 100644
>> index 000000000..1e4609774
>> --- /dev/null
>> +++ b/mm/bpf_memcontrol.c
>> @@ -0,0 +1,88 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Memory Controller-related BPF kfuncs and auxiliary code
>> + *
>> + * Author: Roman Gushchin <roman.gushchin@linux.dev>
>> + */
>> +
>> +#include <linux/memcontrol.h>
>> +#include <linux/bpf.h>
>> +
>> +__bpf_kfunc_start_defs();
>> +
>> +/**
>> + * bpf_get_mem_cgroup - Get a reference to a memory cgroup
>> + * @css: pointer to the css structure
>> + *
>> + * Returns a pointer to a mem_cgroup structure after bumping
>> + * the corresponding css's reference counter.
>> + *
>> + * It's fine to pass a css which belongs to any cgroup controller,
>> + * e.g. unified hierarchy's main css.
>> + *
>> + * Implements KF_ACQUIRE semantics.
>> + */
>> +__bpf_kfunc struct mem_cgroup *
>> +bpf_get_mem_cgroup(struct cgroup_subsys_state *css)
>> +{
>> +	struct mem_cgroup *memcg = NULL;
>> +	bool rcu_unlock = false;
>> +
>> +	if (!root_mem_cgroup)
>> +		return NULL;
>> +
>> +	if (root_mem_cgroup->css.ss != css->ss) {
>                                             ^^^^^^^
>
> Can this dereference a NULL css pointer?  The function checks css for
> NULL at line 42 with "if (css && css_tryget(css))", which suggests css
> can be NULL.  If a BPF program calls this function with a NULL css,
> wouldn't it crash here before reaching that check?

Here css passed as an argument to bpf_get_mem_cgroup() can't be NULL,
because the BPF verifier guarantees that it's a valid css pointer.

However the result of rcu_dereference_raw(cgroup->subsys[ssid]) can be
NULL, this is why the "if (css && css_tryget(css))" check is required
down below.

