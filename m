Return-Path: <cgroups+bounces-7292-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A154A78A85
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 11:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00148188DDD3
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 09:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA28235354;
	Wed,  2 Apr 2025 09:01:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C562343AE;
	Wed,  2 Apr 2025 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743584488; cv=none; b=IK0pV/bCnXC8kl1JCMEWJzt1ZlcMCjpKV7WF9Ogso101mcjyN9SW+mhQ2dfOyCizoc1/bFHBhFlhhIFfQGG1W61px1l8780N+/FHOgClzBS1G9+7VsUtdDlN7yZicgmzLC1IP3vK25oJdHSQjo2GpLvsFIYgJ/mWqc+Njj/KAWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743584488; c=relaxed/simple;
	bh=/pNJ4ySFXY59RP+nBAoZcrCaOE6/t/NpIkcVaOsrs8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RUh+b/rMzhp9mSDJVLgh9Nfi1/TTRZ8Qy1D3MnzrsRKHo3RauzSMbvrsXe3UU6jJvZNza+JZ5J8VkeHiPtWdhtcZXkIAGcIdAJQPucUuNSbcG9rN2kO4UVUcZWGJMRIgdb47I2KPsa3iX5hyQ78xL85aRof/md5rTYbQqoJLVv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so58001635e9.0;
        Wed, 02 Apr 2025 02:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743584485; x=1744189285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1nAxP9Cm1Xgk9CKkL1H+osxhAxtr2UzCZivomiql3CU=;
        b=w7rDPG/x4+KrSEd+5TWSATJR4CsEkwxRPgmcGkAUKN33vPKJWHK7TdEKf4OtrksM0i
         h0vXSX1wwy5WKZEMyoIYZZp7uQAaNbYdn6qbmtGy6lrUJEHdD9CmYAHZzBTzfu0i91D6
         qgtD7KcIrwp3AlFypKQZj/NbQnxsCSXFec5D0IlnJ2TG7W9GX/UGbSlwp4/36CIM67H8
         LCOqlrKzl8c914cH+q5E8Gjf8YqptW0jOSnTXqvw9jt9rAb+SFST5ngBVBJgSwkssaEJ
         2IbxaXN4pUyFGMYw49CNMFPBzFfcyrexzjIQUkmIJ4e5s6NNnFylAg6MKdCZniRIl33h
         3XdA==
X-Forwarded-Encrypted: i=1; AJvYcCUghB8QYS0TvovxBbPoX0QiMK6C8/b54+88YVY4KxTlawyK60x1RRKScdO8Ah36HKJ5G/jKkTut@vger.kernel.org, AJvYcCUpRjaHCubFz5iIaYG9voppGmQmHqUoa0S3R5CYOHCAhVmaKA3x3f0ZifT+myyOHV5AjMaaUDwyZeR7MOrW@vger.kernel.org
X-Gm-Message-State: AOJu0YxuaAIiZEDB//zbQjDydrTTSxR9okNeN2icOpT6UCDOq5JaeluR
	eK5AzCNExkJe3CqYUxfAoPtWc6iVVbVdCMPhvmhkmTAVBXL9vDw0
X-Gm-Gg: ASbGnctmLXgWwZzjxf9voa4217pEQghI1h2dl7eDgzGBA50LuiLMN48pUB6xIrD4arU
	oqcvnU0ls1W3ob2wHkXHN0Z3ecIpyq79g0mQnIs5USjye7R2SH0/yv38QY0Ezog9ryQW1aFlc8e
	Hwf5a0dIsLhN+pjh0Kf+UREEvarICDme1M2iDZsygekTDBoKCtLhoB4dmn22QPBlbM4TNzh63a8
	In9jYilfOYpEY8P0ydTz8p8PWfkGYKUxPn8qKASmXb5WlqpGXXhoQnV5pb7G0vDM2HADjXlcEJT
	vNZKPGACjMJ/gzIs801hyNcnZ1uCg/tf3umV15jAAxfmquMB5hTS74gCoMcVWr5R2RlQgAaKsXI
	sKVyGN/d57lQ=
X-Google-Smtp-Source: AGHT+IF377z38nyMutbgU0BfWnTmCRNwm367leNG/aLpAUpSFIciSLft2x0pBCWn6VuKILiIZhmHMQ==
X-Received: by 2002:a05:600c:1382:b0:43c:e7ae:4bc9 with SMTP id 5b1f17b1804b1-43db61e0348mr120742425e9.1.1743584485035;
        Wed, 02 Apr 2025 02:01:25 -0700 (PDT)
Received: from localhost.localdomain (109-81-92-185.rct.o2.cz. [109.81.92.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b658b7bsm16145003f8f.20.2025.04.02.02.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 02:01:24 -0700 (PDT)
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>,
	Rik van Riel <riel@surriel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups mailinglist <cgroups@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH] memcg, oom: do not bypass oom killer for dying tasks
Date: Wed,  2 Apr 2025 11:01:17 +0200
Message-ID: <20250402090117.130245-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Hocko <mhocko@suse.com>

7775face2079 ("memcg: killed threads should not invoke memcg OOM killer") has added
a bypass of the oom killer path for dying threads because a very
specific workload (described in the changelog) could hit "no killable
tasks" path. This itself is not fatal condition but it could be annoying
if this was a common case.

On the other hand the bypass has some issues on its own. Without
triggering oom killer we won't be able to trigger async oom reclaim
(oom_reaper) which can operate on killed tasks as well as long as they
still have their mm available. This could be the case during futex
cleanup when the memory as pointed out by Johannes in [1]. The said case
is still not fully understood but let's drop this bypass that was mostly
driven by an artificial workload and allow dying tasks to go into oom
path. This will make the code easier to reason about and also help
corner cases where oom_reaper could help to release memory.

[1] https://lore.kernel.org/all/20241212183012.GB1026@cmpxchg.org/T/#u

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..9c30c442e3b0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1627,7 +1627,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * A few threads which were not waiting at mutex_lock_killable() can
 	 * fail to bail out. Therefore, check again after holding oom_lock.
 	 */
-	ret = task_is_dying() || out_of_memory(&oc);
+	ret = out_of_memory(&oc);
 
 unlock:
 	mutex_unlock(&oom_lock);
-- 
2.49.0


