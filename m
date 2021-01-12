Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2FD2F34C1
	for <lists+cgroups@lfdr.de>; Tue, 12 Jan 2021 16:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392028AbhALPzg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Jan 2021 10:55:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33011 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392448AbhALPzf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Jan 2021 10:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610466849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KyiMZR0vfJuhbR4RIu5PNgEE9Brtz8v0SzJO9Fvad9w=;
        b=cUs3/cVdpPmgGxaqSok7JgXi35Se7p4HMBIqFnUZjoSJe+a1FUkEWHjaZDLlkMG9cRADh0
        qHWyXm6m0BV6mXMjq6YVKrkUmpfj97AWGarRNd0s455oSctHsZMaZbFUX8iCrjhgS3vwaL
        4SPrUtTXZ9UQftbm6vUH2IBkofmLReA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-Hcim-w0ZML6BijZTwQQgQg-1; Tue, 12 Jan 2021 10:54:05 -0500
X-MC-Unique: Hcim-w0ZML6BijZTwQQgQg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15B5418C89C4;
        Tue, 12 Jan 2021 15:54:03 +0000 (UTC)
Received: from x1.com (ovpn-113-251.rdu2.redhat.com [10.10.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2B1A5D9CD;
        Tue, 12 Jan 2021 15:53:50 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marco Perronet <perronet@mpi-sws.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        cgroups@vger.kernel.org
Subject: [PATCH 0/6] sched/deadline: cpuset task acceptance review
Date:   Tue, 12 Jan 2021 16:53:39 +0100
Message-Id: <cover.1610463999.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

While surveying the properties of the SCHED_DEADLINE, Marco Perronet found some
inconsistencies in the acceptance of DL threads on cpuset. More precisely,
regarding the acceptance of treads with arbitrary affinity. He contacted me,
and while doing the investigation, we found yet other potential issues
addressed in this patch series.

Each patch has a more in-depth explanation, including ways to reproduce
the problem. 

Daniel Bristot de Oliveira (6):
  sched/deadline: Consolidate the SCHED_DL task_can_attach() check on
    its own function
  sched/deadline: Inform dl_task_can_attach() if the cpuset is exclusive
  sched/deadline: Allow DL tasks on empty (cgroup v2) cpusets
  sched/deadline: Block DL tasks on non-exclusive cpuset if bandwitdh
    control is enable
  sched/deadline: Add helpers to get the correct root domain/span/dl_bw
  sched/deadline: Fixes cpu/rd/dl_bw references for suspended tasks

 include/linux/sched.h   |  2 +-
 kernel/cgroup/cpuset.c  |  5 ++++-
 kernel/sched/core.c     | 13 ++++++------
 kernel/sched/deadline.c | 28 ++++++++++++++++++++++---
 kernel/sched/sched.h    | 45 ++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 80 insertions(+), 13 deletions(-)

-- 
2.29.2

