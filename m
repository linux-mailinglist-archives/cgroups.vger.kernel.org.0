Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374976DAFAE
	for <lists+cgroups@lfdr.de>; Fri,  7 Apr 2023 17:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjDGPbY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Apr 2023 11:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjDGPbD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Apr 2023 11:31:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BDC213B
        for <cgroups@vger.kernel.org>; Fri,  7 Apr 2023 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680881419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5eE8zuLKcMzLpL2FtuAWtdIO+Pdjkebtgu24Aa6llV4=;
        b=OkUFdqjdGq01tx6eqvCdg90Xefy6SvkzSIYRicbLNok+2akWCOyzrfDnAvtcdCCuXq6C5U
        KQsypjWL7wZ4qWmmDbp+EQwpu34guW9bFaCOvKxWhZI0EonwsO70Re3y0mqFnoaFeudrrQ
        jb3WY5AiL0ewyKM+qQjRsT7QEB0w6uQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-xkHeZsBvO8SGG0fWPLnAlw-1; Fri, 07 Apr 2023 11:30:15 -0400
X-MC-Unique: xkHeZsBvO8SGG0fWPLnAlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2870C8996E2;
        Fri,  7 Apr 2023 15:30:15 +0000 (UTC)
Received: from [10.22.33.209] (unknown [10.22.33.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A12B2166B30;
        Fri,  7 Apr 2023 15:30:14 +0000 (UTC)
Message-ID: <89853ab9-7759-11bf-f751-28ce81a4f02e@redhat.com>
Date:   Fri, 7 Apr 2023 11:30:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/3] cgroup/cpuset: Allow only one active attach operation
 per cpuset
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gscrivan@redhat.com
References: <20230331145045.2251683-1-longman@redhat.com>
 <20230331145045.2251683-4-longman@redhat.com>
 <20230406-haselnuss-baumhaus-83dc05f869df@brauner>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230406-haselnuss-baumhaus-83dc05f869df@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/6/23 05:44, Christian Brauner wrote:
> On Fri, Mar 31, 2023 at 10:50:45AM -0400, Waiman Long wrote:
>> The current cpuset code uses the global cpuset_attach_old_cs variable
>> to store the old cpuset value between consecutive cpuset_can_attach()
>> and cpuset_attach() calls. Since a caller of cpuset_can_attach() may
>> not need to hold the global cgroup_threadgroup_rwsem, parallel cpuset
>> attach operations are possible.
>>
>> When there are concurrent cpuset attach operations in progress,
>> cpuset_attach() may fetch the wrong value from cpuset_attach_old_cs
>> causing incorrect result.  To avoid this problem while still allowing
>> certain level of parallelism, drop cpuset_attach_old_cs and use a
>> per-cpuset attach_old_cs value. Also restrict to at most one active
>> attach operation per cpuset to avoid corrupting the value of the
>> per-cpuset attach_old_cs value.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 19 ++++++++++++++-----
>>   1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 2367de611c42..3f925c261513 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -198,6 +198,8 @@ struct cpuset {
>>   
>>   	/* Handle for cpuset.cpus.partition */
>>   	struct cgroup_file partition_file;
>> +
>> +	struct cpuset *attach_old_cs;
>>   };
>>   
>>   /*
>> @@ -2456,22 +2458,27 @@ static int fmeter_getrate(struct fmeter *fmp)
>>   	return val;
>>   }
>>   
>> -static struct cpuset *cpuset_attach_old_cs;
>> -
>>   /* Called by cgroups to determine if a cpuset is usable; cpuset_rwsem held */
>>   static int cpuset_can_attach(struct cgroup_taskset *tset)
>>   {
>>   	struct cgroup_subsys_state *css;
>> -	struct cpuset *cs;
>> +	struct cpuset *cs, *oldcs;
>>   	struct task_struct *task;
>>   	int ret;
>>   
>>   	/* used later by cpuset_attach() */
>> -	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
>> +	oldcs = task_cs(cgroup_taskset_first(tset, &css));
>>   	cs = css_cs(css);
>>   
>>   	percpu_down_write(&cpuset_rwsem);
>>   
>> +	/*
>> +	 * Only one cpuset attach operation is allowed for each cpuset.
>> +	 */
>> +	ret = -EBUSY;
>> +	if (cs->attach_in_progress)
>> +		goto out_unlock;
> That'll mean CLONE_INTO_CGROUP becomes even more interestig because it
> isn't subject to this restriction in contrast to fork()+migrate, right?

This patch is not related to the CLONE_INTO_CGROUP. In fact, I have 
dropped that in latter version.

Cheers,
Longman

