Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127FB465670
	for <lists+cgroups@lfdr.de>; Wed,  1 Dec 2021 20:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbhLATaD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Dec 2021 14:30:03 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44422 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352754AbhLAT3z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Dec 2021 14:29:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 14B4BCE20C9;
        Wed,  1 Dec 2021 19:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6C2C53FCC;
        Wed,  1 Dec 2021 19:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638386790;
        bh=3+tnIAcNVr2gta2d6KcvPHcSCBpbqcLGNEvi3YD2Bzc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rKgVT8JDPWA16vqh7GQr4lsVDvAHNuZ1r02ArxnYe0m7okuxBOs8g+gY1lE/3rjpc
         Cks4KxJanYC9vcIiiaXtM5mOwdKYznkH/JldRpwv6s0RxHnRQ0EuV6m7aO6NEzUoGy
         +ylkEFul+MaPps8zm5eQ2q5bYkDL2SWkF3vve19MnJIU28iroQ8Mr37w6XJdP3Wj+S
         3mOfQ09teahngAk7Rf8yhE7A8VDbHaeGHIPl632bUIhSpU8o+aVTSeuaoa5Z3PUCl9
         g09Y7lrwP94TZKPmWR4pklorqJnx1IEPAP/MZFJ3++doGgD5Q1jAzZ9V0JHls07eFV
         VmDJGdCm21L7A==
Message-ID: <d25a9279-6687-df30-3ae1-93ad73bfe193@kernel.org>
Date:   Wed, 1 Dec 2021 21:26:23 +0200
MIME-Version: 1.0
Subject: Re: [RFC] psi: Add additional PSI counters for each type of memory
 pressure
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     vincent.guittot@linaro.org, juri.lelli@redhat.com,
        peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        mhocko@kernel.org, vdavydov.dev@gmail.com, tj@kernel.org,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1636558597-248294-1-git-send-email-quic_c_gdjako@quicinc.com>
 <YYv26rKib03JnYZN@cmpxchg.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <YYv26rKib03JnYZN@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10.11.21 18:44, Johannes Weiner wrote:
> On Wed, Nov 10, 2021 at 07:36:37AM -0800, Georgi Djakov wrote:
>> From: Carlos Ramirez <carlrami@codeaurora.org>
>>
>> Calculates psi totals for memory pressure subevents:
>> compaction, thrashing, direct compaction, direct reclaim, and kswapd0.
>> Uses upper 16 bits of psi_flags to track memory subevents.
> 
> Oof, that's quite heavy both in terms of branches, but also in terms
> of cache - which, depending on wakeup pattern and cpu topology can
> really hurt those paths.
> 
> What's the usecase? Do you have automation that needs to act on one
> type of stall but not the others, for example?

This is mostly for debugging and profiling purposes and does not have 
any automation yet.

> I find that looking at vmstat events on hosts with elevated pressure
> tends to give a pretty good idea of the source. It should also be
> possible to whip up a short bpftrace script to track down culprit
> callstacks of psi_memstall_*.

I found very similar patchset that has been posted previously proposing
almost the same types and some tracepoints in addition to that. I don't
see anyone having an argument against this in the past, so I'm wondering
if this could be an acceptable approach?

https://lore.kernel.org/r/1585649077-10896-2-git-send-email-laoar.shao@gmail.com

>> @@ -1053,19 +1128,56 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
>> +		seq_printf(m, "%s avg10=%lu.%02lu avg60=%lu.%02lu avg300=%lu.%02lu total=%llu %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu\n",
>>   			   full ? "full" : "some",
>>   			   LOAD_INT(avg[0]), LOAD_FRAC(avg[0]),
>>   			   LOAD_INT(avg[1]), LOAD_FRAC(avg[1]),
>>   			   LOAD_INT(avg[2]), LOAD_FRAC(avg[2]),
>> -			   total);
>> +			   total, total_blk_cgroup_throttle, total_bio, total_compaction,
>> +			   total_thrashing, total_cgroup_reclaim_high,
>> +			   total_cgroup_reclaim_high_sleep, total_cgroup_try_charge,
>> +			   total_direct_compaction, total_direct_reclaim, total_read_swappage,
>> +			   total_kswapd);
> 
> The file format is a can of worms. I doubt we can change this at this
> point without breaking parsers, so those numbers would have to live
> somewhere else. But let's figure out the above questions before
> worrying about this.

Agree.

Thanks,
Georgi
