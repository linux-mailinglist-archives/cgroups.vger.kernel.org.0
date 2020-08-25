Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD8D250E8F
	for <lists+cgroups@lfdr.de>; Tue, 25 Aug 2020 04:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHYCFK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 22:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgHYCFJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Aug 2020 22:05:09 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96536C061574
        for <cgroups@vger.kernel.org>; Mon, 24 Aug 2020 19:05:08 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id x24so9161568otp.3
        for <cgroups@vger.kernel.org>; Mon, 24 Aug 2020 19:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xCEzVSHJfiSnfhxabuVNC9t0rkX2zX2AVt5dsDA1M40=;
        b=Qx7zECjPFmyvrTTs8F/ocW7tCcVkTwhnunAlXDXZ02SD4HEo5pHK0qvUZ8cmV197QW
         23MJoL24elKzlrQkZr8Yc7T8ZQWrmKbeOUd4hY5pKufw1Z5VW9CMRTRZfbjXU1Za+2yc
         qRLjAl0KCQd2veC9jbi1F0Watbt0V5rKLyNSxNLUGzhHJw2G/qIDuCpOTi/JiHnQg6Lr
         gSCfATvLRBLoL6yZredvS7LzkNyRekKGV1W4rh92bKf6/LJkuKnmLxgLMp2gUOAexBpV
         MmYNyURSACJ5Zg10joqtevQml+/+IDZ7wYzyaTgpNw8011WUWi4XwnMLAStJVcudiGaV
         qJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xCEzVSHJfiSnfhxabuVNC9t0rkX2zX2AVt5dsDA1M40=;
        b=KLs+ec4/5jUFp7fwex1xb6BwpQQGciYZc6ZOJ6Y5DeNoe1t12ssZpa7fAj2XvCJWoZ
         en4VRebTIBEYDClF1AE+qscdS9aJlm/UQjb+keAXhcxEEDXS/hHhzfssAQ0iH2s/2K+3
         fpwbypIrgwRNKJkYjAGByiS+RI9koQg+LRfF0gdcB2hRqriHSMVneIWBp4KqoybzWJcq
         /7vh/B4xKNoPHcjiNRAXjOQHBV2gQ+ksbMU5koDTTCpwU5OXZ24QJ32nNPxdl7PZVS7+
         Tpb7mnLtu+Xd1O+H6eIg+XU1SIhrGv8+GckOYiW85kMzLMKLR1r7Vg28szkYOdjJxVS4
         HhBQ==
X-Gm-Message-State: AOAM531zhlZ5ojRu/df+jA9n3206P3iStl58qlfL9+6vrdLbYv+4vDUD
        Jg2LKEY5/O/I7Q3l3wEQXF3B5A==
X-Google-Smtp-Source: ABdhPJxzM2WV+TVOMQL/4Ow6BMstFoj6g+xmPTXBpDKBq7id1uxSEggrr4ObCz8lU1snOf/c5wzcZg==
X-Received: by 2002:a9d:12a9:: with SMTP id g38mr5224481otg.299.1598321107433;
        Mon, 24 Aug 2020 19:05:07 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w62sm2402101otb.52.2020.08.24.19.05.05
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 24 Aug 2020 19:05:06 -0700 (PDT)
Date:   Mon, 24 Aug 2020 19:04:53 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nao.horiguchi@gmail.com,
        osalvador@suse.de, mike.kravetz@oracle.com
Subject: Re: [Resend PATCH 1/6] mm/memcg: warning on !memcg after readahead
 page charged
In-Reply-To: <12425e06-38ce-7ff4-28ce-b0418353fc67@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2008241849020.1171@eggly.anvils>
References: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com> <20200820145850.GA4622@lca.pw> <20200821080127.GD32537@dhcp22.suse.cz> <20200821123934.GA4314@lca.pw> <20200821134842.GF32537@dhcp22.suse.cz> <20200824151013.GB3415@dhcp22.suse.cz>
 <12425e06-38ce-7ff4-28ce-b0418353fc67@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 25 Aug 2020, Alex Shi wrote:
> reproduce using our linux-mm random bug collection on NUMA systems.
> >>
> >> OK, I must have missed that this was on ppc. The order makes more sense
> >> now. I will have a look at this next week.
> > 
> > OK, so I've had a look and I know what's going on there. The
> > move_pages12 is migrating hugetlb pages. Those are not charged to any
> > memcg. We have completely missed this case. There are two ways going
> > around that. Drop the warning and update the comment so that we do not
> > forget about that or special case hugetlb pages.
> > 
> > I think the first option is better.
> > 
> 
> 
> Hi Michal,
> 
> Compare to ignore the warning which is designed to give, seems addressing
> the hugetlb out of charge issue is a better solution, otherwise the memcg
> memory usage is out of control on hugetlb, is that right?

Please don't suppose that this is peculiar to hugetlb: I'm not
testing hugetlb at all (sorry), but I see the VM_WARN_ON_ONCE from
mem_cgroup_page_lruvec(), and from mem_cgroup_migrate(), and from
mem_cgroup_swapout().

In all cases seen on a PageAnon page (well, in one case PageKsm).
And not related to THP either: seen also on machine incapable of THP.

Maybe there's an independent change in 5.9-rc that's defeating
expectations here, or maybe they were never valid.  Worth
investigating, even though the patch is currently removed,
to find out why expectations were wrong.

You'll ask me for more info, stacktraces etc, and I'll say sorry,
no time today.  Please try the swapping tests I sent before.

And may I say, the comment
/* Readahead page is charged too, to see if other page uncharged */
is nonsensical to me, and much better deleted: maybe it would make
some sense if the reader could see the comment it replaces - as
they can in the patch - but not in the resulting source file.

Hugh
