Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911AA4D40E9
	for <lists+cgroups@lfdr.de>; Thu, 10 Mar 2022 06:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbiCJFsx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Mar 2022 00:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239646AbiCJFsn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Mar 2022 00:48:43 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1B012E141;
        Wed,  9 Mar 2022 21:47:41 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0V6n8cyj_1646891254;
Received: from 30.21.164.59(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V6n8cyj_1646891254)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Mar 2022 13:47:36 +0800
Message-ID: <014c8afe-e57f-0f31-32bb-cf4ff3d3cb95@linux.alibaba.com>
Date:   Thu, 10 Mar 2022 13:47:34 +0800
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
 <defa02c1-9660-f335-a764-d89dbe2f502e@linux.alibaba.com>
 <YijrVmzG8/yT9a0f@slm.duckdns.org>
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <YijrVmzG8/yT9a0f@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/3/10 02:00, Tejun Heo wrote:
> Hello,
> 
> On Wed, Mar 09, 2022 at 04:30:51PM +0800, Tianchen Ding wrote:
>> "the sched domains and the load balancer" you mentioned are the ways to
>> "balance" tasks on each domains. However, this patchset aims to "group" them
>> together to win hot cache and less competition, which is different from load
>> balancer. See commit log of the patch 3/4 and this link:
>> https://lore.kernel.org/all/11d4c86a-40ef-6ce5-6d08-e9d0bc9b512a@linux.alibaba.com/
> 
> I read that but it doesn't make whole lot of sense to me. As Peter noted, we
> already have issues with cross NUMA node balancing interacting with in-node
> balancing, which likely indicates that it needs more unified solution rather
> than more fragmented. I have a hard time seeing how adding yet another layer
> on top helps the situation.
> 
>>> * If, for some reason, you need more customizable behavior in terms of cpu
>>>     allocation, which is what cpuset is for, maybe it'd be better to build the
>>>     load balancer in userspace. That'd fit way better with how cgroup is used
>>>     in general and with threaded cgroups, it should fit nicely with everything
>>>     else.
>>>
>>
>> We put group balancer in kernel space because this new policy does not
>> depend on userspace apps. It's a "general" feature.
> 
> Well, it's general for use cases which are happy with the two knobs that you
> defined for your use case.
> 
>> Doing "dynamic cpuset" in userspace may also introduce performance issue,
>> since it may need to bind and unbind different cpusets for several times,
>> and is too strict(compared with our "soft bind").
> 
> My bet is that you're gonna be able to get just about the same bench results
> with userspace diddling with thread cgroup membership. Why not try that
> first? The interface is already there. I have a hard time seeing the
> justification for hard coding this into the kernel at this stage.
> 
> Thanks.
> 

Well, I understand your point is putting this in userspace. However, 
we've considered about that but found it hard to do so. If you have any 
better idea, please share with us. :-)

If we want to build group balancer in userspace, we need:
   1) gather load info from each rq periodically
   2) make decision to set cpuset.cpus of each cgroup

However, there're some problems about this way.

For 1), we need to consider how frequently collecting these info, which 
may impact performance and accuracy. If the load changes hugely right 
after we get it once, our data are expired and then the decision may be 
wrong. (If we are in kernel, faster action can be taken.)

We believe 2) is harder. The specific policy may be complex and alter 
according to different scenes. There's not a general method.
e.g., with 16cpus and 4 cgroups, how to decide when we set one of them 
0-3(when busy)or 0-7(when some of other cgroups are idle)? If there are 
much more threads in cgroupA than cgroupB/C/D , and we want to satisfy 
cgroupA as far as possible(on the premise of fairness of B/C/D)， 
dynamically enlarging(when B/C/D partly idle) and shrinking(when B/C/D 
busy) cpuset of cgroupA requires complex policy. In this example, 
fairness and performance can be provided by existing scheduler, but when 
it comes to grouping hot cache or decreasing competion, both scheduler 
in kernel and action in userspace are hard to solve.
What's more, in many cloud computing scenes, there may be hundreds or 
thousands of containers, which are much larger than partition number. 
These containers may be dynamically created and destroyed at any time. 
Making policy to manage them from userspace will not be practical.

These problems become easy when going to kernelspace. We get info 
directly from scheduler, and help revising its decision at some key 
points, or do some support work(e.g., task migration if possible).

Thanks.
