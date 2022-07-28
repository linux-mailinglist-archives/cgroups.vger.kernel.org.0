Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1398584276
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 16:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiG1O7N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 10:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiG1O7L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 10:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE90112D12
        for <cgroups@vger.kernel.org>; Thu, 28 Jul 2022 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659020349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z/5IAGid/MkaGLoGKjcup59KN/CNT4vmw2F2KlJ1qxE=;
        b=iy/CWFy2ERcNaDYBIusjuZmZzM2djzl3Ob9ZYUFU4SLuxVobavzg6W/LkgiITBlML+6mv+
        lYQVD+GvcQh4JBl9nlexWzpa32MZbfi4xwN31DbQ2r/zMojD3Ey56MVOOgI1OMG1SjJkEX
        wznnx+XRolb1+lDBHPrr1fEMNhnA0YA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-pUuMEUEVMhqVl6KTPnjYeA-1; Thu, 28 Jul 2022 10:59:04 -0400
X-MC-Unique: pUuMEUEVMhqVl6KTPnjYeA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22A903817A70;
        Thu, 28 Jul 2022 14:59:03 +0000 (UTC)
Received: from [10.22.9.86] (unknown [10.22.9.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C81B2026D64;
        Thu, 28 Jul 2022 14:59:02 +0000 (UTC)
Message-ID: <a58852b4-313a-9271-f31d-f79a91ec188b@redhat.com>
Date:   Thu, 28 Jul 2022 10:59:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] cgroup/cpuset: Keep current cpus list if cpus
 affinity was explicitly set
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220728005815.1715522-1-longman@redhat.com>
 <20220728144420.GA27407@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220728144420.GA27407@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/28/22 10:44, Michal Koutný wrote:
> Hello.
>
> On Wed, Jul 27, 2022 at 08:58:14PM -0400, Waiman Long <longman@redhat.com> wrote:
>> It was found that any change to the current cpuset hierarchy may reset
>> the cpus_allowed list of the tasks in the affected cpusets to the
>> default cpuset value even if those tasks have cpus affinity explicitly
>> set by the users before.
> I'm surprised this went so long unnoticed / unreported.
>
> Could it be users relied on that implicit affinity reset?

As said, it is more easily triggered in a cgroup v2 environment. 
Systemd, on a cgroup v2 environment, will write "+cpuset" to the root 
cgroup's subtree_control file when a new container is instantiated. I 
don't know why it is doing that, but that cause problem as it resets all 
the cpus_allowed list assignment. Cgroup v1 doesn't have this problem.


>> That is especially easy to trigger under a cgroup v2 environment where
>> writing "+cpuset" to the root cgroup's cgroup.subtree_control file
>> will reset the cpus affinity of all the processes in the system.
> This should apply only to tasks that were extracted out of the root
> cgroup, no? (OK, those are all processes practically.)
The reset is done on all cgroups in a particular subtree. In the case of 
cgroup root, it is all the processes in the system.
>
> (Even without your second patch, the scope should be limited because of
> src_cset==dst_cset check in cgroup_migrate_prepare_dst().)
>
>> That is especially problematic in a nohz_full environment where the
>> tasks running in the nohz_full CPUs usually have their cpus affinity
>> explicitly set and will behave incorrectly if cpus affinity changes.
> One could also argue that for such processes, cgroup hierarchy should be
> first configured and only then they start and set own affinity.
>
>> Fix this problem by adding a flag in the task structure to indicate that
>> a task has their cpus affinity explicitly set before and make cpuset
>> code not to change their cpus_allowed list unless the user chosen cpu
>> list is no longer a subset of the cpus_allowed list of the cpuset itself.
> I'm uneasy with the occasional revert of this flag, i.e. the task who
> set their affinity would sometimes have it overwritten and sometimes
> not (which might have been relied on, especially with writes into
> cpuset.cpus).
> (But I have no better answer than the counter-argument above since
> there's no easier way to detect the implicit migrations.)
I also thought about that. Another possible alternative is to use the 
intersection of cpuset's cpu list and task's own cpu list as long as it 
is not empty. Reducing the number of cpus assigned to a task may produce 
some unexpected behavior too.
>
> Also, is there similar effect with memory binding?

I think so, but memory binding is less frequently used and its effect is 
less noticeable.

Cheers,
Longman

>
> Thanks,
> Michal
>

