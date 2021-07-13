Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E451B3C67DC
	for <lists+cgroups@lfdr.de>; Tue, 13 Jul 2021 03:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhGMBM2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Jul 2021 21:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbhGMBM2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Jul 2021 21:12:28 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F59BC0613E9
        for <cgroups@vger.kernel.org>; Mon, 12 Jul 2021 18:09:39 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w13-20020ac843cd0000b0290251f0b91196so6452686qtn.14
        for <cgroups@vger.kernel.org>; Mon, 12 Jul 2021 18:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cfXnc9Zc9o3ptZPRnTFsvWMpDY8BWRepBXZRyd5PlI0=;
        b=LimyZz27wI/KGrLZPTZiNvhL9etIS58Jg/XdTXPk3yRn/TVtwaCz9ycSaaCZCAn+9P
         ecOlZ7hM5JZhxPntRzEJg/VyzOmlbwUKPLC9aO06yllP5E3C2Th0ozf6YGWocP+khU4y
         LfWv6uNsrBNqs6aYot1LAuVc0W5dt6mTzRO4uE2ktOlDX0PiSgtHa9LJAQFGgP3dTNfj
         769TSyYWXBZHgWDaT40b5MWC0W+Tj6VF6X7bNFW11r/DDnsXrY0zowiYhRiwWpl05jZY
         36wKV9FlWI6cDJl+6BPOr5h0YTfYX6IYecWZAMFPOami47wLYBmcdcxetkUa3kEx9fwI
         qekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cfXnc9Zc9o3ptZPRnTFsvWMpDY8BWRepBXZRyd5PlI0=;
        b=AogXgV/psZHU3vghznoYfsk4u8VFzjs/S1FHH2ACeX8gFlRszzbtp+ANbv1bLsAcIW
         bP4du9dSd45cx2DwKnot26k/hWkCmgRPCbFoZpdBEu/KkOJidW8hEZddpp/WvwgzSiNI
         UPv7KiKRjelhsEerUUKgKvVCkntMrk0APDSKm+6D9BZ2X5wIihGsvpeO5IhsjCZsMCxM
         vcCtwfoOsiRbwQRyehVpl2+Bt2MG4lpPHmU5OmvDUib8IIMw2822rYoZrN4sa/Js95cb
         S9Dng/7hg1O/jCpFBVjm9N69p5BDCJMCFuON5VOpnR0ri3Qv7oFcIDDOJixP+52tWqmB
         OKGg==
X-Gm-Message-State: AOAM530QIFHQ6YwFRVszptkfFbMApUQAVL9Lz7Qvee0ZBU9crEfJhJlE
        fXfTwOgW1j6ZtX0HuDOotryR5ugY+QQ=
X-Google-Smtp-Source: ABdhPJzSrZINmqW/6pCJgBY7HBjZ1f77ueR8ZPkCRIRns7EI7lDYTzBjY50uw7j5/MFPmcU5BYqYQz7sHMo=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:2a5a:e173:9576:794e])
 (user=surenb job=sendgmr) by 2002:a05:6214:e4e:: with SMTP id
 o14mr2249847qvc.46.1626138578201; Mon, 12 Jul 2021 18:09:38 -0700 (PDT)
Date:   Mon, 12 Jul 2021 18:09:32 -0700
Message-Id: <20210713010934.299876-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v4 1/3] mm, memcg: add mem_cgroup_disabled checks in
 vmpressure and swap-related functions
From:   Suren Baghdasaryan <surenb@google.com>
To:     tj@kernel.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, mhocko@suse.com,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        shakeelb@google.com, guro@fb.com, songmuchun@bytedance.com,
        shy828301@gmail.com, alexs@kernel.org, richard.weiyang@gmail.com,
        vbabka@suse.cz, axboe@kernel.dk, iamjoonsoo.kim@lge.com,
        david@redhat.com, willy@infradead.org, apopple@nvidia.com,
        minchan@kernel.org, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add mem_cgroup_disabled check in vmpressure, mem_cgroup_uncharge_swap and
cgroup_throttle_swaprate functions. This minimizes the memcg overhead in
the pagefault and exit_mmap paths when memcgs are disabled using
cgroup_disable=memory command-line option.
This change results in ~2.1% overhead reduction when running PFT test [1]
comparing {CONFIG_MEMCG=n, CONFIG_MEMCG_SWAP=n} against {CONFIG_MEMCG=y,
CONFIG_MEMCG_SWAP=y, cgroup_disable=memory} configuration on an 8-core
ARM64 Android device.

[1] https://lkml.org/lkml/2006/8/29/294 also used in mmtests suite

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 3 +++
 mm/swapfile.c   | 3 +++
 mm/vmpressure.c | 7 ++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ae1f5d0cb581..a228cd51c4bd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7305,6 +7305,9 @@ void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	struct mem_cgroup *memcg;
 	unsigned short id;
 
+	if (mem_cgroup_disabled())
+		return;
+
 	id = swap_cgroup_record(entry, 0, nr_pages);
 	rcu_read_lock();
 	memcg = mem_cgroup_from_id(id);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1e07d1c776f2..707fa0481bb4 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3778,6 +3778,9 @@ void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
 	struct swap_info_struct *si, *next;
 	int nid = page_to_nid(page);
 
+	if (mem_cgroup_disabled())
+		return;
+
 	if (!(gfp_mask & __GFP_IO))
 		return;
 
diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index d69019fc3789..9b172561fded 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -240,7 +240,12 @@ static void vmpressure_work_fn(struct work_struct *work)
 void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 		unsigned long scanned, unsigned long reclaimed)
 {
-	struct vmpressure *vmpr = memcg_to_vmpressure(memcg);
+	struct vmpressure *vmpr;
+
+	if (mem_cgroup_disabled())
+		return;
+
+	vmpr = memcg_to_vmpressure(memcg);
 
 	/*
 	 * Here we only want to account pressure that userland is able to
-- 
2.32.0.93.g670b81a890-goog

