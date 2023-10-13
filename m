Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FDE7C8996
	for <lists+cgroups@lfdr.de>; Fri, 13 Oct 2023 18:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjJMQEP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Oct 2023 12:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjJMQEP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Oct 2023 12:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F5FC9
        for <cgroups@vger.kernel.org>; Fri, 13 Oct 2023 09:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697213006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nqf6Wos6j/dOB8iX9uZ+sliE7IdSLRs7IhOwsFPasV8=;
        b=HVLY4O+kiiTKPT7yJHZok/6dmr9qawlcK0aqYKkcjWlchtgwXSfsEULd64M68JFUlD2ubX
        8t02m1Xg+Z+RTdzr2oCbKNnxqS81vofUVpkunM5S4ct2zt3835KpBjg3RDQDJb3JeYEXAP
        QR/Udn0Q0Om7ePOXYMNLdzSI9Cjymlk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-694-KMMaU5QkNK6QYcars7KklA-1; Fri, 13 Oct 2023 12:03:20 -0400
X-MC-Unique: KMMaU5QkNK6QYcars7KklA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D804887E6B;
        Fri, 13 Oct 2023 16:03:19 +0000 (UTC)
Received: from [10.22.17.138] (unknown [10.22.17.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78D7D1C06535;
        Fri, 13 Oct 2023 16:03:18 +0000 (UTC)
Message-ID: <f75859e0-04d4-3da2-8df0-eb8841623a7c@redhat.com>
Date:   Fri, 13 Oct 2023 12:03:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v8 0/7] cgroup/cpuset: Support remote partitions
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
References: <20230905133243.91107-1-longman@redhat.com>
 <ahevhcy2aa7k3plmfvlepjehs6u3fun3j4oyskdz7axkhftlyi@zr3j473rciwi>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ahevhcy2aa7k3plmfvlepjehs6u3fun3j4oyskdz7axkhftlyi@zr3j473rciwi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/13/23 11:50, Michal Koutný wrote:
> Hello.
>
> (I know this is heading for 6.7. Still I wanted to have a look at this
> after it stabilized somehow to understand the new concept better but I
> still have some questions below.)
>
> On Tue, Sep 05, 2023 at 09:32:36AM -0400, Waiman Long <longman@redhat.com> wrote:
>> Both scheduling and isolated partitions can be formed as a remote
>> partition. A local partition can be created under a remote partition.
>> A remote partition, however, cannot be formed under a local partition
>> for now.
>>
>>
>> With this patch series, we allow the creation of remote partition
>> far from the root. The container management tool can manage the
>> "cpuset.cpus.exclusive" file without impacting the other cpuset
>> files that are managed by other middlewares. Of course, invalid
>> "cpuset.cpus.exclusive" values will be rejected.
> I take the example with a nested cgroup `cont` to which I want to
> dedicate two CPUs (0 and 1).
> IIUC, I can do this both with a chain of local root partitions or as a
> single remote partion.
>
>
> [chain]
>    root
>    |                           \
>    mid1a                        mid1b
>     cpuset.cpus=0-1              cpuset.cpus=2-15
>     cpuset.cpus.partition=root
>    |
>    mid2
>     cpuset.cpus=0-1
>     cpuset.cpus.partition=root
>    |
>    cont
>     cpuset.cpus=0-1
>     cpuset.cpus.partition=root
In this case, the effective CPUs of both mid1a and mid2 will be empty. 
IOW, you can't have any task in these 2 cpusets.
>
> [remote]
>    root
>    |                           \
>    mid1a                        mid1b
>     cpuset.cpus.exclusive=0-1    cpuset.cpus=2-15
>    |
>    mid2
>     cpuset.cpus.exclusive=0-1
>    |
>    cont
>     cpuset.cpus.exclusive=0-1
>     cpuset.cpus.partition=root
>
> In the former case I must configure cpuset.cpus and
> cpuset.cpus.partition along the whole path and in the second case
> cpuset.cpus.exclusive still along the whole path and root at the bottom
> only.
>
> What is the difference between the two configs above?
> (Or can you please give an example where the remote partitions are
> better illustrated?)

For the remote case, you can have intermediate tasks in both mid1a and 
mid2 as long as cpuset.cpus contains more CPUs than cpuset.cpus.exclusive.


> <snip>
>> Modern container orchestration tools like Kubernetes use the cgroup
>> hierarchy to manage different containers. And it is relying on other
>> middleware like systemd to help managing it. If a container needs to
>> use isolated CPUs, it is hard to get those with the local partitions
>> as it will require the administrative parent cgroup to be a partition
>> root too which tool like systemd may not be ready to manage.
> Such tools ready aren't ready to manage cpuset.cpus.exclusive, are they?
> IOW tools need to distinguish exclusive and "shared" CPUs which is equal
> to distinguishing root and member partitions.

They will be ready eventually. This requirement of remote partition 
actually came from our OpenShift team as the use of just local partition 
did not meet their need. They don't need access to exclusive CPUs in the 
parent cgroup layer for their management daemons. They do need to 
activate isolated partition in selected child cgroups to support our 
Telco customers to run workloads like DPDK.

So they will add the support to upstream Kubernetes.

Cheers,
Longman


