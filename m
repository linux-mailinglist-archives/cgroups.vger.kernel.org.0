Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FDC6476DA
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 20:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiLHT54 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 14:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLHT54 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 14:57:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316F45C0DC
        for <cgroups@vger.kernel.org>; Thu,  8 Dec 2022 11:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670529423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TZRYE/zC/NinxkpytfI2ULEuvdHw2Fkmlz2Sq9exJ+g=;
        b=SXyxWtaBKS9Y5auEhcUtLIjtfx+Wn3vRt+SvNQ0r6tPYITavcYpnMCf6DwTE0MZjGKlF8N
        rL+7yWQGIS+Xe0CAC+EhfN/mRyqnYq87AU8Sn4vbhY0+JC8Se8jhhZgRBIooGE9E0oY+A8
        hfXWcgUBQdfBi3jJM5KK+oPN8PApPyk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-mJNRIKvbPRyvoEdVyoa9MA-1; Thu, 08 Dec 2022 14:56:59 -0500
X-MC-Unique: mJNRIKvbPRyvoEdVyoa9MA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 684BF2A59564;
        Thu,  8 Dec 2022 19:56:59 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD14F492B04;
        Thu,  8 Dec 2022 19:56:58 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] cgroup/cpuset: Task migration optimization
Date:   Thu,  8 Dec 2022 14:56:32 -0500
Message-Id: <20221208195634.2604362-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It is found that workloads that generate a lot of task migrations
among different cpusets are severely throttled because of the use
of percpu rwsem in cpuset_rwsem. It is the same problem that led to
commit 3942a9bd7b58 ("locking, rcu, cgroup: Avoid synchronize_sched()
in __cgroup_procs_write()") and commit 6a010a49b63a ("cgroup: Make
!percpu threadgroup_rwsem operations optional").

The first patch in this series changes cpuset_can_attach() to use
the read lock instead of the write lock. The second patch allows
disabling of percpu reader fast path depending on the presence of
CGRP_ROOT_FAVOR_DYNMODS flag in the cgroup root.

Waiman Long (2):
  cgroup/cpuset: Use cpuset_rwsem read lock in cpuset_can_attach()
  cgroup/cpuset: Make percpu cpuset_rwsem operation depending on DYNMODS
    state

 kernel/cgroup/cpuset.c | 75 ++++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 17 deletions(-)

-- 
2.31.1

