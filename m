Return-Path: <cgroups+bounces-7122-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA8EA66D3A
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 09:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB4C188FD8C
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 07:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B841FCF47;
	Tue, 18 Mar 2025 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPALmsbw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CDA1F8753;
	Tue, 18 Mar 2025 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284734; cv=none; b=sOP7ICMH+5sQzxdtS7tuN6KhTNbjf3LvAETjvtheTKuQnS+jTmx6hvqSfKoQhbv2jTcSGDp41p7HmFL8IKqvBULfcI3josFT9DKLVNlgBmvoxMegqK0G5O5+rQehKEvBhE6m3eKIyegq9qy6BNowEyT0icvUvYNktJyZpqKtD+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284734; c=relaxed/simple;
	bh=8AIZR7VifItg46MbpI522Li+Emir8/MNMaSmkN5+zO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BMfCZYhDWbPnwEhlbBuI6/GBuGSWhVyjsYvJCOt+F/007x4k0xxakJmod0a7lkcWXO/T+cXwdvIt26JDdymX/xKizRsMTSseUUh3a/wELSHic/HryBX2ZLd2sj5u/FkEy5lnNpTzshgAnZLCfRYT/DhClxCED1CyOOlNNevrlD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPALmsbw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224171d6826so456405ad.3;
        Tue, 18 Mar 2025 00:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742284732; x=1742889532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxXzV7DwlTDF8yOc5L7I2B68LYmEIw24ReUnP4B+up0=;
        b=PPALmsbwvyXsWSWk2yU4YsvDLnUmFbeleoStXoE1FdR2GepMcPbDe0U3bGNXDmFElj
         HK+wtqV0MiouQGvib4An9/k/RaWm+rU/6KhJv/b8SMSDhKSxTpbExWVdWsciqzZBFOPj
         byr8nI8w/bB2dRUfQ5fLn52oo84xN3R5j864UhGz711OmYASZNbHtTbeEy4eKVIIKeRn
         gc+st3QJc/v1ZsRd9FYqgqSW5HQC2GmcVzRN95+CrMgyAqImEEs0emvw1Y3kW3FaxzBA
         98FpBaTOWc5FGqF/ANooOywOx2LffK0QvFZw39ZfIkuLueTbcwrLJWS7zKEuZdghFwhK
         s0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742284732; x=1742889532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxXzV7DwlTDF8yOc5L7I2B68LYmEIw24ReUnP4B+up0=;
        b=u2hykgGz4JcN+aKsViHPqI32VN39xlTXtb21MltBi3M5w0gG5KsFY86AJvzelfSsYS
         sw/H9JaHfUSoExaRbbJE+4j8xFypyi0GfSdu2kYtyl4H00cg8CnFVm2KjHeJYO4mU/ag
         nVY9Avqmf0ABBTGvMNCq8IPMOs2z0SY4HFi1dw5K4WOu3bKq4dlCTk9TK7yCU08nmFfA
         qZo1RWJNokDwK93MJ9dU1FQIV8wwCAvo/+bXYSX85RyR8tUAnhhfhiHZzHRPFgFtacmq
         rmCd4q2y7r9SGjq8+85IsVXhsJ488LFsol8ku+G0m9nAtjZSKbDb1ccwVJvBSuof5OeZ
         6hFw==
X-Forwarded-Encrypted: i=1; AJvYcCUG58jjDX3K0VLG6c2/B6Cg4dtDdDjaiCUNXeZyvY7o+tD5rOpycnOLA8Rh6yQGdPrSOIEmJqwTXtE=@vger.kernel.org, AJvYcCX2vlgTHiU77hGKhWrB5QDgX0ldZ+KU81ptfINrOtmqnORhjCFeT8kFyIhNNpFWobQl/pw3SeSdUkZ84oek@vger.kernel.org
X-Gm-Message-State: AOJu0YzjKa5kNEXNLDwZEiK4uJCcThDjw8iysl8NINmRYtnlHiD9vZGJ
	iatjGKwr33KUVNJ4WhkvuwnrhGaOIeX1lZ+ANq1M/GdxBBEo5Rpz
X-Gm-Gg: ASbGncvctti3s6FfnwpGUc6BGHwZ4GbYYexSb05LkGLpdzTaqyqle75BXGRxS/ucIex
	z06GEtv9GvQMY2VdxBRlbIeIk2ycDByu0/cHCop5yqz/RJuIUivE+tCK6lDybfue8DMMoX97qGv
	8bdCt6HWUDiU7Z5ifpQmlKxVKEZP4ORP8pSIGxcfnVcuMJdsgLS/QgeaNhE74E5s+Jx9PnacEB0
	wKm4wzo3p0J0oXBJYlH0PZ/gamXyslWatMtWARg/8NLbsiXuPguvWfAqSEjqtM8OOakm47sqCi0
	yKhTeTJY1du6YPlRuVoQ4KeM5S7TAJBc8aafeaVy2Zvz58xv4mBWVv5Gz1QD1Vo/5C4l1qj5hg=
	=
X-Google-Smtp-Source: AGHT+IG70M+3jC0+LlNGEu2YxLMWJbOVsC00G6HIxEPm5SmjKCbYKfZWcOZHy16UHVYEjTwiL26qDg==
X-Received: by 2002:a17:903:1a26:b0:224:c46:d166 with SMTP id d9443c01a7336-225e0b18f50mr238963125ad.40.1742284731742;
        Tue, 18 Mar 2025 00:58:51 -0700 (PDT)
Received: from localhost.localdomain ([103.165.80.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbfdfesm88149865ad.203.2025.03.18.00.58.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Mar 2025 00:58:51 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	corbet@lwn.net,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>
Subject: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from direct reclaim statistics
Date: Tue, 18 Mar 2025 15:58:32 +0800
Message-Id: <20250318075833.90615-2-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250318075833.90615-1-jiahao.kernel@gmail.com>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Jia <jiahao1@lixiang.com>

In proactive memory reclaim scenarios, it is necessary to
accurately track proactive reclaim statistics to dynamically
adjust the frequency and amount of memory being reclaimed
proactively. Currently, proactive reclaim is included in
direct reclaim statistics, which can make these
direct reclaim statistics misleading.

Therefore, separate proactive reclaim memory from the
direct reclaim counters by introducing new counters:
pgsteal_proactive, pgdemote_proactive, and pgscan_proactive,
to avoid confusion with direct reclaim.

Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  9 +++++++
 include/linux/mmzone.h                  |  1 +
 include/linux/vm_event_item.h           |  2 ++
 mm/memcontrol.c                         |  7 +++++
 mm/vmscan.c                             | 35 ++++++++++++++-----------
 mm/vmstat.c                             |  3 +++
 6 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index cb1b4e759b7e..d6692607f80a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1570,6 +1570,9 @@ The following nested keys are defined.
 	  pgscan_khugepaged (npn)
 		Amount of scanned pages by khugepaged  (in an inactive LRU list)
 
+	  pgscan_proactive (npn)
+		Amount of scanned pages proactively (in an inactive LRU list)
+
 	  pgsteal_kswapd (npn)
 		Amount of reclaimed pages by kswapd
 
@@ -1579,6 +1582,9 @@ The following nested keys are defined.
 	  pgsteal_khugepaged (npn)
 		Amount of reclaimed pages by khugepaged
 
+	  pgsteal_proactive (npn)
+		Amount of reclaimed pages proactively
+
 	  pgfault (npn)
 		Total number of page faults incurred
 
@@ -1656,6 +1662,9 @@ The following nested keys are defined.
 	  pgdemote_khugepaged
 		Number of pages demoted by khugepaged.
 
+	  pgdemote_proactive
+		Number of pages demoted by proactively.
+
 	  hugetlb
 		Amount of memory used by hugetlb pages. This metric only shows
 		up if hugetlb usage is accounted for in memory.current (i.e.
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9540b41894da..69b4996dadc8 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -220,6 +220,7 @@ enum node_stat_item {
 	PGDEMOTE_KSWAPD,
 	PGDEMOTE_DIRECT,
 	PGDEMOTE_KHUGEPAGED,
+	PGDEMOTE_PROACTIVE,
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index f70d0958095c..f11b6fa9c5b3 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -41,9 +41,11 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		PGSTEAL_KSWAPD,
 		PGSTEAL_DIRECT,
 		PGSTEAL_KHUGEPAGED,
+		PGSTEAL_PROACTIVE,
 		PGSCAN_KSWAPD,
 		PGSCAN_DIRECT,
 		PGSCAN_KHUGEPAGED,
+		PGSCAN_PROACTIVE,
 		PGSCAN_DIRECT_THROTTLE,
 		PGSCAN_ANON,
 		PGSCAN_FILE,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4de6acb9b8ec..32e28ab90914 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -315,6 +315,7 @@ static const unsigned int memcg_node_stat_items[] = {
 	PGDEMOTE_KSWAPD,
 	PGDEMOTE_DIRECT,
 	PGDEMOTE_KHUGEPAGED,
+	PGDEMOTE_PROACTIVE,
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
@@ -431,9 +432,11 @@ static const unsigned int memcg_vm_event_stat[] = {
 	PGSCAN_KSWAPD,
 	PGSCAN_DIRECT,
 	PGSCAN_KHUGEPAGED,
+	PGSCAN_PROACTIVE,
 	PGSTEAL_KSWAPD,
 	PGSTEAL_DIRECT,
 	PGSTEAL_KHUGEPAGED,
+	PGSTEAL_PROACTIVE,
 	PGFAULT,
 	PGMAJFAULT,
 	PGREFILL,
@@ -1390,6 +1393,7 @@ static const struct memory_stat memory_stats[] = {
 	{ "pgdemote_kswapd",		PGDEMOTE_KSWAPD		},
 	{ "pgdemote_direct",		PGDEMOTE_DIRECT		},
 	{ "pgdemote_khugepaged",	PGDEMOTE_KHUGEPAGED	},
+	{ "pgdemote_proactive",		PGDEMOTE_PROACTIVE	},
 #ifdef CONFIG_NUMA_BALANCING
 	{ "pgpromote_success",		PGPROMOTE_SUCCESS	},
 #endif
@@ -1432,6 +1436,7 @@ static int memcg_page_state_output_unit(int item)
 	case PGDEMOTE_KSWAPD:
 	case PGDEMOTE_DIRECT:
 	case PGDEMOTE_KHUGEPAGED:
+	case PGDEMOTE_PROACTIVE:
 #ifdef CONFIG_NUMA_BALANCING
 	case PGPROMOTE_SUCCESS:
 #endif
@@ -1503,10 +1508,12 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	seq_buf_printf(s, "pgscan %lu\n",
 		       memcg_events(memcg, PGSCAN_KSWAPD) +
 		       memcg_events(memcg, PGSCAN_DIRECT) +
+		       memcg_events(memcg, PGSCAN_PROACTIVE) +
 		       memcg_events(memcg, PGSCAN_KHUGEPAGED));
 	seq_buf_printf(s, "pgsteal %lu\n",
 		       memcg_events(memcg, PGSTEAL_KSWAPD) +
 		       memcg_events(memcg, PGSTEAL_DIRECT) +
+		       memcg_events(memcg, PGSTEAL_PROACTIVE) +
 		       memcg_events(memcg, PGSTEAL_KHUGEPAGED));
 
 	for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c767d71c43d7..fa816cd08ac3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -441,21 +441,26 @@ void drop_slab(void)
 	} while ((freed >> shift++) > 1);
 }
 
-static int reclaimer_offset(void)
+#define CHECK_RECLAIMER_OFFSET(type)					\
+	do {								\
+		BUILD_BUG_ON(PGSTEAL_##type - PGSTEAL_KSWAPD !=		\
+			     PGDEMOTE_##type - PGDEMOTE_KSWAPD);	\
+		BUILD_BUG_ON(PGSTEAL_##type - PGSTEAL_KSWAPD !=		\
+			     PGSCAN_##type - PGSCAN_KSWAPD);		\
+	} while (0)
+
+static int reclaimer_offset(struct scan_control *sc)
 {
-	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD !=
-			PGDEMOTE_DIRECT - PGDEMOTE_KSWAPD);
-	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD !=
-			PGDEMOTE_KHUGEPAGED - PGDEMOTE_KSWAPD);
-	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD !=
-			PGSCAN_DIRECT - PGSCAN_KSWAPD);
-	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD !=
-			PGSCAN_KHUGEPAGED - PGSCAN_KSWAPD);
+	CHECK_RECLAIMER_OFFSET(DIRECT);
+	CHECK_RECLAIMER_OFFSET(KHUGEPAGED);
+	CHECK_RECLAIMER_OFFSET(PROACTIVE);
 
 	if (current_is_kswapd())
 		return 0;
 	if (current_is_khugepaged())
 		return PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD;
+	if (sc->proactive)
+		return PGSTEAL_PROACTIVE - PGSTEAL_KSWAPD;
 	return PGSTEAL_DIRECT - PGSTEAL_KSWAPD;
 }
 
@@ -1986,7 +1991,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 				     &nr_scanned, sc, lru);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
-	item = PGSCAN_KSWAPD + reclaimer_offset();
+	item = PGSCAN_KSWAPD + reclaimer_offset(sc);
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_scanned);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
@@ -2002,10 +2007,10 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	spin_lock_irq(&lruvec->lru_lock);
 	move_folios_to_lru(lruvec, &folio_list);
 
-	__mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(),
+	__mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),
 					stat.nr_demoted);
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
-	item = PGSTEAL_KSWAPD + reclaimer_offset();
+	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_reclaimed);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
@@ -4545,7 +4550,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 			break;
 	}
 
-	item = PGSCAN_KSWAPD + reclaimer_offset();
+	item = PGSCAN_KSWAPD + reclaimer_offset(sc);
 	if (!cgroup_reclaim(sc)) {
 		__count_vm_events(item, isolated);
 		__count_vm_events(PGREFILL, sorted);
@@ -4695,10 +4700,10 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 		reset_batch_size(walk);
 	}
 
-	__mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(),
+	__mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),
 					stat.nr_demoted);
 
-	item = PGSTEAL_KSWAPD + reclaimer_offset();
+	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, reclaimed);
 	__count_memcg_events(memcg, item, reclaimed);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 16bfe1c694dd..eff4d833ff8a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1273,6 +1273,7 @@ const char * const vmstat_text[] = {
 	"pgdemote_kswapd",
 	"pgdemote_direct",
 	"pgdemote_khugepaged",
+	"pgdemote_proactive",
 #ifdef CONFIG_HUGETLB_PAGE
 	"nr_hugetlb",
 #endif
@@ -1307,9 +1308,11 @@ const char * const vmstat_text[] = {
 	"pgsteal_kswapd",
 	"pgsteal_direct",
 	"pgsteal_khugepaged",
+	"pgsteal_proactive",
 	"pgscan_kswapd",
 	"pgscan_direct",
 	"pgscan_khugepaged",
+	"pgscan_proactive",
 	"pgscan_direct_throttle",
 	"pgscan_anon",
 	"pgscan_file",
-- 
2.34.1


