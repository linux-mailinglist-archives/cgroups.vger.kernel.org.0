Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A027C40A2
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 22:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjJJUEv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 16:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjJJUEm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 16:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C10F109
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696968226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Q1ao8fPZNUoCR6F1A4bfZDN3G9jXtzU1z74a4lCd3M=;
        b=GJ69qPx1LYlCRRKZP344o8hmVSuWm24i9sYpzf7nrd3p6+AA/N+rxpo89SiepICVRLsHrW
        eqj4ZzST7ICEHEXXMTOruehaGAu8TtLWcMITcw+d8zkNIDUDKyvqBez4w39VhV1DDZfBrM
        2BfQoTJpdKbxuZFv5sED6CZ87HGRR4U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-itfBRZr6PNm8GnfQyPjYJw-1; Tue, 10 Oct 2023 16:03:44 -0400
X-MC-Unique: itfBRZr6PNm8GnfQyPjYJw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B95B3801BCB;
        Tue, 10 Oct 2023 20:03:43 +0000 (UTC)
Received: from [10.22.9.34] (unknown [10.22.9.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEB72492B04;
        Tue, 10 Oct 2023 20:03:41 +0000 (UTC)
Message-ID: <31e06652-1dbd-e32f-3123-d17e178c5c27@redhat.com>
Date:   Tue, 10 Oct 2023 16:03:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] cgroup/cpuset: Change nr_deadline_tasks to an atomic_t
 value
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xia Fukun <xiafukun@huawei.com>
References: <20231009191515.3262292-1-longman@redhat.com>
 <ZSTiULEnD7SF9n7y@localhost.localdomain>
 <6b769316-6434-5054-43f5-7933fc2bee01@redhat.com>
In-Reply-To: <6b769316-6434-5054-43f5-7933fc2bee01@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 10/10/23 15:44, Waiman Long wrote:
>
> On 10/10/23 01:34, Juri Lelli wrote:
>> Hi,
>>
>> On 09/10/23 15:15, Waiman Long wrote:
>>> The nr_deadline_tasks field in cpuset structure was introduced by
>>> commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
>>> in cpusets"). Unlike nr_migrate_dl_tasks which is only modified under
>>> cpuset_mutex, nr_deadline_tasks can be updated in various contexts
>>> under different locks. As a result, data races may happen that cause
>>> incorrect value to be stored in nr_deadline_tasks leading to incorrect
>> Could you please make an example of such data races?
>
> Since update to cs->nr_deadline_tasks is not protected by a single 
> lock, it is possible that multiple CPUs may try to modify it at the 
> same time.  It is possible that nr_deadline_tasks++ and 
> nr_deadline_tasks-- can be done in a single instruction like in x86 
> and hence atomic. However, operation like "cs->nr_deadline_tasks += 
> cs->nr_migrate_dl_tasks" is likely a RMW operation and so is subjected 
> to racing. It is mostly theoretical, but probably not impossible.

Sorry, even increment and decrement operators are not atomic.

inc_dl_tasks_cs() is only called from switched_to_dl() in deadline.c 
which is protected by the rq_lock, but there are multiple rq's. 
dec_dl_tasks_cs() is called from switched_from_dl() in deadline.c and 
cgroup_exit() in cgroup.c. The later one is protected by css_set_lock. 
The other place where nr_deadline_tasks can be changed is in 
cpuset_attach() protected by cpuset_mutex.

Cheers,
Longman


