Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70483C2C17
	for <lists+cgroups@lfdr.de>; Sat, 10 Jul 2021 02:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhGJAjQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Jul 2021 20:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhGJAjP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Jul 2021 20:39:15 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58448C0613E5
        for <cgroups@vger.kernel.org>; Fri,  9 Jul 2021 17:36:31 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z1-20020a0cfec10000b02902dbb4e0a8f2so2072433qvs.6
        for <cgroups@vger.kernel.org>; Fri, 09 Jul 2021 17:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZSFxQqEllnhgQqgVGWhX1TPVzgfo+pOEQxzVXUrGXrk=;
        b=sAc/7ecFZP5kXA30C5YZ8xkXOBRQdtm2F5t0/CXgWYYABwvtTUr/VKqm/I/gky0Rq8
         WveSgzFU18PV2ZevoAP+ectWUbltAEfoTlMnhaj/RjMSDDPfpZ4P36rsnHFI1zv7oHT5
         AuepZM6oeCMBUm0kxEG65nYNsEVn3AIOnXyEHJ7TlLkF0Z2Vb6FULt+zS/JoVFNTjHhe
         1ArC5OTnPtacdAyffJBWyYYjx3lrCgZGjp9uK/zuiR0Kc7YDoaBa1Pp5MdKA040qqPX/
         7N0i9ZQTB556jwAN+CJxb8G/iCx2WwlA9F25zL7moMckGy85MVe2PxoqJBl/9kj8Oe47
         2Qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZSFxQqEllnhgQqgVGWhX1TPVzgfo+pOEQxzVXUrGXrk=;
        b=eltbeIltPhYEimns//AgT2Tw1bD/p17U8pePHzKGz0bteX8XQgJDuoNb02/5yWZ3YN
         vUr6xD51yze7/J88lpw4TIQVD96NJyP3gJgYJ1JwaLQySNaSzK0I69XHSSI0uQDfe4t9
         zVabZ5v8Zc1TikgQ0tFpqyo/7Q/iuC7sZomxGQct/POy/fLp5Lp326otfXpqSp2prm7C
         L/8m8BPsd3Q+gvHCdCm1qECS5FboD5I4tsIH3H/+WDQg9M52KIhYTAVahMSOsE0ug3W1
         O57uuxgM001M0v2X7LaAWmPjF3hlp3uJm4kl7rVS1KI6J3dYFCljOLskYp0aGUqyFtBU
         YHQw==
X-Gm-Message-State: AOAM530SyI5GjVql0zu2pnJKwGYhUi6oWOcml2oBx/zg+QReG75aolHt
        KPtCgL7eeoNxDWtPzyRcAM/TYwIfWJc=
X-Google-Smtp-Source: ABdhPJxkP75WgV21IZcNxlRS6TAmzQqF7mR5/9LIYDXJQsk1G4XmdLL2D1kY+MbFVZVjIcVqYIoBzqaGKgs=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:9f62:e8e9:4de2:f00a])
 (user=surenb job=sendgmr) by 2002:ad4:5386:: with SMTP id i6mr39090484qvv.2.1625877390205;
 Fri, 09 Jul 2021 17:36:30 -0700 (PDT)
Date:   Fri,  9 Jul 2021 17:36:24 -0700
Message-Id: <20210710003626.3549282-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v3 1/3] mm, memcg: add mem_cgroup_disabled checks in
 vmpressure and swap-related functions
From:   Suren Baghdasaryan <surenb@google.com>
To:     tj@kernel.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        songmuchun@bytedance.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, vbabka@suse.cz, axboe@kernel.dk,
        iamjoonsoo.kim@lge.com, david@redhat.com, willy@infradead.org,
        apopple@nvidia.com, minchan@kernel.org, linmiaohe@huawei.com,
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
This change results in ~2.1% overhead reduction when running PFT test
comparing {CONFIG_MEMCG=n, CONFIG_MEMCG_SWAP=n} against {CONFIG_MEMCG=y,
CONFIG_MEMCG_SWAP=y, cgroup_disable=memory} configuration on an 8-core
ARM64 Android device.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
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

