Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBEE3B825C
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 14:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhF3MsD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 08:48:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35898 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbhF3MsD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 08:48:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2201C225A1;
        Wed, 30 Jun 2021 12:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625057134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=95yU7azCR9vrMUUQnIiZZ2YMD6UkK2dFrLDtadQtmOU=;
        b=EOoyWKwYBEWeOZVNOd4TZb8SKU8Uz1SwSHS+ebntuPIXR0lqulrlkuIDtG/mscBaLPtlkV
        BFO4i7lcUXk9mkcrkXfKll1Rihe4cfpKKjgNfsFOjG4/Q7xuzJUtcHmS50+7ZNs56hEdJT
        TCzeB5OW/m/JCuLuS7z0Z8jsIxgEmug=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E93CBA3B8C;
        Wed, 30 Jun 2021 12:45:33 +0000 (UTC)
Date:   Wed, 30 Jun 2021 14:45:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 14/18] mm/memcg: Convert mem_cgroup_move_account() to
 use a folio
Message-ID: <YNxnbTNAeNB9Isie@dhcp22.suse.cz>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-15-willy@infradead.org>
 <YNwrrl6cn48t6w5B@dhcp22.suse.cz>
 <YNxUCLt/scn1d5jQ@casper.infradead.org>
 <YNxhlr4d7Nl0vCz0@dhcp22.suse.cz>
 <YNxkFSGUoaSzZ/36@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNxkFSGUoaSzZ/36@casper.infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 30-06-21 13:31:17, Matthew Wilcox wrote:
> On Wed, Jun 30, 2021 at 02:20:38PM +0200, Michal Hocko wrote:
> > On Wed 30-06-21 12:22:48, Matthew Wilcox wrote:
> > > We need to decide what 'NR_ANON_THPS' means in a folio-based world where
> > > we have folios of all orders.  Does it count only the number of pages
> > > in folios >= HPAGE_PMD_SIZE?  Or does it count the number of pages in
> > > folios > PAGE_SIZE?
> > 
> > At this stage we only have PMD based, right? I believe it would be
> > simpler to stick with that at the moment and change that to a more
> > generic way along with other places which need updating.
> > 
> > Wrt. counters they do count pages so in this case this shouldn't be a
> > problem. But we do have counters for pmd mappings and that might need
> > some care.
> 
> Looking at how these are reported:
> 
>         show_val_kb(m, "AnonHugePages:  ",
>                     global_node_page_state(NR_ANON_THPS));
>         show_val_kb(m, "ShmemHugePages: ",
>                     global_node_page_state(NR_SHMEM_THPS));
>         show_val_kb(m, "ShmemPmdMapped: ",
>                     global_node_page_state(NR_SHMEM_PMDMAPPED));
>         show_val_kb(m, "FileHugePages:  ",
>                     global_node_page_state(NR_FILE_THPS));
>         show_val_kb(m, "FilePmdMapped:  ",
>                     global_node_page_state(NR_FILE_PMDMAPPED));
> 
> it specifically refers to 'HugePages', so I think we need to only
> count folios with order >= PMD_ORDER.

Why? The presented value is in kB. It gives us a cumulative number of
transparent large pages.  Sure breakdown to respective orders would be
impossible in general but the same would be the case if order > PMD_ORDER.

I am not really sure how useful that information is in practice but that
is a different story.

> I'll make that change to
> folio_transhuge() and use folio_transhuge() here.

Thanks!

-- 
Michal Hocko
SUSE Labs
