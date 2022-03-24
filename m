Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141A74E5EF2
	for <lists+cgroups@lfdr.de>; Thu, 24 Mar 2022 07:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345983AbiCXGwl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Mar 2022 02:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiCXGwk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Mar 2022 02:52:40 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFB195493;
        Wed, 23 Mar 2022 23:51:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0V83hx77_1648104651;
Received: from 30.39.225.82(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V83hx77_1648104651)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Mar 2022 14:50:53 +0800
Message-ID: <4529fa25-9497-b05c-90c0-42fb10841a22@linux.alibaba.com>
Date:   Thu, 24 Mar 2022 14:50:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
Subject: Re: [RFC PATCH v2 0/4] Introduce group balancer
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
 <014c8afe-e57f-0f31-32bb-cf4ff3d3cb95@linux.alibaba.com>
 <YjjA+vyQuh5fNeLG@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <YjjA+vyQuh5fNeLG@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2022/3/22 02:16, Tejun Heo wrote:
> Hello,
> 
> On Thu, Mar 10, 2022 at 01:47:34PM +0800, Tianchen Ding wrote:
>> If we want to build group balancer in userspace, we need:
>>    1) gather load info from each rq periodically
>>    2) make decision to set cpuset.cpus of each cgroup
>>
>> However, there're some problems about this way.
>>
>> For 1), we need to consider how frequently collecting these info, which may
>> impact performance and accuracy. If the load changes hugely right after we
>> get it once, our data are expired and then the decision may be wrong. (If we
>> are in kernel, faster action can be taken.)
> 
> We now have a pretty well established way to transport data to userspace at
> really low overhead. If you piggy back on bpf interfaces, they can usually
> be pretty unintrusive and low effort as long as you have the right kind of
> data aggregated already, which shouldn't be that difficult here.
> 

Yes, bpf is a good way to fetch these data.
In fact we may also consider impacting on some decisions of scheduler in 
some scenes. But it seems to be a long term work...

>> We believe 2) is harder. The specific policy may be complex and alter
>> according to different scenes. There's not a general method.
>> e.g., with 16cpus and 4 cgroups, how to decide when we set one of them
>> 0-3(when busy)or 0-7(when some of other cgroups are idle)? If there are much
>> more threads in cgroupA than cgroupB/C/D , and we want to satisfy cgroupA as
>> far as possible(on the premise of fairness of B/C/D)， dynamically
>> enlarging(when B/C/D partly idle) and shrinking(when B/C/D busy) cpuset of
>> cgroupA requires complex policy. In this example, fairness and performance
>> can be provided by existing scheduler, but when it comes to grouping hot
>> cache or decreasing competion, both scheduler in kernel and action in
>> userspace are hard to solve.
> 
> So, I get that it's not easy. In fact, we don't even yet know how to
> properly compare loads across groups of CPUs - simple sums that you're using
> break down when there are big gaps in weight numbers across tasks and can
> become meaningless in the presence of CPU affinities. They can still work

"simple sums" is fine because we only use this load when selecting 
partitions, not migrating.

If I understand correctly, do you mean a scene that:
cgroupA has only one thread with full busy load (1024)
cgroup B/C/D have many threads with small load (maybe 100)
There're two CPU partitons:0-3 and 4-7

If A choose 0-3 (we suppose its thread sticking on cpu0), so the load of 
partition 0-3 becomes 1024 because simple sums. So B/C/D will all choose 
partition 4-7. This will be fine since our group balancer is a kind of 
"soft" bind. If we are waking a thread from cgroupB and find there is no 
free cpu in 4-7, we'll fallback to normal path and select other idle cpu 
(i.e., 1-3) if possible.
Otherwise, if there is no idle cpu totally, meaning the whole system is 
busy. The existing load balance mechanism will handle it, and our 
patches only try to switch two tasks if their cache in their own cgroups 
can be closer after migration.

> when the configuration is fairly homogeenous and controlled but the standard
> should be far higher for something we bake into the kernel and expose
> userland-visible interface for.
> 

Our aim is to improve performance of apps, so will not limit cpu usage 
strictly. This kind of soft bind also helps to avoid conflicts with 
existing load balance mechanism. We may explain this in document.

>> What's more, in many cloud computing scenes, there may be hundreds or
>> thousands of containers, which are much larger than partition number. These
>> containers may be dynamically created and destroyed at any time. Making
>> policy to manage them from userspace will not be practical.
>>
>> These problems become easy when going to kernelspace. We get info directly
>> from scheduler, and help revising its decision at some key points, or do
>> some support work(e.g., task migration if possible).
> 
> I don't think they become necessarily easy. Sure, you can hack up something
> which works for some cases by poking into existing code; however, the bar
> for acceptance is also way higher for a kernel interface - it should be
> generic, consistent with other interfaces (I won't go into cgroup interface
> issues here), and work orthogonally with other kernel features (ie. task /
> group weights should work in an explainable way). I don't think the proposed
> patches are scoring high in those axes.
> 

We set the interface into cpuset subsys because partition info should 
follow effective_cpus. There may be a problem that we need to get load 
info from cpu subsys, so "cpu" and "cpuset" should be both enabled in 
the same cgroup. Fortunately, this is easy in cgroup-v2. Any other 
conflict do you see?

About "work orthogonally with other kernel features", we've explained 
above. Weights are only used in selecting partitions and we just tend to 
trying pulling tasks to their selected partitions, not force.

> I'm not against the goal here. Given that cgroups express the logical
> structure of applications running on the system, it does make sense to
> factor that into scheduling decisions. However, what's proposed seems too
> premature and I have a hard time seeing why this level of functionality
> would be difficult to be implement from userspace with some additions in
> terms of visibility which is really easy to do these days.

Just as out explanation in the last mail, we believe building this in 
userspace is not easy. Because interfaces provided by kernel now is 
inflexible. From the view of cgroup, it is given a binded "cpuset.cpus", 
and all cpus in this range are treated equally, while all cpus out of 
this range are strictly forbidden. The existing cpuset mechanisms do 
help resource limitation and isolation, but may be weak on improving 
perforamce.

So, our idea is, doing this in userspace, which relies on existing 
kernel interfaces, is hard. Only exposing more data to increase 
visibility in userspace is not enough. We need a whole solution from 
collecting data to impacting decisions of the scheduler. Maybe eBPF can 
cover all these works in the future, but it takes long time to develop 
and maybe too much to achieve just dynamic cpu bind.

Thanks.
