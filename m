Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688D4688C22
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 01:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjBCAzP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 19:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBCAzN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 19:55:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE4066EE3
        for <cgroups@vger.kernel.org>; Thu,  2 Feb 2023 16:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675385670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UyBSV52Bo/UVzmB9w3peJU7nHdiZsCWd8KWrOAz7syU=;
        b=V4FAN31ldEKUUzgbOwSw+LOoysjH34nFWVDdZRC13yA32C3bpdbHShjNPTdV3RLRKq+QYC
        mToVnmIJvEMuA1o9IM0zVoJaP9t9HFEJ6o3xfRU+nnAFy7t7zrefT3MyrsQFBd1cjMyAti
        j+PPq08FsAXB7T6AIMTtJQHmgE5PoKw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-acDVK25KPSmg8F6c0PoT_A-1; Thu, 02 Feb 2023 19:54:27 -0500
X-MC-Unique: acDVK25KPSmg8F6c0PoT_A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12A3D299E76A;
        Fri,  3 Feb 2023 00:54:27 +0000 (UTC)
Received: from [10.22.8.157] (unknown [10.22.8.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68669492C3E;
        Fri,  3 Feb 2023 00:54:26 +0000 (UTC)
Message-ID: <b4e88791-45a1-888c-00c9-97026bf90298@redhat.com>
Date:   Thu, 2 Feb 2023 19:54:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Content-Language: en-US
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
 <8787b5f7-9822-e49b-0357-d0ce224ca920@redhat.com>
 <Y9wwP4LF9vgreO3U@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y9wwP4LF9vgreO3U@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/2/23 16:50, Tejun Heo wrote:
> On Thu, Feb 02, 2023 at 04:05:14PM -0500, Waiman Long wrote:
>> On 2/2/23 15:53, Waiman Long wrote:
>>> On 2/2/23 15:48, Tejun Heo wrote:
>>>> On Thu, Feb 02, 2023 at 03:46:02PM -0500, Waiman Long wrote:
>>>>>>> I will work on a patchset to do that as a counter offer.
>>>>>> We will need a small and simple patch for /urgent, or I will need to
>>>>>> revert all your patches -- your call.
>>>>>>
>>>>>> I also don't tihnk you fully appreciate the ramifications of
>>>>>> task_cpu_possible_mask(), cpuset currently gets that quite wrong.
>>>>> OK, I don't realize the urgency of that. If it is that urgent, I
>>>>> will have
>>>>> no objection to get it in for now. We can improve it later on.
>>>>> So are you
>>>>> planning to get it into the current 6.2 rc or 6.3?
>>>>>
>>>>> Tejun, are you OK with that as you are the cgroup maintainer?
>>>> Yeah, gotta fix the regression but is there currently a solution
>>>> which fixes
>>>> the regression but doesn't further break other stuff?
>>> I believe there is a better way to do that, but it will need more time
>>> to flex out. Since cpuset_cpus_allowed() is only used by
>>> kernel/sched/core.c, Peter will be responsible if it somehow breaks
>>> other stuff.
>> Maybe my cpuset patch that don't update task's cpumask on cpu offline event
>> can help. However, I don't know the exact scenario where the regression
>> happen, so it may not.
> Neither patch looks like they would break anything. That said, the patches
> aren't trivial and we're really close to the merge window, so I'd really
> appreciate if you can take a look and test a bit before we send these
> Linus's way. We can replace it with a better solution afterwards.

OK, will do.

Cheers,
Longman

