Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316F12FBA22
	for <lists+cgroups@lfdr.de>; Tue, 19 Jan 2021 15:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbhASOnz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 09:43:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731669AbhASJms (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 04:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611049272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rA912ssEjdc11sdlbuultyIkt3xlDDquI7cJUnlq4yQ=;
        b=Y/x9Zp4MXgsaLQ2NKchGcPgaF0E6Hehkt+aWnH5NdtV9GeeP5wHRkTLMIAVwqEkUgIOqys
        qmBSG9PTSQqClP2rurnYpvlSlbLw8I34oJo70zR7ZaM3UHNaxnRuP78zWXSFDYYFcCPams
        1Obni8UEkyJX1VILn7QTCTC4tstL5b0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-C5smNCIwN_WdDFS6EwQozg-1; Tue, 19 Jan 2021 04:41:08 -0500
X-MC-Unique: C5smNCIwN_WdDFS6EwQozg-1
Received: by mail-wr1-f71.google.com with SMTP id g16so9661944wrv.1
        for <cgroups@vger.kernel.org>; Tue, 19 Jan 2021 01:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rA912ssEjdc11sdlbuultyIkt3xlDDquI7cJUnlq4yQ=;
        b=tyDaBlwA8ysiUfC6I/zgk3QpV8IvT0iPZo0qow8BCAnVSRLc/9pl8Uw3jQWvEXUdth
         TieLE40NcFQhqtcOmcgZ3Qm7H60Z2mbFRpNGOYe8AyNNPtdAiWY8YjjsSeyPfPjoCKd0
         4q274jO6e/8NZmnrJbRJ/evFJjKs5zPPfswHHjO/CEH8nq6ypay6EjVnD7RtQ48Ea5cd
         pYQaAx/fb7xGY0tYYzpgRoDr/03GQknb+kLpL+U/cv26c8L6rPXyuMT6d3gFfvuRw2SK
         FZuTlyrOdfGWEH6NwDD6/+pbRRVwNa2YmzZ93uoD1MAo3xlUOgDBOBLbtygaAhU8nIir
         AjKg==
X-Gm-Message-State: AOAM530nXscsWPIw5D47G3uLT75iid6iLsNcRm4PVPM86Lc68ENKuKEo
        Sy7mqFY3tQiXNn0272Iu3Z8Y1pqPfAJTJ6oV6pCILqRQ1JsZiwFJkblcGu91ZeJvI1KR7tOHbBi
        iAXfK+2ooC0UelaZsVZAqaZoHi1NNa7rNSDBPvkJzefX5evsugT2ssPAN5axWqedoOMch
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr3525284wru.334.1611049266472;
        Tue, 19 Jan 2021 01:41:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyo5rCi6LL5iRaFmuFsthO6gkLMi6OZSb9Yy7qdPtrmaxjbUb6NdSD+nzxdb0yoVGFffcs4LQ==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr3525246wru.334.1611049266211;
        Tue, 19 Jan 2021 01:41:06 -0800 (PST)
Received: from x1.bristot.me (host-79-46-192-171.retail.telecomitalia.it. [79.46.192.171])
        by smtp.gmail.com with ESMTPSA id w4sm3375305wmc.13.2021.01.19.01.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 01:41:05 -0800 (PST)
Subject: Re: [PATCH 4/6] sched/deadline: Block DL tasks on non-exclusive
 cpuset if bandwitdh control is enable
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Marco Perronet <perronet@mpi-sws.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        cgroups@vger.kernel.org
References: <cover.1610463999.git.bristot@redhat.com>
 <7b336c37cc3c38def6de181df8ba8c3148c5cc0c.1610463999.git.bristot@redhat.com>
 <4b37b32b-0e16-ffbc-ca6a-fbee935c0813@arm.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <08dd4e61-5c4a-b010-2149-8f84ced3fb38@redhat.com>
Date:   Tue, 19 Jan 2021 10:41:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4b37b32b-0e16-ffbc-ca6a-fbee935c0813@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/14/21 4:51 PM, Dietmar Eggemann wrote:
> On 12/01/2021 16:53, Daniel Bristot de Oliveira wrote:
>> The current SCHED_DEADLINE design supports only global scheduler,
>> or variants of it, i.e., clustered and partitioned, via cpuset config.
>> To enable the partitioning of a system with clusters of CPUs, the
>> documentation advises the usage of exclusive cpusets, creating an
>> exclusive root_domain for the cpuset.
>>
>> Attempts to change the cpu affinity of a thread to a cpu mask different
>> from the root domain results in an error. For instance:
> 
> [...]
> 
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index 788a391657a5..c221e14d5b86 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -2878,6 +2878,13 @@ int dl_task_can_attach(struct task_struct *p,
>>  	if (cpumask_empty(cs_cpus_allowed))
>>  		return 0;
>>  
>> +	/*
>> +	 * Do not allow moving tasks to non-exclusive cpusets
>> +	 * if bandwidth control is enabled.
>> +	 */
>> +	if (dl_bandwidth_enabled() && !exclusive)
>> +		return -EBUSY;
>> +
>>  	/*
>>  	 * The task is not moving to another root domain, so it is
>>  	 * already accounted.
>>
> 
> But doesn't this mean you only have to set this cgroup exclusive/root to
> run into the same issue:
> 
> with this patch:
> 
> cgroupv1:
> 
> root@juno:/sys/fs/cgroup/cpuset# chrt -d --sched-period 1000000000
> --sched-runtime 100000000 0 sleep 500 &
> [1] 1668
> root@juno:/sys/fs/cgroup/cpuset# PID1=$!
> 
> root@juno:/sys/fs/cgroup/cpuset# chrt -d --sched-period 1000000000
> --sched-runtime 100000000 0 sleep 500 &
> [2] 1669
> root@juno:/sys/fs/cgroup/cpuset# PID2=$!
> 
> root@juno:/sys/fs/cgroup/cpuset# mkdir A
> 
> root@juno:/sys/fs/cgroup/cpuset# echo 0 > ./A/cpuset.mems
> root@juno:/sys/fs/cgroup/cpuset# echo 0 > ./A/cpuset.cpus
> 
> root@juno:/sys/fs/cgroup/cpuset# echo $PID2 > ./A/cgroup.procs
> -bash: echo: write error: Device or resource busy
> 
> root@juno:/sys/fs/cgroup/cpuset# echo 1 > ./A/cpuset.cpu_exclusive
> 
> root@juno:/sys/fs/cgroup/cpuset# echo $PID2 > ./A/cgroup.procs
> 
> root@juno:/sys/fs/cgroup/cpuset# cat /proc/$PID1/status | grep
> Cpus_allowed_list | awk '{print $2}'
> 0-5
> root@juno:/sys/fs/cgroup/cpuset# cat /proc/$PID2/status | grep
> Cpus_allowed_list | awk '{print $2}'
> 0

On CPU v1 we also need to disable the load balance to create a root domain, right?

> cgroupv2:

Yeah, I see your point. I was seeing a different output because of Fedora
default's behavior of adding the tasks to the system.slice/user.slice...

doing:

> root@juno:/sys/fs/cgroup# echo +cpuset > cgroup.subtree_control

# echo $$ > cgroup.procs

> root@juno:/sys/fs/cgroup# chrt -d --sched-period 1000000000
> --sched-runtime 100000000 0 sleep 500 &
> [1] 1687
> root@juno:/sys/fs/cgroup# PID1=$!
> 
> root@juno:/sys/fs/cgroup# chrt -d --sched-period 1000000000
> --sched-runtime 100000000 0 sleep 500 &
> [2] 1688
> root@juno:/sys/fs/cgroup# PID2=$!
> 
> root@juno:/sys/fs/cgroup# mkdir A
> 
> root@juno:/sys/fs/cgroup# echo 0 > ./A/cpuset.mems
> root@juno:/sys/fs/cgroup# echo 0 > ./A/cpuset.cpus
> 
> root@juno:/sys/fs/cgroup# echo $PID2 > ./A/cgroup.procs
> -bash: echo: write error: Device or resource busy
> 
> root@juno:/sys/fs/cgroup# echo root > ./A/cpuset.cpus.partition
> 
> root@juno:/sys/fs/cgroup# echo $PID2 > ./A/cgroup.procs
> 
> root@juno:/sys/fs/cgroup# cat /proc/$PID1/status | grep
> Cpus_allowed_list | awk '{print $2}'
> 0-5
> root@juno:/sys/fs/cgroup# cat /proc/$PID2/status | grep
> Cpus_allowed_list | awk '{print $2}'
> 0

makes me see the same behavior. This will require further analysis.

So, my plan now is to split this patch set into two, one with patches 1,3,5, and
6, which fixes the most "easy" part of the problems, and another with 2 and 4
that will require further investigation (discussed this with Dietmar already).

Thoughts?

-- Daniel

