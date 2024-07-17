Return-Path: <cgroups+bounces-3730-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D33093382E
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 09:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125371F21AB7
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 07:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8871C68F;
	Wed, 17 Jul 2024 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JV4U7TLN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6234E1109;
	Wed, 17 Jul 2024 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721202364; cv=none; b=gHNLEsxH0vTmDffOjrsITuI5y+eEAyxB3T0GTL7V/MEpbzP1sFgYgoyvLpZPzEVha570FDb6lDajyW6nCP5099S1csDTTT3npzTkQVAkJQ2oPMR6AdC3q6EkAGQGdDGJRtEeVLYmn2tYreBtJwB0w4xIm/H5/ZBcwhoI3r7sKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721202364; c=relaxed/simple;
	bh=M1UAov2c9FIa5WR/+oBi3eCA5gwsOt1hDB+03zxYG4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CaA0U1U2IXs6orzuU5cRUW1BANW2OAXcMbjXjS8mnE6qJkgNkTm5bo5wJkDUlt08WpGDIAZOFrt799SQu1hSWSdm79A9Gyzs1q+vPzEPzck3kQC0eJ4MQSBkQzFQdeZ00/frcygRr2Z62m4tL5P96TjjxE5MPVsmYEvJ5pN9Q1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JV4U7TLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EACDC32782;
	Wed, 17 Jul 2024 07:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721202363;
	bh=M1UAov2c9FIa5WR/+oBi3eCA5gwsOt1hDB+03zxYG4c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JV4U7TLNV/x4Mchsr5JmvrBdpgbJCzl3+aSXz06WivcXQwzX1bcKyk1UYdoIaZWMB
	 QnUzBT2MIuvW/oMsd77wnpZwiK0lpI+mPXdxTlD2bJicB7lhxU37+6AUG8HitUTNkl
	 R5UVXf3EFnc5haC0C+n6/PQDGKBLLPF3w93pH+n1GWGrKSBL0wOfoEViLJAXJuBMGn
	 VgNBGL2ZaJPXiz52bs8jyeZ5EDfeVchNK1O6xzvg3X7Z26yDBvDiTQ2q7lP8Br9B8K
	 Jv9ftcXSOww9/JdlL3Wm4ei5CObiUkOi1dheMGmTZKbmkMwGkeldSVFMqO0vosvLus
	 iCKL7TReGNdMw==
Message-ID: <e656b89a-1dcd-4fcc-811a-a7222232acc7@kernel.org>
Date: Wed, 17 Jul 2024 09:46:00 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, tj@kernel.org,
 cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
 longman@redhat.com, kernel-team@cloudflare.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <171952310959.1810550.17003659816794335660.stgit@firesoul>
 <171952312320.1810550.13209360603489797077.stgit@firesoul>
 <4n3qu75efpznkomxytm7irwfiq44hhi4hb5igjbd55ooxgmvwa@tbgmwvcqsy75>
 <7ecdd625-37a0-49f1-92fc-eef9791fbe5b@kernel.org>
 <9a7930b9-dec0-418c-8475-5a7e18b3ec68@kernel.org>
 <CAJD7tkYX9OaAyWg=L_5v7GaKtKmptPpMGJh7Org5tcY4D-YnCw@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkYX9OaAyWg=L_5v7GaKtKmptPpMGJh7Org5tcY4D-YnCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/07/2024 23.54, Yosry Ahmed wrote:
> On Mon, Jul 8, 2024 at 8:26 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
>>
>> On 28/06/2024 11.39, Jesper Dangaard Brouer wrote:
>>>
>>>
>>> On 28/06/2024 01.34, Shakeel Butt wrote:
>>>> On Thu, Jun 27, 2024 at 11:18:56PM GMT, Jesper Dangaard Brouer wrote:
>>>>> Avoid lock contention on the global cgroup rstat lock caused by kswapd
>>>>> starting on all NUMA nodes simultaneously. At Cloudflare, we observed
>>>>> massive issues due to kswapd and the specific mem_cgroup_flush_stats()
>>>>> call inlined in shrink_node, which takes the rstat lock.
>>>>>
>> [...]
>>>>>    static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>>>>> @@ -312,6 +315,45 @@ static inline void __cgroup_rstat_unlock(struct
>>>>> cgroup *cgrp, int cpu_in_loop)
>>>>>        spin_unlock_irq(&cgroup_rstat_lock);
>>>>>    }
>>>>> +#define MAX_WAIT    msecs_to_jiffies(100)
>>>>> +/* Trylock helper that also checks for on ongoing flusher */
>>>>> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
>>>>> +{
>>>>> +    bool locked = __cgroup_rstat_trylock(cgrp, -1);
>>>>> +    if (!locked) {
>>>>> +        struct cgroup *cgrp_ongoing;
>>>>> +
>>>>> +        /* Lock is contended, lets check if ongoing flusher is already
>>>>> +         * taking care of this, if we are a descendant.
>>>>> +         */
>>>>> +        cgrp_ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
>>>>> +        if (cgrp_ongoing && cgroup_is_descendant(cgrp, cgrp_ongoing)) {
>>>>
>>>> I wonder if READ_ONCE() and cgroup_is_descendant() needs to happen
>>>> within in rcu section. On a preemptable kernel, let's say we got
>>>> preempted in between them, the flusher was unrelated and got freed
>>>> before we get the CPU. In that case we are accessing freed memory.
>>>>
>>>
>>> I have to think about this some more.
>>>
>>
>> I don't think this is necessary. We are now waiting (for completion) and
>> not skipping flush, because as part of take down function
>> cgroup_rstat_exit() is called, which will call cgroup_rstat_flush().
>>
>>
>>    void cgroup_rstat_exit(struct cgroup *cgrp)
>>    {
>>          int cpu;
>>          cgroup_rstat_flush(cgrp);
>>
>>
> 
> Sorry for the late response, I was traveling for a bit. I will take a
> look at your most recent version shortly. But I do have a comment
> here.
> 
> I don't see how this addresses Shakeel's concern. IIUC, if the cgroup
> was freed after READ_ONCE() (and cgroup_rstat_flush() was called),
> then cgroup_is_descendant() will access freed memory. We are not
> holding the lock here so we are not preventing cgroup_rstat_flush()
> from being called for the freed cgroup, right?

If we go back to only allowing root-cgroup to be ongoing-flusher, then
we could do a cgroup_rstat_flush(root) in cgroup_rstat_exit() to be sure
nothing is left waiting for completion scheme. Right?

IMHO the code is getting too complicated with sub-cgroup's as ongoing
flushers which also required having 'completion' queues per cgroup.
We should go back to only doing this for the root-cgroup.

--Jesper



