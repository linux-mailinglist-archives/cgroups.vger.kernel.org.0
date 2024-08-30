Return-Path: <cgroups+bounces-4604-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E915965A28
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 10:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC291F24A39
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 08:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F67816C689;
	Fri, 30 Aug 2024 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1dfjJZM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D313A16BE2B;
	Fri, 30 Aug 2024 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006175; cv=none; b=q12WNm+OeMNg4+FsaUnQyzHF8PQzp6kkO0kZElZ8cuyJ5VY3hoHOXGG4Tz4XpNwb86U1hEnRpiL6qK4Md770axoir97g8thSGH4lzCAii7SeTTyA1dxsotcq05bUkUBHYwZAoT8WDga+SaszWY/b9uel2QX51zdbpfdu5ckenhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006175; c=relaxed/simple;
	bh=6iDvifggTaOH44UT6njNqiYwywcsxgrNyE7xGZicVig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RvzeA/O4A83Vrbwqq/SUK9WgKchMQu6y7we1Gf+iCJAvWzviR2cIAhnGh/pl/4lPrGfJxt2ihVFglgjvAjSC/Hajo86ZHej4RQTF427vQsYZrjqZc1UHs3xl1vJncbP6Sfp5c++6tw3A56diqiJtNOsHsn4O/vfbZN4RNPKRjOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1dfjJZM; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-70b2421471aso877184a12.0;
        Fri, 30 Aug 2024 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725006173; x=1725610973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ewjWosioynS9QjLJzPP/p/LP8/+o765Ca4TuY9GDfQ=;
        b=k1dfjJZMt0lNcdPfK75op0O8dmVNd95ycLZmSOhUZUMH8G9uLAbXuf1BxkDEFOZPCG
         ASbE+4UM/CWCGVDAykO2jMe6FT1kyBoOuoxfLipzbZNrdXRlHvSlPUCSLhCyW1OflU/E
         4LFQ0Dtx0KJYlOBdC3k8Xzc6gbvOE405LY2L5z57kJYuoj7VxjYsfTxrP4hhaP/w4t87
         QL+IYi+ytpNP6fMf6QtJ8iMFmHNycVur+/5kcJDUT3DHMY8DaSwaj/A9AzE2o/0zBGr6
         YM1e8QBjyfrck6XGlSYaE5p+JCqQ9pX9hrwco7kQrFnsPI4BUyC9+cnM1xJLh3Yoy8j5
         /1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725006173; x=1725610973;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ewjWosioynS9QjLJzPP/p/LP8/+o765Ca4TuY9GDfQ=;
        b=nc9rjiPLegfmhHk3UXjJpW3I3qkHuHbqqVXWmRsjYZvx2ls4FCA9B+WGca34OHBqa9
         kE9elaWjy0OBi6KOFIijUI4wn5HxnM+r4s+gXyAVruBPj2xfUfZpseww2Yf+3uWP18EL
         8NgKE+n7TtLfy4moRCrPttbzh0f76WGWxMczQevJN254QsaN5QpGDzgEcoN3Fy1Q/eyX
         zs0ho1xFgVRaB7xQAE2a4Rlz5bUSc6L4rqMrGowV1aeYuhdbDfdX/Yhnlf1DsnRDBf3/
         nbUc6Au/qiMB5wOtQqvdcGqAsIJ0I3aCpm3gb1Hbv2xY/gfFiuF/oGR41kfHEq4ig9Ub
         pkEg==
X-Forwarded-Encrypted: i=1; AJvYcCULvMC+0a3mOp222N8vUih73rQTrtia/hXbbDWaehdXKngo40A0pySBIRrp0Qy2hPPfdeaine7s@vger.kernel.org, AJvYcCVQ4EY2P11zr8l4+lwu+BSt6XPElfcJ4YmtbYljYQerg0qHWPuRBu2m0UTBy8t7wHQbDsliDfs3TG5N6wDa@vger.kernel.org
X-Gm-Message-State: AOJu0YwdaQyJsi0NAeLUCWIXdg+NJu6w81QPzbpcUjQj0SEQk6DnOU0r
	fBDhT7Kgv9phK6Nk/boLdSGpyzJctHU3cLNZ8ynAQkcTPZvrd9Rk
X-Google-Smtp-Source: AGHT+IGdtecW2ZO4g4vdfngXfhM0JCRsaqI0LNGJZiq1ZEecxwo+Hlehe5MApd/ZlNiDNIysqYKRJw==
X-Received: by 2002:a17:90a:e7c6:b0:2c9:7849:4e22 with SMTP id 98e67ed59e1d1-2d85618c33emr5718939a91.8.1725006172936;
        Fri, 30 Aug 2024 01:22:52 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b12553asm3165774a91.22.2024.08.30.01.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:22:52 -0700 (PDT)
From: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
To: linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jingxiang Zeng <linuszeng@tencent.com>
Subject: [PATCH] mm/memcontrol: add per-memcg pgpgin/pswpin counter
Date: Fri, 30 Aug 2024 16:22:44 +0800
Message-ID: <20240830082244.156923-1-jingxiangzeng.cas@gmail.com>
X-Mailer: git-send-email 2.43.5
Reply-To: Jingxiang Zeng <linuszeng@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jingxiang Zeng <linuszeng@tencent.com>

In proactive memory reclamation scenarios, it is necessary to
estimate the pswpin and pswpout metrics of the cgroup to
determine whether to continue reclaiming anonymous pages in
the current batch. This patch will collect these metrics and
expose them.

Signed-off-by: Jingxiang Zeng <linuszeng@tencent.com>
---
 mm/memcontrol-v1.c | 2 ++
 mm/memcontrol.c    | 2 ++
 mm/page_io.c       | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index b37c0d870816..44803cbea38a 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -2729,6 +2729,8 @@ static const char *const memcg1_stat_names[] = {
 static const unsigned int memcg1_events[] = {
 	PGPGIN,
 	PGPGOUT,
+	PSWPIN,
+	PSWPOUT,
 	PGFAULT,
 	PGMAJFAULT,
 };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 087a8cb1a6d8..dde3d026f174 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -418,6 +418,8 @@ static const unsigned int memcg_vm_event_stat[] = {
 	PGPGIN,
 	PGPGOUT,
 #endif
+	PSWPIN,
+	PSWPOUT,
 	PGSCAN_KSWAPD,
 	PGSCAN_DIRECT,
 	PGSCAN_KHUGEPAGED,
diff --git a/mm/page_io.c b/mm/page_io.c
index b6f1519d63b0..4bc77d1c6bfa 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -310,6 +310,7 @@ static inline void count_swpout_vm_event(struct folio *folio)
 	}
 	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
 #endif
+	count_memcg_folio_events(folio, PSWPOUT, folio_nr_pages(folio));
 	count_vm_events(PSWPOUT, folio_nr_pages(folio));
 }
 
@@ -505,6 +506,7 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 		for (p = 0; p < sio->pages; p++) {
 			struct folio *folio = page_folio(sio->bvec[p].bv_page);
 
+			count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
 			folio_mark_uptodate(folio);
 			folio_unlock(folio);
 		}
@@ -588,6 +590,7 @@ static void swap_read_folio_bdev_sync(struct folio *folio,
 	 * attempt to access it in the page fault retry time check.
 	 */
 	get_task_struct(current);
+	count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
 	count_vm_event(PSWPIN);
 	submit_bio_wait(&bio);
 	__end_swap_bio_read(&bio);
@@ -603,6 +606,7 @@ static void swap_read_folio_bdev_async(struct folio *folio,
 	bio->bi_iter.bi_sector = swap_folio_sector(folio);
 	bio->bi_end_io = end_swap_bio_read;
 	bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
+	count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
 	count_vm_event(PSWPIN);
 	submit_bio(bio);
 }
-- 
2.43.5


