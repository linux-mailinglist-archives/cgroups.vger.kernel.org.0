Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF781CFC26
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2020 19:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgELR2X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 May 2020 13:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgELR2X (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 12 May 2020 13:28:23 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 217A5205ED;
        Tue, 12 May 2020 17:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589304502;
        bh=1p6BnnVdA+O7XO+1OEIQ+R7NdNbgDqC3c6zfHthSp6g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GbmmbJ9PguPY/A4f4QbueuezRI1+jd98ZVdzclvgkFeb6uc4RlSMcCjD5qOtNdQJb
         5vspDSdmmn+dCdTXnGLRfJ+IOfciS3uR3+KBs8wtuTUFKMt3BA3ACws/5DE1Xm3FHc
         pS5QQ1RuxSAXbSfJl7VRA2b01Ey8EerSWtK5eb94=
Date:   Tue, 12 May 2020 10:28:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kernel-team@fb.com,
        tj@kernel.org, hannes@cmpxchg.org, chris@chrisdown.name,
        cgroups@vger.kernel.org, shakeelb@google.com
Subject: Re: [PATCH mm v2 1/3] mm: prepare for swap over-high accounting and
 penalty calculation
Message-ID: <20200512102819.4858a60a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200512070858.GO29153@dhcp22.suse.cz>
References: <20200511225516.2431921-1-kuba@kernel.org>
        <20200511225516.2431921-2-kuba@kernel.org>
        <20200512070858.GO29153@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 12 May 2020 09:08:58 +0200 Michal Hocko wrote:
> On Mon 11-05-20 15:55:14, Jakub Kicinski wrote:
> > Slice the memory overage calculation logic a little bit so we can
> > reuse it to apply a similar penalty to the swap. The logic which
> > accesses the memory-specific fields (use and high values) has to
> > be taken out of calculate_high_delay().
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> some recommendations below.

Thank you!

> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 05dcb72314b5..8a9b671c3249 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2321,41 +2321,48 @@ static void high_work_func(struct work_struct *work)
> >   #define MEMCG_DELAY_PRECISION_SHIFT 20
> >   #define MEMCG_DELAY_SCALING_SHIFT 14
> >  
> > -/*
> > - * Get the number of jiffies that we should penalise a mischievous cgroup which
> > - * is exceeding its memory.high by checking both it and its ancestors.
> > - */
> > -static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
> > -					  unsigned int nr_pages)
> > +static u64 calculate_overage(unsigned long usage, unsigned long high)  
> 
> the naming is slightly confusing. I would concider the return value
> to be in memory units rather than time because I would read it as
> overrage of high. calculate_throttle_penalty would be more clear to me.

Hm. The unit is the fraction of high. Here is the code, it's quite hard
to read in diff form (I should have used --histogram, sorry):

static u64 calculate_overage(unsigned long usage, unsigned long high)
{
	u64 overage;

	if (usage <= high)
		return 0;

	/*
	 * Prevent division by 0 in overage calculation by acting as if
	 * it was a threshold of 1 page
	 */
	high = max(high, 1UL);

	overage = usage - high;
	overage <<= MEMCG_DELAY_PRECISION_SHIFT;
	return div64_u64(overage, high);
}

calculate_throttle_penalty() sounds like it returns time. How about
something like calc_overage_frac() ? Or calc_overage_perc()?
(abbreviating to "calc" so the caller fits on a line)
