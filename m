Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482D21F7038
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2020 00:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgFKWau (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Jun 2020 18:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgFKWat (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Jun 2020 18:30:49 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4E7C03E96F
        for <cgroups@vger.kernel.org>; Thu, 11 Jun 2020 15:30:49 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id s13so5849130otd.7
        for <cgroups@vger.kernel.org>; Thu, 11 Jun 2020 15:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=+EahI0YlQUT1/wBvgRJFQZcHP3obsCOagtKe7ySyhrM=;
        b=W26cncJyLH/i2zSIOMrO837pRs3uf2BxQU7IzrLdCgttozbazIeNDlQgCyQFiYpUyY
         Ms4olROFTxfvmQAdemlh52vDy0Ftr89GQMQrDXOir38oNwY8+8gPiDMnQChh/qPvfhj1
         iUsIdILczYmCpO1xqBDBaFflxA4qJYGotgpCt1+gBdruUxe14ckzTnM3+9z+NR3Qkckp
         8bXFzj6IhT3p8E6ZtAmnlH8HwiB/X34paleeTrwi7sO8xUPY1QHO1EqXGNShfQxJUmTK
         oNomeUpR4hUAyI5seihocIFNBhP5T0Ojn22FOBFdo6AgdYqo+CShth6zOvtf4oEc8vZn
         S8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=+EahI0YlQUT1/wBvgRJFQZcHP3obsCOagtKe7ySyhrM=;
        b=R27ZKvsmZjw5TnE45FuGZmnjVfeAAWgiGyN9Q3QHzrKmKlPC2cCZHxLFnRIDrUpnvb
         tcTCoNYeT1GB79RQy3Lq0LS2QJBP5Ea4BnHHegIjbdQIdy/15HZ2WAnArkduvnpXx1Bj
         jYriyIRc1soz+ncEpZGBH8PQx62K2DEWdYjXF+fIccDL3actB8o61H4PM8MxZ0uUaqnW
         65ptlabohprm6wI9HuUGNIyfmUNy8oGU5TkjXe0KtiK15DoyejQCgbLB/3vr9LeVkeDd
         U2+thtX8Lgup9kOLzCOlqLsSqWm6fXA5hKA4wcLpnxvO8LVfw9EAet6KqtfYr2tNx1xV
         GSSA==
X-Gm-Message-State: AOAM530TgJ2fbiVU39JP8NEWUJgvI28kfQVaA44lSLDuELBzhiXEV9WN
        ugdKHIOs8/nIJoim6Burh9+Urg==
X-Google-Smtp-Source: ABdhPJzEon9DZKGa7Vpn9RDUNP7chh++P+QM4RhU5y/VWUIMVZUMKcU4pCYumWLy9ZXhRooe4mHeuA==
X-Received: by 2002:a05:6830:1dba:: with SMTP id z26mr8682022oti.180.1591914648150;
        Thu, 11 Jun 2020 15:30:48 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r15sm978948oot.5.2020.06.11.15.30.45
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2020 15:30:47 -0700 (PDT)
Date:   Thu, 11 Jun 2020 15:30:45 -0700 (PDT)
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
Subject: [PATCH alexv12 2/2] mm/compaction: fix call to
 __isolate_lru_page_prepare()
Message-ID: <alpine.LSU.2.11.2006111529010.10801@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

isolate_migratepages_block() is calling __isolate_lru_page_prepare()
at a point when it has not yet acquired a reference to the page, and
may not yet hold the right lruvec lock: it has no hold on the page.

trylock_page() is not safe to use at this time: its setting PG_locked
can race with the page being freed or allocated ("Bad page"), and can
also erase flags being set by one of those "sole owners" of a freshly
allocated page who use non-atomic __SetPageFlag().

Though I have tried rcu_read_lock() instead of trylock_page() there
(like in page_evictable()), 054f1d1faaed ("mm/swap_state.c: simplify
total_swapcache_pages() with get_swap_device()") stopped the freeing of
swapper_spaces by RCU; and races against setting PageSwapCache, and the
dereference of mapping->a_ops, and the lack of any page reference: all
make that a more dubious approach.

Just move the call to __isolate_lru_page_prepare() after the call to
get_page_unless_zero(), when using trylock_page() has become safe
(safe given __isolate's  check for PageLRU - unsafe without that).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
I had envisaged this as a separate patch; but once it came down
to just moving the call inside isolate_migratepages_block(), it's
probably best folded into 10/16 or 12/16 (needs isolate_fail_put).

I shall probably want to come along later, to clean up or eliminate
__isolate_lru_page_prepare(): which I found before to have almost
nothing in common between its use by isolate_migratepages_block()
and its use by isolate_lru_pages(). We can then do its safer checks
before the get_page_unless_zero(). But trying that cleanup right
now would just get in the way of this series.

 mm/compaction.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- alexv12/mm/compaction.c	2020-06-11 13:48:10.437046025 -0700
+++ hughd/mm/compaction.c	2020-06-11 13:49:05.570579095 -0700
@@ -960,9 +960,6 @@ isolate_migratepages_block(struct compac
 		if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
 			goto isolate_fail;
 
-		if (__isolate_lru_page_prepare(page, isolate_mode) != 0)
-			goto isolate_fail;
-
 		/*
 		 * Be careful not to clear PageLRU until after we're
 		 * sure the page is not being freed elsewhere -- the
@@ -971,6 +968,9 @@ isolate_migratepages_block(struct compac
 		if (unlikely(!get_page_unless_zero(page)))
 			goto isolate_fail;
 
+		if (__isolate_lru_page_prepare(page, isolate_mode) != 0)
+			goto isolate_fail_put;
+
 		/* Try isolate the page */
 		if (!TestClearPageLRU(page))
 			goto isolate_fail_put;
