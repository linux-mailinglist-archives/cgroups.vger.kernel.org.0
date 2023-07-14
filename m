Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9FD754065
	for <lists+cgroups@lfdr.de>; Fri, 14 Jul 2023 19:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbjGNRYh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jul 2023 13:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGNRYg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jul 2023 13:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7A13593
        for <cgroups@vger.kernel.org>; Fri, 14 Jul 2023 10:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689355428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IjSCUEVQqiObQodmnZyPQvDEZ31gPn7XJ/bLLSzzo2c=;
        b=G7EHlYsN9BxuOKBhudcioQVvtVk46H0MzLZGw6w7hoE5FhlJvFM2WRR5q99DQAG1H9PG2K
        fPYuG2YwRsLY+lMZKD0ViW+8HiyB+X2pz1zir2PSJdq7X0S0lI9r/RjZ/3rfrxWs7hlkG+
        OsEiIixGVrDXb+Gd1x1qkDfndnlzz7M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-1q70EXljPLGuQ4wmDRDicA-1; Fri, 14 Jul 2023 13:23:44 -0400
X-MC-Unique: 1q70EXljPLGuQ4wmDRDicA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4614185A78F;
        Fri, 14 Jul 2023 17:23:43 +0000 (UTC)
Received: from [10.22.9.81] (unknown [10.22.9.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35CD5C2C856;
        Fri, 14 Jul 2023 17:23:43 +0000 (UTC)
Message-ID: <fea3587a-ca6a-6930-bd3d-c4f7f330be67@redhat.com>
Date:   Fri, 14 Jul 2023 13:23:42 -0400
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CABWYdi2iWYT0sHpK74W6=Oz6HA_3bAqKQd4h+amK0n3T3nge6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/13/23 19:25, Ivan Babrou wrote:
> On Mon, Jul 10, 2023 at 5:44 PM Waiman Long <longman@redhat.com> wrote:
>> On 7/10/23 19:21, Ivan Babrou wrote:
>>> On Wed, Jul 5, 2023 at 11:20 PM Shakeel Butt <shakeelb@google.com> wrote:
>>>> On Fri, Jun 30, 2023 at 04:22:28PM -0700, Ivan Babrou wrote:
>>>>> Hello,
>>>>>
>>>>> We're seeing CPU load issues with cgroup stats retrieval. I made a
>>>>> public gist with all the details, including the repro code (which
>>>>> unfortunately requires heavily loaded hardware) and some flamegraphs:
>>>>>
>>>>> * https://gist.github.com/bobrik/5ba58fb75a48620a1965026ad30a0a13
>>>>>
>>>>> I'll repeat the gist of that gist here. Our repro has the following
>>>>> output after a warm-up run:
>>>>>
>>>>> completed:  5.17s [manual / mem-stat + cpu-stat]
>>>>> completed:  5.59s [manual / cpu-stat + mem-stat]
>>>>> completed:  0.52s [manual / mem-stat]
>>>>> completed:  0.04s [manual / cpu-stat]
>>>>>
>>>>> The first two lines do effectively the following:
>>>>>
>>>>> for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/memory.stat
>>>>> /sys/fs/cgroup/system.slice/cpu.stat > /dev/null
>>>>>
>>>>> The latter two are the same thing, but via two loops:
>>>>>
>>>>> for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/cpu.stat >
>>>>> /dev/null; done
>>>>> for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/memory.stat
>>>>>> /dev/null; done
>>>>> As you might've noticed from the output, splitting the loop into two
>>>>> makes the code run 10x faster. This isn't great, because most
>>>>> monitoring software likes to get all stats for one service before
>>>>> reading the stats for the next one, which maps to the slow and
>>>>> expensive way of doing this.
>>>>>
>>>>> We're running Linux v6.1 (the output is from v6.1.25) with no patches
>>>>> that touch the cgroup or mm subsystems, so you can assume vanilla
>>>>> kernel.
>>>>>
>>>>>   From the flamegraph it just looks like rstat flushing takes longer. I
>>>>> used the following flags on an AMD EPYC 7642 system (our usual pick
>>>>> cpu-clock was blaming spinlock irqrestore, which was questionable):
>>>>>
>>>>> perf -e cycles -g --call-graph fp -F 999 -- /tmp/repro
>>>>>
>>>>> Naturally, there are two questions that arise:
>>>>>
>>>>> * Is this expected (I guess not, but good to be sure)?
>>>>> * What can we do to make this better?
>>>>>
>>>>> I am happy to try out patches or to do some tracing to help understand
>>>>> this better.
>>>> Hi Ivan,
>>>>
>>>> Thanks a lot, as always, for reporting this. This is not expected and
>>>> should be fixed. Is the issue easy to repro or some specific workload or
>>>> high load/traffic is required? Can you repro this with the latest linus
>>>> tree? Also do you see any difference of root's cgroup.stat where this
>>>> issue happens vs good state?
>>> I'm afraid there's no easy way to reproduce. We see it from time to
>>> time in different locations. The one that I was looking at for the
>>> initial email does not reproduce it anymore:
>> My understanding of mem-stat and cpu-stat is that they are independent
>> of each other. In theory, reading one shouldn't affect the performance
>> of reading the others. Since you are doing mem-stat and cpu-stat reading
>> repetitively in a loop, it is likely that all the data are in the cache
>> most of the time resulting in very fast processing time. If it happens
>> that the specific memory location of mem-stat and cpu-stat data are such
>> that reading one will cause the other data to be flushed out of the
>> cache and have to be re-read from memory again, you could see
>> significant performance regression.
>>
>> It is one of the possible causes, but I may be wrong.
> Do you think it's somewhat similar to how iterating a matrix in rows
> is faster than in columns due to sequential vs random memory reads?
>
> * https://stackoverflow.com/q/9936132
> * https://en.wikipedia.org/wiki/Row-_and_column-major_order
> * https://en.wikipedia.org/wiki/Loop_interchange

Yes, it is similar to what is being described in those articles.


>
> I've had a similar suspicion and it would be good to confirm whether
> it's that or something else. I can probably collect perf counters for
> different runs, but I'm not sure which ones I'll need.
>
> In a similar vein, if we could come up with a tracepoint that would
> tell us the amount of work done (or any other relevant metric that
> would help) during rstat flushing, I can certainly collect that
> information as well for every reading combination.

The perf-c2c tool may be able to help. The data to look for is how often 
the data is from caches vs direct memory load/store.

Cheers,
Longman

