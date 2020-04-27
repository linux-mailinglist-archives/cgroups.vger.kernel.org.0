Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19521BB239
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2020 01:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgD0X4v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Apr 2020 19:56:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27038 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726318AbgD0X4t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Apr 2020 19:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588031808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=xqSYkkiN5zo6A8A9R6SrdTZLgFG5Vtd3h0pL6NAIaDM=;
        b=fgb9lB1QQNEMwkcUFnXDzgRvoRAfWRK/iBUfLwBhGt3j5X6xnfvCop8JS6A7+C5vkvfyfe
        HMh4jtH9av+fLOj0VdGBe7xtpvVhDeearTgP78q+wg+HsybkT/snufRIy5NPtHiitcP3aR
        xFIcIKJKn4P3xbvo/eoXtbUoqIpDXCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-YS63Xv_VM8-Rn4F-pZDCCA-1; Mon, 27 Apr 2020 19:56:44 -0400
X-MC-Unique: YS63Xv_VM8-Rn4F-pZDCCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BEC6107ACCA;
        Mon, 27 Apr 2020 23:56:42 +0000 (UTC)
Received: from llong.com (ovpn-112-176.rdu2.redhat.com [10.10.112.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56F7760BE2;
        Mon, 27 Apr 2020 23:56:33 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Qian Cai <cai@lca.pw>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/4] mm/slub: Fix sysfs circular locking dependency
Date:   Mon, 27 Apr 2020 19:56:17 -0400
Message-Id: <20200427235621.7823-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

v2:
 - Use regular cmpxchg() instead of x86-only try_cmpxchg() in patch 2.
 - Add patches 3 and 4 to fix circular locking dependency showing up
   at shutdown time.

With lockdep enabled, issuing the following command to the slub sysfs
files will cause splat about circular locking dependency to show up
either immediately afterwards or at shutdown time.

 # echo 1 > validate
 # echo 1 > shrink

This patchset fixes these lockdep splats by replacing slab_mutex with
memcg_cache_ids_sem as well as changing some of the lock operations
with trylock.

Waiman Long (4):
  mm, slab: Revert "extend slab/shrink to shrink all memcg caches"
  mm/slub: Fix slab_mutex circular locking problem in slab_attr_store()
  mm/slub: Fix another circular locking dependency in slab_attr_store()
  mm/slub: Fix sysfs shrink circular locking dependency

 include/linux/memcontrol.h     |  1 +
 include/linux/memory_hotplug.h |  2 +
 mm/memcontrol.c                |  5 ++
 mm/memory_hotplug.c            |  5 ++
 mm/slab.h                      |  1 -
 mm/slab_common.c               | 37 -------------
 mm/slub.c                      | 98 +++++++++++++++++++++++++++++-----
 7 files changed, 99 insertions(+), 50 deletions(-)

-- 
2.18.1

