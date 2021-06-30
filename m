Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5384F3B813E
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 13:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbhF3LZs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 07:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhF3LZr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 07:25:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BA8C061756
        for <cgroups@vger.kernel.org>; Wed, 30 Jun 2021 04:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qrj5IivtqnPita8/luPfOpstNFxH4Y1PmGJb28I+4HM=; b=KHSWYVNSEXqE+hAvHoVc7fT9bk
        hEybG4f2y4gDErI3lZGWGyRNBBc53Ku52AfOJoulx9w4gTCsMkQ+3bGHXBE2JOEatBYRHS3IJr9JL
        6+rTND0YLsSmh03mf3yZ0oQ+jh82oH2VQHuleOnYsautd7SvnBZwI2bP6mH9y6MuVXC4FQiktIiuu
        XyD1Y1MBxT47ouppzTDbwLRgwl+l9R/q/R5oPklGzbUk/i0pR76NXykDMtOLW+uZhVwAMrPCqt/+4
        OdfWsZURDjCZb5RqwPjqVb6kyHbKAcDsZw4XTXxktL+cvrOJslMxGkz0ofUkqerejMB25uOv+Gcw6
        OEq9VJTg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyYIq-005GfN-NM; Wed, 30 Jun 2021 11:22:56 +0000
Date:   Wed, 30 Jun 2021 12:22:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 14/18] mm/memcg: Convert mem_cgroup_move_account() to
 use a folio
Message-ID: <YNxUCLt/scn1d5jQ@casper.infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-15-willy@infradead.org>
 <YNwrrl6cn48t6w5B@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNwrrl6cn48t6w5B@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 30, 2021 at 10:30:38AM +0200, Michal Hocko wrote:
> > -	if (PageAnon(page)) {
> > -		if (page_mapped(page)) {
> > +	if (folio_anon(folio)) {
> > +		if (folio_mapped(folio)) {
> >  			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
> >  			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
> > -			if (PageTransHuge(page)) {
> > +			if (folio_multi(folio)) {
> 
> Shouldn't be folio_transhuge? The resulting code is the same but
> folio_transhuge is more explicit and matches the THP aspect.

I genuinely don't know.  For the benefit of those reading along, the
important part of the context is:

                if (folio_mapped(folio)) {
                        __mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
                        __mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
                        if (folio_multi(folio)) {
                                __mod_lruvec_state(from_vec, NR_ANON_THPS,
                                                   -nr_pages);
                                __mod_lruvec_state(to_vec, NR_ANON_THPS,
                                                   nr_pages);
                        }
                }

We need to decide what 'NR_ANON_THPS' means in a folio-based world where
we have folios of all orders.  Does it count only the number of pages
in folios >= HPAGE_PMD_SIZE?  Or does it count the number of pages in
folios > PAGE_SIZE?

Similar question (and I suspect the same answer) for NR_SHMEM_THPS and
NR_FILE_THPS.  Right now, I've been accounting any multi-page folio as
a THP, but I don't have a good sense of what the answer should be.
