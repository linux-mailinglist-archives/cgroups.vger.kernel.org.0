Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1A7CD7A55
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2019 17:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfJOPqx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Oct 2019 11:46:53 -0400
Received: from foss.arm.com ([217.140.110.172]:41380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfJOPqx (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 15 Oct 2019 11:46:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 195D428;
        Tue, 15 Oct 2019 08:46:53 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 76F613F68E;
        Tue, 15 Oct 2019 08:46:51 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc:     lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org,
        mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com
Subject: [PATCH v3 0/2] sched/topology: Asymmetric topologies fixes
Date:   Tue, 15 Oct 2019 16:42:48 +0100
Message-Id: <20191015154250.12951-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

I got a nice splat while testing out the toggling of
sched_asym_cpucapacity, so this gets a new patch.

Details are in the logs.

v2 changes:
  - Use static_branch_{inc,dec} rather than enable/disable

v3 changes:
  - New patch: add fix for empty cpumap in sched domain rebuild
  - Move static_branch_dec outside of RCU read-side section (Quentin)

Cheers,
Valentin

Valentin Schneider (2):
  sched/topology: Don't try to build empty sched domains
  sched/topology: Allow sched_asym_cpucapacity to be disabled

 kernel/cgroup/cpuset.c  |  8 ++++++++
 kernel/sched/topology.c | 11 +++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

--
2.22.0

