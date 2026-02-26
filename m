Return-Path: <cgroups+bounces-14442-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCDRMXGgoGlVlAQAu9opvQ
	(envelope-from <cgroups+bounces-14442-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 20:35:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD331AE694
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 20:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70A7730CD49F
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 19:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BA444DB7D;
	Thu, 26 Feb 2026 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le1BRfQ7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9453644E025
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134198; cv=none; b=NWGPeySrwJ5uP+hhBWE6IJaVCOUUmVg2Gql9AGsvuELjVmeRF7O6g17Y+0Tf+5Pl/M84/ecAnOBVnv9z2nBDkcZCqO7r8FSuHY/AvsbQtfa9lDs1ZgPFI+E+kBz9n25SFiTRHoRGPQXLZymK+HHSZ2HFBujZO/xeVxn5E3orS5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134198; c=relaxed/simple;
	bh=I/6VfJFxIb4g0o8KWA7c8Glu4mFHW8x/F43F+Sqs7Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAbmo+JzK363jL+d+hFypISJOQyP5rG6+OLFcn1inh168SDDqDXuGOeOxVlcRvawTEKnLphSSYuFNLw5JJbMNpBhGYHC6pIhz8SUT0o9Iqr2OugwzMtTm7HFRmjqLm7EJzfeo7xatxKKThaWGs04OdZX/dX2bDc5MBVj6jjvH0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Le1BRfQ7; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4638e238094so738478b6e.3
        for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 11:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134192; x=1772738992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPksRk4LAnsoFLQrd4UcyaPDU9XJzdmOlJT+foKyitQ=;
        b=Le1BRfQ7f7OzIrthjeVdUlhU6gRFJQWUrBHuMVsnV6j3mycFZ6REiUIw/BPMx1SG4/
         7EjOfvPLKpg/MzcL9CAgQ37r44Hk5Ku4mW60OwPdm+1J/0fzw7ygSI2xAlKy3jim+vL1
         0alld4trryC6EEeXEr5JDHhoPSN6JF+7EmqzryDjiWEjqt6Zg+V+3qy1u+oVG5/lAZtq
         7npqNj3/UR+LE0t+GMpRzExQFR/cm7tMcpRzkPbesfj2ZoICgWg8gq0clVEvgrAR8BFC
         AR9LOWXeMK4mgM8NyZy1a1LJgZRKAqYjtI2KussTEa1s7YdZtXimjR5ian1ziJKQkV5Q
         3c9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134192; x=1772738992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qPksRk4LAnsoFLQrd4UcyaPDU9XJzdmOlJT+foKyitQ=;
        b=dxf34J+/x9LWl7vL10uBAuiqPvQIwE+Ude9ZJK6QsbWYe8fUMtUZ21kbor4jugJxZn
         pvTJk84eBFNBrGI+xM+4xgvQjaLXNwqVawU1dEEdWQXbMMUVVj0d7Vqez36qd0NEz4y9
         LRjRen0DXGQ1Sqy3rhOuIvqOvdEwGR/X62jmxL2fRC7Wy6Guyn2gQbdDSOyDeliJ1rGE
         ok99rWobb4VSXDOygGxc3nd/DT9JP/g3qOE9FfM5ROZzRWMqj7AcsWnt61R38G6lODrK
         XBl8D6SgYLjNR3Dg893I8c7+WPF0xuHXeOxAvTpJbkA+6mu59LhK5XkL0axS1c6G51I2
         HRQw==
X-Forwarded-Encrypted: i=1; AJvYcCWlkCIPEm0D/t/1v6F1lYHA3UOjPMcCP6xf3lMPqfwh7Z8Yy85qgGZmMNblXNayUvU1fNA7mFiq@vger.kernel.org
X-Gm-Message-State: AOJu0YxjaZ58vzBVNRCD8PMbPxY7dubhbfoKA84DpKW15mNiOegrKqq2
	FcvU1MA4yLeKK8uofK28hAoZEYLAIqsY2oHL1OVUHlLKDqoGi7y6IRyO
X-Gm-Gg: ATEYQzwx0nsjW5B3PEP3cfdCkolsU79k+93ytEoxNTLXJpYKr2cjByejXyM9nt8FaPT
	9Zcy/KjSwibQb5+nn91wxLQAfPammzI6bAAxh2QCTzYqDuahXifG+VUw3BZLb8GavDRc1cG5UV3
	5ZtUFiJctJBEnCy6UJ6z/Fi4w7AGUQfIEYpTxsjtp6AhZ2wlv7wnmFPdM/ltjfz/jBoDtu3ZgX9
	FMuOqbYzKEmftmNTeGpzNt4HJBYofNNP4rs1IzNAiLv0dKe3kOEGVGrUvqmbx+VkEmu/CS3IS8z
	SvWC1Znehk8JKUYHwrYCnUmVU7t5YNNHzjxbFNcGHYlazPJTFRXstjoDmnC802KE9WpoiTcitmZ
	FqUdFF8G9xNJ+eJ8xu68/Bxd21Bn+KKTKkpTQ0oDDUJ4h0GvqSLxTv10Be7MuLDzc0xmNV9c9Cv
	1CwA8a/DJYOCXp5L/bSsm4gA==
X-Received: by 2002:a05:6808:4707:b0:45e:f0ae:bc0f with SMTP id 5614622812f47-464be9cbef3mr147302b6e.23.1772134192235;
        Thu, 26 Feb 2026 11:29:52 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:59::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf9b24dsm2713097fac.7.2026.02.26.11.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:29:50 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 7/8] mm/memcontrol: Track MEMCG_ZSWAPPED in bytes
Date: Thu, 26 Feb 2026 11:29:30 -0800
Message-ID: <20260226192936.3190275-8-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226192936.3190275-1-joshua.hahnjy@gmail.com>
References: <20260226192936.3190275-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,linux.dev,gmail.com,kernel.org,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	TAGGED_FROM(0.00)[bounces-14442-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FD331AE694
X-Rspamd-Action: no action

Zswap compresses and uncompresses in PAGE_SIZE units, which simplifies
the accounting for how much memory it has compressed. However, when a
compressed object is stored at the boundary of two zspages, accounting
at PAGE_SIZE units makes it difficult to fractionally charge each
backing zspage with the ratio of memory it backs for the compressed
object.

To make sub-PAGE_SIZE granularity charging possible for MEMCG_ZSWAPPED,
track the value in bytes and adjust its accounting accordingly.

No functional changes intended.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/memcontrol.h | 2 +-
 mm/memcontrol.c            | 5 +++--
 mm/zsmalloc.c              | 4 ++--
 mm/zswap.c                 | 6 ++++--
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index dd4278b1ca35..d3952c918fd4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -38,7 +38,7 @@ enum memcg_stat_item {
 	MEMCG_VMALLOC,
 	MEMCG_KMEM,
 	MEMCG_ZSWAP_B,
-	MEMCG_ZSWAPPED,
+	MEMCG_ZSWAPPED_B,
 	MEMCG_NR_STAT,
 };
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3432e1afc037..b662902d4e03 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -340,7 +340,7 @@ static const unsigned int memcg_stat_items[] = {
 	MEMCG_VMALLOC,
 	MEMCG_KMEM,
 	MEMCG_ZSWAP_B,
-	MEMCG_ZSWAPPED,
+	MEMCG_ZSWAPPED_B,
 };
 
 #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
@@ -1345,7 +1345,7 @@ static const struct memory_stat memory_stats[] = {
 	{ "shmem",			NR_SHMEM			},
 #ifdef CONFIG_ZSWAP
 	{ "zswap",			MEMCG_ZSWAP_B			},
-	{ "zswapped",			MEMCG_ZSWAPPED			},
+	{ "zswapped",			MEMCG_ZSWAPPED_B		},
 #endif
 	{ "file_mapped",		NR_FILE_MAPPED			},
 	{ "file_dirty",			NR_FILE_DIRTY			},
@@ -1393,6 +1393,7 @@ static int memcg_page_state_unit(int item)
 	switch (item) {
 	case MEMCG_PERCPU_B:
 	case MEMCG_ZSWAP_B:
+	case MEMCG_ZSWAPPED_B:
 	case NR_SLAB_RECLAIMABLE_B:
 	case NR_SLAB_UNRECLAIMABLE_B:
 		return 1;
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 88c7cd399261..6794927c60fb 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -980,7 +980,7 @@ static void zs_charge_objcg(struct zpdesc *zpdesc, struct obj_cgroup *objcg,
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
 	mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
-	mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);
+	mod_memcg_state(memcg, MEMCG_ZSWAPPED_B, 1);
 	rcu_read_unlock();
 }
 
@@ -997,7 +997,7 @@ static void zs_uncharge_objcg(struct zpdesc *zpdesc, struct obj_cgroup *objcg,
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
 	mod_memcg_state(memcg, MEMCG_ZSWAP_B, -size);
-	mod_memcg_state(memcg, MEMCG_ZSWAPPED, -1);
+	mod_memcg_state(memcg, MEMCG_ZSWAPPED_B, -1);
 	rcu_read_unlock();
 }
 
diff --git a/mm/zswap.c b/mm/zswap.c
index 77d3c6516ed3..97f38d0afa86 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1214,8 +1214,10 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	 */
 	if (!mem_cgroup_disabled()) {
 		mem_cgroup_flush_stats(memcg);
-		nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
-		nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
+		nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B);
+		nr_backing >>= PAGE_SHIFT;
+		nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED_B);
+		nr_stored >>= PAGE_SHIFT;
 	} else {
 		nr_backing = zswap_total_pages();
 		nr_stored = atomic_long_read(&zswap_stored_pages);
-- 
2.47.3


