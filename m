Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F7C7B6547
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 11:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjJCJRx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 05:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjJCJRv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 05:17:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A27AF;
        Tue,  3 Oct 2023 02:17:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 050512189A;
        Tue,  3 Oct 2023 09:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696324666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHMY/QK7iViujm+75eY0KL1YTgmg3x9ujdg7FPt3TI8=;
        b=OZcPJ8KLJgaqqBIZ9hziftqLWT/5Y6IhTybSpPiZOUyssGqjfwWFz54YyMW7FaL+dKBlJv
        VBm4OntUrg4/OGf1j101r6hnTUdboh4qHxao0EolR+hTJQM37P+atlbiurMHIfmTYOi+DN
        AN8l1z9bhEjLJ0sceYNh7Mow9zBzoVA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8FCF139F9;
        Tue,  3 Oct 2023 09:17:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZdZFODncG2U5SAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 03 Oct 2023 09:17:45 +0000
Date:   Tue, 3 Oct 2023 11:17:45 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        riel@surriel.com, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
Message-ID: <ZRvcOV0+wkYRuGEh@dhcp22.suse.cz>
References: <20230928005723.1709119-1-nphamcs@gmail.com>
 <20230928005723.1709119-2-nphamcs@gmail.com>
 <ZRrI90KcRBwVZn/r@dhcp22.suse.cz>
 <20231002145026.GB4414@cmpxchg.org>
 <ZRrc8hv4t740MZar@dhcp22.suse.cz>
 <20231002152555.GA5054@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002152555.GA5054@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 02-10-23 11:25:55, Johannes Weiner wrote:
> On Mon, Oct 02, 2023 at 05:08:34PM +0200, Michal Hocko wrote:
> > On Mon 02-10-23 10:50:26, Johannes Weiner wrote:
> > > On Mon, Oct 02, 2023 at 03:43:19PM +0200, Michal Hocko wrote:
> > > > On Wed 27-09-23 17:57:22, Nhat Pham wrote:
> > [...]
> > > > - memcg limit reclaim doesn't assist hugetlb pages allocation when
> > > >   hugetlb overcommit is configured (i.e. pages are not consumed from the
> > > >   pool) which means that the page allocation might disrupt workloads
> > > >   from other memcgs.
> > > > - failure to charge a hugetlb page results in SIGBUS rather
> > > >   than memcg oom killer. That could be the case even if the
> > > >   hugetlb pool still has pages available and there is
> > > >   reclaimable memory in the memcg.
> > > 
> > > Are these actually true? AFAICS, regardless of whether the page comes
> > > from the pool or the buddy allocator, the memcg code will go through
> > > the regular charge path, attempt reclaim, and OOM if that fails.
> > 
> > OK, I should have been more explicit. Let me expand. Charges are
> > accounted only _after_ the actual allocation is done. So the actual
> > allocation is not constrained by the memcg context. It might reclaim
> > from the memcg at that time but the disruption could have already
> > happened. Not really any different from regular memory allocation
> > attempt but much more visible with GB pages and one could reasonably
> > expect that memcg should stop such a GB allocation if the local reclaim
> > would be hopeless to free up enough from its own consumption.
> > 
> > Makes more sense?
> 
> Yes, that makes sense.
> 
> This should be fairly easy to address by having hugetlb do the split
> transaction that charge_memcg() does in one go, similar to what we do
> for the hugetlb controller as well. IOW,
> 
> alloc_hugetlb_folio()
> {
> 	if (mem_cgroup_hugetlb_try_charge())
> 		return ERR_PTR(-ENOMEM);
> 
> 	folio = dequeue();
> 	if (!folio) {
> 		folio = alloc_buddy();
> 		if (!folio)
> 			goto uncharge;
> 	}
> 
> 	mem_cgroup_hugetlb_commit_charge();
> }

yes, this makes sense. I still suspect we will need a better charge
reclaim tuning for GB pages as those are just too huge and a simple
MAX_RECLAIM_RETRIES * GB worth of reclaim targets might be just overly
aggressive.

-- 
Michal Hocko
SUSE Labs
