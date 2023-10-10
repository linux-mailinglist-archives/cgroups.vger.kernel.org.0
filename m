Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7A07BF154
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 05:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441980AbjJJDVi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 23:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441981AbjJJDVb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 23:21:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE02B4
        for <cgroups@vger.kernel.org>; Mon,  9 Oct 2023 20:21:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a4f6729d16so90067057b3.0
        for <cgroups@vger.kernel.org>; Mon, 09 Oct 2023 20:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696908087; x=1697512887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2uIMTmtGdqUKunPgdDdu073V0kaqxVUtvtbHday0wrc=;
        b=Wlih9CQgTOSvCKOUzBNw+I6e5fdxI5H5mgw3wf4O4qOlCsNqIz8xShIwVneez9K8RU
         74SQf01um+Dyv4V+JsZUgP72iakse/Girf5eZ3AyQAqUCgZYYWOyZ1pLcDzl5H9e3N7d
         qlDN3G1NI7pyW1HNBmelKPSYtNtXbUGTE9LNIhOS2TQ86BPdXUrc2UCTOuY4EzjFyQVg
         c+dFBYyoZ1/juzjX7gfMx3UHqGyVGLE7nPI2xNmZm0qkCJ70i0JTNjbWwLIGLNbRU940
         QBg6TsdP29BH15jEjNz3jejJYb0BmZK/swihy6HmGBlS0XzZU4tPqhtXM7ZSMQUHhexa
         Vz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696908087; x=1697512887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2uIMTmtGdqUKunPgdDdu073V0kaqxVUtvtbHday0wrc=;
        b=So4H/V5wzRKBxqOm+JP3m1QfN0LFW360d/812Mippz3j1j/eV7EAwyCXoGMx2Ak3Y8
         Q/Tfqb5GlPC34YNVq8vqgunEWIlfCFypxoaBAWb5qc7SMGjLxoFsNncnjrZG31nHWT5J
         GcvbBZTuSXrhIcUrO8NrsuN+xvlpF7uHfY9DRrigAcOAN0zJOwGRIT7KLCQKNCTebkQF
         shQroQe4mbiFbE3JZL/gJLcQ+nKlXSn8/nehVgd/Bv03GtiuAMv4piXyRPrS5i5L7AH2
         sogpOhIMX1EAS/b9tZLvuGQLHo59svz/X2TCTlkq0m4gU4jVwptKNaKcMfrUSHmqn1Dt
         arUg==
X-Gm-Message-State: AOJu0YwOdD7b3LO44uhg7sT8EhvZYi/KPm0qb1+mLcI6zFgvmozyb8on
        O5uQAgQDQS+aOiz1ipf9wl/UQoQNYx4u2pGU
X-Google-Smtp-Source: AGHT+IH27StA7m2woHqh/tcnCp3uYnoxUCBEP5s+DN8GVWI1rrXovlh8AYsn+eA2pINcXrMN7noHvFZw+UL9M22y
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:c44c:0:b0:586:50cf:e13f with SMTP
 id s12-20020a81c44c000000b0058650cfe13fmr286393ywj.1.1696908087335; Mon, 09
 Oct 2023 20:21:27 -0700 (PDT)
Date:   Tue, 10 Oct 2023 03:21:15 +0000
In-Reply-To: <20231010032117.1577496-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231010032117.1577496-5-yosryahmed@google.com>
Subject: [PATCH v2 4/5] mm: workingset: move the stats flush into workingset_test_recent()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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
---
 mm/workingset.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index b192e44a0e7c..a573be6c59fd 100644
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
2.42.0.609.gbb76f46606-goog

