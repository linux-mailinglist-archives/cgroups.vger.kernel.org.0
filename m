Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7EB31F02B
	for <lists+cgroups@lfdr.de>; Thu, 18 Feb 2021 20:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhBRTmB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Feb 2021 14:42:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:44974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232090AbhBRTN7 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 18 Feb 2021 14:13:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613675586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2LEQzo8vyQpA89Pwawhl0KdWDVli2brjorL41NH4bg0=;
        b=q5SAQAr80eSFU1sPIy6CPtTyAaCdMpHwCM7Gkx4DMHmqb7iSUZx2XB3g4/RHdI4czipuk2
        sGettzMqvcBp7SCmWZYw0Y5AcV8QnfUtNNaVuiascQ56cekbOUDDKk2RY/AWErk/j5iQ8c
        p2/P60C3SgKfPh9tyOlO+mt9MUgS07U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8EDA4ACD4;
        Thu, 18 Feb 2021 19:13:06 +0000 (UTC)
Date:   Thu, 18 Feb 2021 20:13:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm: Fix dropped memcg from mem cgroup soft limit
 tree
Message-ID: <YC68QRVsCONXscCl@dhcp22.suse.cz>
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
 <8d35206601ccf0e1fe021d24405b2a0c2f4e052f.1613584277.git.tim.c.chen@linux.intel.com>
 <YC4kV7dkJpxjW+df@dhcp22.suse.cz>
 <c3ffa2cb-cb2c-20b7-d722-c875934992e9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3ffa2cb-cb2c-20b7-d722-c875934992e9@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 18-02-21 10:30:20, Tim Chen wrote:
> 
> 
> On 2/18/21 12:24 AM, Michal Hocko wrote:
> 
> > 
> > I have already acked this patch in the previous version along with Fixes
> > tag. It seems that my review feedback has been completely ignored also
> > for other patches in this series.
> 
> Michal,
> 
> My apology.  Our mail system screwed up and there are some mail missing
> from our mail system that I completely missed your mail.  
> Only saw them now after I looked into the lore.kernel.org.

I see. My apology for suspecting you from ignoring my review.
 
> Responding to your comment:
> 
> >Have you observed this happening in the real life? I do agree that the
> >threshold based updates of the tree is not ideal but the whole soft
> >reclaim code is far from optimal. So why do we care only now? The
> >feature is essentially dead and fine tuning it sounds like a step back
> >to me.
> 
> Yes, I did see the issue mentioned in patch 2 breaking soft limit
> reclaim for cgroup v1.  There are still some of our customers using
> cgroup v1 so we will like to fix this if possible.

It would be great to see more details.

> For patch 3 regarding the uncharge_batch, it
> is more of an observation that we should uncharge in batch of same node
> and not prompted by actual workload.
> Thinking more about this, the worst that could happen
> is we could have some entries in the soft limit tree that overestimate
> the memory used.  The worst that could happen is a soft page reclaim
> on that cgroup.  The overhead from extra memcg event update could
> be more than a soft page reclaim pass.  So let's drop patch 3
> for now.

I would still prefer to handle that in the soft limit reclaim path and
check each memcg for the soft limit reclaim excess before the reclaim.
 
> Let me know if you will like me to resend patch 1 with the fixes tag
> for commit 4e41695356fb ("memory controller: soft limit reclaim on contention")
> and if there are any changes I should make for patch 2.

I will ack and suggest Fixes.

> 
> Thanks.
> 
> Tim

-- 
Michal Hocko
SUSE Labs
