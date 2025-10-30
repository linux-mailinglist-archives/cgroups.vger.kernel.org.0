Return-Path: <cgroups+bounces-11444-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E27CBC22AE2
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 00:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1C604EA24B
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 23:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E65244667;
	Thu, 30 Oct 2025 23:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BqYnhxem"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFA0147C9B
	for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 23:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761866114; cv=none; b=gYQCDgWrb41yIwkGcFyIBOoi2EFNnQ0clSxU/UzJ5vEF+cCmo7KA082GtDispPZlGlGyqSRzk4amArrsYhW03Av8cuoP4CdL4LCUPYvr45fuNobK287H92LyOSxkMEZuTSTV4jXKQrpvJgSTkIqWuvJ0KU7WCIxh66ji1/Op7lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761866114; c=relaxed/simple;
	bh=Dn7XJpP4rtwOB8NIOvQUmEMjKhFFZhahMNdfR72i7xQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=myjAzTV9MBxq3+OTdKHJp1CR+4/ph7i1rdVuvCZFVm+Zyxam2o2h4/DgRFHFVcVqGY+hNuLEX4QY5+vmJgKDX1SndbyOv4ivFdTBE1nyxnIc4chB6cyS4zY4DeR/XcyAgG0Fvde/9h6PG2ddbhrfGaRTS7RlFbl/n8tU/JgrmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BqYnhxem; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761866108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbsSEZaCMc7K7Atlywq1UA86pTshfXfbD+JgyxyXRuw=;
	b=BqYnhxemjKDpfH7eW6N6jRHjYMwxVKsjcN/cG4hJ/T6pdPe4keRlC9cXgEVIkTtv5p+oKQ
	GnmPbl0/rkAOQXBte6goaO5WKU8xpmSSgoKdLnR8zZsR2QT+6Mz336obgwm5/+sF49C/wu
	lUk4ZnQnJUDPb4AYlGp8YqKaJXOl8rk=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>,  Amery Hung <ameryhung@gmail.com>,  Andrew
 Morton <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org,  Alexei
 Starovoitov <ast@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,
  Michal Hocko <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,
  Johannes Weiner <hannes@cmpxchg.org>,  Andrii Nakryiko
 <andrii@kernel.org>,  JP Kobryn <inwardvessel@gmail.com>,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,  bpf@vger.kernel.org,
  Martin KaFai Lau <martin.lau@kernel.org>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops
 to cgroups
In-Reply-To: <e027a330-8d51-44e5-badc-7c3ec4d41e23@linux.dev> (Martin KaFai
	Lau's message of "Thu, 30 Oct 2025 15:42:12 -0700")
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
	<20251027231727.472628-3-roman.gushchin@linux.dev>
	<CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
	<87zf98xq20.fsf@linux.dev>
	<CAHzjS_tnmSPy_cqCUHiLGt8Ouf079wQBQkostqJqfyKcJZPXLA@mail.gmail.com>
	<CAMB2axMkYS1j=KeECZQ9rnupP8kw7dn1LnGV4udxMp=f=qoEQA@mail.gmail.com>
	<877bwcus3h.fsf@linux.dev>
	<CAHzjS_u5oqD3Dsk9JjK942QBL8UOMkqdM23xP0yTEb+MMuOoLw@mail.gmail.com>
	<e027a330-8d51-44e5-badc-7c3ec4d41e23@linux.dev>
Date: Thu, 30 Oct 2025 16:14:59 -0700
Message-ID: <87bjloj824.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 10/30/25 2:34 PM, Song Liu wrote:
>> Hi Roman,
>> On Thu, Oct 30, 2025 at 12:07=E2=80=AFPM Roman Gushchin
>> <roman.gushchin@linux.dev> wrote:
>> [...]
>>>> In TCP congestion control and BPF qdisc's model:
>>>>
>>>> During link_create, both adds the struct_ops to a list, and the
>>>> struct_ops can be indexed by name. The struct_ops are not "active" by
>>>> this time.
>>>> Then, each has their own interface to 'apply' the struct_ops to a
>>>> socket or queue: setsockopt() or netlink.
>>>>
>>>> But maybe cgroup-related struct_ops are different.
>>>
>>> Both tcp congestion and qdisk cases are somewhat different because
>>> there already is a way to select between multiple implementations, bpf
>>> just adds another one. In the oom case, it's not true. As of today,
>>> there is only one (global) oom killer. Of course we can create
>>> interfaces to allow a user make a choice. But the question is do we want
>>> to create such interface for the oom case specifically (and later for
>>> each new case separately), or there is a place for some generalization?
>> Agreed that this approach requires a separate mechanism to attach
>> the struct_ops to an entity.
>>=20
>>> Ok, let me summarize the options we discussed here:
>> Thanks for the summary!
>>=20
>>>
>>> 1) Make the attachment details (e.g. cgroup_id) the part of struct ops
>>> itself. The attachment is happening at the reg() time.
>>>
>>>    +: It's convenient for complex stateful struct ops'es, because a
>>>        single entity represents a combination of code and data.
>>>    -: No way to attach a single struct ops to multiple entities.
>>>
>>> This approach is used by Tejun for per-cgroup sched_ext prototype.
>>>
>>> 2) Make the attachment details a part of bpf_link creation. The
>>> attachment is still happening at the reg() time.
>>>
>>>    +: A single struct ops can be attached to multiple entities.
>>>    -: Implementing stateful struct ops'es is harder and requires passing
>>>       an additional argument (some sort of "self") to all callbacks.
>>> I'm using this approach in the bpf oom proposal.
>>>
>> I think both 1) and 2) have the following issue. With cgroup_id in
>> struct_ops or the link, the cgroup_id works more like a filter. The
>> cgroup doesn't hold any reference to the struct_ops. The bpf link
>> holds the reference to the struct_ops, so we need to keep the
>> the link alive, either by keeping an active fd, or by pinning the
>> link to bpffs. When the cgroup is removed, we need to clean up
>> the bpf link separately.
>
> The link can be detached (struct_ops's unreg) by the user space.
>
> The link can also be detached from the subsystem (cgroup) here.
> It was requested by scx:
> https://lore.kernel.org/all/20240530065946.979330-7-thinker.li@gmail.com/
>
> Not sure if scx has started using it.
>
>>=20
>>> 3) Move the attachment out of .reg() scope entirely. reg() will register
>>> the implementation system-wide and then some 3rd-party interface
>>> (e.g. cgroupfs) should be used to select the implementation.
>>>
>>>    +: ?
>>>    -: New hard-coded interfaces might be required to enable bpf-driven
>>>       kernel customization. The "attachment" code is not shared between
>>>       various struct ops cases.
>>>       Implementing stateful struct ops'es is harder and requires passing
>>>       an additional argument (some sort of "self") to all callbacks.
>>>
>>> This approach works well for cases when there is already a selection
>>> of implementations (e.g. tcp congestion mechanisms), and bpf is adding
>>> another one.
>> Another benefit of 3) is that it allows loading an OOM controller in
>> a
>> kernel module, just like loading a file system in a kernel module. This
>> is possible with 3) because we paid the cost of adding a new select
>> attach interface.
>> A semi-separate topic, option 2) enables attaching a BPF program
>> to a kernel object (a cgroup here, but could be something else). This
>> is an interesting idea, and we may find it useful in other cases (attach
>> a BPF program to a task_struct, etc.).

Yep, task_struct is an attractive target for something like mm-related
policies (THP, NUMA, memory tiers etc).

>
> Does it have plan for a pure kernel module oom implementation?

I highly doubt.

> I think the link-to-cgrp support here does not necessary stop the
> later write to cgroupfs support if a kernel module oom is indeed needed
> in the future.
>
> imo, cgroup-bpf has a eco-system around it, so it is sort of special. bpf=
 user
> has expectation on how a bpf prog is attached to a cgroup. The introspect=
ion,
> auto detachment from the cgroup when the link is gone...etc.
>
> If link-to-cgrp is used, I prefer (2). Stay with one way to attach
> to a cgrp. It is also consistent with the current way of attaching a sing=
le
> bpf prog to a cgroup. It is now attaching a map/set of bpf prog to a cgro=
up.
> The individual struct_ops implementation can decide if it should
> allow a struct_ops be attached multiple times.

+1

