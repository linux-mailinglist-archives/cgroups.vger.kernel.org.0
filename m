Return-Path: <cgroups+bounces-4872-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20512977B7E
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2024 10:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE381F232D9
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2024 08:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28041D86D9;
	Fri, 13 Sep 2024 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D68tsCrY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312FD1C1739;
	Fri, 13 Sep 2024 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217105; cv=none; b=u8KoeevtqQIXycIYRDVjIcfxkI5aQaZlbwI4KHb3/uyN8eTPsir1v+xdMFwFJxFBZXxm1WmdhuUobGstG8QvpMPY6eJ7+1e6Ru0KkkmYQMZPAJjrjBGGlyGQKQJNOIaGa85dvBVL0Ez/w1Iey/u4Z3IgcGJ4z6LQHdn1Bamxk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217105; c=relaxed/simple;
	bh=KWhYi+qvNeCAr97t6ZVq3R1AolA5LQ3hOHzwcaUUC64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDImDo5oJYs+qNmxL+Ja3st7c9RCMUsmg+2lhIgizvUfl6naRqEkDQJOftVYV372HkYMrtnApBAf1GpWlejYlVL0ys6Lug5y+td+36ITzU0xWYBnRi17IDv2hvBOMCQdfYOMpS23gRr79Tva3YpIXc9y+f21PERvSIm6InDscwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D68tsCrY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7191901abd6so498090b3a.3;
        Fri, 13 Sep 2024 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726217103; x=1726821903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUS5oZWz1q1hL0PjDhEQP80uJLgD2DBG0JdaSzX6lAM=;
        b=D68tsCrYB2Tu5PnnOionEnigtSS8TLgCrgKr+p4srF3qZOs1SIgb/9et/EWgcnhcoZ
         woQY6RaEev6iXvC40ARnb5qhmAS0MeZRGXfhRCHP1ct1yA1Ektx62Z+fXQ6A4sNXJYKr
         dCznTCnOwy1Ib6tDaMmbtTgqKmRruA7vP2tyVFyMDOVQmTHB5j+8zgUDpCF61v5mleYI
         8u56nZ9fH5YAfmAzE0tD0h8UozuwNStTs4+8Yy1+S2PFrOC2xIhmHyiuMKiPc1CqSsyF
         woz41O28qXgAU/olH31QvpCFnML9Gxtj6HGDWefa/BkstKvNuyRimslSEgytVrlOxZ1v
         wIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726217103; x=1726821903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUS5oZWz1q1hL0PjDhEQP80uJLgD2DBG0JdaSzX6lAM=;
        b=nUF6kE3lb5XYlaYZAw5FVyWKCadxMWyKWoNMRAUv3RlSct96V6drYg9J4P6TVfV5n4
         FW8v5eRhzEKu079i/XIwry+6hPcmXkVZDF8ttbkR1+HabPgjUlGFZLUyF55r4Mh7cxYd
         9r02vLgoDMSHqWOVrprlbvp4jW25bedpa6H1YTmOItRBflWkOnndC/fWi7mTN+xo1/6u
         XeqkTHWwrN63ET+2WR200xDGHAXdvuM5Am135VLltdXfAU+SHfc3INNkfQ9eXFVgg11s
         HirlDtyJnsCpmnuj76t+OlkOpA+d6rjt8osFR/ntc+K3cJxxn17f1OUFj5VwGRVuxtq7
         J09g==
X-Forwarded-Encrypted: i=1; AJvYcCXMnB2AbXJ7e8D9AQBORkfRu5XqCJbYdZLVih46Ypvrys2NQwHPRsRGEKbiGaTGf++SjoMzoAic@vger.kernel.org, AJvYcCXPGBOYyApmvSa4bnAnzpmiJBEtqPnLomG6M65TO2zmjkShxKsqbiDf8THVY0Sijq92XXwVOAWU5sPLvYrx@vger.kernel.org
X-Gm-Message-State: AOJu0YxchViZHHjDvJBrb11ZSwVRO21QuVhhMlGTzg484vzRW2W23FD1
	3EVcX2IKW14WeMtKlCqnUrWwsqYA2tZla0MpooTyP4+3BFw7+c5r
X-Google-Smtp-Source: AGHT+IFM3fsIXbQsAGSP8vEDOA2RW06x2PLYcdAG+HgQRZL8tAE5rlmiB9X133hAyyTkQv9uiljeEQ==
X-Received: by 2002:a05:6a20:c6ce:b0:1cf:4fa8:49f2 with SMTP id adf61e73a8af0-1d112eb2521mr2897580637.49.1726217103144;
        Fri, 13 Sep 2024 01:45:03 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.161])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fc8506sm5696295b3a.5.2024.09.13.01.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 01:45:02 -0700 (PDT)
From: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linuszeng@tencent.com,
	linux-kernel@vger.kernel.org,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	yosryahmed@google.com
Subject: [PATCH V2] mm/memcontrol: add per-memcg pgpgin/pswpin counter
Date: Fri, 13 Sep 2024 16:44:53 +0800
Message-ID: <20240913084453.3605621-1-jingxiangzeng.cas@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <Jingxiang Zeng <linuszeng@tencent.com>
References: <Jingxiang Zeng <linuszeng@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jingxiang Zeng <linuszeng@tencent.com>

In proactive memory reclamation scenarios, it is necessary to estimate the
pswpin and pswpout metrics of the cgroup to determine whether to continue
reclaiming anonymous pages in the current batch.  This patch will collect
these metrics and expose them.

Link: https://lkml.kernel.org/r/20240830082244.156923-1-jingxiangzeng.cas@gmail.com
Signed-off-by: Jingxiang Zeng <linuszeng@tencent.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/memcontrol.c | 2 ++
 mm/page_io.c    | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6efbfc9399d0..dbc1d43a5c4c 100644
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


