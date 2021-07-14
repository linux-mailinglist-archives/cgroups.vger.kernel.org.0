Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D583C85A1
	for <lists+cgroups@lfdr.de>; Wed, 14 Jul 2021 15:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhGNN5U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Jul 2021 09:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231941AbhGNN5T (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 14 Jul 2021 09:57:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 716BC61396;
        Wed, 14 Jul 2021 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626270868;
        bh=qo7KUgteHWgNW47PtvyntjuZc5d4R6Q5Gt3N6bWyOgg=;
        h=From:To:Cc:Subject:Date:From;
        b=mgmLYjetbD+nFD278pzf58PemKwKBbEln0f5LV64/cJhVlvRpwshWdfc3rZcShJMi
         AJW8XozOc6wG7qUL3ZNiH0wexMsBmIGNdPHPG1iUGwlGvfgZU8D3xurTy+7eIL9X7B
         Ur5dETD9ECBThjXubHgzRC/2OjZFSQeK8jiRufcJt5ZcYF0HDVu7w3CHDAlr7y5V5G
         pjcUia56+zfR28SarXGXbqU7RvoeYJDX5q7DuefA6WF4B/db+TxLE553nC4DmPy2f0
         JMvJNT+qoxHZqwxeQUvPEspKvPVQ5BueQxr0xyB1ItaLThRgmzHeYMRRBnxHIYZIRE
         Jwhq8fisPorXA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: [RFC PATCH 0/6] cpuset: Allow to modify isolcpus through cpuset
Date:   Wed, 14 Jul 2021 15:54:14 +0200
Message-Id: <20210714135420.69624-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The fact that "isolcpus=" behaviour can't be modified at runtime is an
eternal source of discussion and debate opposing a useful feature against
a terrible interface.

I've long since tried to figure out a proper way to control this at
runtime using cpusets, which isn't easy as a boot time single cpumask
is difficult to map to a hierarchy of cpusets that can even overlap.

The idea here is to map the boot-set isolation behaviour to any cpuset
directory whose cpumask is a subset of "isolcpus=". I let you browse
for details on the last patch.

Note this is still WIP and half-baked, but I figured it's important to
validate the interface early.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	cpuset/isolation

HEAD: 6d3dba1115b7ea464febf3763244c783e87c7baf

Thanks,
	Frederic
---

Frederic Weisbecker (6):
      pci: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
      workqueue: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
      net: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
      sched/isolation: Split domain housekeeping mask from the rest
      sched/isolation: Make HK_FLAG_DOMAIN mutable
      cpuset: Add cpuset.isolation_mask file


 drivers/pci/pci-driver.c        |  21 ++++++--
 include/linux/sched/isolation.h |   4 ++
 kernel/cgroup/cpuset.c          | 111 ++++++++++++++++++++++++++++++++++++++--
 kernel/sched/isolation.c        |  73 ++++++++++++++++++++++----
 kernel/workqueue.c              |   4 +-
 net/core/net-sysfs.c            |   6 +--
 6 files changed, 196 insertions(+), 23 deletions(-)
