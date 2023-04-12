Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433436DFEB2
	for <lists+cgroups@lfdr.de>; Wed, 12 Apr 2023 21:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjDLTYt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Apr 2023 15:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjDLTYq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Apr 2023 15:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072816185
        for <cgroups@vger.kernel.org>; Wed, 12 Apr 2023 12:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681327438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gm7p9LzOsq7lA9HHLCBfHG6/8kEc7wW/woCOwGU+U0U=;
        b=OPGPGEICfGfroOyVLOhgaSAQzT2DXL1JrfB9QSuFqLDAw+OOVf9SX+nB+8ARRZEbBQ7FfM
        sunMoBDcCjzVqRSLFfHcXJqIut88oSLJA2TRL/54yeRRUN6pCqxQSzZroawf5vqHotfDFG
        EsERrNodchpAuoWIwCLxb1Jt+Tm8QCM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-mM-sHtx1NxunenmWV2roRw-1; Wed, 12 Apr 2023 15:23:53 -0400
X-MC-Unique: mM-sHtx1NxunenmWV2roRw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BAA7855300;
        Wed, 12 Apr 2023 19:23:53 +0000 (UTC)
Received: from [10.22.32.168] (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D4861415117;
        Wed, 12 Apr 2023 19:23:52 +0000 (UTC)
Message-ID: <e5cf4caa-1f39-8bfe-1862-50cfa4e8ee8f@redhat.com>
Date:   Wed, 12 Apr 2023 15:23:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 5/5] cgroup/cpuset: Optimize out unneeded
 cpuset_can_fork/cpuset_cancel_fork calls
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
References: <20230411133601.2969636-1-longman@redhat.com>
 <20230411133601.2969636-6-longman@redhat.com>
 <ZDb4G2jgQFK8h8Ys@slm.duckdns.org>
 <90b7bc16-0673-02b7-dad1-f24bc956f1c5@redhat.com>
 <ZDcDxecF0Y5F0pV6@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZDcDxecF0Y5F0pV6@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/12/23 15:17, Tejun Heo wrote:
> Hello,
>
> On Wed, Apr 12, 2023 at 02:40:53PM -0400, Waiman Long wrote:
>> On 4/12/23 14:27, Tejun Heo wrote:
>>> On Tue, Apr 11, 2023 at 09:36:01AM -0400, Waiman Long wrote:
>>>> The newly introduced cpuset_can_fork() and cpuset_cancel_fork() calls
>>>> are only needed when the CLONE_INTO_CGROUP flag is set which is not
>>>> likely. Adding an extra cpuset_can_fork() call does introduce a bit
>>>> of performance overhead in the fork/clone fastpath. To reduce this
>>>> performance overhead, introduce a new clone_into_cgroup_can_fork flag
>>>> into the cgroup_subsys structure. This flag, when set, will call the
>>>> can_fork and cancel_fork methods only if the CLONE_INTO_CGROUP flag
>>>> is set.
>>>>
>>>> The cpuset code is now modified to set this flag. The same cpuset
>>>> checking code in cpuset_can_fork() and cpuset_cancel_fork() will have
>>>> to stay as the cgroups can be different, but the cpusets may still be
>>>> the same. So the same check must be present in both cpuset_fork() and
>>>> cpuset_can_fork() to make sure that attach_in_progress is correctly set.
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> Waiman, I'm not necessarily against this optimization but can we at least
>>> have some performance numbers to show that this is actually meaningful?
>>> Given how heavy our fork path is, I'm not too sure this would show up in any
>>> meaningful way.
>> That make sense to me. I am OK to leave it for now as it is an optimization
>> patch anyway.
>>
>> BTW, another question that I have is about the cgroup_threadgroup_rwsem. It
>> is currently a percpu rwsem. Is it possible to change it into a regular
>> rwsem instead? It is causing quite a bit of latency for workloads that
>> require rather frequent changes to cgroups. I know we have a "favordynmods"
>> mount option to disable the percpu operation. This will still be less
>> performant than a normal rwsem. Of course the downside is that the fork/exit
>> fastpaths will be slowed down a bit.
> I don't know. Maybe? A rwsem actually has a scalability factor in that the
> more CPUs are forking, the more expensive the rwsem becomes, so it is a bit
> more of a concern. Another factor is that in majority of use cases we're
> almost completely bypassing write-locking percpu_rwsem, so it feel a bit sad
> to convert it to a regular rwsem. So, if favordynmods is good enough, I'd
> like to keep it that way.

It is just a thought that I have since Juri is in the process of 
reverting the change of cpuset_mutex to cpuset_rwsem. Percpu rwsem can 
be a bit problematic in PREEMPT_RT kernel since it does not support 
proper priority inheritance though.

Cheers,
Longman

