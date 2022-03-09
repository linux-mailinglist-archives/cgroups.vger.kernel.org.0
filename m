Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE32B4D2AA7
	for <lists+cgroups@lfdr.de>; Wed,  9 Mar 2022 09:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiCIIb7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Mar 2022 03:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCIIb6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Mar 2022 03:31:58 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02842107AAA;
        Wed,  9 Mar 2022 00:30:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0V6iwN-y_1646814652;
Received: from 30.97.48.240(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V6iwN-y_1646814652)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Mar 2022 16:30:54 +0800
Message-ID: <defa02c1-9660-f335-a764-d89dbe2f502e@linux.alibaba.com>
Date:   Wed, 9 Mar 2022 16:30:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC PATCH v2 0/4] Introduce group balancer
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michael Wang <yun.wang@linux.alibaba.com>,
        Cruz Zhao <cruzzhao@linux.alibaba.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Vipin Sharma <vipinsh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20220308092629.40431-1-dtcccc@linux.alibaba.com>
 <YieOvaqJeEW2lta/@slm.duckdns.org>
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <YieOvaqJeEW2lta/@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/3/9 01:13, Tejun Heo wrote:
> Hello,
> 
> On Tue, Mar 08, 2022 at 05:26:25PM +0800, Tianchen Ding wrote:
>> Modern platform are growing fast on CPU numbers. To achieve better
>> utility of CPU resource, multiple apps are starting to sharing the CPUs.
>>
>> What we need is a way to ease confliction in share mode,
>> make groups as exclusive as possible, to gain both performance
>> and resource efficiency.
>>
>> The main idea of group balancer is to fulfill this requirement
>> by balancing groups of tasks among groups of CPUs, consider this
>> as a dynamic demi-exclusive mode. Task trigger work to settle it's
>> group into a proper partition (minimum predicted load), then try
>> migrate itself into it. To gradually settle groups into the most
>> exclusively partition.
>>
>> GB can be seen as an optimize policy based on load balance,
>> it obeys the main idea of load balance and makes adjustment
>> based on that.
>>
>> Our test on ARM64 platform with 128 CPUs shows that,
>> throughput of sysbench memory is improved about 25%,
>> and redis-benchmark is improved up to about 10%.
> 
> The motivation makes sense to me but I'm not sure this is the right way to
> architecture it. We already have the framework to do all these - the sched
> domains and the load balancer. Architecturally, what the suggested patchset
> is doing is building a separate load balancer on top of cpuset after using
> cpuset to disable the existing load balancer, which is rather obviously
> convoluted.
> 

"the sched domains and the load balancer" you mentioned are the ways to 
"balance" tasks on each domains. However, this patchset aims to "group" 
them together to win hot cache and less competition, which is different 
from load balancer. See commit log of the patch 3/4 and this link:
https://lore.kernel.org/all/11d4c86a-40ef-6ce5-6d08-e9d0bc9b512a@linux.alibaba.com/

> * AFAICS, none of what the suggested code does is all that complicated or
>    needs a lot of input from userspace. it should be possible to parametrize
>    the existing load balancer to behave better.
> 

Group balancer mainly needs 2 inputs from userspace: cpu partition info 
and cgroup info.
Cpu partition info does need user input (and maybe a bit complicated). 
As a result, the division methods are __free__ to users(can refer to 
NUMA nodes, clusters, cache, etc.)
Cgroup info doesn't need extra input. It's naturally configured.

It do parametrize the existing load balancer to behave better.
Group balancer is a kind of optimize policy, and should obey the basic
policy (load balance) and improve it.
The relationship between load balancer and group balancer is explained 
in detail at the above link.

> * If, for some reason, you need more customizable behavior in terms of cpu
>    allocation, which is what cpuset is for, maybe it'd be better to build the
>    load balancer in userspace. That'd fit way better with how cgroup is used
>    in general and with threaded cgroups, it should fit nicely with everything
>    else.
> 

We put group balancer in kernel space because this new policy does not 
depend on userspace apps. It's a "general" feature.
Doing "dynamic cpuset" in userspace may also introduce performance 
issue, since it may need to bind and unbind different cpusets for 
several times, and is too strict(compared with our "soft bind").

