Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095781AD3F0
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2020 03:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgDQBGm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Apr 2020 21:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728466AbgDQBGm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 16 Apr 2020 21:06:42 -0400
Received: from kicinski-fedora-PC1C0HJN.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0880F20776;
        Fri, 17 Apr 2020 01:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587085602;
        bh=9icVWG0gyR32riSUJgQiR5peqCOVsPBMCFCA6dSTpKI=;
        h=From:To:Cc:Subject:Date:From;
        b=rrhl/gVzXRUQQkLm+GhPI4UHgVoR7wYFRawXF5o2ZeJmR3zDNAIop5lCMmX8vZ22M
         ElbQdQ5QnlHD115XAZPvpp1vk61hzWyCFdgQI89NY2yH08GCI8hBMqe+L8e7xSOT9F
         xBFB/XbiA2cH0d6/wgn9BHzm4JljBWgUuQoOa/Mg=
From:   Jakub Kicinski <kuba@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, kernel-team@fb.com, tj@kernel.org,
        hannes@cmpxchg.org, chris@chrisdown.name, cgroups@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 0/3] memcg: Slow down swap allocation as the available space gets depleted
Date:   Thu, 16 Apr 2020 18:06:14 -0700
Message-Id: <20200417010617.927266-1-kuba@kernel.org>
X-Mailer: git-send-email 2.25.2
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

Solve this by adapting the same approach that memory.high uses -
slow down allocation as the resource gets depleted turning the
depletion behavior from abrupt cliff one to gradual degradation
observable through memory pressure metric.

[1] https://github.com/facebookincubator/oomd

Jakub Kicinski (3):
  mm: prepare for swap over-high accounting and penalty calculation
  mm: move penalty delay clamping out of calculate_high_delay()
  mm: automatically penalize tasks with high swap use

 include/linux/memcontrol.h |   4 +
 mm/memcontrol.c            | 166 ++++++++++++++++++++++++++++---------
 2 files changed, 131 insertions(+), 39 deletions(-)

-- 
2.25.2

