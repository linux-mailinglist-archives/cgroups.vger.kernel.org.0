Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C8C7623EF
	for <lists+cgroups@lfdr.de>; Tue, 25 Jul 2023 22:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGYUul (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jul 2023 16:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjGYUuh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jul 2023 16:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1A5E47
        for <cgroups@vger.kernel.org>; Tue, 25 Jul 2023 13:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690318197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s/yfCfAbJiZTz8QCwyXpeKRXITW91oWR1I5Gnu5NNWQ=;
        b=WB9g5+bzv2e/vnwGLgfIryYnN+Rpr6CKiZWVDKiqV8nxHhqvGY/Dz1mgRWIZjGMwBOJCA9
        SjukeM4kXRDpyUXjRZVvDF2j5S80cH9+YSL5uAhhyvX7rbBmNhVsUX1u3FfnJ8D9xoIAfT
        x6LJczgK2CQesc+w0tALkucgMZ8DT7Q=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-whry9tybMvSga9lzapOpjg-1; Tue, 25 Jul 2023 16:49:53 -0400
X-MC-Unique: whry9tybMvSga9lzapOpjg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DAAD1C03DAA;
        Tue, 25 Jul 2023 20:49:52 +0000 (UTC)
Received: from [10.22.18.12] (unknown [10.22.18.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD61B40C206F;
        Tue, 25 Jul 2023 20:49:51 +0000 (UTC)
Message-ID: <4553b9cd-2450-31f4-2c04-6a9b93499190@redhat.com>
Date:   Tue, 25 Jul 2023 16:49:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH-cgroup v5 0/5] cgroup/cpuset: Support remote partitions
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
References: <20230713172601.3285847-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230713172601.3285847-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 7/13/23 13:25, Waiman Long wrote:
>   v5:
>    - [v4] https://lore.kernel.org/lkml/20230627143508.1576882-1-longman@redhat.com/
>    - Drop the first 4 patches as they had been merged.
>    - Make cpuset.cpus.exclusive invariant once it is manually set. This
>      also means the cpuset.cpus.exclusive may not show the effective value
>      that is actually being used.
>    - Update the documentation and test accordingly.
>
>   v4:
>    - [v3] https://lore.kernel.org/lkml/20230627005529.1564984-1-longman@redhat.com/
>    - Fix compilation problem reported by kernel test robot.
>
> This patch series introduces a new cpuset control file
> "cpuset.cpus.exclusive" which must be a subset of "cpuset.cpus"
> and the parent's "cpuset.cpus.exclusive". This control file lists
> the exclusive CPUs to be distributed down the hierarchy. Any one
> of the exclusive CPUs can only be distributed to at most one child
> cpuset. Unlike "cpuset.cpus", invalid input to "cpuset.cpus.exclusive"
> will be rejected with an error. This new control file has no effect on
> the behavior of the cpuset until it turns into a partition root. At that
> point, its effective CPUs will be set to its exclusive CPUs unless some
> of them are offline.
>
> This patch series also introduces a new category of cpuset partition
> called remote partitions. The existing partition category where the
> partition roots have to be clustered around the root cgroup in a
> hierarchical way is now referred to as local partitions.
>
> A remote partition can be formed far from the root cgroup
> with no partition root parent. While local partitions can be
> created without touching "cpuset.cpus.exclusive" as it can be set
> automatically if a cpuset becomes a local partition root. Properly set
> "cpuset.cpus.exclusive" values down the hierarchy are required to create
> a remote partition.
>
> Both scheduling and isolated partitions can be formed in a remote
> partition. A local partition can be created under a remote partition.
> A remote partition, however, cannot be formed under a local partition
> for now.
>
> Modern container orchestration tools like Kubernetes use the cgroup
> hierarchy to manage different containers. And it is relying on other
> middleware like systemd to help managing it. If a container needs to
> use isolated CPUs, it is hard to get those with the local partitions
> as it will require the administrative parent cgroup to be a partition
> root too which tool like systemd may not be ready to manage.
>
> With this patch series, we allow the creation of remote partition
> far from the root. The container management tool can manage the
> "cpuset.cpus.exclusive" file without impacting the other cpuset
> files that are managed by other middlewares. Of course, invalid
> "cpuset.cpus.exclusive" values will be rejected.
>
> Waiman Long (5):
>    cgroup/cpuset: Add cpuset.cpus.exclusive for v2
>    cgroup/cpuset: Introduce remote partition
>    cgroup/cpuset: Check partition conflict with housekeeping setup
>    cgroup/cpuset: Documentation update for partition
>    cgroup/cpuset: Extend test_cpuset_prs.sh to test remote partition
>
>   Documentation/admin-guide/cgroup-v2.rst       |  114 +-
>   kernel/cgroup/cpuset.c                        | 1242 ++++++++++++-----
>   .../selftests/cgroup/test_cpuset_prs.sh       |  419 ++++--
>   3 files changed, 1291 insertions(+), 484 deletions(-)
>
Tejun,

Do you have any further suggested change that you would like to see?

Cheers,
Longman

