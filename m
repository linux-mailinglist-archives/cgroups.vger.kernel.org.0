Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61543F21B4
	for <lists+cgroups@lfdr.de>; Thu, 19 Aug 2021 22:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhHSUh7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Aug 2021 16:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhHSUh7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Aug 2021 16:37:59 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8438C061756
        for <cgroups@vger.kernel.org>; Thu, 19 Aug 2021 13:37:22 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 22so8622694qkg.2
        for <cgroups@vger.kernel.org>; Thu, 19 Aug 2021 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H/v8jtp4MTdUHWsrgy0yYUi2ohESXHCLRr9KfdOGOGU=;
        b=X3sJinq0pDD/8IcMO4wwhfPnPyw3rNuV+72zNB5mcMP+5uSf8rC33okclSRDnV5fff
         L7FpVXiWwN6kVi1mm8yfgZaVorUvtR9kwdH/5bKkyHYtlbqgBoGR0H3oDPpUkSsTbCAo
         oJKuXgkgB1gxZfB/F64F4GTywyYi+yG8WIuudFyJPoKVkCSM9t0G21kBP2ON24sW5HZX
         6AA9uAzy+DdAdC3lCJXMV80rVwwszeJOMPe8YMgwxpkjXiGrYzGioMd+VnKG1vB/jtW+
         MvDkTXpKRo2jCBx/6ln3g0PmRfwz6bF3ZuJ2ZmqmQxvnim5j84oaJ6w0G3xXdBmsi9Dc
         vU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H/v8jtp4MTdUHWsrgy0yYUi2ohESXHCLRr9KfdOGOGU=;
        b=F2mgANUiKPITU4G9RlrGjIOvdwf+QGtimeoiIoN5vWWV86+h4fl1g4CuA6RC3AsBL5
         R4sHTA33ZNxoo09bHybvYjFNbMNIdMWxx2KHCYr7yEExK9wMyIbIm7sVoFY/otQG3fw6
         BMjc8YtUjYyxn7IYePhmxyjXnkTMy6B92QkYtajj/vnN7brUT4fhqQvZLt6ttYF2Y9Bc
         qYMltpCN4AnjMdFN9/4X2FSyHpAlU3jDPrKPGUTEBaloL0rVruDtThN47ZRqMN7aBijD
         JtmF/ihfSwipvvIywv7ep+ISHYICfIO0MqYP5h5gWWcNYMa07AI5rGBlrYMtKMGIGPyl
         mDag==
X-Gm-Message-State: AOAM532/8yHy0VgTF+ZNJB9xNvvJ20BpVElX4E+zAEfzxvRXTBA9jaOR
        x2pJUaVLzKGj57t5rY7LZ56prQ==
X-Google-Smtp-Source: ABdhPJytkjyRm+4YOePYeBBlJwcE+dj7l2FNMe+YO2l/un06Vvg9Esl5WwHLGqJ0hTtBK2oTqxId6A==
X-Received: by 2002:a05:620a:941:: with SMTP id w1mr5410596qkw.434.1629405441687;
        Thu, 19 Aug 2021 13:37:21 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id z6sm372234qtq.78.2021.08.19.13.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 13:37:20 -0700 (PDT)
Date:   Thu, 19 Aug 2021 16:38:59 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Leon Yang <lnyng@fb.com>, Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: fix occasional OOMs due to proportional
 memory.low reclaim
Message-ID: <YR7BY2Z0cXvW/uTO@cmpxchg.org>
References: <20210817180506.220056-1-hannes@cmpxchg.org>
 <YR5yUolPN+hSsUgJ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR5yUolPN+hSsUgJ@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 19, 2021 at 05:01:38PM +0200, Michal Hocko wrote:
> On Tue 17-08-21 14:05:06, Johannes Weiner wrote:
> > We've noticed occasional OOM killing when memory.low settings are in
> > effect for cgroups. This is unexpected and undesirable as memory.low
> > is supposed to express non-OOMing memory priorities between cgroups.
> > 
> > The reason for this is proportional memory.low reclaim. When cgroups
> > are below their memory.low threshold, reclaim passes them over in the
> > first round, and then retries if it couldn't find pages anywhere else.
> > But when cgroups are slighly above their memory.low setting, page scan
> > force is scaled down and diminished in proportion to the overage, to
> > the point where it can cause reclaim to fail as well - only in that
> > case we currently don't retry, and instead trigger OOM.
> > 
> > To fix this, hook proportional reclaim into the same retry logic we
> > have in place for when cgroups are skipped entirely. This way if
> > reclaim fails and some cgroups were scanned with dimished pressure,
> > we'll try another full-force cycle before giving up and OOMing.
> > 
> > Reported-by: Leon Yang <lnyng@fb.com>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks

> 
> Although I have to say that the code is quite tricky and it deserves
> more comments. See below.
> 
> [...]
> > @@ -2576,6 +2578,15 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
> >  			 * hard protection.
> >  			 */
> >  			unsigned long cgroup_size = mem_cgroup_size(memcg);
> > +			unsigned long protection;
> > +
> > +			/* memory.low scaling, make sure we retry before OOM */
> > +			if (!sc->memcg_low_reclaim && low > min) {
> > +				protection = low;
> > +				sc->memcg_low_skipped = 1;
> > +			} else {
> > +				protection = min;
> > +			}
> 
> Just by looking at this in isolation one could be really curious how
> does this not break the low memory protection altogether.

You're right, it's a bit too terse.

> The logic is spread over 3 different places.
> 
> Would something like the following be more understandable?
> 
> 			/*
> 			 * Low limit protected memcgs are already excluded at
> 			 * a higher level (shrink_node_memcgs) but scaling
> 			 * down the reclaim target can result in hard to
> 			 * reclaim and premature OOM. We do not have a full
> 			 * picture here so we cannot really judge this
> 			 * sutuation here but pro-actively flag this scenario
> 			 * and let do_try_to_free_pages to retry if
> 			 * there is no progress.
> 			 */

I've been drafting around with this, but it seems to say the same
thing as the comment I put into struct scan_control already:

	/*
	 * Cgroup memory below memory.low is protected as long as we
	 * don't threaten to OOM. If any cgroup is reclaimed at
	 * reduced force or passed over entirely due to its memory.low
	 * setting (memcg_low_skipped), and nothing is reclaimed as a
	 * result, then go back back for one more cycle that reclaims
	 * the protected memory (memcg_low_reclaim) to avert OOM.
	 */

How about a brief version of this with a pointer to the original?

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 701106e1829c..c32d686719d5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2580,7 +2580,12 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 			unsigned long cgroup_size = mem_cgroup_size(memcg);
 			unsigned long protection;
 
-			/* memory.low scaling, make sure we retry before OOM */
+			/*
+			 * Soft protection must not cause reclaim failure. Let
+			 * the upper level know if we skipped pages during the
+			 * first pass, so it can retry if necessary. See the
+			 * struct scan_control definition of those flags.
+			 */
 			if (!sc->memcg_low_reclaim && low > min) {
 				protection = low;
 				sc->memcg_low_skipped = 1;
@@ -2853,16 +2858,16 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 
 		if (mem_cgroup_below_min(memcg)) {
 			/*
-			 * Hard protection.
-			 * If there is no reclaimable memory, OOM.
+			 * Hard protection. Always respected. If there is not
+			 * enough reclaimable memory elsewhere, it's an OOM.
 			 */
 			continue;
 		} else if (mem_cgroup_below_low(memcg)) {
 			/*
-			 * Soft protection.
-			 * Respect the protection only as long as
-			 * there is an unprotected supply
-			 * of reclaimable memory from other cgroups.
+			 * Soft protection must not cause reclaim failure. Let
+			 * the upper level know if we skipped pages during the
+			 * first pass, so it can retry if necessary. See the
+			 * struct scan_control definition of those flags.
 			 */
 			if (!sc->memcg_low_reclaim) {
 				sc->memcg_low_skipped = 1;
