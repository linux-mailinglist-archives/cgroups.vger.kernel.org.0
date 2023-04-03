Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95C06D4F32
	for <lists+cgroups@lfdr.de>; Mon,  3 Apr 2023 19:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjDCRm0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Apr 2023 13:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjDCRmZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Apr 2023 13:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4970FDF
        for <cgroups@vger.kernel.org>; Mon,  3 Apr 2023 10:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680543700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=du5ube66GFFv6eiC7GgKY4F8MRZGEnQkABRtMIiA1tM=;
        b=J6cASXk5i9MHrtpZDY8dEZvmUQKNuPizeI6WliI719tDfaYDiQEb6IJyq3fn1lH3ATkSzJ
        P3lNcBzS5+aERcfFSpAisMZ2HjCQ16slHA4jaRYYu4l2E1TOcaw1hCQ0iu2zMRy3zGOHXB
        taKagSrR63RGIUIJAGRbr70nEqz9w2c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-vsOxvpMkMAm9e-diM8GuYA-1; Mon, 03 Apr 2023 13:41:37 -0400
X-MC-Unique: vsOxvpMkMAm9e-diM8GuYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A37E4101A54F;
        Mon,  3 Apr 2023 17:41:34 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED04C40C6EC4;
        Mon,  3 Apr 2023 17:41:33 +0000 (UTC)
Message-ID: <24b67530-62ce-4f9c-7b74-d41d2ccc710e@redhat.com>
Date:   Mon, 3 Apr 2023 13:41:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/3] cgroup/cpuset: Allow only one active attach operation
 per cpuset
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gscrivan@redhat.com
References: <20230331145045.2251683-1-longman@redhat.com>
 <20230331145045.2251683-4-longman@redhat.com>
 <20230403164736.lpjdpzxxnjlpxrqv@blackpad>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230403164736.lpjdpzxxnjlpxrqv@blackpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 4/3/23 12:47, Michal Koutný wrote:
> On Fri, Mar 31, 2023 at 10:50:45AM -0400, Waiman Long <longman@redhat.com> wrote:
>> The current cpuset code uses the global cpuset_attach_old_cs variable
>> to store the old cpuset value between consecutive cpuset_can_attach()
>> and cpuset_attach() calls. Since a caller of cpuset_can_attach() may
>> not need to hold the global cgroup_threadgroup_rwsem, parallel cpuset
>> attach operations are possible.
> Do I understand correctly this consequence of the cpuset_attach_task()
> on the clone path?
> In that particular case (with CLONE_INTO_CGROUP) cgroup_mutex is taken,
> so the access the the old_cs variable should still be synchronized with
> regular migrations that are also under cgroup_mutex.

This patch is actually not related to the CLONE_INTO_GROUP problem in 
patch 1. It is a generic problem when multiple users are moving threads 
into cgroup.threads of the same or different cpusets simultaneously.


>> When there are concurrent cpuset attach operations in progress,
>> cpuset_attach() may fetch the wrong value from cpuset_attach_old_cs
>> causing incorrect result.  To avoid this problem while still allowing
>> certain level of parallelism, drop cpuset_attach_old_cs and use a
>> per-cpuset attach_old_cs value. Also restrict to at most one active
>> attach operation per cpuset to avoid corrupting the value of the
>> per-cpuset attach_old_cs value.
> Secondly, semantically wouldn't a `void *ss_priv[CGROUP_SUBSYS_COUNT]`
> in struct cgroup_taskset make it simpler wrt the exclusivity guarantees?

I guess we can put the old_cs value into cgroup_taskset. Since the 
related attach_in_progress value is in cpuset, so I put the old_cs there 
too.


> Thirdly, if my initial assumptino is right -- I'd suggest ordering this
> before the patch `cgroup/cpuset: Make cpuset_fork() handle
> CLONE_INTO_CGROUP properly` to spare backporters possible troubles if
> this is would be a fixup to that.

I don't believe this patch has a dependency on patch 1.

I had thought about adding a fixes tag so it will be backported to 
stable. However, this problem should be rare. Let's see what others 
think about it.

Cheers,
Longman

