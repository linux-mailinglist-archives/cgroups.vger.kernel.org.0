Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD227652632
	for <lists+cgroups@lfdr.de>; Tue, 20 Dec 2022 19:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLTS2H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Dec 2022 13:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLTS2F (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Dec 2022 13:28:05 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1172FCE07;
        Tue, 20 Dec 2022 10:28:03 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671560881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fg7QsgWuG0CK6tIt3L6718+/M9y6wWUM/N8cNALh9TI=;
        b=ZHVNnOLpMF+Ywc7fWfYrtgEJG7ECKPNcowJh37ZPNcPXh37spKjvpph0drQIetn8FffIYU
        3uVakPqt+fudCFRJgjA5Fx+RTpdJ6Rc4DVHwgYHe6JVo6Dnq6hLyjc7+8HKqabHCxkpipV
        D0OC2p5gt02s6fn4ps0pVPWnG7XrepY=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     linux-mm@kvack.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH RFC 0/2] mm: kmem: optimize obj_cgroup pointer retrieval
Date:   Tue, 20 Dec 2022 10:27:43 -0800
Message-Id: <20221220182745.1903540-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patchset improves the performance of get_obj_cgroup_from_current(), which
is used to get an objcg pointer on the kernel memory allocation fast path.

Results (1M 8-bytes accounted allocations):

| version         | accounted (us) | delta | unaccounted (us) |  delta |
|-----------------+----------------+-------+------------------+--------|
| baseline (6.1+) |          81042 |       |            45269 |        |
| patch 1         |          78756 | -2.8% |            42731 |  -5.6% |
| patch 2         |          73650 | -9.1% |            30662 | -32.3% |

Unaccounted allocations were performed from a user's task belonging to
the root cgroup, so savings are particularly large because previously
the root_mem_cgroup pointer was obtained first just to learn that it's
corresponding objcg is NULL.


Roman Gushchin (2):
  mm: kmem: optimize get_obj_cgroup_from_current()
  mm: kmem: add direct objcg pointer to task_struct

 include/linux/sched.h |   4 ++
 mm/memcontrol.c       | 102 ++++++++++++++++++++++++++++++++----------
 2 files changed, 83 insertions(+), 23 deletions(-)

-- 
2.39.0

