Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB00F3F1C1C
	for <lists+cgroups@lfdr.de>; Thu, 19 Aug 2021 17:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbhHSPCR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Aug 2021 11:02:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33612 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhHSPCR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Aug 2021 11:02:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4F16B22035;
        Thu, 19 Aug 2021 15:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629385299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZQw3aQLXjbGr24aoUzdui2AtIu+xn1XQqrKU4F2ntFA=;
        b=e0Gy5MxNWI0jxmMgbRDddx64OBNlnVKh6x2MNkmWrtDZn8njNPyac2b4yfRE1B26nwA/GB
        RKkpeQ31uiHC+/i5OWborImMWZPMA9jeGQ6czSwfnNHvIEzHFUZDBJBZnqmGDZDSbzxzfM
        wdj7yVvsCFBSAACHHxca877k1HIi7+8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 15B2DA3BA2;
        Thu, 19 Aug 2021 15:01:39 +0000 (UTC)
Date:   Thu, 19 Aug 2021 17:01:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Leon Yang <lnyng@fb.com>, Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: fix occasional OOMs due to proportional
 memory.low reclaim
Message-ID: <YR5yUolPN+hSsUgJ@dhcp22.suse.cz>
References: <20210817180506.220056-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817180506.220056-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 17-08-21 14:05:06, Johannes Weiner wrote:
> We've noticed occasional OOM killing when memory.low settings are in
> effect for cgroups. This is unexpected and undesirable as memory.low
> is supposed to express non-OOMing memory priorities between cgroups.
> 
> The reason for this is proportional memory.low reclaim. When cgroups
> are below their memory.low threshold, reclaim passes them over in the
> first round, and then retries if it couldn't find pages anywhere else.
> But when cgroups are slighly above their memory.low setting, page scan
> force is scaled down and diminished in proportion to the overage, to
> the point where it can cause reclaim to fail as well - only in that
> case we currently don't retry, and instead trigger OOM.
> 
> To fix this, hook proportional reclaim into the same retry logic we
> have in place for when cgroups are skipped entirely. This way if
> reclaim fails and some cgroups were scanned with dimished pressure,
> we'll try another full-force cycle before giving up and OOMing.
> 
> Reported-by: Leon Yang <lnyng@fb.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Although I have to say that the code is quite tricky and it deserves
more comments. See below.

[...]
> @@ -2576,6 +2578,15 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  			 * hard protection.
>  			 */
>  			unsigned long cgroup_size = mem_cgroup_size(memcg);
> +			unsigned long protection;
> +
> +			/* memory.low scaling, make sure we retry before OOM */
> +			if (!sc->memcg_low_reclaim && low > min) {
> +				protection = low;
> +				sc->memcg_low_skipped = 1;
> +			} else {
> +				protection = min;
> +			}

Just by looking at this in isolation one could be really curious how
does this not break the low memory protection altogether. The logic is
spread over 3 different places.

Would something like the following be more understandable?

			/*
			 * Low limit protected memcgs are already excluded at
			 * a higher level (shrink_node_memcgs) but scaling
			 * down the reclaim target can result in hard to
			 * reclaim and premature OOM. We do not have a full
			 * picture here so we cannot really judge this
			 * sutuation here but pro-actively flag this scenario
			 * and let do_try_to_free_pages to retry if
			 * there is no progress.
			 */
>  
>  			/* Avoid TOCTOU with earlier protection check */
>  			cgroup_size = max(cgroup_size, protection);
> -- 
> 2.32.0

-- 
Michal Hocko
SUSE Labs
