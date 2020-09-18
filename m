Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FA426FB28
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 13:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIRLJS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Sep 2020 07:09:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:59446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgIRLJS (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 18 Sep 2020 07:09:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600427356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oLMBMFXjeRjM8sse2MwoiIZCDWhxj5hdGhG2mv+8ZfM=;
        b=aCy12HXaLpMFm3wWBWPRD4Mau7bVtBzZ4QC0hZ//7Ai72QDZ/Ppx0fmC2hUo65dnEhtIvI
        fJlNYu79u38CAVGOsY+KQjSXAL4qyJ22dK6LTePMfrzBgN37bR4BmL71zl5JMp2KJ1+qbf
        CPVZlgErUmwP5U34x2epVjvUBELhQyo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5ABFCABC4;
        Fri, 18 Sep 2020 11:09:50 +0000 (UTC)
Date:   Fri, 18 Sep 2020 13:09:14 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] mm: use page_off_lru()
Message-ID: <20200918110914.GK28827@dhcp22.suse.cz>
References: <20200918030051.650890-1-yuzhao@google.com>
 <20200918030051.650890-3-yuzhao@google.com>
 <20200918073700.GE28827@dhcp22.suse.cz>
 <20200918102713.GB1004594@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918102713.GB1004594@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 18-09-20 04:27:13, Yu Zhao wrote:
> On Fri, Sep 18, 2020 at 09:37:00AM +0200, Michal Hocko wrote:
> > On Thu 17-09-20 21:00:40, Yu Zhao wrote:
> > > This patch replaces the only open-coded __ClearPageActive() with
> > > page_off_lru(). There is no open-coded __ClearPageUnevictable()s.
> > > 
> > > Before this patch, we have:
> > > 	__ClearPageActive()
> > > 	add_page_to_lru_list()
> > > 
> > > After this patch, we have:
> > > 	page_off_lru()
> > > 		if PageUnevictable()
> > > 			__ClearPageUnevictable()
> > > 		else if PageActive()
> > > 			__ClearPageActive()
> > > 	add_page_to_lru_list()
> > > 
> > > Checking PageUnevictable() shouldn't be a problem because these two
> > > flags are mutually exclusive. Leaking either will trigger bad_page().
> > 
> > I am sorry but the changelog is really hard to grasp. What are you
> > trying to achieve, why and why it is safe. This should be a general
> > outline for any patch. I have already commented on the previous patch
> > and asked you for the explanation why removing __ClearPageActive from
> > this path is desirable and safe. I have specifically asked to clarify
> > the compound page situation as that is using its oen destructor in the
> > freeing path and that might result in page_off_lru to be not called.
> 
> Haven't I explained we are NOT removing __ClearPageActive()? Is my
> notion of the code structure above confusing you? Or 'open-coded'
> could mean different things?

Please read through my reply carefuly. I am not saying what you are
doing is wrong. I am expressing a lack of justification which is the
case throughout this patch series. You do not explain why we need it and
why reviewers should spend time on this. Because the review is not as
trivial as looking at the diff.
-- 
Michal Hocko
SUSE Labs
