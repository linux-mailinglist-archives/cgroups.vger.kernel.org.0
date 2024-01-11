Return-Path: <cgroups+bounces-1116-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E287382AFAB
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 14:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CD41C236CC
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAF9171B8;
	Thu, 11 Jan 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="2EUhicx7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC39171A2
	for <cgroups@vger.kernel.org>; Thu, 11 Jan 2024 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78314e00350so464433785a.1
        for <cgroups@vger.kernel.org>; Thu, 11 Jan 2024 05:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1704979748; x=1705584548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VmAACpAT+7XgSF5ovEqoKHBY0dChYojGZwUF1rmaV+s=;
        b=2EUhicx7PYvj8p7RaBSLF+XCz4h0MwSSrc0nCNj2iS+B+1CkRGwTaqBbRXf/SZez4s
         m2RFuoKCJw4aKZvdwjofibVnGL3Mc+yTZXm5JUTFuT0l4ZWNX6nAZ1Yn4cu182PTOw7w
         yJQORX8DkbOAIwUPdAPBZTxNXTTchC+7CullkrwmmwTOqvIM6uTW68VJvcbecXh/adpe
         11hEJwmRtRKHbsTPlV2Ph/mcjTCHszIdRG0rXSewlF9j7sUpVEnM9GRTU3hF1hzCRzNU
         WY/0najjK5kPEVtKDNrAlcDVIG7EqlSferpeibpF6SDUdN89cWvjtzIDOAOU3FeX9QDF
         0EZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704979748; x=1705584548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmAACpAT+7XgSF5ovEqoKHBY0dChYojGZwUF1rmaV+s=;
        b=pDjt0GoVOE0ljEaope4M322EFMpbbZ/x+fsAw4a8LHSNJuh/zt5+HS9QhBxlAwa+7R
         CsLq4yh8waRJFUiYW/S6xq1lNcBepKY5njV/0hsYJAd61Uu9HvMlMrAZAmwc3UZDoU1q
         58AyowZOahPYHh8YLic/xb6nvDYgkXz756xyj5yOZFuL1iOXMPmskJW1noIG6a9Akw9e
         e5CtDqGX1UB+sRIETbwkbUwqS2v3BnG5dOau5HvRVgVJJxmFffs4tREB2ZUm/bANnwZO
         b6nvyeQ3+45wWwRlCIGNm13Z6TfOPz5w4XWSGnt6zMKoTGuzH3TE3HHOyt143rUflSB7
         3TOw==
X-Gm-Message-State: AOJu0YyvKA1plJCR9oGrskW94CvmXmnbB+bWH1nsXbhVhIkY5MgPXK5N
	6ZijLT/w9Bh4Im+9m6wmsz9njJsMah+UVw==
X-Google-Smtp-Source: AGHT+IGb0E1FwTgNxq1HVe0jtfGI6qy/+AuYBoa6OQKhuzykwVNnO6P23dEQOxol/x1Lne9ldG9BZQ==
X-Received: by 2002:a05:6214:c4b:b0:67f:143d:b8ca with SMTP id r11-20020a0562140c4b00b0067f143db8camr1202969qvj.44.1704979747934;
        Thu, 11 Jan 2024 05:29:07 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id f7-20020a05621400c700b0067fa1179b57sm296884qvs.131.2024.01.11.05.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 05:29:07 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: memcontrol: don't throttle dying tasks on memory.high
Date: Thu, 11 Jan 2024 08:29:02 -0500
Message-ID: <20240111132902.389862-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While investigating hosts with high cgroup memory pressures, Tejun
found culprit zombie tasks that had were holding on to a lot of
memory, had SIGKILL pending, but were stuck in memory.high reclaim.

In the past, we used to always force-charge allocations from tasks
that were exiting in order to accelerate them dying and freeing up
their rss. This changed for memory.max in a4ebf1b6ca1e ("memcg:
prohibit unconditional exceeding the limit of dying tasks"); it noted
that this can cause (userspace inducable) containment failures, so it
added a mandatory reclaim and OOM kill cycle before forcing charges.
At the time, memory.high enforcement was handled in the userspace
return path, which isn't reached by dying tasks, and so memory.high
was still never enforced by dying tasks.

When c9afe31ec443 ("memcg: synchronously enforce memory.high for large
overcharges") added synchronous reclaim for memory.high, it added
unconditional memory.high enforcement for dying tasks as well. The
callstack shows that this path is where the zombie is stuck in.

We need to accelerate dying tasks getting past memory.high, but we
cannot do it quite the same way as we do for memory.max: memory.max is
enforced strictly, and tasks aren't allowed to move past it without
FIRST reclaiming and OOM killing if necessary. This ensures very small
levels of excess. With memory.high, though, enforcement happens lazily
after the charge, and OOM killing is never triggered. A lot of
concurrent threads could have pushed, or could actively be pushing,
the cgroup into excess. The dying task will enter reclaim on every
allocation attempt, with little hope of restoring balance.

To fix this, skip synchronous memory.high enforcement on dying tasks
altogether again. Update memory.high path documentation while at it.

Fixes: c9afe31ec443 ("memcg: synchronously enforce memory.high for large overcharges")
Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 73692cd8c142..aca879995022 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2603,8 +2603,9 @@ static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
 }
 
 /*
- * Scheduled by try_charge() to be executed from the userland return path
- * and reclaims memory over the high limit.
+ * Reclaims memory over the high limit. Called directly from
+ * try_charge() when possible, but also scheduled to be called from
+ * the userland return path where reclaim is always able to block.
  */
 void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 {
@@ -2673,6 +2674,9 @@ void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 	}
 
 	/*
+	 * Reclaim didn't manage to push usage below the limit, slow
+	 * this allocating task down.
+	 *
 	 * If we exit early, we're guaranteed to die (since
 	 * schedule_timeout_killable sets TASK_KILLABLE). This means we don't
 	 * need to account for any ill-begotten jiffies to pay them off later.
@@ -2867,8 +2871,22 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		}
 	} while ((memcg = parent_mem_cgroup(memcg)));
 
+	/*
+	 * Reclaim is scheduled for the userland return path already,
+	 * but also attempt synchronous reclaim to avoid excessive
+	 * overrun while the task is still inside the kernel. If this
+	 * is successful, the return path will see it when it rechecks
+	 * the overage, and simply bail out.
+	 *
+	 * Skip if the task is already dying, though. Unlike
+	 * memory.max, memory.high enforcement isn't as strict, and
+	 * there is no OOM killer involved, which means the excess
+	 * could already be much bigger (and still growing) than it
+	 * could for memory.max; the dying task could get stuck in
+	 * fruitless reclaim for a long time, which isn't desirable.
+	 */
 	if (current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH &&
-	    !(current->flags & PF_MEMALLOC) &&
+	    !(current->flags & PF_MEMALLOC) && !task_is_dying() &&
 	    gfpflags_allow_blocking(gfp_mask)) {
 		mem_cgroup_handle_over_high(gfp_mask);
 	}
-- 
2.43.0


