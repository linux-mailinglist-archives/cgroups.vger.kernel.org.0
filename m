Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8129A1CE894
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2020 00:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgEKWza (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 May 2020 18:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgEKWza (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 11 May 2020 18:55:30 -0400
Received: from kicinski-fedora-PC1C0HJN.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBAE3206CC;
        Mon, 11 May 2020 22:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589237730;
        bh=pxjZnopLEhvVuE+hwn+nFyI+Zvw/0BY6mIaM+QZzV7A=;
        h=From:To:Cc:Subject:Date:From;
        b=DBRJCAly+tHOgZNaQm1yXJo14p3rpfNMkFGOf/JTiwFC8KbCSIDuK+9NMQxg1l1db
         4n9EbIX9vjTGND0oaWj7Dv3rRevFAGRUoKVbP/3+fdsPCYOT3Qpf+I4c6kW1Zw3wYi
         3uWV3g5tnzxSHDPldQgRgoZeKEb2DI88HJJ0u/kk=
From:   Jakub Kicinski <kuba@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, kernel-team@fb.com, tj@kernel.org,
        hannes@cmpxchg.org, chris@chrisdown.name, cgroups@vger.kernel.org,
        shakeelb@google.com, mhocko@kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH mm v2 0/3] memcg: Slow down swap allocation as the available space gets depleted
Date:   Mon, 11 May 2020 15:55:13 -0700
Message-Id: <20200511225516.2431921-1-kuba@kernel.org>
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

v1: https://lore.kernel.org/linux-mm/20200417010617.927266-1-kuba@kernel.org/

Jakub Kicinski (3):
  mm: prepare for swap over-high accounting and penalty calculation
  mm: move penalty delay clamping out of calculate_high_delay()
  mm: automatically penalize tasks with high swap use

 Documentation/admin-guide/cgroup-v2.rst |  16 +++
 include/linux/memcontrol.h              |   4 +
 mm/memcontrol.c                         | 166 ++++++++++++++++++------
 3 files changed, 147 insertions(+), 39 deletions(-)

-- 
2.25.4

