Return-Path: <cgroups+bounces-5273-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2259B13F0
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 02:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E0D8B21E73
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 00:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29FBAD2F;
	Sat, 26 Oct 2024 00:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/xosGhl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB508460
	for <cgroups@vger.kernel.org>; Sat, 26 Oct 2024 00:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729903719; cv=none; b=k/J/J3t6bKwqy5MxtlfJJH73PTk5Om3dEN04Mf9IXX4JJNU27Rw2Fuw7A1wIWoQaX+adTvYRlX0gnzjBtNgc1wZNmu2RHIg3ln1BMtdh7aiYUg72twv8Zj2LMNIqOZ6oCSGyCB5OG8xavJZYxbhkbo11I1ghSGiE9F0OeuXSNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729903719; c=relaxed/simple;
	bh=CFc6xsh79AlT1IwPlMYYlZUz+LIsbvClmVJBLdSAzHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgzS5xkkE1l+6t4Wr1mxgKz5L26Ce5Bc+9dZgD40HYGyi0f5q2h2wmcCXOsiIvpIUuFcOwjlLslFNPOa4J+zURARWTXgo8mZ2+q9oOLX6lYzO91Qv+n/lr0nq+nEl4s5ebRswO2NB2PWX7KIjP7b+1lxsY2LWoqF4a12jeO8KSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/xosGhl; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2eb9dde40so1995498a91.0
        for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 17:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729903717; x=1730508517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7wkW5g8TgqYKms/EFJSg4ezSMWpKMTpB9wnMr55mBM=;
        b=Q/xosGhlhAWI4D3UGKA+rz1rypWyZS4j2bQ2cQS67DQ86gtOp94UpwazaVSfZ5703O
         PvBM0AsaG8zGOwRYE+pqyiohSkja5Zats8pCc/HN4wUqcKs+/BO2ysMCZp/ARvaT2Zyg
         ojjnlujDB6yq339uzXCY8CKN0y1StX4xVUEsZ6Nc+mPBlvybqq+LbiRxvn1TXYrGYOEK
         m/rdahhBQnxX4dl8d8m3yb68dz8XFj/PE9TxzP/FqwpQowA5XnWvjhMLPigoxi5Wu/Lg
         sVkUZIzMRVJH0AN4AGfMKNF3f+vx+MPO+m1OPpfefsiT7IXqU/Vx6fNPv8rTdIdUHgUt
         /alQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729903717; x=1730508517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7wkW5g8TgqYKms/EFJSg4ezSMWpKMTpB9wnMr55mBM=;
        b=ry/mIZ5kxMi8suu8FAETZfokjeaU3jQgDnIiavYarRRcV/nW5MkpvBaX+EcZWmNrI2
         3YG4ZrVrKoC/jH+UGGkQjnHNr76hsgJx6JOUlW1zgiyG0T7TW9IrzZiRhbCOJG2owHaq
         AuGHtcqCP+RhPE3kkpswrbhPen/wFK+ADpSExZE5d2IMYLom40c4hN75WpYW+0puEEEm
         RXYBLAxVjLDOxnmKaEsJvQJM8nJttFwF3VoHnHgNy5qA+/a8gT4Yod0DYS4WAgDaENfR
         i5JJjT7Xo6D/NZMfFw+HzVI1Ptd/KHezKvxup+hHCxi4L9JKGhv9q2vQdXotOBwojwRT
         1j2w==
X-Forwarded-Encrypted: i=1; AJvYcCU+8JZInp3beQwuA0D1slGs5RT8GV6K1mnsBN+v5takXEQKjVIzVGMaQKuOgSCyz3GSalpMSYsu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8qrBeqRtnPlNQZclzH58KQK72HwOl02YRLAj6n2slhcQtGLgw
	DvkyCfZ0aa9N2buVHlemgGgcI6XxFJWbdfRHKZxrWoKxuSEjouK0
X-Google-Smtp-Source: AGHT+IGRa7wyJzb72DXQWRWTr+119ZVVaA6HoCFe7k1c8dGjMI4ZUfJOYX++19OXxKJqpUeCJq4grg==
X-Received: by 2002:a17:90a:ca07:b0:2e2:e597:6cdc with SMTP id 98e67ed59e1d1-2e8f107c680mr1496488a91.22.1729903717298;
        Fri, 25 Oct 2024 17:48:37 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48ad66sm4249738a91.4.2024.10.25.17.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 17:48:36 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org,
	rostedt@goodmis.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 2/2 v2] memcg: use memcg flush tracepoint
Date: Fri, 25 Oct 2024 17:48:26 -0700
Message-ID: <20241026004826.55351-3-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241026004826.55351-1-inwardvessel@gmail.com>
References: <20241026004826.55351-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of the memcg flush tracepoint within memcontrol.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 mm/memcontrol.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 18c3f513d766..c3d6163aaa1c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -588,8 +588,16 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	}
 }
 
-static void do_flush_stats(struct mem_cgroup *memcg)
+static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
 {
+	bool needs_flush = memcg_vmstats_needs_flush(memcg->vmstats);
+
+	trace_memcg_flush_stats(memcg, atomic64_read(&memcg->vmstats->stats_updates),
+		force, needs_flush);
+
+	if (!force && !needs_flush)
+		return;
+
 	if (mem_cgroup_is_root(memcg))
 		WRITE_ONCE(flush_last_time, jiffies_64);
 
@@ -613,8 +621,7 @@ void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 	if (!memcg)
 		memcg = root_mem_cgroup;
 
-	if (memcg_vmstats_needs_flush(memcg->vmstats))
-		do_flush_stats(memcg);
+	__mem_cgroup_flush_stats(memcg, false);
 }
 
 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
@@ -630,7 +637,7 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	 * Deliberately ignore memcg_vmstats_needs_flush() here so that flushing
 	 * in latency-sensitive paths is as cheap as possible.
 	 */
-	do_flush_stats(root_mem_cgroup);
+	__mem_cgroup_flush_stats(root_mem_cgroup, true);
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
@@ -5281,11 +5288,8 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 			break;
 		}
 
-		/*
-		 * mem_cgroup_flush_stats() ignores small changes. Use
-		 * do_flush_stats() directly to get accurate stats for charging.
-		 */
-		do_flush_stats(memcg);
+		/* Force flush to get accurate stats for charging */
+		__mem_cgroup_flush_stats(memcg, true);
 		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
 		if (pages < max)
 			continue;
-- 
2.47.0


