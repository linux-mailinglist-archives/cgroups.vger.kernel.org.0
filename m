Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F1B48EC2B
	for <lists+cgroups@lfdr.de>; Fri, 14 Jan 2022 16:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbiANPER (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 10:04:17 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:34282 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238270AbiANPEQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 10:04:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V1pfdAE_1642172651;
Received: from 30.21.164.113(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0V1pfdAE_1642172651)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Jan 2022 23:04:12 +0800
Message-ID: <86fbc313-e179-0cbd-8f5b-66e7b5964b14@linux.alibaba.com>
Date:   Fri, 14 Jan 2022 23:04:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v2 2/3] sched/core: Forced idle accounting per-cpu
Content-Language: en-US
To:     Josh Don <joshdon@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        cgroups@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1641894961-9241-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1641894961-9241-3-git-send-email-CruzZhao@linux.alibaba.com>
 <CABk29NtonxXS53J-+3w_GTLTVurf8HS4v35T9evoGyERB0uDqA@mail.gmail.com>
From:   cruzzhao <cruzzhao@linux.alibaba.com>
In-Reply-To: <CABk29NtonxXS53J-+3w_GTLTVurf8HS4v35T9evoGyERB0uDqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2022/1/12 上午9:59, Josh Don 写道:
> On Tue, Jan 11, 2022 at 1:56 AM Cruz Zhao <CruzZhao@linux.alibaba.com> wrote:
>>
>> Accounting for "forced idle" time per cpu, which is the time a cpu is
>> forced to idle by its SMT sibling.
>>
>> As it's not accurate to measure the capacity loss only by cookie'd forced
>> idle time, and it's hard to trace the forced idle time caused by all the
>> uncookie'd tasks, we account the forced idle time from the perspective of
>> the cpu.
>>
>> Forced idle time per cpu is displayed via /proc/schedstat, we can get the
>> forced idle time of cpu x from the 10th column of the row for cpu x. The
>> unit is ns. It also requires that schedstats is enabled.
>>
>> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
>> ---
> 
> Two quick followup questions:
> 
> 1) From your v1, I still wasn't quite sure if the per-cpu time was
> useful or not for you versus a single overall sum (ie. I think other
> metrics could be more useful for analyzing steal_cookie if that's what
> you're specifically interested in). Do you definitely want the per-cpu
> totals?
> 
IMO, the per-cpu forced idle time can help us get to know whether the
forced idle time is uniform among the core, or among all the cpus. IMO,
it's a kind of balance.

> 2) If your cgroup accounting patch is merged, do you still want this
> patch? You can grab the global values from the root cgroup (assuming
> you have cgroups enabled). The only potential gap is if you need
> per-cpu totals, though I'm working to add percpu stats to cgroup-v2:
> https://lkml.kernel.org/r/%3C20220107234138.1765668-1-joshdon@google.com%3E

If cgroup accounting patch is merged, this patch is still needed.

Consider the following scenario:
Task p of cgroup A is running on cpu x, and it forces cpu y into idle
for t ns. The forceidle time of cgroup A on cpu x increases t ns, and
the forcedidle time of cpu y increases t ns.

That is, the force idle time of cgroup is defined as the forced idle
time it caused, and the force idle time of cpu is defined as the time
the cpu is forced into idle, which have different meanings from each other.

And for SMT > 2, we cannot caculate the forced idle time of cpu x from
the cgroup interface.

Best,
Cruz Zhao
