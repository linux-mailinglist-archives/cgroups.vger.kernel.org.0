Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C884253D58
	for <lists+cgroups@lfdr.de>; Thu, 27 Aug 2020 08:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgH0GAv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Aug 2020 02:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgH0GAu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Aug 2020 02:00:50 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F77DC061246
        for <cgroups@vger.kernel.org>; Wed, 26 Aug 2020 23:00:50 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 144so4930750qkl.5
        for <cgroups@vger.kernel.org>; Wed, 26 Aug 2020 23:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NtN8IRKJbzMJm++6LA+dfi/0c6Tg1EKcXVsplcKZjIA=;
        b=OHUT2pXBHEvz0iQbWGht6j79B2je+0WG1m4V06yzQSmQ8xZ0CTqRyOf2DFbg599fsQ
         in1XxmVaKLFPXQhY7e0CbKCZIThDyunI62UcrwGETKCLwUyDACGT2fLoIa3QLMv47ujv
         hgKSCIE6sM0G45Nwf8tJ3cjUfi8x9N3IqHqNVIiH6kcIddQlA6kvjjZv0Oim2YJnkLfm
         ouySm8zYZ+EhX/1rThbbUYa/8d8DgEZotJ7lglQKUB6h/0VxGLttAqZkMyZl4QQKBdya
         iAKe52c5+KP365662n/5VnEJpllmtyDO+8oPDP1f7h9ofPcCZCTQ4x/tw+0zmWL7oX+p
         I5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NtN8IRKJbzMJm++6LA+dfi/0c6Tg1EKcXVsplcKZjIA=;
        b=Pa6m6n1iJRa29Cg6e6iPLKO5oqP7xli1KZjWBsLW/V7PXdWjpFwAUNolu7pet/OA5c
         Jn14NhYsJ3MX+1vqP/Z/V9vDSLdgxsS+XWDeeoAOdvEm2h5Tc6nRGxOlowo53BJFBemU
         KrKt8UE+P2Z2BrXFG5uBBS7uTrAkTa5Jj3e4Jg/tDhcduHAJJ2kmvHJODr0EGSJYS3D/
         TttFyo99r1lwPLnckz8vynngVsDg96NALEWlYoh4/7NDzFfRVd6DglFAq0Ob3uD+keIZ
         YUCPPbYN1YlAH1fwF9OEGp1EHUSD8MPfGzJKtIA7jl2AwZz3txAh7ylhPBhRoDgU4dSg
         +V9w==
X-Gm-Message-State: AOAM533CS1kY1w9eyEdMinhhH0sxnhIp4m6AIEeq8Y51bg29uFDWW478
        IchegXa8IAEc7J9fpg5zJ6tf7w==
X-Google-Smtp-Source: ABdhPJzTi4TOXzZ1Rou+0ylWYjoURnjNtWOQ/tpkqfSGOVu4C9+0/TdnaP1vDHHc5DUgSCwUiy9Ugg==
X-Received: by 2002:a37:2750:: with SMTP id n77mr17039241qkn.26.1598508048964;
        Wed, 26 Aug 2020 23:00:48 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d9sm885200qkl.7.2020.08.26.23.00.46
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 26 Aug 2020 23:00:47 -0700 (PDT)
Date:   Wed, 26 Aug 2020 23:00:33 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
        Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nao.horiguchi@gmail.com,
        osalvador@suse.de, mike.kravetz@oracle.com
Subject: Re: [Resend PATCH 1/6] mm/memcg: warning on !memcg after readahead
 page charged
In-Reply-To: <alpine.LSU.2.11.2008241849020.1171@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2008262222380.4405@eggly.anvils>
References: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com> <20200820145850.GA4622@lca.pw> <20200821080127.GD32537@dhcp22.suse.cz> <20200821123934.GA4314@lca.pw> <20200821134842.GF32537@dhcp22.suse.cz> <20200824151013.GB3415@dhcp22.suse.cz>
 <12425e06-38ce-7ff4-28ce-b0418353fc67@linux.alibaba.com> <alpine.LSU.2.11.2008241849020.1171@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 24 Aug 2020, Hugh Dickins wrote:
> On Tue, 25 Aug 2020, Alex Shi wrote:
> > reproduce using our linux-mm random bug collection on NUMA systems.
> > >>
> > >> OK, I must have missed that this was on ppc. The order makes more sense
> > >> now. I will have a look at this next week.
> > > 
> > > OK, so I've had a look and I know what's going on there. The
> > > move_pages12 is migrating hugetlb pages. Those are not charged to any
> > > memcg. We have completely missed this case. There are two ways going
> > > around that. Drop the warning and update the comment so that we do not
> > > forget about that or special case hugetlb pages.
> > > 
> > > I think the first option is better.
> > > 
> > 
> > 
> > Hi Michal,
> > 
> > Compare to ignore the warning which is designed to give, seems addressing
> > the hugetlb out of charge issue is a better solution, otherwise the memcg
> > memory usage is out of control on hugetlb, is that right?

I agree: it seems that hugetlb is not participating in memcg and lrus,
so it should not even be calling mem_cgroup_migrate().  That happens
because hugetlb finds the rest of migrate_page_states() useful,
but maybe there just needs to be an "if (!PageHuge(page))" or
"if (!PageHuge(newpage))" before its call to mem_cgroup_migrate() -
but I have not yet checked whether either of those actually works.

The same could be done inside mem_cgroup_migrate() instead,
but it just seems wrong for hugetlb to be getting that far,
if it has no other reason to enter mm/memcontrol.c.

> 
> Please don't suppose that this is peculiar to hugetlb: I'm not
> testing hugetlb at all (sorry), but I see the VM_WARN_ON_ONCE from
> mem_cgroup_page_lruvec(), and from mem_cgroup_migrate(), and from
> mem_cgroup_swapout().
> 
> In all cases seen on a PageAnon page (well, in one case PageKsm).
> And not related to THP either: seen also on machine incapable of THP.
> 
> Maybe there's an independent change in 5.9-rc that's defeating
> expectations here, or maybe they were never valid.  Worth
> investigating, even though the patch is currently removed,
> to find out why expectations were wrong.

It was very well worth investigating.  And at the time of writing
the above, I thought it was coming up very quickly on all machines,
but in fact it only came up quickly on the one exercising KSM;
on the other machines it took about an hour to appear, so no
wonder that you and others had not already seen it.

While I'd prefer to spring the answer on you all in the patch that
fixes it, there's something more there that I don't fully understand
yet, and want to sort out before posting; so I'd better not keep you
in suspense... we broke the memcg charging of ksm_might_need_to_copy()
pages a couple of releases ago, and not noticed until your warning.

What's surprising is that the same bug can affect PageAnon pages too,
even when there's been no KSM involved whatsoever.  I put in the KSM
fix, set all the machines running, expecting to get more info on the
PageAnon instances, but all of them turned out to be fixed.

> 
> You'll ask me for more info, stacktraces etc, and I'll say sorry,
> no time today.  Please try the swapping tests I sent before.
> 
> And may I say, the comment
> /* Readahead page is charged too, to see if other page uncharged */
> is nonsensical to me, and much better deleted: maybe it would make
> some sense if the reader could see the comment it replaces - as
> they can in the patch - but not in the resulting source file.

I stand by that remark; but otherwise, I think this was a helpful
commit that helped to identify a bug, just as it was intended to do.
(I say "helped to" because its warnings alerted, but did not point
to the culprit: I had to add another in lru_cache_add() to find it.)

Hugh
