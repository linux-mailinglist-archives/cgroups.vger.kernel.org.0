Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9B27C8CDF
	for <lists+cgroups@lfdr.de>; Fri, 13 Oct 2023 20:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjJMSMo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Oct 2023 14:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjJMSMm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Oct 2023 14:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653B9DE
        for <cgroups@vger.kernel.org>; Fri, 13 Oct 2023 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697220715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XIlRT028Oilu2T1armBjKk281LICHF+uokOf7ejKB88=;
        b=Ng3wW6/7ZrJ9rc4tRm5VYgk78GL5Ouk0eTcrQK+TOEmblSa1CPj0OmKh2RsrzbE+A6KWq+
        pBEMYRMGkPNy3f+a2YzDiKsHV4e8VjD/9MvYsasRxwBVzD4Ns3R0VDcuJU9B11+2KtoprF
        VctEgwsp4VGz+mKcCSr5cTrPSRQYdAg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-AhnJ3bsNPlSj1UTHtQz4mg-1; Fri, 13 Oct 2023 14:11:48 -0400
X-MC-Unique: AhnJ3bsNPlSj1UTHtQz4mg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3575F88B7A0;
        Fri, 13 Oct 2023 18:11:48 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87F7C20296DB;
        Fri, 13 Oct 2023 18:11:47 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 0/4] cgroup/cpuset: Improve CPU isolation in isolated partitions
Date:   Fri, 13 Oct 2023 14:11:18 -0400
Message-Id: <20231013181122.3518610-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Isolated cpuset partition can currently be created to contain an
exclusive set of CPUs not used in other cgroups and with load balancing
disabled to reduce interference from the scheduler.

The main purpose of this isolated partition type is to dynamically
emulate what can be done via the "isolcpus" boot command line option,
specifically the default domain flag. One effect of the "isolcpus" option
is to remove the isolated CPUs from the cpumasks of unbound workqueues
since running work functions in an isolated CPU can be a major source
of interference. Changing the unbound workqueue cpumasks can be done at
run time by writing an appropriate cpumask without the isolated CPUs to
/sys/devices/virtual/workqueue/cpumask. So one can set up an isolated
cpuset partition and then write to the cpumask sysfs file to achieve
similar level of CPU isolation. However, this manual process can be
error prone.

This patch series implements automatic exclusion of isolated CPUs from
unbound workqueue cpumasks when an isolated cpuset partition is created
and then adds those CPUs back when the isolated partition is destroyed.

There are also other places in the kernel that look at the HK_FLAG_DOMAIN
cpumask or other HK_FLAG_* cpumasks and exclude the isolated CPUs from
certain actions to further reduce interference. CPUs in an isolated
cpuset partition will not be able to avoid those interferences yet. That
may change in the future as the need arises.

Waiman Long (4):
  workqueue: Add workqueue_unbound_exclude_cpumask() to exclude CPUs
    from wq_unbound_cpumask
  selftests/cgroup: Minor code cleanup and reorganization of
    test_cpuset_prs.sh
  cgroup/cpuset: Keep track of CPUs in isolated partitions
  cgroup/cpuset: Take isolated CPUs out of workqueue unbound cpumask

 Documentation/admin-guide/cgroup-v2.rst       |  10 +-
 include/linux/workqueue.h                     |   2 +-
 kernel/cgroup/cpuset.c                        | 237 +++++++++++++-----
 kernel/workqueue.c                            |  42 +++-
 .../selftests/cgroup/test_cpuset_prs.sh       | 209 +++++++++------
 5 files changed, 350 insertions(+), 150 deletions(-)

-- 
2.39.3

