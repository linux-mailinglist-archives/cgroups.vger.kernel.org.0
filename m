Return-Path: <cgroups+bounces-14771-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Bl0ASTIsWnvFAAAu9opvQ
	(envelope-from <cgroups+bounces-14771-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 20:53:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D73E5269A52
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 20:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 400D33016B8A
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 19:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5366638553D;
	Wed, 11 Mar 2026 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hxnu4Tee"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BB0382F23
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258730; cv=none; b=L3MRqgSNwDpCUEBJyQvvqV9YByrbs1a+mdl7KrK3R9/WBq9XLLWUfGPAUsVWl7yutEajaFfO4aBLv2uAHU7A+vk1LmzbEQ8PO1+Bawus9C2HnyDqNoDVQtvPn4vUlWMlDeaDdWjhqthuoudBAWdKai0piPuzgCHfhAc90YUI4R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258730; c=relaxed/simple;
	bh=HF2J8eGf9ezx76WeuiLEbVDyfaZqYDKuQnnfjxWeg54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjjvoc+tkZHDCcwMOMVkRmqAZznjJj3Yx/vpmHa0I15d4eJEvKg9i5vq+dEIhCtrbibOWezREXxMTXWsq2HiD7P9A9P/62LuIHT4jc8RQDi/B5ptyt/hkz3xGvJ8TJTY5M4AR7j3D5XWgERUWuPlyQzH5TTrR/4jDzjc2sFzSpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hxnu4Tee; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-415e568a7ecso127249fac.0
        for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 12:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773258725; x=1773863525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uGTcZbp7r+H1UaYa68xNPMIKqxUKJCwYhvaf1Y6xf8=;
        b=Hxnu4Tee603RcE0HCPjo47X15Y6evAy+vlzl0CBtZSOCXXb+i9TjhKjEwShWI2QEDD
         kRN3zlACPOTzsw1lCK2TJrOPr+Ii8vlrgoLVgF1eupIa6KAIOMaiqvql+OVhOq/AP23r
         3ZwQiRma01TTys1e1JKbFkewmnc0/u6vjkeiNoKOVQtYLgHl0Zzr2YS2hwqW5g0sXz4Y
         amrrm0fx+FdRDG1f6UmMmA+65xic+rmOe3enDorLXS49ZidXl8quPNQXelizEc7Z56DQ
         Rrbo219EO0KIEjxlVEivA8AMTNIumxHdXgrlIke+N3a+rhdz5ip9IIgSXmtKqMmxWPpE
         aspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773258725; x=1773863525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9uGTcZbp7r+H1UaYa68xNPMIKqxUKJCwYhvaf1Y6xf8=;
        b=gQrUK3I25j5I12R9rsZ2SpnNDf6+G4KP+JJQmQdNLwJ7oloFPpHpAH0SWGcCQcPg2l
         VgTjcdSpA+fbqkI8uMigEIwTM1ZvOPiaTr26UI2TmbuvbwZa+FLfbcHqgKktO3UmtuyX
         FI1jfefL/Tt8CRR9x3SvT1F+NHjP90sn6dClb3rpdtpCXSURy5elgvt5ev+6cTTlv99m
         wwzvj9lDyc3RobzSi+puFSuVsZyWDEz6r5Cb37b/LGVKhOjQdvGDiz6OO1BMa32iLWJy
         zglAToSt1/xvlfUh7UYSbslmwslOIHtgMqDS4kzgkryRSUYjOJGqwFm8E+C7eFtIqDLw
         LXRA==
X-Forwarded-Encrypted: i=1; AJvYcCXMHK0PMdDPbCHCwqKdKj+nTHZ70acsoZaZKO2EJRCo9k6v31j7LW++4BbjablprFwO7JoRPfuI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5x5soHxlVCRqe32aGyBZdvmcVCygDqoeGQCdrdbwEoehsmVwx
	BanP1eQCAmtzWqsd2ZotP6qpO+HM+waF/wwuHLO8MCkPMouw9GVfNgkK
X-Gm-Gg: ATEYQzzJVdVZ/2YWHml/dJ27ombzFYcN/cSB0/IqNpY2zhDKrMflut+lWnx6ZZAw7pf
	65NBETi8ky5EzzcevblvEkf4ABw0y4OJadW3gwvbrdqUHs9nnvb1QMbqLx+VdPKZp0p/N5IEg2O
	raZwtxcPSS55i0khYJw8zbcJqctBJJd325uGrwuRmKFYgrhfNJzXu8AXiotZX5MoQzOUXgiJ9Le
	cBr2bDJP6S65QmEbjg8cxD/ORSpiQuPHR0jPBG2DHX7p+Z971Am95OCNOwa2fKt+qzCQGMkhhMO
	wRCuf176SGXeELFPq+lvKiiMyK15G1hZSHxcQAk0nC7WquZSC+utHSegj6U7+dNPmfiiZE/3lYu
	vlcTxHeoPPBNMpxhVlHEHo2oml3Z99eWcuCXdOo0ekFCJWb/rhMeDipQNmmePYpU0kQxl7l+cgO
	oYlhJTmv578crAp3ijMKHAKA==
X-Received: by 2002:a05:6870:3c8b:b0:417:31f3:5def with SMTP id 586e51a60fabf-4177ca59b45mr2303457fac.32.1773258725506;
        Wed, 11 Mar 2026 12:52:05 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:46::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e64a931sm3100861fac.14.2026.03.11.12.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 12:52:05 -0700 (PDT)
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
Subject: [PATCH 08/11] mm/memcontrol: Track MEMCG_ZSWAPPED in bytes
Date: Wed, 11 Mar 2026 12:51:45 -0700
Message-ID: <20260311195153.4013476-9-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311195153.4013476-1-joshua.hahnjy@gmail.com>
References: <20260311195153.4013476-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,linux.dev,gmail.com,kernel.org,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	TAGGED_FROM(0.00)[bounces-14771-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D73E5269A52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Zswap compresses and uncompresses in PAGE_SIZE units, which simplifies
the accounting for how much memory it has compressed. However, when a
compressed object is stored at the boundary of two zspages, accounting
at a PAGE_SIZE granularity makes it difficult to fractionally charge
each backing zspage with the ratio of memory it backs for the
compressed object.

To make sub-PAGE_SIZE granularity charging possible for MEMCG_ZSWAPPED,
track the value in bytes and adjust its accounting accordingly.

No functional changes intended.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/memcontrol.h | 2 +-
 mm/memcontrol.c            | 5 +++--
 mm/zsmalloc.c              | 4 ++--
 mm/zswap.c                 | 8 +++++---
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 701d9ab6fef1..ce2e598b5963 100644
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
index 68139be66a4f..1cb02d2febe8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -342,7 +342,7 @@ static const unsigned int memcg_stat_items[] = {
 	MEMCG_VMALLOC,
 	MEMCG_KMEM,
 	MEMCG_ZSWAP_B,
-	MEMCG_ZSWAPPED,
+	MEMCG_ZSWAPPED_B,
 };
 
 #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
@@ -1364,7 +1364,7 @@ static const struct memory_stat memory_stats[] = {
 	{ "shmem",			NR_SHMEM			},
 #ifdef CONFIG_ZSWAP
 	{ "zswap",			MEMCG_ZSWAP_B			},
-	{ "zswapped",			MEMCG_ZSWAPPED			},
+	{ "zswapped",			MEMCG_ZSWAPPED_B		},
 #endif
 	{ "file_mapped",		NR_FILE_MAPPED			},
 	{ "file_dirty",			NR_FILE_DIRTY			},
@@ -1412,6 +1412,7 @@ static int memcg_page_state_unit(int item)
 	switch (item) {
 	case MEMCG_PERCPU_B:
 	case MEMCG_ZSWAP_B:
+	case MEMCG_ZSWAPPED_B:
 	case NR_SLAB_RECLAIMABLE_B:
 	case NR_SLAB_UNRECLAIMABLE_B:
 		return 1;
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 291194572a09..24665d7cd4a9 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1047,7 +1047,7 @@ static void zs_charge_objcg(struct zs_pool *pool, struct obj_cgroup *objcg,
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
 	mod_memcg_state(memcg, pool->compressed_stat, size);
-	mod_memcg_state(memcg, pool->uncompressed_stat, 1);
+	mod_memcg_state(memcg, pool->uncompressed_stat, PAGE_SIZE);
 	rcu_read_unlock();
 }
 
@@ -1066,7 +1066,7 @@ static void zs_uncharge_objcg(struct zs_pool *pool, struct obj_cgroup *objcg,
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
 	mod_memcg_state(memcg, pool->compressed_stat, -size);
-	mod_memcg_state(memcg, pool->uncompressed_stat, -1);
+	mod_memcg_state(memcg, pool->uncompressed_stat, -(int)PAGE_SIZE);
 	rcu_read_unlock();
 }
 #else
diff --git a/mm/zswap.c b/mm/zswap.c
index bca29a6e18f3..d81e2db4490b 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -257,7 +257,7 @@ static struct zswap_pool *zswap_pool_create(char *compressor)
 	/* unique name for each pool specifically required by zsmalloc */
 	snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_count));
 	pool->zs_pool = zs_create_pool(name, true, MEMCG_ZSWAP_B,
-				       MEMCG_ZSWAPPED);
+				       MEMCG_ZSWAPPED_B);
 	if (!pool->zs_pool)
 		goto error;
 
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
2.52.0


