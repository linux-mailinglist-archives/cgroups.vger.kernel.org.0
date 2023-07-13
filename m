Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC7F7529CB
	for <lists+cgroups@lfdr.de>; Thu, 13 Jul 2023 19:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjGMR1P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jul 2023 13:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGMR1P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jul 2023 13:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C581BD4
        for <cgroups@vger.kernel.org>; Thu, 13 Jul 2023 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689269187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b39/2E54J6/ek/nF8sDTY7kZp1goyhE+qUqHrG0pcmw=;
        b=PfMP2tsUOJ7+EqKRvoF2cu1t8V8dlE1T90Opli5TOLpIB41Uee0WpUfP6K0ZdEfmxbSaS2
        yd9Qz9awTbtlh7/glEXXqx2zJ8panE6e0hnlj2WD54j+ODLECmBEG91mEn4JTNTY1+SBnh
        uDjofV0zb4VmzeliUe5q/FqCh25CFLc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-6jvb-hD8PnyMn0AirtJ13A-1; Thu, 13 Jul 2023 13:26:25 -0400
X-MC-Unique: 6jvb-hD8PnyMn0AirtJ13A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15F20185A791;
        Thu, 13 Jul 2023 17:26:25 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D67402166B26;
        Thu, 13 Jul 2023 17:26:23 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup v5 0/5] cgroup/cpuset: Support remote partitions
Date:   Thu, 13 Jul 2023 13:25:56 -0400
Message-Id: <20230713172601.3285847-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

 v5:
  - [v4] https://lore.kernel.org/lkml/20230627143508.1576882-1-longman@redhat.com/
  - Drop the first 4 patches as they had been merged.
  - Make cpuset.cpus.exclusive invariant once it is manually set. This
    also means the cpuset.cpus.exclusive may not show the effective value
    that is actually being used.
  - Update the documentation and test accordingly.

 v4:
  - [v3] https://lore.kernel.org/lkml/20230627005529.1564984-1-longman@redhat.com/
  - Fix compilation problem reported by kernel test robot.

This patch series introduces a new cpuset control file
"cpuset.cpus.exclusive" which must be a subset of "cpuset.cpus"
and the parent's "cpuset.cpus.exclusive". This control file lists
the exclusive CPUs to be distributed down the hierarchy. Any one
of the exclusive CPUs can only be distributed to at most one child
cpuset. Unlike "cpuset.cpus", invalid input to "cpuset.cpus.exclusive"
will be rejected with an error. This new control file has no effect on
the behavior of the cpuset until it turns into a partition root. At that
point, its effective CPUs will be set to its exclusive CPUs unless some
of them are offline.

This patch series also introduces a new category of cpuset partition
called remote partitions. The existing partition category where the
partition roots have to be clustered around the root cgroup in a
hierarchical way is now referred to as local partitions.

A remote partition can be formed far from the root cgroup
with no partition root parent. While local partitions can be
created without touching "cpuset.cpus.exclusive" as it can be set
automatically if a cpuset becomes a local partition root. Properly set
"cpuset.cpus.exclusive" values down the hierarchy are required to create
a remote partition.

Both scheduling and isolated partitions can be formed in a remote
partition. A local partition can be created under a remote partition.
A remote partition, however, cannot be formed under a local partition
for now.

Modern container orchestration tools like Kubernetes use the cgroup
hierarchy to manage different containers. And it is relying on other
middleware like systemd to help managing it. If a container needs to
use isolated CPUs, it is hard to get those with the local partitions
as it will require the administrative parent cgroup to be a partition
root too which tool like systemd may not be ready to manage.

With this patch series, we allow the creation of remote partition
far from the root. The container management tool can manage the
"cpuset.cpus.exclusive" file without impacting the other cpuset
files that are managed by other middlewares. Of course, invalid
"cpuset.cpus.exclusive" values will be rejected.

Waiman Long (5):
  cgroup/cpuset: Add cpuset.cpus.exclusive for v2
  cgroup/cpuset: Introduce remote partition
  cgroup/cpuset: Check partition conflict with housekeeping setup
  cgroup/cpuset: Documentation update for partition
  cgroup/cpuset: Extend test_cpuset_prs.sh to test remote partition

 Documentation/admin-guide/cgroup-v2.rst       |  114 +-
 kernel/cgroup/cpuset.c                        | 1242 ++++++++++++-----
 .../selftests/cgroup/test_cpuset_prs.sh       |  419 ++++--
 3 files changed, 1291 insertions(+), 484 deletions(-)

-- 
2.31.1

