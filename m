Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34916BAAC8
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 09:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjCOIaW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Mar 2023 04:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjCOIaV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Mar 2023 04:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E8338030;
        Wed, 15 Mar 2023 01:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0979761C11;
        Wed, 15 Mar 2023 08:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1A8C433EF;
        Wed, 15 Mar 2023 08:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678869019;
        bh=hE3fyUKCNJmb98hi99Yf0nUKlq4P8XUaLti7/cHlkAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WPz9bRlf9fJg6WWMO2QCT6ZiS+HD6KIaORlrD5kSzQHVsUyDsHDVCUkyChJRzcW53
         aiDdOSHkhfGaBKm3fV5Um97lcnuBwe6OysqlsaXKUEYChQDH6whtwEE6l7HmhsE489
         O7eszhammUP47bNxQ8lDeHipaWXJdrraqC8aA1JY=
Date:   Wed, 15 Mar 2023 09:30:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cai Xinchen <caixinchen1@huawei.com>
Cc:     longman@redhat.com, lizefan.x@bytedance.com, tj@kernel.org,
        hannes@cmpxchg.org, sashal@kernel.org, mkoutny@suse.com,
        zhangqiao22@huawei.com, juri.lelli@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, stable@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.19 0/3] Backport patches to fix threadgroup_rwsem <->
 cpus_read_lock() deadlock
Message-ID: <ZBGCEgB7wEe0pCNk@kroah.com>
References: <20230303045050.139985-1-caixinchen1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303045050.139985-1-caixinchen1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 03, 2023 at 04:50:47AM +0000, Cai Xinchen wrote:
> We have a deadlock problem which can be solved by commit 4f7e7236435ca
> ("cgroup: Fix threadgroup_rwsem <-> cpus_read_lock() deadlock").
> However, it makes lock order of cpus_read_lock and cpuset_mutex
> wrong in v4.19. The call sequence is as follows:
> cgroup_procs_write()
>         cgroup_procs_write_start()
>                 get_online_cpus(); // cpus_read_lock()
>                 percpu_down_write(&cgroup_threadgroup_rwsem)
>         cgroup_attach_task
>                 cgroup_migrate
>                         cgroup_migrate_execute
>                                 ss->attach (cpust_attach)
>                                         mutex_lock(&cpuset_mutex)
> 
> it seems hard to make cpus_read_lock is locked before
> cgroup_threadgroup_rwsem and cpuset_mutex is locked before
> cpus_read_lock unless backport the commit d74b27d63a8beb
> ("cgroup/cpuset: Change cpuset_rwsem and hotplug lock order")
> 
> Juri Lelli (1):
>   cgroup/cpuset: Change cpuset_rwsem and hotplug lock order
> 
> Tejun Heo (1):
>   cgroup: Fix threadgroup_rwsem <-> cpus_read_lock() deadlock
> 
> Tetsuo Handa (1):
>   cgroup: Add missing cpus_read_lock() to cgroup_attach_task_all()
> 
>  include/linux/cpuset.h    |  8 +++----
>  kernel/cgroup/cgroup-v1.c |  3 +++
>  kernel/cgroup/cgroup.c    | 49 +++++++++++++++++++++++++++++++++++----
>  kernel/cgroup/cpuset.c    | 25 ++++++++++++--------
>  4 files changed, 66 insertions(+), 19 deletions(-)
> 
> -- 
> 2.17.1
> 

Now queued up, thanks.

greg k-h
