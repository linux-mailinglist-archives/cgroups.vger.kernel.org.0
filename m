Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BED0A8768
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2019 21:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfIDNxM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Sep 2019 09:53:12 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:59224 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726304AbfIDNxM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Sep 2019 09:53:12 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 5723E2E1AF9;
        Wed,  4 Sep 2019 16:53:09 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id VODvC8jeNf-r9Nu2Lhc;
        Wed, 04 Sep 2019 16:53:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1567605189; bh=9NG/dDnFeKeZHp7gq4Bt3jk12l8IcLQ6rwdO1YD1xvQ=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=Ai2bzEbJdK+baGdRKLO3SHZG+trevrPdYggz78BEbE91uKDRhP/r9odOJkZ2Dga3G
         FRTz0fb1uTJTZwcwqMnA44/U1x/ocUIpHSlF7wqoKjKBtWlvjg/cs2pLxaO+QAOYKF
         ZnbqrmTnFEbaAXSvZhbTEvvJhjBU5YXvFV3SbSTs=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:c142:79c2:9d86:677a])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id qxrH47Cxp8-r8D0XNmB;
        Wed, 04 Sep 2019 16:53:09 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v1 0/7] mm/memcontrol: recharge mlocked pages
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Wed, 04 Sep 2019 16:53:08 +0300
Message-ID: <156760509382.6560.17364256340940314860.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently mlock keeps pages in cgroups where they were accounted.
This way one container could affect another if they share file cache.
Typical case is writing (downloading) file in one container and then
locking in another. After that first container cannot get rid of cache.
Also removed cgroup stays pinned by these mlocked pages.

This patchset implements recharging pages to cgroup of mlock user.

There are three cases:
* recharging at first mlock
* recharging at munlock to any remaining mlock
* recharging at 'culling' in reclaimer to any existing mlock

To keep things simple recharging ignores memory limit. After that memory
usage temporary could be higher than limit but cgroup will reclaim memory
later or trigger oom, which is valid outcome when somebody mlock too much.

---

Konstantin Khlebnikov (7):
      mm/memcontrol: move locking page out of mem_cgroup_move_account
      mm/memcontrol: add mem_cgroup_recharge
      mm/mlock: add vma argument for mlock_vma_page()
      mm/mlock: recharge memory accounting to first mlock user
      mm/mlock: recharge memory accounting to second mlock user at munlock
      mm/vmscan: allow changing page memory cgroup during reclaim
      mm/mlock: recharge mlocked pages at culling by vmscan


 Documentation/admin-guide/cgroup-v1/memory.rst |    5 +
 include/linux/memcontrol.h                     |    9 ++
 include/linux/rmap.h                           |    3 -
 mm/gup.c                                       |    2 
 mm/huge_memory.c                               |    4 -
 mm/internal.h                                  |    6 +
 mm/ksm.c                                       |    2 
 mm/memcontrol.c                                |  104 ++++++++++++++++--------
 mm/migrate.c                                   |    2 
 mm/mlock.c                                     |   14 +++
 mm/rmap.c                                      |    5 +
 mm/vmscan.c                                    |   17 ++--
 12 files changed, 121 insertions(+), 52 deletions(-)

--
Signature
