Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766851E4EB2
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2020 21:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgE0T6t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 May 2020 15:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgE0T6t (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 27 May 2020 15:58:49 -0400
Received: from kicinski-fedora-PC1C0HJN.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E5D620835;
        Wed, 27 May 2020 19:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590609529;
        bh=cceq0nslNmPBHRGNvAoKjcHO4wn3WWeH8aZ2B6tbH7E=;
        h=From:To:Cc:Subject:Date:From;
        b=vsS3GJQY+3GrTaTAyo2NBKB3ea2HqlQR2dkWOfILWtaR4A+ZpBr3yneZCZEF9Hv2z
         sx4UHToiQuGHNRbjtIN2L6mteYz2c4iX5C3zYKGiE4pDoX4gJRdt13QfD9+GktJbsA
         OXmFO+iwSCBivypAZJPtHqhtl6PPsK8yVcKgvUVg=
From:   Jakub Kicinski <kuba@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, kernel-team@fb.com, tj@kernel.org,
        hannes@cmpxchg.org, chris@chrisdown.name, cgroups@vger.kernel.org,
        shakeelb@google.com, mhocko@kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH mm v6 0/4] memcg: Slow down swap allocation as the available space gets depleted
Date:   Wed, 27 May 2020 12:58:42 -0700
Message-Id: <20200527195846.102707-1-kuba@kernel.org>
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

v5: https://lore.kernel.org/linux-mm/20200521002411.3963032-1-kuba@kernel.org/
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
 include/linux/page_counter.h            |   8 ++
 mm/memcontrol.c                         | 177 ++++++++++++++++++------
 4 files changed, 160 insertions(+), 49 deletions(-)

-- 
2.25.4

