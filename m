Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CDF5931B6
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 17:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiHOPX2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 11:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiHOPX2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 11:23:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49A1827157
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 08:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660577006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KTWFb/xozwZ/9TO1t27BpD9rjZxXL2g2toO6qXFlfc4=;
        b=I8m1tZpKFzzFrjeCoW2mMZIoNquvyNrsOYS7j97ZkayidiUksD2mZQTkPo7MGP7dgLjufw
        YDNWKubfGvG5qWTFexb5NhhzA0csBbQWp2S9tC2y/IovkYix4wbOhkF9fWFkuXK7BO9hjC
        6ozawpOYRDAi+Q83dMdXcH8oMwjTZn8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-nn_4UGYaOCWUHZH4POrdEg-1; Mon, 15 Aug 2022 11:23:23 -0400
X-MC-Unique: nn_4UGYaOCWUHZH4POrdEg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B4E73C01E16;
        Mon, 15 Aug 2022 15:23:22 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F9FF2166B26;
        Mon, 15 Aug 2022 15:23:21 +0000 (UTC)
Message-ID: <64276639-c6bc-f2ab-8e3b-0c2a36fbe0ad@redhat.com>
Date:   Mon, 15 Aug 2022 11:23:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/3] sched: Use user_cpus_ptr for saving user provided
 cpumask in sched_setaffinity()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220812203929.364341-1-longman@redhat.com>
 <20220812203929.364341-2-longman@redhat.com>
 <YvoKa3tbOaszsp1y@worktop.programming.kicks-ass.net>
 <401bae73-3063-e0ab-c288-2c6e3be75fc5@redhat.com>
 <YvpXbofPloXkHWdq@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YvpXbofPloXkHWdq@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/15/22 10:25, Peter Zijlstra wrote:
> On Mon, Aug 15, 2022 at 09:52:27AM -0400, Waiman Long wrote:
>> On 8/15/22 04:57, Peter Zijlstra wrote:
>>> On Fri, Aug 12, 2022 at 04:39:27PM -0400, Waiman Long wrote:
>>>> The user_cpus_ptr field is added by commit b90ca8badbd1 ("sched:
>>>> Introduce task_struct::user_cpus_ptr to track requested affinity"). It
>>>> is currently used only by arm64 arch due to possible asymmetric cpu
>>>> setup. This patch extends its usage to save user provided cpumask when
>>>> sched_setaffinity() is called for all arches.
>>>>
>>>> To preserve the existing arm64 use case, a new cpus_affinity_set flag is
>>>> added to differentiate if user_cpus_ptr is set up by sched_setaffinity()
>>>> or by force_compatible_cpus_allowed_ptr(). user_cpus_ptr
>>>> set by sched_setaffinity() has priority and won't be
>>>> overwritten by force_compatible_cpus_allowed_ptr() or
>>>> relax_compatible_cpus_allowed_ptr().
>>> What why ?! The only possible case where
>>> restrict_cpus_allowed_ptr() will now need that weird new state is when
>>> the affinity has never been set before, in that case cpus_ptr should be
>>> possible_mask.
>> Since I don't have a full history for this particular patch series that add
>> user_cpus_ptr, I am hesitant to change the current behavior for arm64
>> systems. However, given the statement that user_cpus_ptr is for tracking
>> "requested affinity" which I assume is when user applications call
>> sched_setaffinity(). It does make sense we may not really need this if
>> sched_setaffinity() is never called.
> So it comes from the asymmetric arm stuff, where only little cores can
> still run arm32 code. This means that on those machines, 32bit code
> needs to be contrained so a subset of CPUs.
>
> A direct consequence of that was that if you have any 32bit program in
> your process hierarchy, you loose the big cores from you affinity mask.
>
> For some reason that wasn't popular..  Hence the save/restore of cpumasks.

I am aware of that part of the patch series.


>>> Please just make a single consistent rule and don't make weird corner
>>> cases like this.
>> I will take a closer look to try to simplify the rule here.
> I think something like:
>
> 	mask = p->user_cpus_ptr;
> 	if (!mask)
> 		mask = &init_task.cpus_mask;
>
> 	// impose cpuset masks
>
> should 'just-work'.

I think that should work in relax_compatible_cpus_allowed_ptr().

Thanks,
Longman

