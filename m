Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1742BFE540
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2019 19:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKOSsy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Nov 2019 13:48:54 -0500
Received: from foss.arm.com ([217.140.110.172]:35346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfKOSsy (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 15 Nov 2019 13:48:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA4E930E;
        Fri, 15 Nov 2019 10:48:53 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 028533F534;
        Fri, 15 Nov 2019 10:48:51 -0800 (PST)
Subject: Re: [PATCH v2] sched/topology, cpuset: Account for housekeeping CPUs
 to avoid empty cpumasks
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org,
        mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com
References: <20191104003906.31476-1-valentin.schneider@arm.com>
 <d7ed40aa-1ac1-a42d-51eb-b1bd9f839fb1@arm.com>
 <20191115171807.GH19372@blackbody.suse.cz>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <c425c5cb-ba8a-e5f6-d91c-5479779cfb7a@arm.com>
Date:   Fri, 15 Nov 2019 18:48:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115171807.GH19372@blackbody.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 15/11/2019 17:18, Michal Koutný wrote:
> Hello.
> 
> On Thu, Nov 14, 2019 at 04:03:50PM +0000, Valentin Schneider <valentin.schneider@arm.com> wrote:
>> Michal, could I nag you for a reviewed-by? I'd feel a bit more confident
>> with any sort of approval from folks who actually do use cpusets.
> TL;DR I played with the v5.4-rc6 _without_ this fixup and I conclude it
> unnecessary (IOW my previous theoretical observation was wrong).
> 

Thanks for going through the trouble of testing the thing.

> 
> The original problem is non-issue with v2 cpuset controller, because
> effective_cpus are never empty. isolcpus doesn't take out cpuset CPUs,
> hotplug does. In the case, no online CPU remains in the cpuset, it
> inherits ancestor's non-empty cpuset.
> 

But we still take out the isolcpus from the domain span before handing it
over to the scheduler:

	cpumask_or(dp, dp, b->effective_cpus);                               
	cpumask_and(dp, dp, housekeeping_cpumask(HK_FLAG_DOMAIN));

But...

> I reproduced the problem with v1 (before your fix). However, in v1
> effective == allowed (we're destructive and overwrite allowed on
> hotunplug) and we already check the emptiness of 
> 
>   cpumask_intersects(cp->cpus_allowed, housekeeping_cpumask(HK_FLAG_DOMAIN)
> 
> few lines higher. I.e. the fixup adds redundant check against the empty
> sched domain production.
> 

...You're right, I've been misreading that as a '!is_sched_load_balance()'
condition ever since. Duh. So this condition will always catch cpusets than
only span outside the housekeeping domain, and my previous fixup will
catch newly-empty cpusets (due to HP). Perhaps it would've been cleaner to
merge the two, but as things stand this patch isn't needed (as you say).


I tried this out to really be sure (8 CPU SMP aarch64 qemu target):

  cd /sys/fs/cgroup/cpuset                                                                             
                                                                                                     
  mkdir cs1                                                                                            
  echo 1 > cs1/cpuset.cpu_exclusive                                                                    
  echo 0 > cs1/cpuset.mems                                                                             
  echo 0-4 > cs1/cpuset.cpus                                                                           
                                                                                                     
  mkdir cs2                                                                                            
  echo 1 > cs2/cpuset.cpu_exclusive                                                                    
  echo 0 > cs2/cpuset.mems                                                                             
  echo 5-7 > cs2/cpuset.cpus                                                                           
                                                                                                     
  echo 0 > cpuset.sched_load_balance

booted with
  
  isolcpus=6-7

It seems that creating a cpuset with CPUs only outside the housekeeping
domain is forbidden, so I'm creating cs2 with *one* CPU in the domain. When
I hotplug it out, nothing dies horribly:

  echo 0 > /sys/devices/system/cpu/cpu5/online
  [   24.688145] CPU5: shutdown
  [   24.689438] psci: CPU5 killed.
  [   24.714168] allowed=0-4 effective=0-4 housekeeping=0-5
  [   24.714642] allowed=6-7 effective=6-7 housekeeping=0-5
  [   24.715416] CPU5 attaching NULL sched-domain.

> Sorry for the noise and HTH,

Sure does, thanks!

> Michal
> 
