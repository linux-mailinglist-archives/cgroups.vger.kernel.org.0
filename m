Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B7A6DFDC6
	for <lists+cgroups@lfdr.de>; Wed, 12 Apr 2023 20:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjDLSlm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Apr 2023 14:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDLSll (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Apr 2023 14:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97AC1715
        for <cgroups@vger.kernel.org>; Wed, 12 Apr 2023 11:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681324860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFJBJrNBeculyaj0ym1qSRw3QOdcnJCKshH3wr3L4nY=;
        b=fGVM1MweMMpEf9L4Sw7WLYnVA4yTielgjagQX/3+Ec/RzI7B47aBL2QkStOB3+9yGx1TJy
        qkDrDmmttn5zk3ivDj1YlasL6iZkyFb36ANOVMjA8Xn/rcIcKotFAyuK7WTK8LyoSBw4hf
        vUlzrfXvMGpyJ7nufh6GQpQftfloAo0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-kuEP1fR1MMuDo6bf8OQn6A-1; Wed, 12 Apr 2023 14:40:54 -0400
X-MC-Unique: kuEP1fR1MMuDo6bf8OQn6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45FB32817233;
        Wed, 12 Apr 2023 18:40:54 +0000 (UTC)
Received: from [10.22.32.168] (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B73F12027043;
        Wed, 12 Apr 2023 18:40:53 +0000 (UTC)
Message-ID: <90b7bc16-0673-02b7-dad1-f24bc956f1c5@redhat.com>
Date:   Wed, 12 Apr 2023 14:40:53 -0400
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZDb4G2jgQFK8h8Ys@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 4/12/23 14:27, Tejun Heo wrote:
> On Tue, Apr 11, 2023 at 09:36:01AM -0400, Waiman Long wrote:
>> The newly introduced cpuset_can_fork() and cpuset_cancel_fork() calls
>> are only needed when the CLONE_INTO_CGROUP flag is set which is not
>> likely. Adding an extra cpuset_can_fork() call does introduce a bit
>> of performance overhead in the fork/clone fastpath. To reduce this
>> performance overhead, introduce a new clone_into_cgroup_can_fork flag
>> into the cgroup_subsys structure. This flag, when set, will call the
>> can_fork and cancel_fork methods only if the CLONE_INTO_CGROUP flag
>> is set.
>>
>> The cpuset code is now modified to set this flag. The same cpuset
>> checking code in cpuset_can_fork() and cpuset_cancel_fork() will have
>> to stay as the cgroups can be different, but the cpusets may still be
>> the same. So the same check must be present in both cpuset_fork() and
>> cpuset_can_fork() to make sure that attach_in_progress is correctly set.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Waiman, I'm not necessarily against this optimization but can we at least
> have some performance numbers to show that this is actually meaningful?
> Given how heavy our fork path is, I'm not too sure this would show up in any
> meaningful way.

That make sense to me. I am OK to leave it for now as it is an 
optimization patch anyway.

BTW, another question that I have is about the cgroup_threadgroup_rwsem. 
It is currently a percpu rwsem. Is it possible to change it into a 
regular rwsem instead? It is causing quite a bit of latency for 
workloads that require rather frequent changes to cgroups. I know we 
have a "favordynmods" mount option to disable the percpu operation. This 
will still be less performant than a normal rwsem. Of course the 
downside is that the fork/exit fastpaths will be slowed down a bit.

Thanks,
Longman

