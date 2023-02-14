Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59856696C5C
	for <lists+cgroups@lfdr.de>; Tue, 14 Feb 2023 19:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjBNSHV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Feb 2023 13:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjBNSHU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Feb 2023 13:07:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F51F301A7;
        Tue, 14 Feb 2023 10:07:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E76161812;
        Tue, 14 Feb 2023 18:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29529C433EF;
        Tue, 14 Feb 2023 18:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676398031;
        bh=mo5Umjy9gwExO76EH4fhPGRZILkdDvN7zeu4B6IXpbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JSdexqpQj2D7WoDy+wTQzA6bPbEBFtAFfWpra/k3mZOX8F+YU8l+loixlzfQnHpRl
         StJQjCZcxfvI1hCGrP9he6SkWulEfL/jl/hQBIE/ccoad3WYovmNOG2qK++T0iBVnx
         R0DgEQH4KAC0qHSiXbLbDvfEZovk0rupGv8Os8ykx8NK6AUZVXapozkpm9AqDcNA0K
         OAUpw65ppCoidmkeyOwlZ7ta3bM3oEfzqEz6rRNMP2KuxyYfcHeF5iTFWUvJG/XxOn
         yNnpVj55odo0KkauUlQInTpPWnipz1DgegvjUw0eRBlMSCe/Sq4eP09OOewJFXco44
         LUQpFb1Z23MwA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev,
        naoya.horiguchi@nec.com, linmiaohe@huawei.com, david@redhat.com,
        osalvador@suse.de, mike.kravetz@oracle.com, willy@infradead.org,
        damon@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mm: hugetlb: change to return bool for isolate_hugetlb()
Date:   Tue, 14 Feb 2023 18:07:08 +0000
Message-Id: <20230214180708.71645-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230214180324.71585-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 14 Feb 2023 18:03:24 +0000 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 14 Feb 2023 21:59:31 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
> > Now the isolate_hugetlb() only returns 0 or -EBUSY, and most users did not
> > care about the negative value, thus we can convert the isolate_hugetlb()
> > to return a boolean value to make code more clear when checking the
> > hugetlb isolation state. Moreover converts 2 users which will consider
> > the negative value returned by isolate_hugetlb().
> > 
> > No functional changes intended.
> > 
> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > ---
> >  include/linux/hugetlb.h |  6 +++---
> >  mm/hugetlb.c            | 12 ++++++++----
> >  mm/memory-failure.c     |  2 +-
> >  mm/mempolicy.c          |  2 +-
> >  mm/migrate.c            |  2 +-
> >  5 files changed, 14 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index df6dd624ccfe..5f5e4177b2e0 100644
[...]
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 53010a142e7f..c5136fa48638 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2128,7 +2128,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
> >  		if (PageHead(page)) {
> >  			err = isolate_hugetlb(page_folio(page), pagelist);
> >  			if (!err)
> > -				err = 1;
> > +				err = -EBUSY;
> 
> Again, I think this is confusing.  'err' is 'bool', not 'int'.

I mean, 'err' is not 'bool' but 'int', sorry.  See? This confuses me ;)


Thanks,
SJ

> 
> 
> Thanks,
> SJ
> 
> >  		}
> >  	} else {
> >  		struct page *head;
> > -- 
> > 2.27.0
> > 
