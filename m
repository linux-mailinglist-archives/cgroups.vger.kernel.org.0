Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472244DD6E4
	for <lists+cgroups@lfdr.de>; Fri, 18 Mar 2022 10:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiCRJN6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Mar 2022 05:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiCRJN6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Mar 2022 05:13:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1302C5784
        for <cgroups@vger.kernel.org>; Fri, 18 Mar 2022 02:12:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 05720210EC;
        Fri, 18 Mar 2022 09:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647594758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yk/mGHSn8BRwoxpYgM2QMot9CU5E0d7sStOUlUWO988=;
        b=HraKjKE4Fh3wvBHXqN+3Dkof0fl72OSnSPCpTwrGC2jGR9+4rlg/DhmiQWF0z4h7Qb6uQo
        7GUHh7LFyhWnc8lMvZTS0RJQmDgkCyGn4JAke85v4kZ1BBzBUtuMgJIRBYMV51m7U8iw9W
        Hg5SwD8L7Z2hU8GqhH2KtFlpM0A6Y+8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BD587A3B8A;
        Fri, 18 Mar 2022 09:12:37 +0000 (UTC)
Date:   Fri, 18 Mar 2022 10:12:37 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] memcg: Convert mc_target.page to mc_target.folio
Message-ID: <YjRNBdEENrNNrUNe@dhcp22.suse.cz>
References: <YjJJIrENYb1qFHzl@casper.infradead.org>
 <YjMidqgZbieEyBuF@dhcp22.suse.cz>
 <YjQBRx1+Rq7CYC4M@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjQBRx1+Rq7CYC4M@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 18-03-22 03:49:27, Matthew Wilcox wrote:
> On Thu, Mar 17, 2022 at 12:58:46PM +0100, Michal Hocko wrote:
> > On Wed 16-03-22 20:31:30, Matthew Wilcox wrote:
> > > This is a fairly mechanical change to convert mc_target.page to
> > > mc_target.folio.  This is a prerequisite for converting
> > > find_get_incore_page() to find_get_incore_folio().  But I'm not
> > > convinced it's right, and I'm not convinced the existing code is
> > > quite right either.
> > > 
> > > In particular, the code in hunk @@ -6036,28 +6041,26 @@ needs
> > > careful review.  There are also assumptions in here that a memory
> > > allocation is never larger than a PMD, which is true today, but I've
> > > been asked about larger allocations.
> > 
> > Could you be more specific about those usecases? Are they really
> > interested in supporting larger pages for the memcg migration which is
> > v1 only feature? Or you are interested merely to have the code more
> > generic?
> 
> Ah!  I didn't realise memcg migration was a v1-only feature.  I think
> that makes all of the questions much less interesting.  I've done some
> more reading, and it seems like all of this is "best effort", so it
> doesn't really matter if some folios get skipped.

Yes.
[...]

> That makes sense.  I think the case that's currently mishandled is a
> THP in tmpfs which is misaligned when mapped to userspace.  It's
> skipped, even if the entire THP is mapped.  But maybe that simply
> doesn't matter.
> 
> I suppose the question is: Do we care if mappings of files are not
> migrated to the new memcg?  I'm getting a sense that the answer is "no",
> and if we actually ended up skipping all file mappings, it wouldn't
> matter.

Yes, I wouldn't lose sleep over that. You are not introducing a new
regression. The feature is mostly deprecated (along with the whole v1)
so we tend to prefer bug-to-bug compatibility rather than making the
code more complex to solve a theoretical problem (or at least a problem
that nobody is complaining about).

Thanks!
-- 
Michal Hocko
SUSE Labs
