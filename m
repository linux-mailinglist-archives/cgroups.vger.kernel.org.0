Return-Path: <cgroups+bounces-9701-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF98B43509
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 10:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690651C82D9E
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 08:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1752C028A;
	Thu,  4 Sep 2025 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lW0a6TEq"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0003A2BEC43;
	Thu,  4 Sep 2025 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973424; cv=none; b=JE7FtqbFu9qdDRCieIin/xdLrGyl6JON9JNfdY3NuzOKqKMhEJJUVZU4eDyHCVWLuUCvFKSZzXNGYefxg0VAavXxl5U7EdyrwYQS8xMRHrjEKbtrcf3pSS6c5OWR3TMu+7ucx+u4OvxaGjWbq5L9sPeRX5FmLT4gA4k832kCTgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973424; c=relaxed/simple;
	bh=Ea797uyOnJzCFKJU7Ps7JbEQc/YHyKb3Iu5+Q5E1xFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8VRSTbSJ5mNYZidmbK0PiyuamDRHA/rpNv5AFPb2KpIaI1mfOFDbkwYii6aPQpl7KgXoVCjPTzxXDrLlridoQYrK8qWPZzEWJf3FUCFV863sQ6YrMy03Nh1FKN3ZjDEF3Jo9BoIAJeebQw1vlJT36eXBtN+KJQqMkznhH899VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lW0a6TEq; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756973418; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RkPE4ITy1+3CZ+iiMlih1L2trxJFck5ZWEM1kI6X8tA=;
	b=lW0a6TEqMW/gxpynjxbVMkrKZ0lVIBWsTHlozUu5+G7wIpCOrSJ/W0Hdta01Q8HvSlBXjcWBbe7rm2is+D39HS+dRwQJrwQ4DVN7n/eQOP+2dpsSsNytpl7D4weryXQdVyvw0eB2doQ6Nce5v/7FhEAxZsLO90wOmRGq/gVJkXw=
Received: from 30.221.148.63(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0WnEzvj8_1756973417 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 16:10:18 +0800
Message-ID: <8d406a89-3937-4fa2-84a9-624db3c75c76@linux.alibaba.com>
Date: Thu, 4 Sep 2025 16:10:17 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
To: Tejun Heo <tj@kernel.org>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <aLhykIPSGV1k_OG0@slm.duckdns.org>
 <cfe595a7-c20d-4891-aba1-35546c488024@linux.alibaba.com>
 <aLk_o0GUhC14T8f9@slm.duckdns.org>
From: escape <escape@linux.alibaba.com>
In-Reply-To: <aLk_o0GUhC14T8f9@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/4 15:28, Tejun Heo 写道:
> Hello,
>
> On Thu, Sep 04, 2025 at 11:15:26AM +0800, escape wrote:
>> 在 2025/9/4 00:53, Tejun Heo 写道:
>>> Hello,
> ...
>> As Ridong pointed out, in the current code, using CLONE_INTO_CGROUP
>> still requires holding the threadgroup_rwsem, so contention with fork
>> operations persists.
> Sorry about my fumbling explanations repeatedly but this isn't true. On
> cgroup2, if you create a cgroup, enable controllers and then seed it with
> CLONE_INTO_CGROUP, threadgroup_rwsem is out of the picture. The only
> remaining contention point is cgroup_mutex.
>
>> CLONE_INTO_CGROUP helps alleviate the contention between cgroup creation
>> and deletion, but its usage comes with significant limitations:
>>
>> 1. CLONE_INTO_CGROUP is only available in cgroup v2. Although cgroup v2
>> adoption is gradually increasing, many applications have not yet been
>> adapted to cgroup v2, and phasing out cgroup v1 will be a long and
>> gradual process.
>>
>> 2. CLONE_INTO_CGROUP requires specifying the cgroup file descriptor at the
>> time of process fork, effectively restricting cgroup migration to the
>> fork stage. This differs significantly from the typical cgroup attach
>> workflow. For example, in Kubernetes, systemd is the recommended cgroup
>> driver; kubelet communicates with systemd via D-Bus, and systemd
>> performs the actual cgroup attachment. In this case, the process being
>> attached typically does not have systemd as its parent. Using
>> CLONE_INTO_CGROUP in such a scenario is impractical and would require
>> coordinated changes to both systemd and kubelet.
> A percpu rwsem (threadgroup_rwsem) was used instead of per-threadgroup
> locking to avoid adding overhead to hot paths - fork and exit - because
> cgroup operations were expected to be a lot colder. Now, threadgroup rwsem
> is *really* expensive for the writers, so the trade-off could be a bit too
> extreme for some use cases.
>
> However, now that the most common usage pattern doesn't involve
> threadgroup_rwsem, I don't feel too enthusiastic about adding hot path
> overhead to work around usage patterns that we want to move away from. Note
> that dynamic migrations have other more fundamental problems for stateful
> resources and we generally want to move away from it. Sure, a single rwsem
> operation in fork/exit isn't a lot of overhead but it isn't nothing either
> and this will impact everybody.
>
> Maybe we can make it a mount option so that use cases that still depend on
> it can toggle it on? In fact, there's already favordynmods mount option
> which seems like a good fit. Maybe put the extra locking behind that flag?
>
> Thanks.
>
Thank you for your reply.

I agree that mounting with cgroupv2, creating a cgroup, enabling 
controllers,
and then seeding it with CLONE_INTO_CGROUP is an excellent solution. 
However,
we've encountered significant obstacles when applying this approach on some
older systems. We are simultaneously working on enabling CLONE_INTO_CGROUP
support in runc, systemd, and other components, but this will take some 
time.
This patch aims to alleviate the issue to some extent during this 
transitional
period.

Regarding the impact of the extra rwsem operations on hot paths, I have 
conducted
performance testing. In cases where there is no contention on down_write,
the UnixBench spawn test scores remain unaffected.

The suggestion to use the favordynmods flag to control whether the extra 
rwsem
is used is excellent. I will incorporate this condition in the next 
version of
the patch.

Thanks.


