Return-Path: <cgroups+bounces-666-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 877347FCD6B
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 04:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92631C20FF9
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 03:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF565673;
	Wed, 29 Nov 2023 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZ/yirB/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B743A19BB
	for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 19:22:08 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d1b431fa7bso20791347b3.1
        for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 19:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701228128; x=1701832928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GMYQlWUldBV9LWasymxz6cRCo6mSsi6IzDXKk+8BatU=;
        b=AZ/yirB/44st1c2ZHKBLXqzRbxEasy3KBBPGJALG7aHWkTWAW6SJwB49v+Nkz4U5m5
         8IIjgEvQfBPuM34E2f2eiEXoluDlyAzXsDwmwHq2lCpCN78fr/FdAMJKvjGV6o4VJSbM
         5dWuikSJx6swS7wEYfibZKtD3ymHsxK9YSOHGDo5qJWc6w8vyt/6Z3oW+RxU5JmU8NxG
         CrDWIZBk/vGYtRDZtO/3Kq9P+jZZ2iHbWCRNkOrgtDCc+TpnPP4EF4AvzRUg29AvLIIX
         kj1kBSMiSqYAlhE1ELnbhhLRirFG9jf9GMpRNbRcwkZq14LL3tXudmR6QEyqNVdkri3o
         Mpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701228128; x=1701832928;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMYQlWUldBV9LWasymxz6cRCo6mSsi6IzDXKk+8BatU=;
        b=K9MbNZ+QdtwDUHlc1XWsg27Y60V+ztN/y12djplKlRsZzNaOCPOL4galF17TVi3ULD
         PJr2lRsmO6/S8DNgixclVh2r053kGAltU72OGOidyGIgS0fZD2/Yd8sYuiTJCcu6PYus
         NM9boKZ9FfzKb50snrRLX/XEuNMpEvyqanOGgYE9fGUbXkYTkN4i+o+S4f4MaHtjAECT
         lLn8hG4x43E0Fh+ajvjaQ2ye/Z6YuxnX+yGnOUAl6INlPsgRYDSSpLF0geROEBv+xuvQ
         iQKKcak1onbYOW7oGLnqUuMY/50f6VL+61fNHFNfLMJiTjRVPaX3kCGWizg2FtT7QToX
         kMiA==
X-Gm-Message-State: AOJu0YwaJANELuirLZz4lnH7X3UwVQrpNbLxipNgWQIq/FcJYo6ak+sB
	JPz2Z8tUe3/Cy6Wu9HSKt6mJY8nGDpwuCuen
X-Google-Smtp-Source: AGHT+IF6lUJvoUePL6awLPUorDhmrelziQ66K/nBRxKZkO4u8ApkLFgb5tzVr7krTn6SjMgmlcBKg7J4Ix+mgnzs
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:f84:b0:5ca:ad72:2d78 with SMTP
 id df4-20020a05690c0f8400b005caad722d78mr634136ywb.8.1701228128017; Tue, 28
 Nov 2023 19:22:08 -0800 (PST)
Date: Wed, 29 Nov 2023 03:21:52 +0000
In-Reply-To: <20231129032154.3710765-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129032154.3710765-5-yosryahmed@google.com>
Subject: [mm-unstable v4 4/5] mm: workingset: move the stats flush into workingset_test_recent()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com, 
	Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

The workingset code flushes the stats in workingset_refault() to get
accurate stats of the eviction memcg. In preparation for more scoped
flushed and passing the eviction memcg to the flush call, move the call
to workingset_test_recent() where we have a pointer to the eviction
memcg.

The flush call is sleepable, and cannot be made in an rcu read section.
Hence, minimize the rcu read section by also moving it into
workingset_test_recent(). Furthermore, instead of holding the rcu read
lock throughout workingset_test_recent(), only hold it briefly to get a
ref on the eviction memcg. This allows us to make the flush call after
we get the eviction memcg.

As for workingset_refault(), nothing else there appears to be protected
by rcu. The memcg of the faulted folio (which is not necessarily the
same as the eviction memcg) is protected by the folio lock, which is
held from all callsites. Add a VM_BUG_ON() to make sure this doesn't
change from under us.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/workingset.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index c17d45c6f29b0..dce41577a49d2 100644
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
2.43.0.rc1.413.gea7ed67945-goog


