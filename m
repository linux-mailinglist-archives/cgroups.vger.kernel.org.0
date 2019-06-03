Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0F9233AB6
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2019 00:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfFCWFB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Jun 2019 18:05:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44511 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFCWFB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Jun 2019 18:05:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so2558879pfe.11
        for <cgroups@vger.kernel.org>; Mon, 03 Jun 2019 15:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0EoeyvI+6nSZVdPsXoo6A3bLjv7jCmnakg13/Vo0S7g=;
        b=jQQKpymP0x+HXM6AidEDpl+oryXhrFlsULaSJxrk+bRuLIK2zph32NK7fQ9YAJaCBe
         N7+enaR2Vc1oYLo8aptLEfjl+dIsZ+yBuVWMXGIzNgNQI9SdCmD/jLhITwBQ9ehLSkb+
         XEVP/h3PMZVC5vzDLRMA2ctacgD5ioiLhXBcIfjUB5IUWXVcT3hHScDrk9eh/9mNvu5o
         PWXDbM+Um+WQ9hcOjSXq+jo3FDIH6cYOI+MipuzXRWJvoaNI+qxII2acSgoctNl9nHHf
         375AuTgxJjHK4jIuhHyjGLr4uaIo2/oQ034Ox+mp98rzfJnHVOkExpOIKkw9vVPM1s+r
         yyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0EoeyvI+6nSZVdPsXoo6A3bLjv7jCmnakg13/Vo0S7g=;
        b=AaUOirpOYig9IdVNLcYXd+vw7IlK5Rbv2N30sZGXF2GYWnJtD8d5iAy9b7vwlCE+yn
         GsnUH/D32JAoX4/Fhcm/jW8h4kDflBDjRxitw1UWZq0i/qC3Rq3ueyvRA21FB+/Y3WSa
         tHJ0v9MTzyyFo0chYm5WvjE8UGTe24VTPk7R4XuQ4IJHAufEZG9GuiN/kUEqrcNQjiQB
         TXJZTxAF3ikK9X4P8rEjX5lwmFxNRNhOmEQYzYpNVLJjGoLc+9z94gmOrtEXcIYIoe+S
         oD7w3eUV/KXrsQa+/mzmoEAVhu4cBbgq0jGHXXSNip6zBn6i5dTLTfkyli17Cn1bQFa5
         Eumw==
X-Gm-Message-State: APjAAAWWUIwerO6BsVldij64S7bhaOFu9g+3XirpcAEtdGIORgEX0zcp
        AQE4wQk9ghV1tixEGSxizFtts/kWlrY=
X-Google-Smtp-Source: APXvYqxa0AysWp131gGXPRfGsUoOrmmAU0oaOx10qyqfliSX/gy0fcowTdd1qaAaihU44ugQyNlEYQ==
X-Received: by 2002:a63:a34c:: with SMTP id v12mr30337699pgn.198.1559596104078;
        Mon, 03 Jun 2019 14:08:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:9fa4])
        by smtp.gmail.com with ESMTPSA id n32sm7753279pji.29.2019.06.03.14.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 14:08:23 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 01/11] mm: vmscan: move inactive_list_is_low() swap check to the caller
Date:   Mon,  3 Jun 2019 17:07:36 -0400
Message-Id: <20190603210746.15800-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603210746.15800-1-hannes@cmpxchg.org>
References: <20190603210746.15800-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

inactive_list_is_low() should be about one thing: checking the ratio
between inactive and active list. Kitchensink checks like the one for
swap space makes the function hard to use and modify its
callsites. Luckly, most callers already have an understanding of the
swap situation, so it's easy to clean up.

get_scan_count() has its own, memcg-aware swap check, and doesn't even
get to the inactive_list_is_low() check on the anon list when there is
no swap space available.

shrink_list() is called on the results of get_scan_count(), so that
check is redundant too.

age_active_anon() has its own totalswap_pages check right before it
checks the list proportions.

The shrink_node_memcg() site is the only one that doesn't do its own
swap check. Add it there.

Then delete the swap check from inactive_list_is_low().

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 84dcb651d05c..f396424850aa 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2165,13 +2165,6 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
 	unsigned long refaults;
 	unsigned long gb;
 
-	/*
-	 * If we don't have swap space, anonymous page deactivation
-	 * is pointless.
-	 */
-	if (!file && !total_swap_pages)
-		return false;
-
 	inactive = lruvec_lru_size(lruvec, inactive_lru, sc->reclaim_idx);
 	active = lruvec_lru_size(lruvec, active_lru, sc->reclaim_idx);
 
@@ -2592,7 +2585,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
 	 * Even if we did not try to evict anon pages at all, we want to
 	 * rebalance the anon lru active/inactive ratio.
 	 */
-	if (inactive_list_is_low(lruvec, false, sc, true))
+	if (total_swap_pages && inactive_list_is_low(lruvec, false, sc, true))
 		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
 				   sc, LRU_ACTIVE_ANON);
 }
-- 
2.21.0

