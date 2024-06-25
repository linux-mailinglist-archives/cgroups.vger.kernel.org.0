Return-Path: <cgroups+bounces-3360-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9CA916D1D
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 17:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70582B21CD4
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 15:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8298416F0EA;
	Tue, 25 Jun 2024 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVpVooIv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C31543ADE;
	Tue, 25 Jun 2024 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329577; cv=none; b=WmYmLKaVbn53W5fXz3brYcDeqy4lKev6sFJZ2sPa/pnqX7HxU3TLukarGEwUZYwMuBfwG181g7p1XrHl7SGwYKf/h+uPul8WHzD9C3EjLCdiMxjQbr2cgoTSu8lx12ojk+rebXL070w6PP9kx9Gihr7wdUtkLjDoH+ijdnRIq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329577; c=relaxed/simple;
	bh=uZ8BwQJ/Kdq0iyp8vn3LgQFFUO/XtKzGirgwze/0unA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAzJ34pY8m09UE8lv3L+F/s8m2sajOhMEcHTTkGJY0pbgYS4UOWGk6eBzc+Zhzy6lF3IVMKYzVaPqTub2Q+Ee6T4w7uCIt9XunRvSSWsUSbelye49RQvZRIehtdXuDSvDk7sbllWYmUjDSdm0aiRGzp2IQ1jsJnNbDrop0nQ9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVpVooIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83A3C32781;
	Tue, 25 Jun 2024 15:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719329576;
	bh=uZ8BwQJ/Kdq0iyp8vn3LgQFFUO/XtKzGirgwze/0unA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OVpVooIv/ne2KJwP31QW0B8pvv2CFLfRpajLqK33jScWmGhBOKtLs50n/Q8riekVo
	 b2XhWqcmUwnFziccfC3QkrJWgfndsFYXnzayD2Lq+7A+hBtQ0xrIeGVk+dhrT/mWxM
	 LtkWadLfKMF7otN1jwMyjn9nhEP8StXTvJhEAJWpfqsU40ku5jS1KSS7yv5pvZOi/P
	 mUkKdbQX7Psjkoiwk+d9AMsRA21zryclmEdt5367GSPa7BO64Hak7ukKTaKaqYd/zu
	 X10vIZYeLxtkcADsaeihFWqZB5i7HDnXFNxkK7/m+TUb8XYZOPug30piF3O7u/J1Ob
	 DT60ahSF/KEbQ==
Message-ID: <d3b5f10a-2649-446c-a6f9-9311f96e7569@kernel.org>
Date: Tue, 25 Jun 2024 17:32:53 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Yosry Ahmed <yosryahmed@google.com>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: tj@kernel.org, cgroups@vger.kernel.org, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, longman@redhat.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <171923011608.1500238.3591002573732683639.stgit@firesoul>
 <CAJD7tkbHNvQoPO=8Nubrd5an7_9kSWM=5Wh5H1ZV22WD=oFVMg@mail.gmail.com>
 <tl25itxuzvjxlzliqsvghaa3auzzze6ap26pjdxt6spvhf5oqz@fvc36ntdeg4r>
 <CAJD7tkaKDcG+W+C6Po=_j4HLOYN23rtVnM0jmC077_kkrrq9xA@mail.gmail.com>
 <exnxkjyaslel2jlvvwxlmebtav4m7fszn2qouiciwhuxpomhky@ljkycu67efbx>
 <CAJD7tkaJXNfWQtoURyf-YWS7WGPMGEc5qDmZrxhH2+RE-LeEEg@mail.gmail.com>
 <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg>
 <CAJD7tkZT_2tyOFq5koK0djMXj4tY8BO3CtSamPb85p=iiXCgXQ@mail.gmail.com>
 <qolg56e7mjloynou6j7ar7xzefqojp4cagzkb3r6duoj5i54vu@jqhi2chs4ecj>
 <CAJD7tka0b52zm=SjqxO-gxc0XTib=81c7nMx9MFNttwVkCVmSg@mail.gmail.com>
 <u3jrec5n42v35f3xiigfqabajjt4onh44eyfajewnzbfqxaekw@5x2daobkkbxh>
 <CAJD7tkaMeevj2TS_aRj_WXVi26CuuBrprYwUfQmszJnwqqJrHw@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkaMeevj2TS_aRj_WXVi26CuuBrprYwUfQmszJnwqqJrHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25/06/2024 11.28, Yosry Ahmed wrote:
> On Mon, Jun 24, 2024 at 5:24 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>
>> On Mon, Jun 24, 2024 at 03:21:22PM GMT, Yosry Ahmed wrote:
>>> On Mon, Jun 24, 2024 at 3:17 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>>>
>>>> On Mon, Jun 24, 2024 at 02:43:02PM GMT, Yosry Ahmed wrote:
>>>> [...]
>>>>>>
>>>>>>> There is also
>>>>>>> a heuristic in zswap that may writeback more (or less) pages that it
>>>>>>> should to the swap device if the stats are significantly stale.
>>>>>>>
>>>>>>
>>>>>> Is this the ratio of MEMCG_ZSWAP_B and MEMCG_ZSWAPPED in
>>>>>> zswap_shrinker_count()? There is already a target memcg flush in that
>>>>>> function and I don't expect root memcg flush from there.
>>>>>
>>>>> I was thinking of the generic approach I suggested, where we can avoid
>>>>> contending on the lock if the cgroup is a descendant of the cgroup
>>>>> being flushed, regardless of whether or not it's the root memcg. I
>>>>> think this would be more beneficial than just focusing on root
>>>>> flushes.
>>>>
>>>> Yes I agree with this but what about skipping the flush in this case?
>>>> Are you ok with that?
>>>
>>> Sorry if I am confused, but IIUC this patch affects all root flushes,
>>> even for userspace reads, right? In this case I think it's not okay to
>>> skip the flush without waiting for the ongoing flush.
>>
>> So, we differentiate between userspace and in-kernel users. For
>> userspace, we should not skip flush and for in-kernel users, we can skip
>> if flushing memcg is the ancestor of the given memcg. Is that what you
>> are saying?
> 
> Basically, I prefer that we don't skip flushing at all and keep
> userspace and in-kernel users the same. We can use completions to make
> other overlapping flushers sleep instead of spin on the lock.
> 

I think there are good reasons for skipping flushes for userspace when 
reading these stats. More below.

I'm looking at kernel code to spot cases where the flush MUST to be
completed before returning.  There are clearly cases where we don't need
100% accurate stats, evident by mem_cgroup_flush_stats_ratelimited() and
mem_cgroup_flush_stats() that use memcg_vmstats_needs_flush().

The cgroup_rstat_exit() call seems to depend on cgroup_rstat_flush() 
being strict/accurate, because need to free the percpu resources.

The obj_cgroup_may_zswap() have a comments that says it needs to get 
accurate stats for charging.

These were the two cases, I found, do you know of others?


> A proof of concept is basically something like:
> 
> void cgroup_rstat_flush(cgroup)
> {
>      if (cgroup_is_descendant(cgroup, READ_ONCE(cgroup_under_flush))) {
>          wait_for_completion_interruptible(&cgroup_under_flush->completion);
>          return;
>      }

This feels like what we would achieve by changing this to a mutex.

> 
>      __cgroup_rstat_lock(cgrp, -1);
>      reinit_completion(&cgroup->completion);
>      /* Any overlapping flush requests after this write will not spin
> on the lock */
>      WRITE_ONCE(cgroup_under_flush, cgroup);
> 
>      cgroup_rstat_flush_locked(cgrp);
>      complete_all(&cgroup->completion);
>      __cgroup_rstat_unlock(cgrp, -1);
> }
> 
> There may be missing barriers or chances to reduce the window between
> __cgroup_rstat_lock and WRITE_ONCE(), but that's what I have in mind.
> I think it's not too complicated, but we need to check if it fixes the
> problem.
> 
> If this is not preferable, then yeah, let's at least keep the
> userspace behavior intact. This makes sure we don't affect userspace
> negatively, and we can change it later as we please.

I don't think userspace reading these stats need to be 100% accurate.
We are only reading the io.stat, memory.stat and cpu.stat every 53 
seconds. Reading cpu.stat print stats divided by NSEC_PER_USEC (1000).

If userspace is reading these very often, then they will be killing the 
system as it disables IRQs.

On my prod system the flush of root cgroup can take 35 ms, which is not 
good, but this inaccuracy should not matter for userspace.

Please educate me on why we need accurate userspace stats?


--Jesper

