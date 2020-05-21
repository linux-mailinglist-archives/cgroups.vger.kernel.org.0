Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19A11DC384
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 02:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgEUAYO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 May 2020 20:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgEUAYN (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 20 May 2020 20:24:13 -0400
Received: from kicinski-fedora-PC1C0HJN.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E93A4205CB;
        Thu, 21 May 2020 00:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590020653;
        bh=r26NeydsvNDo55OBvB+GRlrsWehpCNCiQH47D4WF37M=;
        h=From:To:Cc:Subject:Date:From;
        b=GQNnHwPtg8zXtbzzPUnjPDjlbfA0czbdFy3P2AhAC8K8Ygy2Zmv+eGoMcAvs5jblY
         QcYg1Vofkyu3lDqCksWdExWtf4rCFUsmT8Gsm8dicjg7552Q1j7qJgYuGSQRJ/HL95
         MUjz05KReeGbHuaN5kWRn4qZ5XJiIaUkTiLqKF+g=
From:   Jakub Kicinski <kuba@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, kernel-team@fb.com, tj@kernel.org,
        hannes@cmpxchg.org, chris@chrisdown.name, cgroups@vger.kernel.org,
        shakeelb@google.com, mhocko@kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH mm v5 RESEND 0/4] memcg: Slow down swap allocation as the available space gets depleted
Date:   Wed, 20 May 2020 17:24:07 -0700
Message-Id: <20200521002411.3963032-1-kuba@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Tejun describes the problem as follows:

When swap runs out, there's an abrupt change in system behavior -
the anonymous memory suddenly becomes unmanageable which readily
breaks any sort of memory isolation and can bring down the whole
system. To avoid that, oomd [1] monitors free swap space and triggers
kills when it drops below the specific threshold (e.g. 15%).

While this works, it's far from ideal:
 - Depending on IO performance and total swap size, a given
   headroom might not be enough or too much.
 - oomd has to monitor swap depletion in addition to the usual
   pressure metrics and it currently doesn't consider memory.swap.max.

Solve this by adapting parts of the approach that memory.high uses -
slow down allocation as the resource gets depleted turning the
depletion behavior from abrupt cliff one to gradual degradation
observable through memory pressure metric.

[1] https://github.com/facebookincubator/oomd

v4: https://lore.kernel.org/linux-mm/20200519171938.3569605-1-kuba@kernel.org/
v3: https://lore.kernel.org/linux-mm/20200515202027.3217470-1-kuba@kernel.org/
v2: https://lore.kernel.org/linux-mm/20200511225516.2431921-1-kuba@kernel.org/
v1: https://lore.kernel.org/linux-mm/20200417010617.927266-1-kuba@kernel.org/

Jakub Kicinski (4):
  mm: prepare for swap over-high accounting and penalty calculation
  mm: move penalty delay clamping out of calculate_high_delay()
  mm: move cgroup high memory limit setting into struct page_counter
  mm: automatically penalize tasks with high swap use

 Documentation/admin-guide/cgroup-v2.rst |  20 +++
 include/linux/memcontrol.h              |   4 +-
 include/linux/page_counter.h            |  13 ++
 mm/memcontrol.c                         | 173 +++++++++++++++++-------
 4 files changed, 161 insertions(+), 49 deletions(-)

-- 
2.25.4

