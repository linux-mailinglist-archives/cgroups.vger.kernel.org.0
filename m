Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00516C7F9B
	for <lists+cgroups@lfdr.de>; Fri, 24 Mar 2023 15:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjCXONp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Mar 2023 10:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjCXONl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Mar 2023 10:13:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD5C1CAEF
        for <cgroups@vger.kernel.org>; Fri, 24 Mar 2023 07:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679667172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADiIDdAPnjqVAbV/udpxZCAiMLd8rfZn004mVe2ENYg=;
        b=boB6STEfazdhCem7Eln3rFOE2LzC10XnwpMztzYUkFmj6lJAAgbrkoLKLVJC3bjol1E4kW
        DlD1CmlsHSTMYpyzTgsKEa4zeEuTo+Ip0FRPscHj05qbhBY7OrlQSK979YIDRhhWyyHx8S
        nxcn5aXrVziRwkjSlvF7GA2npUT+fGY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-1m-g8VaUM1S0ZM79i3uKWA-1; Fri, 24 Mar 2023 10:12:45 -0400
X-MC-Unique: 1m-g8VaUM1S0ZM79i3uKWA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7BAE29AA3B5;
        Fri, 24 Mar 2023 14:12:43 +0000 (UTC)
Received: from [10.22.33.184] (unknown [10.22.33.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E174D140EBF4;
        Fri, 24 Mar 2023 14:12:42 +0000 (UTC)
Message-ID: <53582a07-81c6-35eb-10bf-7920b27483be@redhat.com>
Date:   Fri, 24 Mar 2023 10:12:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>, Tejun Heo <tj@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com>
 <ZBz/V5a7/6PZeM7S@slm.duckdns.org>
 <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/24/23 03:22, Yosry Ahmed wrote:
> On Thu, Mar 23, 2023 at 6:39 PM Tejun Heo <tj@kernel.org> wrote:
>> Hello,
>>
>> On Thu, Mar 23, 2023 at 04:00:31AM +0000, Yosry Ahmed wrote:
>>> Currently, when sleeping is not allowed during rstat flushing, we hold
>>> the global rstat lock with interrupts disabled throughout the entire
>>> flush operation. Flushing in an O(# cgroups * # cpus) operation, and
>>> having interrupts disabled throughout is dangerous.
>>>
>>> For some contexts, we may not want to sleep, but can be interrupted
>>> (e.g. while holding a spinlock or RCU read lock). As such, do not
>>> disable interrupts throughout rstat flushing, only when holding the
>>> percpu lock. This breaks down the O(# cgroups * # cpus) duration with
>>> interrupts disabled to a series of O(# cgroups) durations.
>>>
>>> Furthermore, if a cpu spinning waiting for the global rstat lock, it
>>> doesn't need to spin with interrupts disabled anymore.
>> I'm generally not a fan of big spin locks w/o irq protection. They too often
>> become a source of unpredictable latency spikes. As you said, the global
>> rstat lock can be held for quite a while. Removing _irq makes irq latency
>> better on the CPU but on the other hand it makes a lot more likely that the
>> lock is gonna be held even longer, possibly significantly so depending on
>> the configuration and workload which will in turn stall other CPUs waiting
>> for the lock. Sure, irqs are being serviced quicker but if the cost is more
>> and longer !irq context multi-cpu stalls, what's the point?
>>
>> I don't think there's anything which requires the global lock to be held
>> throughout the entire flushing sequence and irq needs to be disabled when
>> grabbing the percpu lock anyway, so why not just release the global lock on
>> CPU boundaries instead? We don't really lose anything significant that way.
>> The durations of irq disabled sections are still about the same as in the
>> currently proposed solution at O(# cgroups) and we avoid the risk of holding
>> the global lock for too long unexpectedly from getting hit repeatedly by
>> irqs while holding the global lock.
> Thanks for taking a look!
>
> I think a problem with this approach is that we risk having to contend
> for the global lock at every CPU boundary in atomic contexts. Right
Isn't it the plan to just do a trylock in atomic contexts so that it 
won't get stuck spinning for the lock for an indeterminate amount of time?
> now we contend for the global lock once, and once we have it we go
> through all CPUs to flush, only having to contend with updates taking
> the percpu locks at this point. If we unconditionally release &
> reacquire the global lock at every CPU boundary then we may contend
> for it much more frequently with concurrent flushers.

Note that with the use of qspinlock in all the major arches, the impact 
of thundering herds of lockers are much less serious than before. There 
are certainly some overhead in doing multiple lock acquires and 
releases, but that shouldn't been too excessive.

I am all in for reducing lock hold time as much as possible as it will 
improve the response time.

Cheers,
Longman

