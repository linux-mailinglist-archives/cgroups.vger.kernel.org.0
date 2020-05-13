Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D301D0A7C
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2020 10:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgEMIGN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 May 2020 04:06:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36551 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgEMIGM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 May 2020 04:06:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id w19so12596298wmc.1
        for <cgroups@vger.kernel.org>; Wed, 13 May 2020 01:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uMZjq/iOl4YhzI3MtVxiCP69dEbqt/r5VFCUz+vIP04=;
        b=RgzSxGaWArDITZB+L0hpHiNoL5TSjaEmpPY7gChvAQlWMayT1ItGn6gHsb4tjjtX8G
         6h3IyafkF74Cq2BSImRhOuopdPCZs+WLUPGJp0IqOaeg4PO5D2dBlZvRF6WRgS2m5fnR
         1S/i2iQHnxCzY5sDTsuXnEe14+FfeZkR7a4f/kmjJ6ULnJqqjB1/+YQAwbkENkvcvCH4
         lb+yalvfCbmykYnyDGu9Gf9X7ARbRDkK+Vpo4cKMXz/lp8t2UShVT6K6/Qv43zE7Sy5T
         kbCY6C6IfF37m5kNvFLdudqDwPHmZYMhTx2rxlq6NORNg5E9Ty0N8yLBgZeMfNjTWUei
         rdJw==
X-Gm-Message-State: AGi0Pub/xx44vplEO+N68k49VjjJ4qvNJFU3A4ASIauu0FZI95dczNeU
        B7H+TxJErwnsMT2Uo8BWLS0=
X-Google-Smtp-Source: APiQypLW0LASPxxt94QEDeFIjzHOhswaS3MCP1BE7S64KLKZMPIgWdL9Zeo/M+k3TyqJp7tuCQHmhw==
X-Received: by 2002:a1c:2d14:: with SMTP id t20mr42849836wmt.28.1589357170591;
        Wed, 13 May 2020 01:06:10 -0700 (PDT)
Received: from localhost (ip-37-188-249-36.eurotel.cz. [37.188.249.36])
        by smtp.gmail.com with ESMTPSA id s12sm24086332wmb.3.2020.05.13.01.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 01:06:09 -0700 (PDT)
Date:   Wed, 13 May 2020 10:06:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kernel-team@fb.com,
        tj@kernel.org, hannes@cmpxchg.org, chris@chrisdown.name,
        cgroups@vger.kernel.org, shakeelb@google.com
Subject: Re: [PATCH mm v2 1/3] mm: prepare for swap over-high accounting and
 penalty calculation
Message-ID: <20200513080607.GR29153@dhcp22.suse.cz>
References: <20200511225516.2431921-1-kuba@kernel.org>
 <20200511225516.2431921-2-kuba@kernel.org>
 <20200512070858.GO29153@dhcp22.suse.cz>
 <20200512102819.4858a60a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512102819.4858a60a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 12-05-20 10:28:19, Jakub Kicinski wrote:
> On Tue, 12 May 2020 09:08:58 +0200 Michal Hocko wrote:
> > On Mon 11-05-20 15:55:14, Jakub Kicinski wrote:
> > > Slice the memory overage calculation logic a little bit so we can
> > > reuse it to apply a similar penalty to the swap. The logic which
> > > accesses the memory-specific fields (use and high values) has to
> > > be taken out of calculate_high_delay().
> > > 
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > some recommendations below.
> 
> Thank you!
> 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 05dcb72314b5..8a9b671c3249 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -2321,41 +2321,48 @@ static void high_work_func(struct work_struct *work)
> > >   #define MEMCG_DELAY_PRECISION_SHIFT 20
> > >   #define MEMCG_DELAY_SCALING_SHIFT 14
> > >  
> > > -/*
> > > - * Get the number of jiffies that we should penalise a mischievous cgroup which
> > > - * is exceeding its memory.high by checking both it and its ancestors.
> > > - */
> > > -static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
> > > -					  unsigned int nr_pages)
> > > +static u64 calculate_overage(unsigned long usage, unsigned long high)  
> > 
> > the naming is slightly confusing. I would concider the return value
> > to be in memory units rather than time because I would read it as
> > overrage of high. calculate_throttle_penalty would be more clear to me.
> 
> Hm. The unit is the fraction of high. Here is the code, it's quite hard
> to read in diff form (I should have used --histogram, sorry):

Yeah, I have checked the resulting code.

> static u64 calculate_overage(unsigned long usage, unsigned long high)
> {
> 	u64 overage;
> 
> 	if (usage <= high)
> 		return 0;
> 
> 	/*
> 	 * Prevent division by 0 in overage calculation by acting as if
> 	 * it was a threshold of 1 page
> 	 */
> 	high = max(high, 1UL);
> 
> 	overage = usage - high;
> 	overage <<= MEMCG_DELAY_PRECISION_SHIFT;
> 	return div64_u64(overage, high);
> }
> 
> calculate_throttle_penalty() sounds like it returns time. How about
> something like calc_overage_frac() ? Or calc_overage_perc()?
> (abbreviating to "calc" so the caller fits on a line)

heh, naming is hard and not the most important thing in the world. So if
_penalty doesn't really sound good to you then let's just stick with
what you've had. I do not really like the _perc/_frac much more because
this is more about the implementation of the function than the
intention. We shouldn't really care whether the throttling is based on
overage scaled linearly (aka fraction) or by other means. The
implementation might change in the future.

-- 
Michal Hocko
SUSE Labs
