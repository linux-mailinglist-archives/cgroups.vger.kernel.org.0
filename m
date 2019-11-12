Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A88EF9375
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 15:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfKLO7p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Nov 2019 09:59:45 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38192 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfKLO7p (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Nov 2019 09:59:45 -0500
Received: by mail-qk1-f195.google.com with SMTP id e2so14670798qkn.5
        for <cgroups@vger.kernel.org>; Tue, 12 Nov 2019 06:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gSINY5VnDSmpBftGgJ6lg01oQr1mDIp5ALDVHMXlZtw=;
        b=Gv4CNBoQWcvSweiWqUWk1x91ARUiIp699peYUwjmh6dVDMofdbK9TZUTy69OMR5wBz
         Sj+vB2GcvnlKfNRZEIMuMD3yS8pJJt++bT0SIHOtaVbPAljtUuvSlhlcMWxzQGQgoRE3
         Kcd06rwOsC5lFXfYYtTIKinfT2hJtltQwpwK1te3zTPVqwAUXLHL6fYLU7jrBrgS8qoj
         5wTN6yJDZt4fm/8Xfr2nFuWSweu2iE2sTod84emu3a9nTDFmzXvrouK8S00TlYIY1f00
         1fPMpGYYvGHDTjbQoG1Pekl7cneX7THKqwP87lTRSl0Y+XYeoSKkQnVFVOyuY5lkinLg
         KMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gSINY5VnDSmpBftGgJ6lg01oQr1mDIp5ALDVHMXlZtw=;
        b=aaqAOPBgSPPjWwjZw8eWh81V4t7Okmf5jyJCR9bE3QNRwhXg7QNKMeKrMjh4W6/nUW
         IBA4g5WVct+d2xw8VVUbbpJQHYWTxE22V0HyClfABXIsM2mBMAs7tL4B1Ol+7xdY7u0q
         RvR0EWXiWlGcB/EBFqlyGcIZgqgslhECJJkmHxHfolYLjwhhZGBhHroUGB7GDcQTz6h8
         0NAhunPJ8Q68pkmNGahuy5BGUSklpsZMc0oiAccNWxaubT784NDufjSFooWBVk7oXu+Y
         CpU4zqrA9TRqX7hNKBhUPisG9Pd3lFo0F6Y9KEOB9tzfigMoCfZHYMfbVoMs7c40aTOi
         eLPg==
X-Gm-Message-State: APjAAAUDjw4TrqHvvmunedRdjiFaNdFuSaYm1274XLTg97rSRflN2BqQ
        n9O646A4ftrLasIRcF3nbKbRmA==
X-Google-Smtp-Source: APXvYqxGVHT2d2Zo/+rHOGGT2x3k3jwx+Qqewg1Ac2Y4lPfZSQlSC0MLZdrrZYbG4EQSFse6ASdTJg==
X-Received: by 2002:a37:9d86:: with SMTP id g128mr5962601qke.191.1573570784074;
        Tue, 12 Nov 2019 06:59:44 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::aa8c])
        by smtp.gmail.com with ESMTPSA id q34sm8004104qte.50.2019.11.12.06.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 06:59:43 -0800 (PST)
Date:   Tue, 12 Nov 2019 06:59:42 -0800
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, guro@fb.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/vmscan: fix an undefined behavior for zone id
Message-ID: <20191112145942.GA168812@cmpxchg.org>
References: <20191108204407.1435-1-cai@lca.pw>
 <64E60F6F-7582-427B-8DD5-EF97B1656F5A@lca.pw>
 <20191111130516.GA891635@chrisdown.name>
 <20191111131427.GB891635@chrisdown.name>
 <20191111132812.GK1396@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111132812.GK1396@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Qian, thanks for the report and the fix.

On Mon, Nov 11, 2019 at 02:28:12PM +0100, Michal Hocko wrote:
> On Mon 11-11-19 13:14:27, Chris Down wrote:
> > Chris Down writes:
> > > Ah, I just saw this in my local checkout and thought it was from my
> > > changes, until I saw it's also on clean mmots checkout. Thanks for the
> > > fixup!
> > 
> > Also, does this mean we should change callers that may pass through
> > zone_idx=MAX_NR_ZONES to become MAX_NR_ZONES-1 in a separate commit, then
> > remove this interim fixup? I'm worried otherwise we might paper over real
> > issues in future.
> 
> Yes, removing this special casing is reasonable. I am not sure
> MAX_NR_ZONES - 1 is a better choice though. It is error prone and
> zone_idx is the highest zone we should consider and MAX_NR_ZONES - 1
> be ZONE_DEVICE if it is configured. But ZONE_DEVICE is really standing
> outside of MM reclaim code AFAIK. It would be probably better to have
> MAX_LRU_ZONE (equal to MOVABLE) and use it instead.

We already use MAX_NR_ZONES - 1 everywhere else in vmscan.c to mean
"no zone restrictions" - get_scan_count() is the odd one out:

- mem_cgroup_shrink_node()
- try_to_free_mem_cgroup_pages()
- balance_pgdat()
- kswapd()
- shrink_all_memory()

It's a little odd that it points to ZONE_DEVICE, but it's MUCH less
subtle than handling both inclusive and exclusive range delimiters.

So I think the better fix would be this:

---
From 1566a255eef7c2165d435125231ad1eeecac7959 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Mon, 11 Nov 2019 13:46:25 -0800
Subject: [PATCH] mm: vmscan: simplify lruvec_lru_size() fix

get_scan_count() passes MAX_NR_ZONES for the reclaim index, which is
beyond the range of valid zone indexes, but used to be handled before
the patch. Every other callsite in vmscan.c passes MAX_NR_ZONES - 1 to
express "all zones, please", so do the same here.

Reported-by: Qian Cai <cai@lca.pw>
Reported-by: Chris Down <chris@chrisdown.name>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index df859b1d583c..34ad8a0f3f27 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2322,10 +2322,10 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	 * anon in [0], file in [1]
 	 */
 
-	anon  = lruvec_lru_size(lruvec, LRU_ACTIVE_ANON, MAX_NR_ZONES) +
-		lruvec_lru_size(lruvec, LRU_INACTIVE_ANON, MAX_NR_ZONES);
-	file  = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES) +
-		lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES);
+	anon  = lruvec_lru_size(lruvec, LRU_ACTIVE_ANON, MAX_NR_ZONES - 1) +
+		lruvec_lru_size(lruvec, LRU_INACTIVE_ANON, MAX_NR_ZONES - 1);
+	file  = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES - 1) +
+		lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES - 1);
 
 	spin_lock_irq(&pgdat->lru_lock);
 	if (unlikely(reclaim_stat->recent_scanned[0] > anon / 4)) {
-- 
2.24.0

