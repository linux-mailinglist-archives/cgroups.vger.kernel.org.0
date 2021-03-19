Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DD534150B
	for <lists+cgroups@lfdr.de>; Fri, 19 Mar 2021 06:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhCSFuR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Mar 2021 01:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbhCSFtr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Mar 2021 01:49:47 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D139BC06175F
        for <cgroups@vger.kernel.org>; Thu, 18 Mar 2021 22:49:46 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id y18so1782332qky.11
        for <cgroups@vger.kernel.org>; Thu, 18 Mar 2021 22:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4EjKKyy6zJi89FUhVJH9257gvcZYHljfd48zTgz5zIU=;
        b=x3QpbZL8xF3lB+fhzJjWSXfOdOYw7IT0xr7pVuPujmaG7k9pCD7DqET3m+8xVwZ5fs
         9k297z+F24N6dyH21lb1L1Xd/k1LuGHRov8Ow80+4RDOpZh75ea7sqWiYm12gaCu5Q0J
         sVUBYLc1+1h4Kx1tvB+uDpg0n/HxaUQ8X4aeJo9h/4EaSEOm3BpoNbfNPF+U9GdYaYI3
         73ndGlNaJSVE+R5glrk8jWDvFVtpL1IKfaJbAWKVNZ0v8wEScvUqQPE7fcnMOvALYcJR
         T7RUNMqMWmr2NpNZNqMiKeRDcre+/EKQRJ7tR6mEQYtwnxKl3A40jfWoKVM7UDzDdbvI
         VClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4EjKKyy6zJi89FUhVJH9257gvcZYHljfd48zTgz5zIU=;
        b=aRT2XVxXm3UrTGbk232ud/EiIs2xcWNZNInWZUn3m1Q+Y/ZmEIFlc9FQc6pW7AeYSU
         AgLek1Jq2xI1ewmM2X1z7XglTzsdeRVbPBKCyGN9lHZcodpL7IA96YAnF40Ne9HUN40h
         tJDZDvSmCoyta9FwMwHZwdublMaSc6FSic32jFOKrEeLGIFMj0a1DPbKEdIqKIc3koru
         NDw2/dU7yezBGYuv0fwNWgAM36KZdFjKa73mSFbuxX5v/P7VFnVL51B5Tkm4x2bFVcqG
         4aLiA/zZ0+V5vI0eSClQWoZw4/mqz9kdtmi5lTjM3NwWh+3Zq3bNroo0XfLqdbs+LJMY
         7igg==
X-Gm-Message-State: AOAM5312tGQowWDQjr4gveYWfefRwmYnzQAljiFIqd+eMSyuAzp0djqE
        Yes7hQloUy76dV7RYqRwt2mJ4g==
X-Google-Smtp-Source: ABdhPJxsQgowksR37eF/5ncjQ+ws7e0Hspq3cD30p7EIjiZktuxNXTFxMUr5xN2ZButKHCm1FmH99g==
X-Received: by 2002:a05:620a:c95:: with SMTP id q21mr7689952qki.360.1616132985879;
        Thu, 18 Mar 2021 22:49:45 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id a10sm3583594qkh.122.2021.03.18.22.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 22:49:45 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/2] mm: memcontrol: don't allocate cgroup swap arrays when memcg is disabled
Date:   Fri, 19 Mar 2021 01:49:43 -0400
Message-Id: <20210319054944.50048-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit 2d1c498072de ("mm: memcontrol: make swap tracking an
integral part of memory control"), the cgroup swap arrays are used to
track memory ownership at the time of swap readahead and swapoff, even
if swap space *accounting* has been turned off by the user via
swapaccount=0 (which sets cgroup_memory_noswap).

However, the patch was overzealous: by simply dropping the
cgroup_memory_noswap conditionals in the swapon, swapoff and uncharge
path, it caused the cgroup arrays being allocated even when the memory
controller as a whole is disabled. This is a waste of that memory.

Restore mem_cgroup_disabled() checks, implied previously by
cgroup_memory_noswap, in the swapon, swapoff, and swap_entry_free
callbacks.

Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c  | 3 +++
 mm/swap_cgroup.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 668d1d7c2645..49bdcf603af1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7101,6 +7101,9 @@ void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	struct mem_cgroup *memcg;
 	unsigned short id;
 
+	if (mem_cgroup_disabled())
+		return;
+
 	id = swap_cgroup_record(entry, 0, nr_pages);
 	rcu_read_lock();
 	memcg = mem_cgroup_from_id(id);
diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index 7f34343c075a..08c3246f9269 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -171,6 +171,9 @@ int swap_cgroup_swapon(int type, unsigned long max_pages)
 	unsigned long length;
 	struct swap_cgroup_ctrl *ctrl;
 
+	if (mem_cgroup_disabled())
+		return 0;
+
 	length = DIV_ROUND_UP(max_pages, SC_PER_PAGE);
 	array_size = length * sizeof(void *);
 
@@ -206,6 +209,9 @@ void swap_cgroup_swapoff(int type)
 	unsigned long i, length;
 	struct swap_cgroup_ctrl *ctrl;
 
+	if (mem_cgroup_disabled())
+		return;
+
 	mutex_lock(&swap_cgroup_mutex);
 	ctrl = &swap_cgroup_ctrl[type];
 	map = ctrl->map;
-- 
2.30.1

