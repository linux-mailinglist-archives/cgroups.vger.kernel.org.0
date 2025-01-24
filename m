Return-Path: <cgroups+bounces-6255-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998B4A1AF73
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 05:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89343AD247
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 04:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A9E1D90A7;
	Fri, 24 Jan 2025 04:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="fY9ieqYi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E0C1D6DB9
	for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 04:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737693555; cv=none; b=c9fHBNhlSA1oGPyK+3jxRvZoI8FyxtrbxCovZ/GG2c8Y0jry56PUWm50qBPMZ/72tZOsnGaAUC3Sj3/FQ4mG84vecLVvr1bxyHlVCL+0EXsO0iePRUMFsJ3VQpVlqeE6RA9jPl8HqWCyH6e78wn/GDciWrlYlH65MKaLRB0KqqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737693555; c=relaxed/simple;
	bh=kATDggIopDDwP7ERBuEvjQHCXfmUFtIVB7lXDOPi7j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAgBEit8UuL1iixS93aHmeImDHtyVsPmnnxd8LS7f9w5tbF6zUhyCuHTGtA6vUrSWAgYlA3OtnYIwL7ZguUwwUAev7ol95e3HR8Om+R0vQ/1ggo9bpJ4NX/N04z6sgAkm+wKuanDSaSqkRfwseU1zRWf9Y/8LJqUKxoy/nSkpV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=fY9ieqYi; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so12121836d6.1
        for <cgroups@vger.kernel.org>; Thu, 23 Jan 2025 20:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1737693552; x=1738298352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnF2WFHU7nDHUVLzoV/yB+mhbLnUF5NDJKTsZnkB61Q=;
        b=fY9ieqYiEszaYFz2h53VZzwL+zu7cQi43XhggwqcPoyrg2pT1DKlDayRPGM8uxoN0G
         6pwxRRIgZPXYXDxv/tdPFxr8Exbf+EqUDfo1nvRfmYN0veY5GKtZuABahA9v0XmvM4Fj
         seLuNN2dV/WD8NobPNm3MhUsjAdOEJbhthVrJPPLkhSKFEcPh1xn8azrHweontAzre07
         mM4ljM7oi+1qCXUpRmB7hC7nas56pI8thuw7t4yihKA2NNhuZyx0IxHmyLAX47lxMvy/
         my18Ey0oh2J4H4uGHL9tpvMx9S2GANh0m/0EfwLWdT9RQRXRx397PKRKKhqJhxS78jAr
         k7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737693552; x=1738298352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnF2WFHU7nDHUVLzoV/yB+mhbLnUF5NDJKTsZnkB61Q=;
        b=SfPjTXiQBauSTQ8M51HEBGX/rxf0YirMBZqs4BAtHfXveLTB9KDCObxDayzCV5Lupv
         itQmw5eCpJ9XuFw+rrNXyZSOc9SDnObTr2xKBz3oa1RiD8D86mUV2iyn3aCjZ0ZUPHV5
         NBqjWGa0H31daRBfiwoXvorLJTFwfvhtMeNeyuWEJfpEPfJQHaiQgzG2Ob4oSOJ7Bs0a
         SSsaMWRC58ODcjs0s1bMkvXCg47SY9L+ZBiXutKi6ADSeE5D7ReqlMh4p7KNEpljaVaj
         66UDysgmQQhQtOqaHraw+MAKz69EEssEppddPQ33YxFXzsL8o55KxuY1m0bzCiOsDU3C
         wheg==
X-Forwarded-Encrypted: i=1; AJvYcCX2tzYPZfB2gm6StOCj3HXRPfQyRidDONHV5Ph8RbiIMs7/MMKM+I/UZEYu+oQENDgo58b7MxS5@vger.kernel.org
X-Gm-Message-State: AOJu0YwUhtrHzJJvhPgwr2lKTapJYYqBDRnh5oSv5wsci8iSWBcITwbC
	di3fB3hoxJfc6D7YcHF7WuAKvEn0Nl7crCAghhiRUX4cVn5qohAjfvxhwOHqk908rgS4l2spae7
	U
X-Gm-Gg: ASbGnct9iLFypSQ6D3y80qP8v8rv3/snxcrhWxg6Bd+zi6/iQs5mBb33UbMSBSYL6/x
	xoCTGuzZYa+gVzUFWFf5PKXMS9i5hFRYp3RAr3g5DTDjFHUajLOyZeRt/ZmN6CuDzqhKDD548L6
	kV//1k4cpkHWCkBVhukkxPJzLDs/lHaal5gmfHg2rCOmmHjBcvUCgJ+L7mYmvws2lAJYbQOM9UR
	1kTmBMyvztbH51nKGarWh2lnNFViwKxzWvdwniTS3d7C/rvheOnFYQEdyIpkryeeXIUwa90u3QJ
	P04=
X-Google-Smtp-Source: AGHT+IF0FE+5UCpTw4hYqqLVu1wQ2oa1lJMAASSqMbEe84oBKZFcwsMVsPJAoGxLDr/qRFkSg/SVhg==
X-Received: by 2002:ad4:5961:0:b0:6d8:7e03:c427 with SMTP id 6a1803df08f44-6e1b21cd940mr423948956d6.20.1737693552056;
        Thu, 23 Jan 2025 20:39:12 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:cbb0:8ad0:a429:60f5])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e2057a87bdsm5151006d6.77.2025.01.23.20.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 20:39:11 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: memcontrol: move stray ratelimit bits to v1
Date: Thu, 23 Jan 2025 23:38:59 -0500
Message-ID: <20250124043859.18808-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124043859.18808-1-hannes@cmpxchg.org>
References: <20250124043859.18808-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

41213dd0f816 ("memcg: move mem_cgroup_event_ratelimit to v1 code")
left this one behind. There are no v2 references.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol-v1.c | 13 +++++++++++++
 mm/memcontrol-v1.h | 12 ------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 2be6b9112808..6d184fae0ad1 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -490,6 +490,19 @@ static void mem_cgroup_threshold(struct mem_cgroup *memcg)
 }
 
 /* Cgroup1: threshold notifications & softlimit tree updates */
+
+/*
+ * Per memcg event counter is incremented at every pagein/pageout. With THP,
+ * it will be incremented by the number of pages. This counter is used
+ * to trigger some periodic events. This is straightforward and better
+ * than using jiffies etc. to handle periodic memcg event.
+ */
+enum mem_cgroup_events_target {
+	MEM_CGROUP_TARGET_THRESH,
+	MEM_CGROUP_TARGET_SOFTLIMIT,
+	MEM_CGROUP_NTARGETS,
+};
+
 struct memcg1_events_percpu {
 	unsigned long nr_page_events;
 	unsigned long targets[MEM_CGROUP_NTARGETS];
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 6dd7eaf96856..4c8f36430fe9 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -28,18 +28,6 @@ static inline bool do_memsw_account(void)
 	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
 }
 
-/*
- * Per memcg event counter is incremented at every pagein/pageout. With THP,
- * it will be incremented by the number of pages. This counter is used
- * to trigger some periodic events. This is straightforward and better
- * than using jiffies etc. to handle periodic memcg event.
- */
-enum mem_cgroup_events_target {
-	MEM_CGROUP_TARGET_THRESH,
-	MEM_CGROUP_TARGET_SOFTLIMIT,
-	MEM_CGROUP_NTARGETS,
-};
-
 unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
 
 void drain_all_stock(struct mem_cgroup *root_memcg);
-- 
2.48.1


