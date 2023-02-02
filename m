Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37806888BF
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 22:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjBBVGW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 16:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjBBVGQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 16:06:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9FC83961
        for <cgroups@vger.kernel.org>; Thu,  2 Feb 2023 13:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675371921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WEHQNucTuGpLdaQhxf42z+oDGAmuQAok38hbITp7osg=;
        b=DohaSiLi8Mo0U1aIn9gm6BYbbAPDo6s457rXLutDyDu1KtkQO5CT7srPfCmtGH6pLxps8t
        NDd2w5c7SnfV88mwVNKE3SZCKXwiCpIqRipW3M48vKBZ1lxkgwOwerOUO/d210Yp5yLpys
        Mf7cQtW5fNpp44mBtEFyM2kTndOkRhE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-RO-UAXgBO3qOXis0u0hiwg-1; Thu, 02 Feb 2023 16:05:16 -0500
X-MC-Unique: RO-UAXgBO3qOXis0u0hiwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF83A101B44E;
        Thu,  2 Feb 2023 21:05:15 +0000 (UTC)
Received: from [10.22.8.157] (unknown [10.22.8.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 187F4140EBF6;
        Thu,  2 Feb 2023 21:05:15 +0000 (UTC)
Message-ID: <8787b5f7-9822-e49b-0357-d0ce224ca920@redhat.com>
Date:   Thu, 2 Feb 2023 16:05:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-2-will@kernel.org>
 <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
 <Y9t1sP/6nFht7RSN@hirez.programming.kicks-ass.net>
 <d630ca53-71f0-c735-fbc3-e826479aa86b@redhat.com>
 <Y9wSC1Wxlm8CKKlN@hirez.programming.kicks-ass.net>
 <2bc730db-704d-080b-6869-02f6d0035fad@redhat.com>
 <Y9whrU4IUeleqdrt@slm.duckdns.org>
 <75de91db-d3bc-0c0e-6199-ef00591e8878@redhat.com>
In-Reply-To: <75de91db-d3bc-0c0e-6199-ef00591e8878@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 2/2/23 15:53, Waiman Long wrote:
>
> On 2/2/23 15:48, Tejun Heo wrote:
>> On Thu, Feb 02, 2023 at 03:46:02PM -0500, Waiman Long wrote:
>>>>> I will work on a patchset to do that as a counter offer.
>>>> We will need a small and simple patch for /urgent, or I will need to
>>>> revert all your patches -- your call.
>>>>
>>>> I also don't tihnk you fully appreciate the ramifications of
>>>> task_cpu_possible_mask(), cpuset currently gets that quite wrong.
>>> OK, I don't realize the urgency of that. If it is that urgent, I 
>>> will have
>>> no objection to get it in for now. We can improve it later on. So 
>>> are you
>>> planning to get it into the current 6.2 rc or 6.3?
>>>
>>> Tejun, are you OK with that as you are the cgroup maintainer?
>> Yeah, gotta fix the regression but is there currently a solution 
>> which fixes
>> the regression but doesn't further break other stuff?
>
> I believe there is a better way to do that, but it will need more time 
> to flex out. Since cpuset_cpus_allowed() is only used by 
> kernel/sched/core.c, Peter will be responsible if it somehow breaks 
> other stuff.

Maybe my cpuset patch that don't update task's cpumask on cpu offline 
event can help. However, I don't know the exact scenario where the 
regression happen, so it may not.

Cheers,
Longman

