Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52901644A10
	for <lists+cgroups@lfdr.de>; Tue,  6 Dec 2022 18:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbiLFROR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Dec 2022 12:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiLFROG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Dec 2022 12:14:06 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEDE30F7E
        for <cgroups@vger.kernel.org>; Tue,  6 Dec 2022 09:14:05 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id d14so16282952edj.11
        for <cgroups@vger.kernel.org>; Tue, 06 Dec 2022 09:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KduHn+5gyrCZCJ3PZZKBhevPs/yCR7iZhiHXyVA0CdE=;
        b=U1tH6w6XQXpYI+Hv+M2BpssrkbT69EZiZtCJ8KUrJiRcGor3DEDhd1mEQhmYBwNQAL
         9YedqqgQJoMza6N6wOnCopBmkDUVl4TGszL7044J1ET/RB82yJLOSkO3A10sVEkWg8tw
         0z38g0G+6klmx7+DUWF/Lj59zdXgVZZkiBhgPm7HtpP6UoAVuRquXY0sRXXXI3tZin53
         VD8Oobr5c3lkHwIXOQw6vLPebCgDSNO7nkyR39EwRxodTc4l3/xeYHpMD0CAYMriMrd2
         N6OnCJlPli+HAoMxQiW5waMNstoUqDSvHSRvQNN/Uv8NqyA+jeyP7SgUNW7gld1NZOSf
         l4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KduHn+5gyrCZCJ3PZZKBhevPs/yCR7iZhiHXyVA0CdE=;
        b=ksZmqVsUz0PHrhk5yhl3dQTBy8RVXUm81BO9gWSBUz5PezGMVhF3B+cfqJMAu5ZC73
         2zb1ToogDXkHJZ1NHPGg1hXHjiX3g/rmQJlzdLC8l5AH/PjqPx2ikgtBVJnnhrWOCmSH
         v9tAaMuSrtX1AHmEsmYcynd8sey8WLWZsSqDH2X2n6napCNok7Kcuon46qnU1SlhqZEI
         yIj+lKBH3+vvbbzuxAgEykQPyIhVzrFT9cjm/MUbmj0IBZKVPN26S18qNnviBWJ5ykFT
         2UljIVMOxKTtVEbMH8Hi+X43wnS7cbDnOauHkBkvYSn64HF+UY4jAehGVkzVFELq7miZ
         REpQ==
X-Gm-Message-State: ANoB5pkopx/IPcUrMiBa16lV+4+O/fnxQ988ohdquF3kFbdnMp5irQZ+
        EKXpUv/n/C4O1v9ch59k/E6JCkuDGryNLFpzj4oLyQ==
X-Google-Smtp-Source: AA0mqf7Ryd9NRT+3N9jQ0YqZ+vYbjjy0DyrVXIILJI2vcnGZiLsDKaLX+crjVJIhIeHPDsTlOyd56w==
X-Received: by 2002:a05:6402:444a:b0:459:401:c23e with SMTP id o10-20020a056402444a00b004590401c23emr65038318edb.23.1670346843685;
        Tue, 06 Dec 2022 09:14:03 -0800 (PST)
Received: from localhost ([2a02:8070:6387:ab20:15aa:3c87:c206:d15e])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906200900b007c0688a68cbsm7534622ejo.176.2022.12.06.09.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:14:03 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm: memcontrol: skip moving non-present pages that are mapped elsewhere
Date:   Tue,  6 Dec 2022 18:13:39 +0100
Message-Id: <20221206171340.139790-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206171340.139790-1-hannes@cmpxchg.org>
References: <20221206171340.139790-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

During charge moving, the pte lock and the page lock cover nearly all
cases of stabilizing page_mapped(). The only exception is when we're
looking at a non-present pte and find a page in the page cache or in
the swapcache: if the page is mapped elsewhere, it can become unmapped
outside of our control. For this reason, rmap needs lock_page_memcg().

We don't like cgroup-specific locks in generic MM code - especially in
performance-critical MM code - and for a legacy feature that's
unlikely to have many users left - if any.

So remove the exception. Arguably that's better semantics anyway: the
page is shared, and another process seems to be the more active user.

Once we stop moving such pages, rmap doesn't need lock_page_memcg()
anymore. The next patch will remove it.

Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 52 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 48c44229cf47..b696354c1b21 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5681,7 +5681,7 @@ static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
  * @from: mem_cgroup which the page is moved from.
  * @to:	mem_cgroup which the page is moved to. @from != @to.
  *
- * The caller must make sure the page is not on LRU (isolate_page() is useful.)
+ * The page must be locked and not on the LRU.
  *
  * This function doesn't do "charge" to new cgroup and doesn't do "uncharge"
  * from old cgroup.
@@ -5698,20 +5698,13 @@ static int mem_cgroup_move_account(struct page *page,
 	int nid, ret;
 
 	VM_BUG_ON(from == to);
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 	VM_BUG_ON(compound && !folio_test_large(folio));
 
-	/*
-	 * Prevent mem_cgroup_migrate() from looking at
-	 * page's memory cgroup of its source page while we change it.
-	 */
-	ret = -EBUSY;
-	if (!folio_trylock(folio))
-		goto out;
-
 	ret = -EINVAL;
 	if (folio_memcg(folio) != from)
-		goto out_unlock;
+		goto out;
 
 	pgdat = folio_pgdat(folio);
 	from_vec = mem_cgroup_lruvec(from, pgdat);
@@ -5798,8 +5791,6 @@ static int mem_cgroup_move_account(struct page *page,
 	mem_cgroup_charge_statistics(from, -nr_pages);
 	memcg_check_events(from, nid);
 	local_irq_enable();
-out_unlock:
-	folio_unlock(folio);
 out:
 	return ret;
 }
@@ -5848,6 +5839,29 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 	else if (is_swap_pte(ptent))
 		page = mc_handle_swap_pte(vma, ptent, &ent);
 
+	if (target && page) {
+		if (!trylock_page(page)) {
+			put_page(page);
+			return ret;
+		}
+		/*
+		 * page_mapped() must be stable during the move. This
+		 * pte is locked, so if it's present, the page cannot
+		 * become unmapped. If it isn't, we have only partial
+		 * control over the mapped state: the page lock will
+		 * prevent new faults against pagecache and swapcache,
+		 * so an unmapped page cannot become mapped. However,
+		 * if the page is already mapped elsewhere, it can
+		 * unmap, and there is nothing we can do about it.
+		 * Alas, skip moving the page in this case.
+		 */
+		if (!pte_present(ptent) && page_mapped(page)) {
+			unlock_page(page);
+			put_page(page);
+			return ret;
+		}
+	}
+
 	if (!page && !ent.val)
 		return ret;
 	if (page) {
@@ -5864,8 +5878,11 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 			if (target)
 				target->page = page;
 		}
-		if (!ret || !target)
+		if (!ret || !target) {
+			if (target)
+				unlock_page(page);
 			put_page(page);
+		}
 	}
 	/*
 	 * There is a swap entry and a page doesn't exist or isn't charged.
@@ -5905,6 +5922,10 @@ static enum mc_target_type get_mctgt_type_thp(struct vm_area_struct *vma,
 		ret = MC_TARGET_PAGE;
 		if (target) {
 			get_page(page);
+			if (!trylock_page(page)) {
+				put_page(page);
+				return MC_TARGET_NONE;
+			}
 			target->page = page;
 		}
 	}
@@ -6143,6 +6164,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 				}
 				putback_lru_page(page);
 			}
+			unlock_page(page);
 			put_page(page);
 		} else if (target_type == MC_TARGET_DEVICE) {
 			page = target.page;
@@ -6151,6 +6173,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 				mc.precharge -= HPAGE_PMD_NR;
 				mc.moved_charge += HPAGE_PMD_NR;
 			}
+			unlock_page(page);
 			put_page(page);
 		}
 		spin_unlock(ptl);
@@ -6193,7 +6216,8 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 			}
 			if (!device)
 				putback_lru_page(page);
-put:			/* get_mctgt_type() gets the page */
+put:			/* get_mctgt_type() gets & locks the page */
+			unlock_page(page);
 			put_page(page);
 			break;
 		case MC_TARGET_SWAP:
-- 
2.38.1

