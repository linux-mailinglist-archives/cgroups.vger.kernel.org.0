Return-Path: <cgroups+bounces-11496-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 930A8C2A72E
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 08:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CBF3B8676
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 07:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4BB2D061C;
	Mon,  3 Nov 2025 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="aoxfi8Ra"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721E2C17B3
	for <cgroups@vger.kernel.org>; Mon,  3 Nov 2025 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156417; cv=none; b=bfvCq/wWv2ffRhyaOhCq5db5WQrjOpKEI6N6FhHk4kWdPZ+Ib/cvRjGtc4QpucvtbwQmJrYlRCtSlAjlijuVHQcO/e1IaEt4PlmFQKJzARkUN0E4ePAJOoZhGnfIFNu4xPxx1ftQEQbADjMQOmxvkdtE5xlsPNZ5iKHJiC1uVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156417; c=relaxed/simple;
	bh=11CarfubxZ0qqJeB0Vehw4TOzZTVQzHPXsWuRlypEew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkwh49GtkHdsdHVA7nuYg65DX7HSjnmzAxpOiql4vNYUcoWgwu5uLb3nbS6cFjD4NoX1CMzsDsEjBDuVdKLZ4bTDlRheMkFBtDNif84COK4hhSU24MTGxklWiouPCK4okheBmHBep4xHveVbf501rr72LBYR7/GV/u8S1KEfcNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=aoxfi8Ra; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3401314d845so5453259a91.1
        for <cgroups@vger.kernel.org>; Sun, 02 Nov 2025 23:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762156415; x=1762761215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M049GtTJOIx1jAzuZfnGS5SMrlVlEyxlsar/o1b4yF0=;
        b=aoxfi8Ra1FzgbVw0i+4G8onXMzKRoV0KsDT9xfY4lD3m8AjDKrQnM4V9jfkB0bXp3U
         5v4rfNYf8W7aDq+WPzUdJTCL8oEDX5UbwTZHiiyLBug2ODPpgqrOWumgTzsQ08tYMhxh
         Eagmcmb7nqAObF9R5BY5+UVhCWpRVwLNcKg7SpU8d7Rr5syovYj+ZWOoAQO1T+ov03ID
         zvdFxCHurOPAzAVXxT5DegQbSUQlMPr2Z8shr5Ucqu2JeWNTzc2qcuZsHtFGGRdc6xcb
         bV70Mlvt3NDdZKTel/+W+f2ipTMDuocX8yWgjqKObAfVgMBFgdPz06lQ2Ut68u6002nB
         QBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762156415; x=1762761215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M049GtTJOIx1jAzuZfnGS5SMrlVlEyxlsar/o1b4yF0=;
        b=WVOJtqkKViOT0Vv1Z49xkMrFQ8O8FUz4uzT+8xaCfkGsjsH5h5/2sWOv83NaogPuLY
         qx1ZjDLtmToe4Lw4qOFM6JGwtiFPTvdwoq1zajw16t/i7W/AEqHqofb2vG5ms993agmU
         5pAb9YJlm1c0bQENVZFE/yHCA8+H4ZEtQrY/j9JE/RUQTBU+UPdUWai10hCiR3HEkf8g
         m/sd/qVQgEkBLCQxFZBmWkzLKI2zAWsWT1kjL/+wgl/t92ZGtToUlRo48/XdjvzSv2Fq
         qutKsrn4ktxvkx8AQvyGR/R42yN4QT4vcTh/WJ+vx6R2DEDJoI0LqEap4/97qMQgrkIy
         H4FA==
X-Forwarded-Encrypted: i=1; AJvYcCXLsxE7/1zalRMsSzB9e6ik8HRodEug9z9lnntG7mFXtFMwpwyGDuAdG26JXylm2TzIB9JasdWg@vger.kernel.org
X-Gm-Message-State: AOJu0YwZsKNhnWqwj5xS6JtPcsNo1BODudF9+dKMVznP7wzKgpg1EUfq
	EGJV6izacnnJokbyGxjaCEf05BD7tGe+7MFUF1MzX9n5eY8TMWkfNL3iFZRwtqLsUv8=
X-Gm-Gg: ASbGnctvqbsOo8UPsf913BuevjJZKH9ndUdNYTIIpHyAg1jmDPaMg35Kn/RY09TKZZw
	Xt5rTtFtGB1Ky4aOeQkSyDEJlmkVvqk4/SG09n/vveeiFEyqLuhIIE/FANmoR4NiA16rwCvhy20
	tenidj+X54aIgm+bj9yKRmQMohsOnDbpCliOqaODqcBevMJNzbWVr5tMzrPMaXJBMSF99iUFN3V
	KoECHjla0RXnP4jBCoiPIa2ec1WSYQmxNfh4gDhc7p0XSUKDFIugc/saq0LaVd4djku/QYpXYne
	UO86B9AMJxhEevHI3MBIhAb8PqGPabFrfH2W3CysvBTP+d7gH+Uc36eECCTHq0k7kBWsjGgtXMt
	wIP9zvqL6uR39Qd5fXKAbKO4WL6WrffvoVEY2poKRF0qYaonoixcszmWJBYV3Emyw051esAn4ED
	2//Qg4AzHubhCVuXx8ArZ/AooR
X-Google-Smtp-Source: AGHT+IFNIljmMinHPhv4QokcHvxrVgwW0bD5RaqFND+JFxMKndgBolIUy2lVbgcYBW1Dd94/zRpM1A==
X-Received: by 2002:a17:90b:3fc3:b0:340:d1a1:af6d with SMTP id 98e67ed59e1d1-340d1a1b159mr8269845a91.36.1762156414854;
        Sun, 02 Nov 2025 23:53:34 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a16652sm34552a91.20.2025.11.02.23.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:53:34 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	lance.yang@linux.dev,
	leon.huangfu@shopee.com,
	shy828301@gmail.com,
	yosryahmed@google.com,
	sashal@kernel.org,
	vishal.moola@gmail.com,
	cerasuolodomenico@gmail.com,
	nphamcs@gmail.com,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Chris Li <chrisl@kernel.org>,
	Greg Thelen <gthelen@google.com>,
	Ivan Babrou <ivan@cloudflare.com>,
	Michal Koutny <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Wei Xu <weixugc@google.com>
Subject: [PATCH 6.6.y 6/7] mm: workingset: move the stats flush into workingset_test_recent()
Date: Mon,  3 Nov 2025 15:51:34 +0800
Message-ID: <20251103075135.20254-7-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103075135.20254-1-leon.huangfu@shopee.com>
References: <20251103075135.20254-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yosry Ahmed <yosryahmed@google.com>

[ Upstream commit b006847222623ac3cda8589d15379eac86a2bcb7 ]

The workingset code flushes the stats in workingset_refault() to get
accurate stats of the eviction memcg.  In preparation for more scoped
flushed and passing the eviction memcg to the flush call, move the call to
workingset_test_recent() where we have a pointer to the eviction memcg.

The flush call is sleepable, and cannot be made in an rcu read section.
Hence, minimize the rcu read section by also moving it into
workingset_test_recent().  Furthermore, instead of holding the rcu read
lock throughout workingset_test_recent(), only hold it briefly to get a
ref on the eviction memcg.  This allows us to make the flush call after we
get the eviction memcg.

As for workingset_refault(), nothing else there appears to be protected by
rcu.  The memcg of the faulted folio (which is not necessarily the same as
the eviction memcg) is protected by the folio lock, which is held from all
callsites.  Add a VM_BUG_ON() to make sure this doesn't change from under
us.

No functional change intended.

Link: https://lkml.kernel.org/r/20231129032154.3710765-5-yosryahmed@google.com
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Greg Thelen <gthelen@google.com>
Cc: Ivan Babrou <ivan@cloudflare.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Koutny <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Wei Xu <weixugc@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
---
 mm/workingset.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 9110957bec5b..6e61ad08df75 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -425,8 +425,16 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 	struct pglist_data *pgdat;
 	unsigned long eviction;

-	if (lru_gen_enabled())
-		return lru_gen_test_recent(shadow, file, &eviction_lruvec, &eviction, workingset);
+	rcu_read_lock();
+
+	if (lru_gen_enabled()) {
+		bool recent = lru_gen_test_recent(shadow, file,
+				&eviction_lruvec, &eviction, workingset);
+
+		rcu_read_unlock();
+		return recent;
+	}
+

 	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workingset);
 	eviction <<= bucket_order;
@@ -448,8 +456,16 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 	 * configurations instead.
 	 */
 	eviction_memcg = mem_cgroup_from_id(memcgid);
-	if (!mem_cgroup_disabled() && !eviction_memcg)
+	if (!mem_cgroup_disabled() &&
+	    (!eviction_memcg || !mem_cgroup_tryget(eviction_memcg))) {
+		rcu_read_unlock();
 		return false;
+	}
+
+	rcu_read_unlock();
+
+	/* Flush stats (and potentially sleep) outside the RCU read section */
+	mem_cgroup_flush_stats_ratelimited();

 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
 	refault = atomic_long_read(&eviction_lruvec->nonresident_age);
@@ -493,6 +509,7 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 		}
 	}

+	mem_cgroup_put(eviction_memcg);
 	return refault_distance <= workingset_size;
 }

@@ -519,19 +536,16 @@ void workingset_refault(struct folio *folio, void *shadow)
 		return;
 	}

-	/* Flush stats (and potentially sleep) before holding RCU read lock */
-	mem_cgroup_flush_stats_ratelimited();
-
-	rcu_read_lock();
-
 	/*
 	 * The activation decision for this folio is made at the level
 	 * where the eviction occurred, as that is where the LRU order
 	 * during folio reclaim is being determined.
 	 *
 	 * However, the cgroup that will own the folio is the one that
-	 * is actually experiencing the refault event.
+	 * is actually experiencing the refault event. Make sure the folio is
+	 * locked to guarantee folio_memcg() stability throughout.
 	 */
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	nr = folio_nr_pages(folio);
 	memcg = folio_memcg(folio);
 	pgdat = folio_pgdat(folio);
@@ -540,7 +554,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);

 	if (!workingset_test_recent(shadow, file, &workingset))
-		goto out;
+		return;

 	folio_set_active(folio);
 	workingset_age_nonresident(lruvec, nr);
@@ -556,8 +570,6 @@ void workingset_refault(struct folio *folio, void *shadow)
 		lru_note_cost_refault(folio);
 		mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file, nr);
 	}
-out:
-	rcu_read_unlock();
 }

 /**
--
2.50.1

