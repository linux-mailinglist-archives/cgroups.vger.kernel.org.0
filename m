Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78029316B12
	for <lists+cgroups@lfdr.de>; Wed, 10 Feb 2021 17:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhBJQXB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Feb 2021 11:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhBJQW7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Feb 2021 11:22:59 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E222C061574
        for <cgroups@vger.kernel.org>; Wed, 10 Feb 2021 08:22:19 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id r21so2271440otk.13
        for <cgroups@vger.kernel.org>; Wed, 10 Feb 2021 08:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wc8HtUu6YXXorPykhuoj08SCrBEaocuYohr96nbgn+w=;
        b=fpSdWoUW/YxqsP5HrQVPzNsTdbTt5mOIk6GqFhMMF/biAw553DP/Q7qeQJMjwPShNk
         1tRCVOShdBPkTNGrIargdgle8wgQceXqCAn3IHA7g3D04Ow8R7+9FWnFmuNmYkLtRhc3
         NPZRlQhxOcWweh5MO8A8cXXzWeWCBg+WAxOyFchaYUnrwwxZ4crSYQ0oL8jAS9UrwmfP
         CW1W7cC6X2NLISJ0M4LetFXkBGcA78Y68b1khrpiqAvP7GG9vuz60hI/o+GaUIpyObsJ
         SJ7LZjvLn5dEu4MAlTKTFOVnNmu8Z9Fsn7GavQTkW21qdobIJyuLdv3dBLsT3lnHDn9s
         ymow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wc8HtUu6YXXorPykhuoj08SCrBEaocuYohr96nbgn+w=;
        b=Q45G66c8cfwatUqlc24p69zc7/3QfF0qSCOlokgYdU7MGMx05UC0zfHo/eEa8TIgrm
         sRc4adluIP6fEKimiOWgeHqehfmA/Px3+CNdXxN4MwVyvFx/4PfceYmmO9YVkfMe73+e
         i7c2dBUevsVaA/JVIEz5WDGysyQHi14PCu5nxVfIWOZ8tEMiVKQZLuJeJTVDqbtiWBGg
         ym/JT7qn4hi/xEJGqAGMA2q0E9KnPTUf4WFxXBbUlhNl0MrLVNXfKfwE/fx0QZEJAY02
         qIARMCh3pFfix9y2VaavvJD5ZLMRdth0d+oL6d5VWcV20fxC9hX1esYMpVFDOiM3ObmO
         RASw==
X-Gm-Message-State: AOAM5328UuI2z9+JTtZ/HZNoCYhx83rJumxFH7gd1saUKhedMUnPsJWs
        dOm5yDWwxivUsfHNe8I+ibTzbw==
X-Google-Smtp-Source: ABdhPJzFYRaplbkS1RH+LmiiiX/VXruT2JjzG+k8qQn+YmZ8WOswV6fq4bPqMPbLfV5JAEg+RBBs9w==
X-Received: by 2002:a05:6830:3497:: with SMTP id c23mr1310200otu.253.1612974138446;
        Wed, 10 Feb 2021 08:22:18 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 94sm466895otf.41.2021.02.10.08.22.17
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 10 Feb 2021 08:22:17 -0800 (PST)
Date:   Wed, 10 Feb 2021 08:22:00 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: page-writeback: simplify memcg handling in
 test_clear_page_writeback()
In-Reply-To: <alpine.LSU.2.11.2102092058290.7553@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2102100813050.8131@eggly.anvils>
References: <20210209214543.112655-1-hannes@cmpxchg.org> <alpine.LSU.2.11.2102092058290.7553@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 9 Feb 2021, Hugh Dickins wrote:
> On Tue, 9 Feb 2021, Johannes Weiner wrote:
> 
> > Page writeback doesn't hold a page reference, which allows truncate to
> > free a page the second PageWriteback is cleared. This used to require
> > special attention in test_clear_page_writeback(), where we had to be
> > careful not to rely on the unstable page->memcg binding and look up
> > all the necessary information before clearing the writeback flag.
> > 
> > Since commit 073861ed77b6 ("mm: fix VM_BUG_ON(PageTail) and
> > BUG_ON(PageWriteback)") test_clear_page_writeback() is called with an
> > explicit reference on the page, and this dance is no longer needed.
> > 
> > Use unlock_page_memcg() and dec_lruvec_page_stat() directly.
> 
> s/stat()/state()/
> 
> This is a nice cleanup: I hadn't seen that connection at all.
> 
> But I think you should take it further:
> __unlock_page_memcg() can then be static in mm/memcontrol.c,
> and its declarations deleted from include/linux/memcontrol.h?

And further: void lock_page_memcg(page), not returning memcg.

> 
> And further: delete __dec_lruvec_state() and dec_lruvec_state()
> from include/linux/vmstat.h - unless you feel that every "inc"
> ought to be matched by a "dec", even when unused.
> 
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> > ---
> >  mm/page-writeback.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index eb34d204d4ee..f6c2c3165d4d 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -2722,12 +2722,9 @@ EXPORT_SYMBOL(clear_page_dirty_for_io);
> >  int test_clear_page_writeback(struct page *page)
> >  {
> >  	struct address_space *mapping = page_mapping(page);
> > -	struct mem_cgroup *memcg;
> > -	struct lruvec *lruvec;
> >  	int ret;
> >  
> > -	memcg = lock_page_memcg(page);
> > -	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> > +	lock_page_memcg(page);
> >  	if (mapping && mapping_use_writeback_tags(mapping)) {
> >  		struct inode *inode = mapping->host;
> >  		struct backing_dev_info *bdi = inode_to_bdi(inode);
> > @@ -2755,11 +2752,11 @@ int test_clear_page_writeback(struct page *page)
> >  		ret = TestClearPageWriteback(page);
> >  	}
> >  	if (ret) {
> > -		dec_lruvec_state(lruvec, NR_WRITEBACK);
> > +		dec_lruvec_page_state(page, NR_WRITEBACK);
> >  		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
> >  		inc_node_page_state(page, NR_WRITTEN);
> >  	}
> > -	__unlock_page_memcg(memcg);
> > +	unlock_page_memcg(page);
> >  	return ret;
> >  }
> >  
> > -- 
> > 2.30.0
> 
