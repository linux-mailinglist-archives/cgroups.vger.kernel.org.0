Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCBF792813
	for <lists+cgroups@lfdr.de>; Tue,  5 Sep 2023 18:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349660AbjIEQWH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Sep 2023 12:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354679AbjIENdi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Sep 2023 09:33:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AD2191
        for <cgroups@vger.kernel.org>; Tue,  5 Sep 2023 06:32:55 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-sN58GK3pOoCccjSxOJpMLQ-1; Tue, 05 Sep 2023 09:32:51 -0400
X-MC-Unique: sN58GK3pOoCccjSxOJpMLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C60B23811F3A;
        Tue,  5 Sep 2023 13:32:50 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A16D20BAE72;
        Tue,  5 Sep 2023 13:32:50 +0000 (UTC)
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
Subject: [PATCH v8 0/7] cgroup/cpuset: Support remote partitions
Date:   Tue,  5 Sep 2023 09:32:36 -0400
Message-Id: <20230905133243.91107-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

 v8:
  - Add a new patch 1 to fix a load balance state problem.
  - Add new test cases to the test script and fixes some bugs in error
    handling.

 v7:
  - https://lore.kernel.org/lkml/d0380dfa-ee2e-e492-38e3-31bf6644e511@redhat.com/
  - Fix a compilation problem in patch 1 & a memory allocation bug in
    patch 2.
  - Change exclusive_cpus type to cpumask_var_t to match other cpumasks
    and make code more consistent.

 v6:
  - https://lore.kernel.org/lkml/20230713172601.3285847-1-longman@redhat.com/
  - Add another read-only cpuset.cpus.exclusive.effective control file
    to expose the effective set of exclusive CPUs.
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

Waiman Long (7):
  cgroup/cpuset: Fix load balance state in update_partition_sd_lb()
  cgroup/cpuset: Add cpuset.cpus.exclusive.effective for v2
  cgroup/cpuset: Add cpuset.cpus.exclusive for v2
  cgroup/cpuset: Introduce remote partition
  cgroup/cpuset: Check partition conflict with housekeeping setup
  cgroup/cpuset: Documentation update for partition
  cgroup/cpuset: Extend test_cpuset_prs.sh to test remote partition

 Documentation/admin-guide/cgroup-v2.rst       |  123 +-
 kernel/cgroup/cpuset.c                        | 1279 ++++++++++++-----
 .../selftests/cgroup/test_cpuset_prs.sh       |  458 ++++--
 3 files changed, 1366 insertions(+), 494 deletions(-)

-- 
2.31.1

