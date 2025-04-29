Return-Path: <cgroups+bounces-7895-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082B9AA0F6F
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 16:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6689C4A3280
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EFB218AB9;
	Tue, 29 Apr 2025 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DMiVA4bg"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E5221A459
	for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937914; cv=none; b=jDcaX6yBsMCACb/tEucLfb48G0r5UjISc3cJqsoi1vpy3ciPEqoXShInOn1AEtjDEvI4XCfF7Mm5rTvfIQe9D3FERHcmpmViWhMFLvqkRL50rZaItJu0lZzbMUCB9SarYHzD3Svp9y9+qwLkycZ7lYuH/ADU+fBCjPZHAPV66zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937914; c=relaxed/simple;
	bh=X4Wo18nxqtTMLDhZsnIwFvvWrKbVcmKLwzzbZn2wAfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ov3n4njH5RWePSlMQkGfFlIc4xFxxYhpn1ySf2nSkU0dJW4W6w/Lh3X7g3q8PxCSBcoTzcAbsnB3V4OZ0tMt+/f41pHpUwzjxKtgx+YbCURHWIz7m9UpQeTMA9BOtzzfZ+n6wDrKv6JPD2EpB3F6byeuEW0a0uH6P/8YrcHfYso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DMiVA4bg; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745937899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rOg8kBrXZEnZpRYh6yQ9Avc2ZWUXKTUFukDwMrQ1gOc=;
	b=DMiVA4bgCsbTpuwrElY5dwht3Cvl2YsSagUxRzi9WTr4aZa0CHe7OYGjmvQ3jkWQYmkdWE
	Q3nFIx+8SJ9JpafbUVrkIZyQJzlZysFdL+o9xmOJKWxddPO8u5/tSYuRiI5Y08fk72fEqh
	IK04CZvyhOsWgHGn3BFqlVxYtH0emwE=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: linux-kernel@vger.kernel.org,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexei Starovoitov <ast@kernel.org>,
  Johannes Weiner <hannes@cmpxchg.org>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  Suren Baghdasaryan <surenb@google.com>,  David
 Rientjes <rientjes@google.com>,  Josh Don <joshdon@google.com>,  Chuyi
 Zhou <zhouchuyi@bytedance.com>,  cgroups@vger.kernel.org,
  linux-mm@kvack.org,  bpf@vger.kernel.org
Subject: Re: [PATCH rfc 00/12] mm: BPF OOM
In-Reply-To: <aBC7E487qDSDTdBH@tiehlicka> (Michal Hocko's message of "Tue, 29
	Apr 2025 13:42:11 +0200")
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
	<aBC7E487qDSDTdBH@tiehlicka>
Date: Tue, 29 Apr 2025 07:44:52 -0700
Message-ID: <87selrrpqz.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Michal Hocko <mhocko@suse.com> writes:

> On Mon 28-04-25 03:36:05, Roman Gushchin wrote:
>> This patchset adds an ability to customize the out of memory
>> handling using bpf.
>> 
>> It focuses on two parts:
>> 1) OOM handling policy,
>> 2) PSI-based OOM invocation.
>> 
>> The idea to use bpf for customizing the OOM handling is not new, but
>> unlike the previous proposal [1], which augmented the existing task
>> ranking-based policy, this one tries to be as generic as possible and
>> leverage the full power of the modern bpf.
>> 
>> It provides a generic hook which is called before the existing OOM
>> killer code and allows implementing any policy, e.g.  picking a victim
>> task or memory cgroup or potentially even releasing memory in other
>> ways, e.g. deleting tmpfs files (the last one might require some
>> additional but relatively simple changes).
>
> Makes sense to me. I still have a slight concern though. We have 3
> different oom handlers smashed into a single one with special casing
> involved. This is manageable (although not great) for the in kernel
> code but I am wondering whether we should do better for BPF based OOM
> implementations. Would it make sense to have different callbacks for
> cpuset, memcg and global oom killer handlers?

Yes, it's certainly possible. If we go struct_ops path, we can even
have both the common hook which handles all types of OOM's and separate
hooks for each type. The user then can choose what's more convenient.
Good point.

>
> I can see you have already added some helper functions to deal with
> memcgs but I do not see anything to iterate processes or find a process to
> kill etc. Is that functionality generally available (sorry I am not
> really familiar with BPF all that much so please bear with me)?

Yes, task iterator is available since v6.7:
https://docs.ebpf.io/linux/kfuncs/bpf_iter_task_new/

>
> I like the way how you naturalely hooked into existing OOM primitives
> like oom_kill_process but I do not see tsk_is_oom_victim exposed. Are
> you waiting for a first user that needs to implement oom victim
> synchronization or do you plan to integrate that into tasks iterators?

It can be implemented in bpf directly, but I agree that it probably
deserves at least an example in the test or a separate in-kernel helper.
In-kernel helper is probably a better idea.

> I am mostly asking because it is exactly these kind of details that
> make the current in kernel oom handler quite complex and it would be
> great if custom ones do not have to reproduce that complexity and only
> focus on the high level policy.

Totally agree.

>
>> The second part is related to the fundamental question on when to
>> declare the OOM event. It's a trade-off between the risk of
>> unnecessary OOM kills and associated work losses and the risk of
>> infinite trashing and effective soft lockups.  In the last few years
>> several PSI-based userspace solutions were developed (e.g. OOMd [3] or
>> systemd-OOMd [4]). The common idea was to use userspace daemons to
>> implement custom OOM logic as well as rely on PSI monitoring to avoid
>> stalls.
>
> This makes sense to me as well. I have to admit I am not fully familiar
> with PSI integration into sched code but from what I can see the
> evaluation is done on regular bases from the worker context kicked off
> from the scheduler code. There shouldn't be any locking constrains which
> is good. Is there any risk if the oom handler took too long though?

It's a good question. In theory yes, it can affect the timing of other
PSI events. An option here is to move it into a separate work, however
I'm not sure if it worth the added complexity. I actually tried this
approach in an earlier version of this patchset, but the problem was
that the code for scheduling this work should be dynamically turned
on/off when a bpf program is attached/detached, otherwise it's an
obvious cpu overhead.
It's doable, but Idk if it's justified.

>
> Also an important question. I can see selftests which are using the
> infrastructure. But have you tried to implement a real OOM handler with
> this proposed infrastructure?

Not yet. Given the size and complexity of the infrastructure of my
current employer, it's not a short process. But we're working on it.

>
>> [1]: https://lwn.net/ml/linux-kernel/20230810081319.65668-1-zhouchuyi@bytedance.com/
>> [2]: https://lore.kernel.org/lkml/20171130152824.1591-1-guro@fb.com/
>> [3]: https://github.com/facebookincubator/oomd
>> [4]: https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd.service.html
>> 
>> ----
>> 
>> This is an RFC version, which is not intended to be merged in the current form.
>> Open questions/TODOs:
>> 1) Program type/attachment type for the bpf_handle_out_of_memory() hook.
>>    It has to be able to return a value, to be sleepable (to use cgroup iterators)
>>    and to have trusted arguments to pass oom_control down to bpf_oom_kill_process().
>>    Current patchset has a workaround (patch "bpf: treat fmodret tracing program's
>>    arguments as trusted"), which is not safe. One option is to fake acquire/release
>>    semantics for the oom_control pointer. Other option is to introduce a completely
>>    new attachment or program type, similar to lsm hooks.
>> 2) Currently lockdep complaints about a potential circular dependency because
>>    sleepable bpf_handle_out_of_memory() hook calls might_fault() under oom_lock.
>>    One way to fix it is to make it non-sleepable, but then it will require some
>>    additional work to allow it using cgroup iterators. It's intervened with 1).
>
> I cannot see this in the code. Could you be more specific please? Where
> is this might_fault coming from? Is this BPF constrain?

It's in __bpf_prog_enter_sleepable(). But I hope I can make this hook
non-sleepable (by going struct_ops path) and the problem will go away.

>
>> 3) What kind of hierarchical features are required? Do we want to nest oom policies?
>>    Do we want to attach oom policies to cgroups? I think it's too complicated,
>>    but if we want a full hierarchical support, it might be required.
>>    Patch "mm: introduce bpf_get_root_mem_cgroup() bpf kfunc" exposes the true root
>>    memcg, which is potentially outside of the ns of the loading process. Does
>>    it require some additional capabilities checks? Should it be removed?
>
> Yes, let's start simple and see where we get from there.

Agree.

Thank you for taking a look and your comments/ideas!

