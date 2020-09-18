Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B24A270464
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 20:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIRSyE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Sep 2020 14:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRSyE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Sep 2020 14:54:04 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB91C0613CE
        for <cgroups@vger.kernel.org>; Fri, 18 Sep 2020 11:54:04 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r9so8049239ioa.2
        for <cgroups@vger.kernel.org>; Fri, 18 Sep 2020 11:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UsPKgMSyFpC4dZoU1fh+j1TUaGHxHd0bh9PqbiT/L5U=;
        b=LkvJaXH+U8mrEYeCNWO2O6kMOoDz/lVdIJf5f58C1MK2fZ4GkvaaL8QNgZTcVMfBfF
         73gJtRq4j076mbGAa63E1ULzd92YYRBtcOAxN7f00c1xs1UgIPCxpy49sT6ZV7mqADlM
         2XwZY6l5+A9FAnwiCFApQ/A1gMNRycje9HMh/3CCm5NOa7FIcIopFGD/HzxxvRiLhIN9
         lIq/f+90PG+yY3bZl5QmkQ+/E1hnXwglFT9YTb79ttaWEiWOFu3pFvAJU/1sObGcXXkt
         wWzZtd9zOOkddEypESurmueNd9Y5YzVrdSMdZr+n3fzVa8Gvdgb8EotBmgPde/pixweg
         f9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UsPKgMSyFpC4dZoU1fh+j1TUaGHxHd0bh9PqbiT/L5U=;
        b=PZg/PoHRhxchbR+by/8rSO33QTnaQaDTMvs48EJiKb+VCCmCt3mUcRcQ/gJgeqx2yo
         TJEdJOkixnRQT1+aNlr8XKO0DakhzVHeFaHFZr5EVuaxcxcz8Saq7DCZgbR/Nz7lHEfP
         iJwSFgmwJ6zGepJIoyt16FGyPURpj7lFQoSgBayI+SExSoU5N5TvauD4jLDiL1DDI+W6
         vxUOpLBH0eCDYGcQJQc7KKoyDuakFWQ2Rwht5GIBuzQktOliy4OBgDKI096DYFqAjb9B
         UV1RzkTm0OwIC/84tF8y+29nPWpIWlKI9DaAI6K035aiAK87dTPUtbp6ZImPrPMR5HNx
         DxEQ==
X-Gm-Message-State: AOAM530dG5n7bE/e+pWPeMjY3gEfaCvIRVOg8sNYihlljfgJT56JVRcU
        2p0u8uJkDmvnlCDiGJ6bvcw43A==
X-Google-Smtp-Source: ABdhPJxHmVEbRNB4JMGgDW9ScAN70Dh87oJ1EB2DOPXrIlbPlDDplv7VfIepqr80Q87AmEKzD/rypQ==
X-Received: by 2002:a6b:6d07:: with SMTP id a7mr27628444iod.82.1600455243299;
        Fri, 18 Sep 2020 11:54:03 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id c85sm2096858ilg.10.2020.09.18.11.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 11:54:02 -0700 (PDT)
Date:   Fri, 18 Sep 2020 12:53:58 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <20200918185358.GA1095986@google.com>
References: <20200918030051.650890-1-yuzhao@google.com>
 <20200918030051.650890-3-yuzhao@google.com>
 <20200918073700.GE28827@dhcp22.suse.cz>
 <20200918102713.GB1004594@google.com>
 <20200918110914.GK28827@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918110914.GK28827@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 18, 2020 at 01:09:14PM +0200, Michal Hocko wrote:
> On Fri 18-09-20 04:27:13, Yu Zhao wrote:
> > On Fri, Sep 18, 2020 at 09:37:00AM +0200, Michal Hocko wrote:
> > > On Thu 17-09-20 21:00:40, Yu Zhao wrote:
> > > > This patch replaces the only open-coded __ClearPageActive() with
> > > > page_off_lru(). There is no open-coded __ClearPageUnevictable()s.
> > > > 
> > > > Before this patch, we have:
> > > > 	__ClearPageActive()
> > > > 	add_page_to_lru_list()
> > > > 
> > > > After this patch, we have:
> > > > 	page_off_lru()
> > > > 		if PageUnevictable()
> > > > 			__ClearPageUnevictable()
> > > > 		else if PageActive()
> > > > 			__ClearPageActive()
> > > > 	add_page_to_lru_list()
> > > > 
> > > > Checking PageUnevictable() shouldn't be a problem because these two
> > > > flags are mutually exclusive. Leaking either will trigger bad_page().
> > > 
> > > I am sorry but the changelog is really hard to grasp. What are you
> > > trying to achieve, why and why it is safe. This should be a general
> > > outline for any patch. I have already commented on the previous patch
> > > and asked you for the explanation why removing __ClearPageActive from
> > > this path is desirable and safe. I have specifically asked to clarify
> > > the compound page situation as that is using its oen destructor in the
> > > freeing path and that might result in page_off_lru to be not called.
> > 
> > Haven't I explained we are NOT removing __ClearPageActive()? Is my
> > notion of the code structure above confusing you? Or 'open-coded'
> > could mean different things?
> 
> Please read through my reply carefuly. I am not saying what you are
> doing is wrong. I am expressing a lack of justification which is the
> case throughout this patch series. You do not explain why we need it and
> why reviewers should spend time on this. Because the review is not as
> trivial as looking at the diff.

I appreciate your time. But if you are looking for some grand
justification, I'm afraid I won't be able to give one, because, as it's
titled, this is just a series of cleanup patches.

My questions above are meant to determine which parts are not clear.
Well, I still don't know. So let's try this. What's your impression upon
reading the first sentence of this patch?

> > > > This patch replaces the only open-coded __ClearPageActive() with
> > > > page_off_lru().

Here is how I would think when I read it (which is purely subjective
since I wrote it):

  'replaces the only (an outlier) open-coded (bad) with
   page_off_lru() (the norm)'

It seems to me it has everything I need to know (or say). Of course I
could spell them all out for you if that's how you'd prefer. And if
it's not enough, then please show me some examples and I'll study
them carefully and try my best to follow them.
