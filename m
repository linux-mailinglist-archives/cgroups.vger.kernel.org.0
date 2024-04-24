Return-Path: <cgroups+bounces-2694-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0178B0A48
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 15:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758DA1F25D7A
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 13:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FB015B128;
	Wed, 24 Apr 2024 13:00:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4624815ADB8;
	Wed, 24 Apr 2024 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963601; cv=none; b=UYUh7PgNB4pUOAib2NBOHx7OtAd9Yg2Ldf6kgGvYLZqfsoeV5GkKif7KHb5VaHzS5p+kg9uNaM8mKaGLeDuS4LND1qiXQ/PDaYfLjT9cLnDp+XZ4OWPd6aiEw8n9MWv3f0QY/1A12a+7dHR+RlcJXsJhniiXR60ngho5fP7FOUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963601; c=relaxed/simple;
	bh=6Yy7m/6CzXiExG1qEJxxc9fYsBWXedfhGZTx/aOQ58k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EML/tXcrsYmNg8JPEmU8u5LGs0KJgqhKN2gI4PT2aySGpK6o8kmTxh5fegmJsBar+ogYY+9JBKFzs9Yxk3tvqSD7NHAf1Q4c7N6ds/fTi0NsmxjxPBthgtZAuLSvndWiF99mo8fgiWkUA+VFRHfp4gODa48d8Gb9aya2ruQ4JMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a524ecaf215so701199766b.2;
        Wed, 24 Apr 2024 05:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713963597; x=1714568397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZpXDLWdbY5cxtVKR5gQdGHFoKg4O1yoZrRZTfWHXEU=;
        b=EGzCv4dOQFnCIUPYodSHgrTVT6q/HuntRurdy1lPQZvVic2k2+VYfyEC5coIiW2ahZ
         lGMKjHPH1sDd5VLbtaSd+zt5TQ0KmcQz5bnhnvl1ccI0azwk1N0437OB+YbLK7K89PI/
         FaOqrlEbuUeXh3jKkBqPQ69YtLhNC9PRlsBME2MvI+iwlX9aGNBHHJBKWyZDAO6/Wm2x
         fmOZsLlzksx5HrPBhz1A/WQOReBka5S9YSW1OkylROjVd1gzZ6TsvigWvlwIGetJnpQ4
         OKZOnn0NKBJj7K4Tdx7fIPbOu4oklmww+fJG2jdyKvKC6Jf8nonqHhBUdJwz/gigJg06
         c8/w==
X-Forwarded-Encrypted: i=1; AJvYcCVIV59K3FBaDeYEJMeoPzLgOljA6wYEOFa3lZ9TlJ8XigYLh8hMj40y3mR2Xze2gvn+gRrEUkuN01k+ac7OqytmZnMSKCZCP7CBTmBZ0PZVYvj42koxhUdzv5yVarC5TwTADp/a+A==
X-Gm-Message-State: AOJu0YyDLK+85DyNzt+7hR9HCSdcSKOhXOTDARrPqM2+CuPpiDZSvF7P
	d3RxK3MPwQAKR0SmPiUPiwnfxSkAiVVEoYirVpDeRmqxYTHNZyi6
X-Google-Smtp-Source: AGHT+IF/RV0/1XswegILNQyeX/GUzV1RYykInrtqHpdfC1ZxMCeLSWwtzZwxtUJZYZPRpwl7qXgTJQ==
X-Received: by 2002:a17:906:d142:b0:a58:828b:554e with SMTP id br2-20020a170906d14200b00a58828b554emr1607782ejb.71.1713963597341;
        Wed, 24 Apr 2024 05:59:57 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id lu10-20020a170906faca00b00a52299d8eecsm8214771ejb.135.2024.04.24.05.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 05:59:56 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: leit@meta.com,
	cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)),
	linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] memcg: Fix data-race KCSAN bug in rstats
Date: Wed, 24 Apr 2024 05:59:39 -0700
Message-ID: <20240424125940.2410718-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A data-race issue in memcg rstat occurs when two distinct code paths
access the same 4-byte region concurrently. KCSAN detection triggers the
following BUG as a result.

	BUG: KCSAN: data-race in __count_memcg_events / mem_cgroup_css_rstat_flush

	write to 0xffffe8ffff98e300 of 4 bytes by task 5274 on cpu 17:
	mem_cgroup_css_rstat_flush (mm/memcontrol.c:5850)
	cgroup_rstat_flush_locked (kernel/cgroup/rstat.c:243 (discriminator 7))
	cgroup_rstat_flush (./include/linux/spinlock.h:401 kernel/cgroup/rstat.c:278)
	mem_cgroup_flush_stats.part.0 (mm/memcontrol.c:767)
	memory_numa_stat_show (mm/memcontrol.c:6911)
<snip>

	read to 0xffffe8ffff98e300 of 4 bytes by task 410848 on cpu 27:
	__count_memcg_events (mm/memcontrol.c:725 mm/memcontrol.c:962)
	count_memcg_event_mm.part.0 (./include/linux/memcontrol.h:1097 ./include/linux/memcontrol.h:1120)
	handle_mm_fault (mm/memory.c:5483 mm/memory.c:5622)
<snip>

	value changed: 0x00000029 -> 0x00000000

The race occurs because two code paths access the same "stats_updates"
location. Although "stats_updates" is a per-CPU variable, it is remotely
accessed by another CPU at
cgroup_rstat_flush_locked()->mem_cgroup_css_rstat_flush(), leading to
the data race mentioned.

Considering that memcg_rstat_updated() is in the hot code path, adding
a lock to protect it may not be desirable, especially since this
variable pertains solely to statistics.

Therefore, annotating accesses to stats_updates with READ/WRITE_ONCE()
can prevent KCSAN splats and potential partial reads/writes.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/memcontrol.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fabce2b50c69..3c99457b36a1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -715,6 +715,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
 	struct memcg_vmstats_percpu *statc;
 	int cpu = smp_processor_id();
+	unsigned int stats_updates;
 
 	if (!val)
 		return;
@@ -722,8 +723,9 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	cgroup_rstat_updated(memcg->css.cgroup, cpu);
 	statc = this_cpu_ptr(memcg->vmstats_percpu);
 	for (; statc; statc = statc->parent) {
-		statc->stats_updates += abs(val);
-		if (statc->stats_updates < MEMCG_CHARGE_BATCH)
+		stats_updates = READ_ONCE(statc->stats_updates) + abs(val);
+		WRITE_ONCE(statc->stats_updates, stats_updates);
+		if (stats_updates < MEMCG_CHARGE_BATCH)
 			continue;
 
 		/*
@@ -731,9 +733,9 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 		 * redundant. Avoid the overhead of the atomic update.
 		 */
 		if (!memcg_vmstats_needs_flush(statc->vmstats))
-			atomic64_add(statc->stats_updates,
+			atomic64_add(stats_updates,
 				     &statc->vmstats->stats_updates);
-		statc->stats_updates = 0;
+		WRITE_ONCE(statc->stats_updates, 0);
 	}
 }
 
@@ -5845,7 +5847,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 			}
 		}
 	}
-	statc->stats_updates = 0;
+	WRITE_ONCE(statc->stats_updates, 0);
 	/* We are in a per-cpu loop here, only do the atomic write once */
 	if (atomic64_read(&memcg->vmstats->stats_updates))
 		atomic64_set(&memcg->vmstats->stats_updates, 0);
-- 
2.43.0


