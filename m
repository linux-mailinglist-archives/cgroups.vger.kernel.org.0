Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87F55F955A
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 17:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKLQRB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Nov 2019 11:17:01 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39913 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKLQRB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Nov 2019 11:17:01 -0500
Received: by mail-qt1-f195.google.com with SMTP id t8so20357449qtc.6
        for <cgroups@vger.kernel.org>; Tue, 12 Nov 2019 08:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=twt8kJzhtPFZcAO1BhdHJtV6MHvkk/INbWMflmbiAcs=;
        b=wOJG7TKZxJq4CpTPsx5BBiOVlFuqacNBz9W6xm0qACo/wundYrFHiI0ekBHcU+WcLW
         0T9Dxdd/2RVxSjtTw3wgLA9Jj54sD1igfoXfVt4ArPEHkPRgdxcedv0G6T9xusV04IOg
         RX4muJAyIWzmgRS+D8J1xPyY3yxJgaSS+nf7HgsHNAz83ChbKjYS/W/wai49fs0hKxyY
         Lg667V1xFa+C2jeV2Dt/miS158NRuX3nDBQAqtQ/hYtjq7JES/R7BV76jHKNjPOrLJVz
         MbpydXjQrDmqeq7BhMOdhQViCt1nzM6u86VU4s/s5OLqaOwJjFhY5KC8x/eib7GMDP2K
         qFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=twt8kJzhtPFZcAO1BhdHJtV6MHvkk/INbWMflmbiAcs=;
        b=cS1+dEIjOx/+W4Ql+eJyoQz5Z8hGIqFiTn+qPgNdTyhGmBQFepfIhiBO3xqU8p/zWB
         JQlEmRworC38LNCq44pkQaTirEH1W6G3zK6dIVr/SxLpquYjtUDO+gyr6HuCnlyHBhov
         dMz7vIfPoBfEHkDY5F4+atbHHtR8dS/Q+gidLvhN2TxnoJyXvWZcBb49D0Rgut8TzTCh
         QJWo7s85BGIfpL3IcvQwgEzA66B3XRxauWP7iDIrRC41Uwou7jt8C0fvtWtd+XXtYhEj
         QictaRVssaQCDBr6sY5xuzeIFFXn5URn6iB5KFLhBeQpICo5OCfHVZ1CR1++wKPOosW4
         Vwnw==
X-Gm-Message-State: APjAAAX/qqZyWQh6iqVr707kVuSQDAiFMLQtHc1odSEx6ep5KZqYwJKg
        jPOezEpvhv0KcIQwqEyZjqcHnqr7RnzSAg==
X-Google-Smtp-Source: APXvYqy5KJiW7cPw9ukstX7WWyRgfEKk9uJb84K1GhrWATzGZmzo1iLD7FFRft6n2cPa6jAJir+f8g==
X-Received: by 2002:ac8:2361:: with SMTP id b30mr31934126qtb.322.1573575420020;
        Tue, 12 Nov 2019 08:17:00 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::aa8c])
        by smtp.gmail.com with ESMTPSA id v186sm8821612qkb.42.2019.11.12.08.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 08:16:59 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:16:58 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, guro@fb.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/vmscan: fix an undefined behavior for zone id
Message-ID: <20191112161658.GF168812@cmpxchg.org>
References: <20191108204407.1435-1-cai@lca.pw>
 <64E60F6F-7582-427B-8DD5-EF97B1656F5A@lca.pw>
 <20191111130516.GA891635@chrisdown.name>
 <20191111131427.GB891635@chrisdown.name>
 <20191111132812.GK1396@dhcp22.suse.cz>
 <20191112145942.GA168812@cmpxchg.org>
 <20191112152750.GA512@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112152750.GA512@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 12, 2019 at 04:27:50PM +0100, Michal Hocko wrote:
> On Tue 12-11-19 06:59:42, Johannes Weiner wrote:
> > Qian, thanks for the report and the fix.
> > 
> > On Mon, Nov 11, 2019 at 02:28:12PM +0100, Michal Hocko wrote:
> > > On Mon 11-11-19 13:14:27, Chris Down wrote:
> > > > Chris Down writes:
> > > > > Ah, I just saw this in my local checkout and thought it was from my
> > > > > changes, until I saw it's also on clean mmots checkout. Thanks for the
> > > > > fixup!
> > > > 
> > > > Also, does this mean we should change callers that may pass through
> > > > zone_idx=MAX_NR_ZONES to become MAX_NR_ZONES-1 in a separate commit, then
> > > > remove this interim fixup? I'm worried otherwise we might paper over real
> > > > issues in future.
> > > 
> > > Yes, removing this special casing is reasonable. I am not sure
> > > MAX_NR_ZONES - 1 is a better choice though. It is error prone and
> > > zone_idx is the highest zone we should consider and MAX_NR_ZONES - 1
> > > be ZONE_DEVICE if it is configured. But ZONE_DEVICE is really standing
> > > outside of MM reclaim code AFAIK. It would be probably better to have
> > > MAX_LRU_ZONE (equal to MOVABLE) and use it instead.
> > 
> > We already use MAX_NR_ZONES - 1 everywhere else in vmscan.c to mean
> > "no zone restrictions" - get_scan_count() is the odd one out:
> > 
> > - mem_cgroup_shrink_node()
> > - try_to_free_mem_cgroup_pages()
> > - balance_pgdat()
> > - kswapd()
> > - shrink_all_memory()
> > 
> > It's a little odd that it points to ZONE_DEVICE, but it's MUCH less
> > subtle than handling both inclusive and exclusive range delimiters.
> > 
> > So I think the better fix would be this:
> 
> lruvec_lru_size is explicitly documented to use MAX_NR_ZONES for all
> LRUs and git grep says there are more instances outside of
> get_scan_count. So all of them have to be fixed.

Which ones?

[hannes@computer linux]$ git grep lruvec_lru_size
include/linux/mmzone.h:extern unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx);
mm/vmscan.c: * lruvec_lru_size -  Returns the number of pages on the given LRU list.
mm/vmscan.c:unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
mm/vmscan.c:    anon  = lruvec_lru_size(lruvec, LRU_ACTIVE_ANON, MAX_NR_ZONES - 1) +
mm/vmscan.c:            lruvec_lru_size(lruvec, LRU_INACTIVE_ANON, MAX_NR_ZONES - 1);
mm/vmscan.c:    file  = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES - 1) +
mm/vmscan.c:            lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES - 1);
mm/vmscan.c:            lruvec_size = lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
[hannes@computer linux]$

The only other user already passes sc->reclaim_idx, which always
points to a valid zone, and is initialized to MAX_NR_ZONES - 1 in many
places.

> I still think that MAX_NR_ZONES - 1 is a very error prone and subtle
> construct IMHO and an alias would be better readable.

I wouldn't mind a follow-up patch that changes this pattern
comprehensively. As it stands, get_scan_count() is the odd one out.

The documentation bit is a good point, though. We should fix
that. Updated patch:

---

From b1b6ce306010554aba6ebd7aac0abffc1576d71a Mon Sep 17 00:00:00 2001
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
 mm/vmscan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index df859b1d583c..5eb96a63ad1e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -323,7 +323,7 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
  * lruvec_lru_size -  Returns the number of pages on the given LRU list.
  * @lruvec: lru vector
  * @lru: lru to use
- * @zone_idx: zones to consider (use MAX_NR_ZONES for the whole LRU list)
+ * @zone_idx: index of the highest zone to include (use MAX_NR_ZONES - 1 for all)
  */
 unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
 {
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

