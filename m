Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA1A77F7AA
	for <lists+cgroups@lfdr.de>; Thu, 17 Aug 2023 15:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351410AbjHQN0v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Aug 2023 09:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351043AbjHQN0T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Aug 2023 09:26:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C602126B7
        for <cgroups@vger.kernel.org>; Thu, 17 Aug 2023 06:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692278733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EIvqGNiOYq+EPYGcgkwpvLebPIjD/Gcyc9aldSjDqvY=;
        b=cQKYNwmGmEOHhdd7/EBPa9wZSnJ+sotLLui60GBXFdF3+jyZib5mDLwrE9Jogoqluhv0rB
        m1CPckFeYvjDvwsNuzaLyrQ1cmbEDI6iPZWH/7iVqZPHLElLY7m0l++ejC1pWRA+YvqqFU
        M6cvD1Xk/0lBLZN6unfWjmb7VHrmqwI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-BciGRrdiN5G5BVx_7wn7Zg-1; Thu, 17 Aug 2023 09:25:29 -0400
X-MC-Unique: BciGRrdiN5G5BVx_7wn7Zg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 563BA108BF02;
        Thu, 17 Aug 2023 13:25:11 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2171F492C13;
        Thu, 17 Aug 2023 13:25:10 +0000 (UTC)
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
Subject: [PATCH-cgroup v7 0/6] cgroup/cpuset: Support remote partitions
Date:   Thu, 17 Aug 2023 09:24:48 -0400
Message-Id: <20230817132454.755459-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

 v7:
  - Fix a compilation problem in patch 1 & a memory allocation bug in
    patch 2.
  - Change exclusive_cpus type to cpumask_var_t to match other cpumasks
    and make code more consistent.

 v6:
  - https://lore.kernel.org/lkml/20230713172601.3285847-1-longman@redhat.com/
  - Add another read-only cpuset.cpus.exclusive.effective control file
    to expose the effective set of exclusive CPUs.
  - Update the documentation and test accordingly.

 v5:
  - https://lore.kernel.org/lkml/20230713172601.3285847-1-longman@redhat.com/
  - Drop the first 4 patches as they had been merged.
  - Make cpuset.cpus.exclusive invariant once it is manually set. This
    also means the cpuset.cpus.exclusive may not show the effective value
    that is actually being used.
  - Update the documentation and test accordingly.


This patch series introduces new cpuset control
files "cpuset.cpus.exclusive" (read-write) and
"cpuset.cpus.exclusive.effective" (read only) for better control of
which exclusive CPUs are being distributed down the cgroup hierarchy
for creating cpuset partition.

Any one of the exclusive CPUs can only be distributed to at most one
child cpuset. Invalid input to "cpuset.cpus.exclusive" that violates the
sibling exclusivity rule will be rejected. This new control files has
no effect on the behavior of the cpuset until it turns into a partition
root. At that point, its effective CPUs will be set to its exclusive
CPUs unless some of them are offline.

This patch series also introduces a new category of cpuset partition
called remote partitions. The existing partition category where the
partition roots have to be clustered around the root cgroup in a
hierarchical way is now referred to as local partitions.

A remote partition can be formed far from the root cgroup with no
partition root parent. While local partitions can be created without
touching "cpuset.cpus.exclusive" as it can be set automatically
if a cpuset becomes a local partition root. Properly setting
"cpuset.cpus.exclusive" values down the hierarchy are required to create
a remote partition.

Both scheduling and isolated partitions can be formed as a remote
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

Waiman Long (6):
  cgroup/cpuset: Add cpuset.cpus.exclusive.effective for v2
  cgroup/cpuset: Add cpuset.cpus.exclusive for v2
  cgroup/cpuset: Introduce remote partition
  cgroup/cpuset: Check partition conflict with housekeeping setup
  cgroup/cpuset: Documentation update for partition
  cgroup/cpuset: Extend test_cpuset_prs.sh to test remote partition

 Documentation/admin-guide/cgroup-v2.rst       |  123 +-
 kernel/cgroup/cpuset.c                        | 1253 ++++++++++++-----
 .../selftests/cgroup/test_cpuset_prs.sh       |  431 ++++--
 3 files changed, 1317 insertions(+), 490 deletions(-)

-- 
2.31.1

