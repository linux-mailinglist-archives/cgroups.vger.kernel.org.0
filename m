Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D68B44C54B
	for <lists+cgroups@lfdr.de>; Wed, 10 Nov 2021 17:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhKJQsq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Nov 2021 11:48:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhKJQsq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 10 Nov 2021 11:48:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3043161248;
        Wed, 10 Nov 2021 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636562758;
        bh=2rKwlyZ/ynAX3ujGshIRvU/bHH1kMmrQsdaEhK7qGGU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mo9CR/krq5MNRIVRB638Ym/lZMkpqiYdpC64Dwx9oQKcTiEWBo6iQ81j15GN6XOvZ
         FGvv2NsdcDHtHtJWfRdV8F+ReKl19MWjJKYlFvJmAsBcmqpsNu2W1Yx5YavvQpjseM
         56MkZCSxcr8gRefguukzuS0D3harUSgTJcugLdEHgAo0fyPyeWTHklmmkZ1POa+d1l
         TmSb5BJCRcEYVlGR1uzSEu3YdDlohZ0x6b0dovukDugXM+YRE/1jo0CC6w4ODmiYlA
         pKHgQQPNN+KjnntlpcJ35qdu9Cz/Y+NestzaNwq6hRHpBmDNnbUBrql9jJMEO36T04
         bB9usziDKB6Aw==
Message-ID: <1fd2d97b-7c83-3a82-ada3-46ec5025c3b1@kernel.org>
Date:   Wed, 10 Nov 2021 18:45:53 +0200
MIME-Version: 1.0
Subject: Re: [RFC] psi: Add additional PSI counters for each type of memory
 pressure
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     hannes@cmpxchg.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, mingo@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        mhocko@kernel.org, vdavydov.dev@gmail.com, tj@kernel.org,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1636558597-248294-1-git-send-email-quic_c_gdjako@quicinc.com>
 <20211110161402.GB174703@worktop.programming.kicks-ass.net>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20211110161402.GB174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 10.11.21 18:14, Peter Zijlstra wrote:
> On Wed, Nov 10, 2021 at 07:36:37AM -0800, Georgi Djakov wrote:
>> @@ -21,7 +19,18 @@ enum psi_task_count {
>>   	 * don't have to special case any state tracking for it.
>>   	 */
>>   	NR_ONCPU,
>> -	NR_PSI_TASK_COUNTS = 4,
>> +	NR_BLK_CGROUP_THROTTLE,
>> +	NR_BIO,
>> +	NR_COMPACTION,
>> +	NR_THRASHING,
>> +	NR_CGROUP_RECLAIM_HIGH,
>> +	NR_CGROUP_RECLAIM_HIGH_SLEEP,
>> +	NR_CGROUP_TRY_CHARGE,
>> +	NR_DIRECT_COMPACTION,
>> +	NR_DIRECT_RECLAIM,
>> +	NR_READ_SWAPPAGE,
>> +	NR_KSWAPD,
>> +	NR_PSI_TASK_COUNTS = 16,
>>   };
>>   
> 
>> @@ -51,9 +80,20 @@ enum psi_states {
>>   	PSI_MEM_FULL,
>>   	PSI_CPU_SOME,
>>   	PSI_CPU_FULL,
>> +	PSI_BLK_CGROUP_THROTTLE,
>> +	PSI_BIO,
>> +	PSI_COMPACTION,
>> +	PSI_THRASHING,
>> +	PSI_CGROUP_RECLAIM_HIGH,
>> +	PSI_CGROUP_RECLAIM_HIGH_SLEEP,
>> +	PSI_CGROUP_TRY_CHARGE,
>> +	PSI_DIRECT_COMPACTION,
>> +	PSI_DIRECT_RECLAIM,
>> +	PSI_READ_SWAPPAGE,
>> +	PSI_KSWAPD,
>>   	/* Only per-CPU, to weigh the CPU in the global average: */
>>   	PSI_NONIDLE,
>> -	NR_PSI_STATES = 7,
>> +	NR_PSI_STATES = 18,
>>   };
> 
> Have you considered what this does to psi_group_cpu's size and layout
> and the impact thereof on performance?

Thanks, i will definitely add some numbers in case there are no other
major arguments against this RFC patch.

BR,
Georgi
