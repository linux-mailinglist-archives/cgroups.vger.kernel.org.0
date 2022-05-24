Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFDD532325
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 08:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiEXG1g (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 02:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiEXG1c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 02:27:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3020872E36
        for <cgroups@vger.kernel.org>; Mon, 23 May 2022 23:27:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ds11so15985771pjb.0
        for <cgroups@vger.kernel.org>; Mon, 23 May 2022 23:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YQmbzG/x1UDz5U0yQVXExNL9W+QNwv5yyDN0QDopwLM=;
        b=SbFCQ3vJYsGUAEX8nyldT87US7H/Zi6r40ReQrz8S1DFmwuWGEoV2ZsawlDNV2F+b9
         cBbWPLt6WyLG/WEs6j6or7s/bkrS5fhQCtCJYspYV7YbDoGUD1Kpw7Cz19/bYZvOSmvn
         C7kr1O/qam5v/KZxRh4lh9qzOJtWk0NaaM5tm7fJrsj7KBzxuKuwY074AEzpGvXjXhRa
         OSdKGe9kRdi5MZEOyUCYPsJ6eblgDNZpMXrb7JA12Yd9Uc5u620Py3qTO2xYaCVNavdX
         iwklkT8fllKtpNXMNWn4waK8JwI1CM/uTxteV3N+Nq25H+HgDd0owN20+UIAf1N6TPfK
         7S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQmbzG/x1UDz5U0yQVXExNL9W+QNwv5yyDN0QDopwLM=;
        b=THdAsIukjR24OdBgYV6iyk0Pw2rSTFy9tYa3SSzK9LKMui0/5oni7udXNlBWDHV/xn
         PmnJI+ljFpB+MTmDge89K65XOTR9h2FVGMsSa8TkvBt5s4rj957euO2c7CM/3tq06RDz
         A66pPnReCDqE6+Qj76gRVl6e6XmobYswMxiqZQZkViv2rItAQsypWO/p2HdkfB2/S3vP
         bcLViSmfYfJFnmFAOx3un4dZAFwUrbgv5DkkEdoiee9lQzpgtqltINBtM0NZY5WlcTZd
         GOJGsg9z1THjTp3oPyi1BSAID3PVpF4VwdxT7vuKFursja1AX16uxFmtV0/6yqKG8OyV
         RoIQ==
X-Gm-Message-State: AOAM532lHrbyu6PDZ2rg8g7+HARr6Ajm9DvVVWi46JdoLqrxkSxeJUnR
        OgDfEQNX0i5RTxsoGL9DnfbOLA==
X-Google-Smtp-Source: ABdhPJyvk99DuGpFOsiT2uRB5kw+R+itIfmHziS8mh58MTBgrfJrSmlj+pJB/4xFtnMj2WkZMk1iTA==
X-Received: by 2002:a17:90b:4ace:b0:1df:cb33:5e7e with SMTP id mh14-20020a17090b4ace00b001dfcb335e7emr2962784pjb.5.1653373644635;
        Mon, 23 May 2022 23:27:24 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([2408:8207:18da:2310:f940:af17:c2f5:8656])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f54500b0016168e90f2dsm6254455plf.219.2022.05.23.23.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 23:27:24 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 02/11] mm: memcontrol: introduce compact_folio_lruvec_lock_irqsave
Date:   Tue, 24 May 2022 14:05:42 +0800
Message-Id: <20220524060551.80037-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220524060551.80037-1-songmuchun@bytedance.com>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If we reuse the objcg APIs to charge LRU pages, the folio_memcg()
can be changed when the LRU pages reparented. In this case, we need
to acquire the new lruvec lock.

    lruvec = folio_lruvec(folio);

    // The page is reparented.

    compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);

    // Acquired the wrong lruvec lock and need to retry.

But compact_lock_irqsave() only take lruvec lock as the parameter,
we cannot aware this change. If it can take the page as parameter
to acquire the lruvec lock. When the page memcg is changed, we can
use the folio_memcg() detect whether we need to reacquire the new
lruvec lock. So compact_lock_irqsave() is not suitable for us.
Similar to folio_lruvec_lock_irqsave(), introduce
compact_folio_lruvec_lock_irqsave() to acquire the lruvec lock in
the compaction routine.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/compaction.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index fe915db6149b..817098817302 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -509,6 +509,29 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
 	return true;
 }
 
+static struct lruvec *
+compact_folio_lruvec_lock_irqsave(struct folio *folio, unsigned long *flags,
+				  struct compact_control *cc)
+{
+	struct lruvec *lruvec;
+
+	lruvec = folio_lruvec(folio);
+
+	/* Track if the lock is contended in async mode */
+	if (cc->mode == MIGRATE_ASYNC && !cc->contended) {
+		if (spin_trylock_irqsave(&lruvec->lru_lock, *flags))
+			goto out;
+
+		cc->contended = true;
+	}
+
+	spin_lock_irqsave(&lruvec->lru_lock, *flags);
+out:
+	lruvec_memcg_debug(lruvec, folio);
+
+	return lruvec;
+}
+
 /*
  * Compaction requires the taking of some coarse locks that are potentially
  * very heavily contended. The lock should be periodically unlocked to avoid
@@ -844,6 +867,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 	/* Time to isolate some pages for migration */
 	for (; low_pfn < end_pfn; low_pfn++) {
+		struct folio *folio;
 
 		if (skip_on_failure && low_pfn >= next_skip_pfn) {
 			/*
@@ -1065,18 +1089,17 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (!TestClearPageLRU(page))
 			goto isolate_fail_put;
 
-		lruvec = folio_lruvec(page_folio(page));
+		folio = page_folio(page);
+		lruvec = folio_lruvec(folio);
 
 		/* If we already hold the lock, we can skip some rechecking */
 		if (lruvec != locked) {
 			if (locked)
 				unlock_page_lruvec_irqrestore(locked, flags);
 
-			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
+			lruvec = compact_folio_lruvec_lock_irqsave(folio, &flags, cc);
 			locked = lruvec;
 
-			lruvec_memcg_debug(lruvec, page_folio(page));
-
 			/* Try get exclusive access under lock */
 			if (!skip_updated) {
 				skip_updated = true;
-- 
2.11.0

