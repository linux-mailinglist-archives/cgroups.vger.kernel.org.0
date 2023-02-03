Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1D7689DF7
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 16:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjBCPSN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 10:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjBCPRF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 10:17:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2BDA6415
        for <cgroups@vger.kernel.org>; Fri,  3 Feb 2023 07:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675437194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iG2sYT3v2a3Wr18XBz4fLFtpFFFcjqNhgLajuLkz3OI=;
        b=NcgJXrMIQYy9GUuIrEaryuv+Qn0ImTnTCmJUr9tHqUsSfE+PCDgW5VKsf22mm1ZDSn9nvp
        s5QWHneM11HUGM8pQi6hMlBtRox7o41xy8vpDchh7PUjLuJDxDx699gzs95mIRBUd4HvCm
        sHjItRKoxgaYCpoLuKouDtJbE89NRGc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-HaMYr2waOAuFOJwJXBl3nQ-1; Fri, 03 Feb 2023 10:13:11 -0500
X-MC-Unique: HaMYr2waOAuFOJwJXBl3nQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFCA488646A;
        Fri,  3 Feb 2023 15:13:10 +0000 (UTC)
Received: from [10.22.18.35] (unknown [10.22.18.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B1312166B34;
        Fri,  3 Feb 2023 15:13:10 +0000 (UTC)
Message-ID: <d626998b-4cb0-dd8f-fd97-21715bf2eb0b@redhat.com>
Date:   Fri, 3 Feb 2023 10:13:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-2-will@kernel.org>
 <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
 <Y9otWX+MGOLDKU6t@hirez.programming.kicks-ass.net>
 <83e53632-27ed-8dde-84f4-68c6776d6da8@redhat.com>
 <a892d340-ea99-1562-0e70-176f02f195c2@redhat.com>
 <Y9rVVldS19oyIZ+g@hirez.programming.kicks-ass.net>
 <773e2f22-211e-163f-64bb-15ae29ad161b@redhat.com>
 <20230203115045.GB5927@willie-the-truck>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230203115045.GB5927@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/3/23 06:50, Will Deacon wrote:
> On Wed, Feb 01, 2023 at 10:34:00PM -0500, Waiman Long wrote:
>> On 2/1/23 16:10, Peter Zijlstra wrote:
>>> On Wed, Feb 01, 2023 at 01:46:11PM -0500, Waiman Long wrote:
>>>
>>>> Note that using cpus_allowed directly in cgroup v2 may not be right because
>>>> cpus_allowed may have no relationship to effective_cpus at all in some
>>>> cases, e.g.
>>>>
>>>>      root
>>>>       |
>>>>       V
>>>>       A (cpus_allowed = 1-4, effective_cpus = 1-4)
>>>>       |
>>>>       V
>>>>       B (cpus_allowed = 5-8, effective_cpus = 1-4)
>>>>
>>>> In the case of cpuset B, passing back cpus 5-8 as the allowed_cpus is wrong.
>>> I think my patch as written does the right thing here. Since the
>>> intersection of (1-4) and (5-8) is empty it will move up the hierarchy
>>> and we'll end up with (1-4) from the cgroup side of things.
>>>
>>> So the purpose of __cs_cpus_allowed() is to override the cpus_allowed of
>>> the root set and force it to cpu_possible_mask.
>>>
>>> Then cs_cpus_allowed() computes the intersection of cs->cpus_allowed and
>>> all it's parents. This will, in the case of B above, result in the empty
>>> mask.
>>>
>>> Then cpuset_cpus_allowed() has a loop that starts with
>>> task_cpu_possible_mask(), intersects that with cs_cpus_allowed() and if
>>> the intersection of that and cpu_online_mask is empty, moves up the
>>> hierarchy. Given cs_cpus_allowed(B) is the empty mask, we'll move to A.
>>>
>>> Note that since we force the mask of root to cpu_possible_mask,
>>> cs_cpus_allowed(root) will be a no-op and if we guarantee (in arch code)
>>> that cpu_online_mask always has a non-empty intersection with
>>> task_cpu_possible_mask(), this loop is guaranteed to terminate with a
>>> viable mask.
>> I will take a closer look at that tomorrow. I will be more comfortable
>> ack'ing that if this is specific to v1 cpuset instead of applying this in
>> both v1 and v2 since it is only v1 that is problematic.
> fwiw, the regression I'm seeing is with cgroup2. I haven't tried v1.

I think I know where the problem is. It is due to the fact the cpuset 
hotplug code doesn't update cpumasks of the tasks in the top cpuset 
(root) at all when there is a cpu offline or online event. It is 
probably because for some of the tasks in the top cpuset, especially the 
percpu kthread, changing their cpumasks can be catastrophic. The hotplug 
code does update the cpumasks of the tasks that are not in the top 
cpuset. This problem is irrespective of whether v1 or v2 is in use.

The partition code does try to update the cpumasks of the tasks in the 
top cpuset, but skip the percpu kthreads. My testing show that is 
probably OK. For safety, I agree that is better to extend the allowed 
cpu list to all the possible cpus (including offline ones) for now until 
more testings are done to find a safe way to do that. That special case 
should apply only to tasks in the top cpuset. For the rests, the current 
code should be OK and is less risky than adopting code in this patch.

Cheers,
Longman

