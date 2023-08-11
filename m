Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3063779AB7
	for <lists+cgroups@lfdr.de>; Sat, 12 Aug 2023 00:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjHKW2R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Aug 2023 18:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjHKW2Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Aug 2023 18:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B25D7
        for <cgroups@vger.kernel.org>; Fri, 11 Aug 2023 15:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691792850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B3JpEKmIc5aKTxtVagbylCxR1p4hdVqIt6adzo20sJ0=;
        b=HJhBXS4c9yaCcFBzkB59WbkzYOby8DHwTKBp1aI3sxl+Vy/lv85osNYksYeRwwjIrmhh4/
        VwGARBP8ndSsR02k0Bjq2CspGi2KC2SRyPNLkIWZnchIPa5MSHipRFOIox4VrEW2ou6en+
        JluCDI4J37rxcjwIZZeeKs+pYm0MMjM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-4aAZabQ3PxWN-TZDv39S2g-1; Fri, 11 Aug 2023 18:27:27 -0400
X-MC-Unique: 4aAZabQ3PxWN-TZDv39S2g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE334101A52E;
        Fri, 11 Aug 2023 22:27:26 +0000 (UTC)
Received: from [10.22.17.82] (unknown [10.22.17.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CD53492C13;
        Fri, 11 Aug 2023 22:27:26 +0000 (UTC)
Message-ID: <a052dffe-ed5e-6d22-8af8-0861e618f327@redhat.com>
Date:   Fri, 11 Aug 2023 18:27:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Expensive memory.stat + cpu.stat reads
Content-Language: en-US
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
 <20230706062045.xwmwns7cm4fxd7iu@google.com>
 <CABWYdi2pBaCrdKcM37oBomc+5W8MdRp1HwPpOExBGYfZitxyWA@mail.gmail.com>
 <d3f3a7bc-b181-a408-af1d-dd401c172cbf@redhat.com>
 <CABWYdi2iWYT0sHpK74W6=Oz6HA_3bAqKQd4h+amK0n3T3nge6g@mail.gmail.com>
 <CABWYdi3YNwtPDwwJWmCO-ER50iP7CfbXkCep5TKb-9QzY-a40A@mail.gmail.com>
 <CABWYdi0+0gxr7PB4R8rh6hXO=H7ZaCzfk8bmOSeQMuZR7s7Pjg@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CABWYdi0+0gxr7PB4R8rh6hXO=H7ZaCzfk8bmOSeQMuZR7s7Pjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/11/23 18:03, Ivan Babrou wrote:
> On Fri, Jul 14, 2023 at 5:30 PM Ivan Babrou <ivan@cloudflare.com> wrote:
>> On Thu, Jul 13, 2023 at 4:25 PM Ivan Babrou <ivan@cloudflare.com> wrote:
>>>> My understanding of mem-stat and cpu-stat is that they are independent
>>>> of each other. In theory, reading one shouldn't affect the performance
>>>> of reading the others. Since you are doing mem-stat and cpu-stat reading
>>>> repetitively in a loop, it is likely that all the data are in the cache
>>>> most of the time resulting in very fast processing time. If it happens
>>>> that the specific memory location of mem-stat and cpu-stat data are such
>>>> that reading one will cause the other data to be flushed out of the
>>>> cache and have to be re-read from memory again, you could see
>>>> significant performance regression.
>>>>
>>>> It is one of the possible causes, but I may be wrong.
>>> Do you think it's somewhat similar to how iterating a matrix in rows
>>> is faster than in columns due to sequential vs random memory reads?
>>>
>>> * https://stackoverflow.com/q/9936132
>>> * https://en.wikipedia.org/wiki/Row-_and_column-major_order
>>> * https://en.wikipedia.org/wiki/Loop_interchange
>>>
>>> I've had a similar suspicion and it would be good to confirm whether
>>> it's that or something else. I can probably collect perf counters for
>>> different runs, but I'm not sure which ones I'll need.
>>>
>>> In a similar vein, if we could come up with a tracepoint that would
>>> tell us the amount of work done (or any other relevant metric that
>>> would help) during rstat flushing, I can certainly collect that
>>> information as well for every reading combination.
>> Since cgroup_rstat_flush_locked appears in flamegraphs for both fast
>> (discrete) and slow (combined) cases, I grabbed some stats for it:
>>
>> * Slow:
>>
>> completed: 19.43s [manual / mem-stat + cpu-stat]
>>
>> $ sudo /usr/share/bcc/tools/funclatency -uT cgroup_rstat_flush_locked
>> Tracing 1 functions for "cgroup_rstat_flush_locked"... Hit Ctrl-C to end.
>> ^C
>> 00:12:55
>>       usecs               : count     distribution
>>           0 -> 1          : 0        |                                        |
>>           2 -> 3          : 0        |                                        |
>>           4 -> 7          : 0        |                                        |
>>           8 -> 15         : 0        |                                        |
>>          16 -> 31         : 0        |                                        |
>>          32 -> 63         : 0        |                                        |
>>          64 -> 127        : 1        |                                        |
>>         128 -> 255        : 191      |************                            |
>>         256 -> 511        : 590      |****************************************|
>>         512 -> 1023       : 186      |************                            |
>>        1024 -> 2047       : 2        |                                        |
>>        2048 -> 4095       : 0        |                                        |
>>        4096 -> 8191       : 0        |                                        |
>>        8192 -> 16383      : 504      |**********************************      |
>>       16384 -> 32767      : 514      |**********************************      |
>>       32768 -> 65535      : 3        |                                        |
>>       65536 -> 131071     : 1        |                                        |
>>
>> avg = 8852 usecs, total: 17633268 usecs, count: 1992
>>
>> * Fast:
>>
>> completed:  0.95s [manual / mem-stat]
>> completed:  0.05s [manual / cpu-stat]
>>
>> $ sudo /usr/share/bcc/tools/funclatency -uT cgroup_rstat_flush_locked
>> Tracing 1 functions for "cgroup_rstat_flush_locked"... Hit Ctrl-C to end.
>> ^C
>> 00:13:27
>>       usecs               : count     distribution
>>           0 -> 1          : 0        |                                        |
>>           2 -> 3          : 0        |                                        |
>>           4 -> 7          : 499      |****************************************|
>>           8 -> 15         : 253      |********************                    |
>>          16 -> 31         : 191      |***************                         |
>>          32 -> 63         : 41       |***                                     |
>>          64 -> 127        : 12       |                                        |
>>         128 -> 255        : 2        |                                        |
>>         256 -> 511        : 2        |                                        |
>>         512 -> 1023       : 0        |                                        |
>>        1024 -> 2047       : 0        |                                        |
>>        2048 -> 4095       : 0        |                                        |
>>        4096 -> 8191       : 0        |                                        |
>>        8192 -> 16383      : 34       |**                                      |
>>       16384 -> 32767      : 21       |*                                       |
>>
>> avg = 857 usecs, total: 904762 usecs, count: 1055
>>
>> There's a different number of calls into cgroup_rstat_flush_locked and
>> they are much slower in the slow case. There are also two bands in the
>> slow case, with 8ms..32ms having the half of the calls.
>>
>> For mem_cgroup_css_rstat_flush:
>>
>> * Slow:
>>
>> completed: 32.77s [manual / mem-stat + cpu-stat]
>>
>> $ sudo /usr/share/bcc/tools/funclatency -uT mem_cgroup_css_rstat_flush
>> Tracing 1 functions for "mem_cgroup_css_rstat_flush"... Hit Ctrl-C to end.
>> ^C
>> 00:21:25
>>       usecs               : count     distribution
>>           0 -> 1          : 93078    |*                                       |
>>           2 -> 3          : 3397714  |****************************************|
>>           4 -> 7          : 1009440  |***********                             |
>>           8 -> 15         : 168013   |*                                       |
>>          16 -> 31         : 93       |                                        |
>>
>> avg = 3 usecs, total: 17189289 usecs, count: 4668338
>>
>> * Fast:
>>
>> completed:  0.16s [manual / mem-stat]
>> completed:  0.04s [manual / cpu-stat]
>>
>> $ sudo /usr/share/bcc/tools/funclatency -uT mem_cgroup_css_rstat_flush
>> Tracing 1 functions for "mem_cgroup_css_rstat_flush"... Hit Ctrl-C to end.
>> ^C
>> 00:21:57
>>       usecs               : count     distribution
>>           0 -> 1          : 1441     |***                                     |
>>           2 -> 3          : 18780    |****************************************|
>>           4 -> 7          : 4826     |**********                              |
>>           8 -> 15         : 732      |*                                       |
>>          16 -> 31         : 1        |                                        |
>>
>> avg = 3 usecs, total: 89174 usecs, count: 25780
>>
>> There's an 181x difference in the number of calls into
>> mem_cgroup_css_rstat_flush.
>>
>> Does this provide a clue? Perhaps cgroup_rstat_cpu_pop_updated is
>> yielding a ton more iterations for some reason here?
>>
>> * https://elixir.bootlin.com/linux/v6.1/source/kernel/cgroup/rstat.c#L196
>>
>> It's inlined, but I can place a probe into the loop:
>>
>>        7         for_each_possible_cpu(cpu) {
>>        8                 raw_spinlock_t *cpu_lock =
>> per_cpu_ptr(&cgroup_rstat_cpu_lock,
>>                                                                 cpu);
>>       10                 struct cgroup *pos = NULL;
>>                          unsigned long flags;
>>
>>                          /*
>>                           * The _irqsave() is needed because cgroup_rstat_lock is
>>                           * spinlock_t which is a sleeping lock on
>> PREEMPT_RT. Acquiring
>>                           * this lock with the _irq() suffix only
>> disables interrupts on
>>                           * a non-PREEMPT_RT kernel. The raw_spinlock_t
>> below disables
>>                           * interrupts on both configurations. The
>> _irqsave() ensures
>>                           * that interrupts are always disabled and
>> later restored.
>>                           */
>>                          raw_spin_lock_irqsave(cpu_lock, flags);
>>                          while ((pos =
>> cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu))) {
>>                                  struct cgroup_subsys_state *css;
>>
>>                                  cgroup_base_stat_flush(pos, cpu);
>>       26                         bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
>>
>>       28                         rcu_read_lock();
>>       29                         list_for_each_entry_rcu(css,
>> &pos->rstat_css_list,
>>                                                          rstat_css_node)
>>       31                                 css->ss->css_rstat_flush(css, cpu);
>>       32                         rcu_read_unlock();
>>                          }
>>       34                 raw_spin_unlock_irqrestore(cpu_lock, flags);
>>
>> I added probes on both line 26 and line 31 to catch the middle and inner loops.
>>
>> * Slow:
>>
>> completed: 32.97s [manual / mem-stat + cpu-stat]
>>
>>   Performance counter stats for '/tmp/derp':
>>
>>           4,702,570      probe:cgroup_rstat_flush_locked_L26
>>           9,301,436      probe:cgroup_rstat_flush_locked_L31
>>
>> * Fast:
>>
>> completed:  0.17s [manual / mem-stat]
>> completed:  0.34s [manual / cpu-stat]
>>
>>   Performance counter stats for '/tmp/derp':
>>
>>              31,769      probe:cgroup_rstat_flush_locked_L26
>>              62,849      probe:cgroup_rstat_flush_locked_L31
>>
>> It definitely looks like cgroup_rstat_cpu_pop_updated is yielding a
>> lot more positions.
>>
>> I'm going to sign off for the week, but let me know if I should place
>> any more probes to nail this down.
> I spent some time looking into this and I think I landed on a fix:
>
> * https://github.com/bobrik/linux/commit/50b627811d54
>
> I'm not 100% sure if it's the right fix for the issue, but it reduces
> the runtime significantly.

It looks like the overhead of mem_cgroup_flush_stats() may be the cause 
of the performance regression. So what version of the Linux kernel are 
you using? From the patch listed in the URL above, it doesn't seem like 
you are using the latest kernel.

The latest upstream kernel already have patches that reduce rstat 
flushing overhead like commit 11192d9c124 ("memcg: flush stats only if 
updated"). Have you try to reproduce it with the latest kernel?

Cheers,
Longman

