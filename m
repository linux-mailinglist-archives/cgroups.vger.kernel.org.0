Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EC54DD3B6
	for <lists+cgroups@lfdr.de>; Fri, 18 Mar 2022 04:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiCRDuw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Mar 2022 23:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiCRDuu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Mar 2022 23:50:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F2B1F044B
        for <cgroups@vger.kernel.org>; Thu, 17 Mar 2022 20:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P+lmjWlX8RjtV4mSys5aX5+QRT1CeRIMXrpuZ7wboyQ=; b=jDNKNbq2aqbauFSSIrR/iLvQkl
        vrOkqrmhcjWFh9YriZGIq1lRPIe0eMDRRbbDlJR8eD+nq/l6SUNwOvk7hK6SVYZApWVJdzgRh+Aui
        cHEGJJCs/zcTRHBC/6CWE9lcreR4hvpqoWFEM9TtaBeAKeq9wwmt07ZmeHopDAfYFORwgYFvSoVAt
        ckr3uLD3/KKM+XL1JwMSTb7URzAMRyW70QzpxD451khxD3pU7qNqwx9IqJcJlPjTVZhlLczjZhQUn
        duJmerinql6KSGBddJIM1OpulEXPRNtnoFTHZ4fhmLaOpYc3jVJMVuakCmHKHsepUjl3aaHA+ReXV
        KjQDzDOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nV3cF-007b06-Rh; Fri, 18 Mar 2022 03:49:27 +0000
Date:   Fri, 18 Mar 2022 03:49:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] memcg: Convert mc_target.page to mc_target.folio
Message-ID: <YjQBRx1+Rq7CYC4M@casper.infradead.org>
References: <YjJJIrENYb1qFHzl@casper.infradead.org>
 <YjMidqgZbieEyBuF@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjMidqgZbieEyBuF@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 17, 2022 at 12:58:46PM +0100, Michal Hocko wrote:
> On Wed 16-03-22 20:31:30, Matthew Wilcox wrote:
> > This is a fairly mechanical change to convert mc_target.page to
> > mc_target.folio.  This is a prerequisite for converting
> > find_get_incore_page() to find_get_incore_folio().  But I'm not
> > convinced it's right, and I'm not convinced the existing code is
> > quite right either.
> > 
> > In particular, the code in hunk @@ -6036,28 +6041,26 @@ needs
> > careful review.  There are also assumptions in here that a memory
> > allocation is never larger than a PMD, which is true today, but I've
> > been asked about larger allocations.
> 
> Could you be more specific about those usecases? Are they really
> interested in supporting larger pages for the memcg migration which is
> v1 only feature? Or you are interested merely to have the code more
> generic?

Ah!  I didn't realise memcg migration was a v1-only feature.  I think
that makes all of the questions much less interesting.  I've done some
more reading, and it seems like all of this is "best effort", so it
doesn't really matter if some folios get skipped.

I'm not entirely sure what the usecases are for >PMD sized folios.
I think the people who are asking for them probably overestimate how
useful / practical they'll turn out to be.  I sense it's a case of "our
hardware supports a range of sizes, and we'd like to be able to support
them all", rather than any sensible evaluation of the pros and cons.

> [...]
> > @@ -6036,28 +6041,26 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
> >  		case MC_TARGET_DEVICE:
> >  			device = true;
> >  			fallthrough;
> > -		case MC_TARGET_PAGE:
> > -			page = target.page;
> > +		case MC_TARGET_FOLIO:
> > +			folio = target.folio;
> >  			/*
> > -			 * We can have a part of the split pmd here. Moving it
> > -			 * can be done but it would be too convoluted so simply
> > -			 * ignore such a partial THP and keep it in original
> > -			 * memcg. There should be somebody mapping the head.
> > +			 * Is bailing out here with a large folio still the
> > +			 * right thing to do?  Unclear.
> >  			 */
> > -			if (PageTransCompound(page))
> > +			if (folio_test_large(folio))
> >  				goto put;
> > -			if (!device && isolate_lru_page(page))
> > +			if (!device && folio_isolate_lru(folio))
> >  				goto put;
> > -			if (!mem_cgroup_move_account(page, false,
> > +			if (!mem_cgroup_move_account(folio, false,
> >  						mc.from, mc.to)) {
> >  				mc.precharge--;
> >  				/* we uncharge from mc.from later. */
> >  				mc.moved_charge++;
> >  			}
> >  			if (!device)
> > -				putback_lru_page(page);
> > -put:			/* get_mctgt_type() gets the page */
> > -			put_page(page);
> > +				folio_putback_lru(folio);
> > +put:			/* get_mctgt_type() gets the folio */
> > +			folio_put(folio);
> >  			break;
> >  		case MC_TARGET_SWAP:
> >  			ent = target.ent;
> 
> It's been some time since I've looked at this particular code but my
> recollection and current understanding is that we are skipping over pte
> mapped huge pages for simplicity so that we do not have to recharge
> all other ptes from the same huge page. What kind of concern do you see
> there?

That makes sense.  I think the case that's currently mishandled is a
THP in tmpfs which is misaligned when mapped to userspace.  It's
skipped, even if the entire THP is mapped.  But maybe that simply
doesn't matter.

I suppose the question is: Do we care if mappings of files are not
migrated to the new memcg?  I'm getting a sense that the answer is "no",
and if we actually ended up skipping all file mappings, it wouldn't
matter.

Thanks for taking a look!
