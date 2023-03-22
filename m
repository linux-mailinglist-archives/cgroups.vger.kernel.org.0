Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4586C4CA5
	for <lists+cgroups@lfdr.de>; Wed, 22 Mar 2023 15:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCVOAN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Mar 2023 10:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCVOAM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Mar 2023 10:00:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4735626B1;
        Wed, 22 Mar 2023 07:00:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D91B24B3;
        Wed, 22 Mar 2023 07:00:52 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 42C033F71E;
        Wed, 22 Mar 2023 07:00:06 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Qais Yousef <qyousef@layalina.io>, Wei Wang <wvw@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [RFC PATCH 0/2] sched/cpuset: Fix DL BW accounting in case can_attach() fails
Date:   Wed, 22 Mar 2023 14:59:57 +0100
Message-Id: <20230322135959.1998790-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

I followed Longman's idea to add a `deadline task transfer count` into
cpuset and only update the `dl task count` in cpuset_attach().

Moreover, I switched from per-task DL BW request to a per-cpuset one.
This way we don't have to free per-task in case xxx_can_attach() fails.

The DL BW freeing is handled in cpuset_cancel_attach() for the case
`multiple controllers and one of the non-cpuset can_attach() fails`.

Only lightly tested on cgroup v1 with exclusive cpusets so far.

Dietmar Eggemann (2):
  sched/deadline: Create DL BW alloc, free & check overflow interface
  cgroup/cpuset: Free DL BW in case can_attach() fails

 include/linux/sched.h   |  4 ++-
 kernel/cgroup/cpuset.c  | 55 +++++++++++++++++++++++++++++++++++++----
 kernel/sched/core.c     | 19 +++-----------
 kernel/sched/deadline.c | 53 +++++++++++++++++++++++++++++----------
 kernel/sched/sched.h    |  2 +-
 5 files changed, 97 insertions(+), 36 deletions(-)

-- 
2.25.1

