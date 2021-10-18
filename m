Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BF1431FE1
	for <lists+cgroups@lfdr.de>; Mon, 18 Oct 2021 16:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhJROjU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 10:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231736AbhJROjT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Oct 2021 10:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634567828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ng7Ch+ziTcXFMqpWwHpxE3VZVmB5z0SGbNUXf+BTCIE=;
        b=aqusNoshNtQkoQ9udO8nZrfeb1VTQEoMF/E9i8WM0kyAXR/lkUwgmZZN2Lg7Rerlc9KW24
        6ia3Vs8d8M9d/4rYxO+meqMsspZKxVtciEo+9yzq+GLKwEP1Uv+UNyQm/vpPCJeOGK9GkC
        0f3YGrp0TYul4HgechSkZVL+268cs1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-ipjXnTKoOA6L-Qk9B6HtqA-1; Mon, 18 Oct 2021 10:37:04 -0400
X-MC-Unique: ipjXnTKoOA6L-Qk9B6HtqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 942E5801B1C;
        Mon, 18 Oct 2021 14:37:02 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7A595F4EE;
        Mon, 18 Oct 2021 14:36:32 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v8 0/6] cgroup/cpuset: Add new cpuset partition type & empty effecitve cpus
Date:   Mon, 18 Oct 2021 10:36:13 -0400
Message-Id: <20211018143619.205065-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

v8:
 - Reorganize the patch series and rationalize the features and
   constraints of a partition.
 - Update patch descriptions and documentation accordingly.

v7:
 - Simplify the documentation patch (patch 5) as suggested by Tejun.
 - Fix a typo in patch 2 and improper commit log in patch 3.

v6:
 - Remove duplicated tmpmask from update_prstate() which should fix the
   frame size too large problem reported by kernel test robot.

This patchset makes four enhancements to the cpuset v2 code.

 Patch 1: Enable partition with no task to have empty cpuset.cpus.effective.

 Patch 2: Refining the features and constraints of a cpuset partition
 clarifying what changes are allowed.

 Patch 3: Add a new partition state "isolated" to create a partition
 root without load balancing. This is for handling intermitten workloads
 that have a strict low latency requirement.

 Patch 4: Enable the "cpuset.cpus.partition" file to show the reason
 that causes invalid partition like "root invalid (No cpu available
 due to hotplug)".

Patch 5 updates the cgroup-v2.rst file accordingly. Patch 6 adds a new
cpuset test to test the new cpuset partition code.

Waiman Long (6):
  cgroup/cpuset: Allow no-task partition to have empty
    cpuset.cpus.effective
  cgroup/cpuset: Refining features and constraints of a partition
  cgroup/cpuset: Add a new isolated cpus.partition type
  cgroup/cpuset: Show invalid partition reason string
  cgroup/cpuset: Update description of cpuset.cpus.partition in
    cgroup-v2.rst
  kselftest/cgroup: Add cpuset v2 partition root state test

 Documentation/admin-guide/cgroup-v2.rst       | 153 ++--
 kernel/cgroup/cpuset.c                        | 393 +++++++----
 tools/testing/selftests/cgroup/Makefile       |   5 +-
 .../selftests/cgroup/test_cpuset_prs.sh       | 664 ++++++++++++++++++
 tools/testing/selftests/cgroup/wait_inotify.c |  87 +++
 5 files changed, 1115 insertions(+), 187 deletions(-)
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_prs.sh
 create mode 100644 tools/testing/selftests/cgroup/wait_inotify.c

-- 
2.27.0

