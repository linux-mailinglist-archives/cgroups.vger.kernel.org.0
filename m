Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8782E688897
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 21:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjBBUxy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 15:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBBUxx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 15:53:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2E97D6FC
        for <cgroups@vger.kernel.org>; Thu,  2 Feb 2023 12:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675371191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gRK/CARXnPMcLAECH0Ip5fyOYnLDjmZoHmRHZ5RoPA8=;
        b=QDZVHGi1ne97wLdiyDftufnB5wv1nxemZ8eLxK0Q+feQ5a9EsaR8He1nSja3YAMq4l8hRt
        Dgj2XH1XWPfeqGtdKLudd4uS2g36ZwJThUW4PmoDj7dkuuEkNxJ6yEUsI97vcZorwNN8i3
        qLZDRj7a9jL/nQI73Qr+u62foLYuFNQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-xcQM3oT4NvaMXbG1J6ctPw-1; Thu, 02 Feb 2023 15:53:05 -0500
X-MC-Unique: xcQM3oT4NvaMXbG1J6ctPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 317F0811E9C;
        Thu,  2 Feb 2023 20:53:05 +0000 (UTC)
Received: from [10.22.8.157] (unknown [10.22.8.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBCF32166B33;
        Thu,  2 Feb 2023 20:53:04 +0000 (UTC)
Message-ID: <75de91db-d3bc-0c0e-6199-ef00591e8878@redhat.com>
Date:   Thu, 2 Feb 2023 15:53:04 -0500
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y9whrU4IUeleqdrt@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 2/2/23 15:48, Tejun Heo wrote:
> On Thu, Feb 02, 2023 at 03:46:02PM -0500, Waiman Long wrote:
>>>> I will work on a patchset to do that as a counter offer.
>>> We will need a small and simple patch for /urgent, or I will need to
>>> revert all your patches -- your call.
>>>
>>> I also don't tihnk you fully appreciate the ramifications of
>>> task_cpu_possible_mask(), cpuset currently gets that quite wrong.
>> OK, I don't realize the urgency of that. If it is that urgent, I will have
>> no objection to get it in for now. We can improve it later on. So are you
>> planning to get it into the current 6.2 rc or 6.3?
>>
>> Tejun, are you OK with that as you are the cgroup maintainer?
> Yeah, gotta fix the regression but is there currently a solution which fixes
> the regression but doesn't further break other stuff?

I believe there is a better way to do that, but it will need more time 
to flex out. Since cpuset_cpus_allowed() is only used by 
kernel/sched/core.c, Peter will be responsible if it somehow breaks 
other stuff.

Thanks,
Longman

