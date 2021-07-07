Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E70E3BEAA5
	for <lists+cgroups@lfdr.de>; Wed,  7 Jul 2021 17:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbhGGP2L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Jul 2021 11:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhGGP2L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Jul 2021 11:28:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC46C061574
        for <cgroups@vger.kernel.org>; Wed,  7 Jul 2021 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+zsfdjVgnxMHynCmmkxrnBrhGlR05KkOhD40pFea5wU=; b=Z9ayHCnfITRQ1mdzMiod9N4wJN
        gkqu78BKwwH+WTEGKQBlvGfBqxkuiQtrk6O5m/hcpdFnUoaJ7+QIO0rihEDbbw6GIqdItItUW+pFz
        PU+N6hlENMCsFFhXmUzFlJAwqkpjwsjkky8OvTom7sNkmnz6P8S9JbjgSAOcJANQQZvuqq6RTzRDQ
        ZuYVH8UDXUNo875q7ASLMaIiPN5+GecbcQ9LYxtWHurgTQnnicgLpu8ihymPSVD3e9I1aImDT6pJF
        vqaIZ34Y8d/YEccLfC8cLa+ofuzNEUHpTwMU4X3OgET9hchOR+KahhkARtbIXYB/LVX8FfuqkY7s3
        mF7kOJdg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m19QB-00CWal-PX; Wed, 07 Jul 2021 15:25:11 +0000
Date:   Wed, 7 Jul 2021 16:25:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 14/18] mm/memcg: Convert mem_cgroup_move_account() to
 use a folio
Message-ID: <YOXHU42efcFGF/D4@casper.infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-15-willy@infradead.org>
 <YNwrrl6cn48t6w5B@dhcp22.suse.cz>
 <YNxUCLt/scn1d5jQ@casper.infradead.org>
 <YNxhlr4d7Nl0vCz0@dhcp22.suse.cz>
 <YNxkFSGUoaSzZ/36@casper.infradead.org>
 <YNxnbTNAeNB9Isie@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNxnbTNAeNB9Isie@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 30, 2021 at 02:45:33PM +0200, Michal Hocko wrote:
> On Wed 30-06-21 13:31:17, Matthew Wilcox wrote:
> > On Wed, Jun 30, 2021 at 02:20:38PM +0200, Michal Hocko wrote:
> > > On Wed 30-06-21 12:22:48, Matthew Wilcox wrote:
> > > > We need to decide what 'NR_ANON_THPS' means in a folio-based world where
> > > > we have folios of all orders.  Does it count only the number of pages
> > > > in folios >= HPAGE_PMD_SIZE?  Or does it count the number of pages in
> > > > folios > PAGE_SIZE?
> > > 
> > > At this stage we only have PMD based, right? I believe it would be
> > > simpler to stick with that at the moment and change that to a more
> > > generic way along with other places which need updating.
> > > 
> > > Wrt. counters they do count pages so in this case this shouldn't be a
> > > problem. But we do have counters for pmd mappings and that might need
> > > some care.
> > 
> > Looking at how these are reported:
> > 
> >         show_val_kb(m, "AnonHugePages:  ",
> >                     global_node_page_state(NR_ANON_THPS));
> >         show_val_kb(m, "ShmemHugePages: ",
> >                     global_node_page_state(NR_SHMEM_THPS));
> >         show_val_kb(m, "ShmemPmdMapped: ",
> >                     global_node_page_state(NR_SHMEM_PMDMAPPED));
> >         show_val_kb(m, "FileHugePages:  ",
> >                     global_node_page_state(NR_FILE_THPS));
> >         show_val_kb(m, "FilePmdMapped:  ",
> >                     global_node_page_state(NR_FILE_PMDMAPPED));
> > 
> > it specifically refers to 'HugePages', so I think we need to only
> > count folios with order >= PMD_ORDER.
> 
> Why? The presented value is in kB. It gives us a cumulative number of
> transparent large pages.  Sure breakdown to respective orders would be
> impossible in general but the same would be the case if order > PMD_ORDER.
> 
> I am not really sure how useful that information is in practice but that
> is a different story.

The scenario I'm thinking about is a situation where we have gigabytes
of memory in the page cache in 16k-64k chunks and we'll see
FileHugePages: 5219348 kB
FilePmdMapped:       0 kB

which might cause the slightly-too-clever user to think there's a
problem.
