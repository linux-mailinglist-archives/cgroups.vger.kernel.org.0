Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8ED59861E
	for <lists+cgroups@lfdr.de>; Thu, 18 Aug 2022 16:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245204AbiHROiB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Aug 2022 10:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244793AbiHROiA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Aug 2022 10:38:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF56C73
        for <cgroups@vger.kernel.org>; Thu, 18 Aug 2022 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660833478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=55iMMmbwkaAqw4I8aj14bQmLqWfqTrm37aZFBETpBEc=;
        b=AXd06DJeCPoJ9Hwe1ARARheouGZU2j2KpSU3nHI2dajStUEwPoNf1ENqXQxPBA05Pko7ye
        GiACcwVfz/LjyRFe9JuTw5lKnp/e8hUGLMVZZboaF4e29tK0B1chAnmjCoWk1BXXd3H/B5
        NaqNAHScpANeeKO3PMR+9jRcrPejDk0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-M4bmjfZDOWKfskDloj51Ww-1; Thu, 18 Aug 2022 10:37:56 -0400
X-MC-Unique: M4bmjfZDOWKfskDloj51Ww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 258CD101A586;
        Thu, 18 Aug 2022 14:37:55 +0000 (UTC)
Received: from [10.22.9.156] (unknown [10.22.9.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB81740CFD05;
        Thu, 18 Aug 2022 14:37:51 +0000 (UTC)
Message-ID: <58f4533b-6d0e-dc5f-2b8c-986212598125@redhat.com>
Date:   Thu, 18 Aug 2022 07:37:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/3] sched: Use user_cpus_ptr for saving user provided
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
References: <20220816192734.67115-1-longman@redhat.com>
 <20220816192734.67115-2-longman@redhat.com>
 <YvymwlTkdsVDtmRB@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YvymwlTkdsVDtmRB@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/17/22 04:28, Peter Zijlstra wrote:
> On Tue, Aug 16, 2022 at 03:27:32PM -0400, Waiman Long wrote:
>
>> This will be some changes in behavior for arm64 systems with asymmetric
>> CPUs in some corner cases. For instance, if sched_setaffinity()
>> has never been called and there is a cpuset change before
>> relax_compatible_cpus_allowed_ptr() is called, its subsequent call will
>> follow what the cpuset allows but not what the previous cpu affinity
>> setting allows.
> That's arguably a correctness fix, no? That is, the save/restore should
> not have been allowed to revert to an earlier cpuset state.

Yes, it is a correctness fix in a sense. I just want to highlight that 
there will be some slight changes in behavior in some corner cases for 
the arm64 arch.

Cheers,
Longman

