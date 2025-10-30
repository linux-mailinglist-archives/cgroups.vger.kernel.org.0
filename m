Return-Path: <cgroups+bounces-11443-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA62C22947
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 23:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D28F4E12EA
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 22:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435EF33BBA3;
	Thu, 30 Oct 2025 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w4Dw2W0B"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7919309E
	for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 22:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761864146; cv=none; b=dCizF993ttleMf9V02D6fXXcClLX+RMtPtcPtK14eqAkE7q5S6WzRnMSlbhjdChSo+ouh2/mWXTnnDAFECL7bUa9lvLnyceWTGSf4uR3/iXOoNy/aKC263mQUnVL/mYzbn8r41EueNO5TzA06/AM8COgkZlxDZ7MbYrKWrzdsks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761864146; c=relaxed/simple;
	bh=vz3AX1jr/hBhpuI255E27qrfwU0pX+IeV1EW3UW2wFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3dm+4U58C7iQOU4YMBVituEfZSImXHH5C1UIdxA5u19gJqCN2iOJrNDYmX7p/dbkbk37mvFGkT8r47RChN7QDQnP6xO2IgawI6vSffxzJd2QNDmzwgcOcTaC+thuqGdqrsMkYlqMIxu8NAvsAjC0+Je5bJ/xrPcD5ze6ma/ZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w4Dw2W0B; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e027a330-8d51-44e5-badc-7c3ec4d41e23@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761864139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6Vi5Tt+I174+kjp03D2P+wbVEq5YpTLLn5FP5kOQX8=;
	b=w4Dw2W0BopQE6NK2KmOiFVG+F56rU0LbOgjR3js4+CdAu537cuAGApUf4DYOLlL9zRo8we
	cQeDGnzMfDQQIM9Mj5dgPvp9rD9tkmXzDkIlj4SxX23PqXXqYpnOKXLmajRX5+Of+uBcwt
	tJqXv97s/MFUkJnqiGdMXKUmBi8A4Nw=
Date: Thu, 30 Oct 2025 15:42:12 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to
 cgroups
To: Song Liu <song@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Andrii Nakryiko <andrii@kernel.org>,
 JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev>
 <CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
 <87zf98xq20.fsf@linux.dev>
 <CAHzjS_tnmSPy_cqCUHiLGt8Ouf079wQBQkostqJqfyKcJZPXLA@mail.gmail.com>
 <CAMB2axMkYS1j=KeECZQ9rnupP8kw7dn1LnGV4udxMp=f=qoEQA@mail.gmail.com>
 <877bwcus3h.fsf@linux.dev>
 <CAHzjS_u5oqD3Dsk9JjK942QBL8UOMkqdM23xP0yTEb+MMuOoLw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAHzjS_u5oqD3Dsk9JjK942QBL8UOMkqdM23xP0yTEb+MMuOoLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/30/25 2:34 PM, Song Liu wrote:
> Hi Roman,
> 
> On Thu, Oct 30, 2025 at 12:07 PM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
> [...]
>>> In TCP congestion control and BPF qdisc's model:
>>>
>>> During link_create, both adds the struct_ops to a list, and the
>>> struct_ops can be indexed by name. The struct_ops are not "active" by
>>> this time.
>>> Then, each has their own interface to 'apply' the struct_ops to a
>>> socket or queue: setsockopt() or netlink.
>>>
>>> But maybe cgroup-related struct_ops are different.
>>
>> Both tcp congestion and qdisk cases are somewhat different because
>> there already is a way to select between multiple implementations, bpf
>> just adds another one. In the oom case, it's not true. As of today,
>> there is only one (global) oom killer. Of course we can create
>> interfaces to allow a user make a choice. But the question is do we want
>> to create such interface for the oom case specifically (and later for
>> each new case separately), or there is a place for some generalization?
> 
> Agreed that this approach requires a separate mechanism to attach
> the struct_ops to an entity.
> 
>> Ok, let me summarize the options we discussed here:
> 
> Thanks for the summary!
> 
>>
>> 1) Make the attachment details (e.g. cgroup_id) the part of struct ops
>> itself. The attachment is happening at the reg() time.
>>
>>    +: It's convenient for complex stateful struct ops'es, because a
>>        single entity represents a combination of code and data.
>>    -: No way to attach a single struct ops to multiple entities.
>>
>> This approach is used by Tejun for per-cgroup sched_ext prototype.
>>
>> 2) Make the attachment details a part of bpf_link creation. The
>> attachment is still happening at the reg() time.
>>
>>    +: A single struct ops can be attached to multiple entities.
>>    -: Implementing stateful struct ops'es is harder and requires passing
>>       an additional argument (some sort of "self") to all callbacks.
>> I'm using this approach in the bpf oom proposal.
>>
> 
> I think both 1) and 2) have the following issue. With cgroup_id in
> struct_ops or the link, the cgroup_id works more like a filter. The
> cgroup doesn't hold any reference to the struct_ops. The bpf link
> holds the reference to the struct_ops, so we need to keep the
> the link alive, either by keeping an active fd, or by pinning the
> link to bpffs. When the cgroup is removed, we need to clean up
> the bpf link separately.

The link can be detached (struct_ops's unreg) by the user space.

The link can also be detached from the subsystem (cgroup) here.
It was requested by scx:
https://lore.kernel.org/all/20240530065946.979330-7-thinker.li@gmail.com/

Not sure if scx has started using it.

> 
>> 3) Move the attachment out of .reg() scope entirely. reg() will register
>> the implementation system-wide and then some 3rd-party interface
>> (e.g. cgroupfs) should be used to select the implementation.
>>
>>    +: ?
>>    -: New hard-coded interfaces might be required to enable bpf-driven
>>       kernel customization. The "attachment" code is not shared between
>>       various struct ops cases.
>>       Implementing stateful struct ops'es is harder and requires passing
>>       an additional argument (some sort of "self") to all callbacks.
>>
>> This approach works well for cases when there is already a selection
>> of implementations (e.g. tcp congestion mechanisms), and bpf is adding
>> another one.
> 
> Another benefit of 3) is that it allows loading an OOM controller in a
> kernel module, just like loading a file system in a kernel module. This
> is possible with 3) because we paid the cost of adding a new select
> attach interface.
> 
> A semi-separate topic, option 2) enables attaching a BPF program
> to a kernel object (a cgroup here, but could be something else). This
> is an interesting idea, and we may find it useful in other cases (attach
> a BPF program to a task_struct, etc.).

Does it have plan for a pure kernel module oom implementation?
I think the link-to-cgrp support here does not necessary stop the
later write to cgroupfs support if a kernel module oom is indeed needed
in the future.

imo, cgroup-bpf has a eco-system around it, so it is sort of special. bpf user
has expectation on how a bpf prog is attached to a cgroup. The introspection,
auto detachment from the cgroup when the link is gone...etc.

If link-to-cgrp is used, I prefer (2). Stay with one way to attach
to a cgrp. It is also consistent with the current way of attaching a single
bpf prog to a cgroup. It is now attaching a map/set of bpf prog to a cgroup.
The individual struct_ops implementation can decide if it should
allow a struct_ops be attached multiple times.

