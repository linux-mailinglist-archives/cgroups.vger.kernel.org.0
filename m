Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0605E1F700F
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2020 00:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgFKW27 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Jun 2020 18:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgFKW26 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Jun 2020 18:28:58 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DCAC03E96F
        for <cgroups@vger.kernel.org>; Thu, 11 Jun 2020 15:28:58 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id t6so5840685otk.9
        for <cgroups@vger.kernel.org>; Thu, 11 Jun 2020 15:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=yQuXdwOztfCCh1OM0Y/znnoWVtA42w245nppjLu++SM=;
        b=C9efrmYgO5lfHiPabO9leNQkZRsdhlwEQGAWMA52SmmHSpafgnK+/l847DiwWOyBpj
         BAeGvslbj7wElzHda4DwvXS0ku8R79Ov2+bHCOh/Wc5QGdmv0su6wFBq2OfvGk2eaTGq
         u9MFt68ahkxY0WjRh3nuhhBOlrOW1MnYy8G6VghffVY4IdRBNay/7mj7FCjMHKTJv2ht
         GYwLGmvsv2JG78AtNqL4aAn4TX+q6VYmWxN1EECEZxgW8vMb3YpE6BvTsBs1SmWoAXbN
         k7edAcL63vK2Ld9noBiS6oSmq4WzbzSYWD0olZCdndrD21tLhFkspBj4YJEgjnw+feF7
         tXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=yQuXdwOztfCCh1OM0Y/znnoWVtA42w245nppjLu++SM=;
        b=VHVw3lx29iwCaigvXFb4qMwQ2Pi71SQakU+XTn+chfXbGKT8nAqDclD3rWS0C8LNEt
         Kut4pMajO6e/Q7+ueo+Yo3yP5Klgvt2VIly58JtD78acJw1zUiNAWkWetdLbN6Pmswm8
         uHxxz49GzT+ugGh7Va1pA6JNRlz3wYtG9Wm5oA05FawWlOH2kBX686RtamqFRaNr/Jor
         Jv2NOtG5am1GhPVIw6RZA+xcFePgAtnUsRFZwZo0+eQhIfagNkDVmol1m7UcJStRbxkg
         KI2ckVASsChbtQPgo5muMBYzLNbv6DRXW7TGaSwizieo0ZqmrHqaGBte2Tx3rBPFENGW
         Gb4A==
X-Gm-Message-State: AOAM533I6wWpcyfKPy21Rb+1MOpVitieWQPmmK08+r8bllkwn+tkEfyl
        9AyGUrxaZ56J4jndjrh6cPnyYw==
X-Google-Smtp-Source: ABdhPJwC0cSrxAVd/oScf78OXudE/J7qH0OBFpxhpmCCenQEqZL2QUwwdccMsG0/Q/aHQLe+aN7Mmg==
X-Received: by 2002:a9d:1c9b:: with SMTP id l27mr9063837ota.22.1591914537191;
        Thu, 11 Jun 2020 15:28:57 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 126sm974999oii.39.2020.06.11.15.28.54
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2020 15:28:56 -0700 (PDT)
Date:   Thu, 11 Jun 2020 15:28:54 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: [PATCH alexv12 1/2] mm/compaction: fix isolate_migratepages_block()
 fails
Message-ID: <alpine.LSU.2.11.2006111526290.10801@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Fix lots of crashes under compaction load: isolate_migratepages_block()
must clean up appropriately when rejecting a page, setting PageLRU again
if it had been cleared; and a put_page() after get_page_unless_zero()
cannot safely be done while holding locked_lruvec - it may turn out to
be the final put_page(), which will take an lruvec lock when PageLRU.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
These fixes should be folded into 10/16 and 12/16,
I have not tried to figure out what belongs in which.

 mm/compaction.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

--- alexv12/mm/compaction.c	2020-06-11 13:24:52.037154793 -0700
+++ hughd/mm/compaction.c	2020-06-11 13:48:10.437046025 -0700
@@ -879,6 +879,7 @@ isolate_migratepages_block(struct compac
 		if (!valid_page && IS_ALIGNED(low_pfn, pageblock_nr_pages)) {
 			if (!cc->ignore_skip_hint && get_pageblock_skip(page)) {
 				low_pfn = end_pfn;
+				page = NULL;
 				goto isolate_abort;
 			}
 			valid_page = page;
@@ -971,10 +972,8 @@ isolate_migratepages_block(struct compac
 			goto isolate_fail;
 
 		/* Try isolate the page */
-		if (!TestClearPageLRU(page)) {
-			put_page(page);
-			goto isolate_fail;
-		}
+		if (!TestClearPageLRU(page))
+			goto isolate_fail_put;
 
 		rcu_read_lock();
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
@@ -1005,7 +1004,8 @@ isolate_migratepages_block(struct compac
 			 */
 			if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
 				low_pfn += compound_nr(page) - 1;
-				goto isolate_fail;
+				SetPageLRU(page);
+				goto isolate_fail_put;
 			}
 		} else
 			rcu_read_unlock();
@@ -1038,6 +1038,15 @@ isolate_success:
 		}
 
 		continue;
+
+isolate_fail_put:
+		/* Avoid potential deadlock in freeing page under lru_lock */
+		if (locked_lruvec) {
+			unlock_page_lruvec_irqrestore(locked_lruvec, flags);
+			locked_lruvec = NULL;
+		}
+		put_page(page);
+
 isolate_fail:
 		if (!skip_on_failure)
 			continue;
@@ -1074,10 +1083,15 @@ isolate_fail:
 	 */
 	if (unlikely(low_pfn > end_pfn))
 		low_pfn = end_pfn;
+	page = NULL;
 
 isolate_abort:
 	if (locked_lruvec)
 		unlock_page_lruvec_irqrestore(locked_lruvec, flags);
+	if (page) {
+		SetPageLRU(page);
+		put_page(page);
+	}
 
 	/*
 	 * Updated the cached scanner pfn once the pageblock has been scanned
