Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401797B55DD
	for <lists+cgroups@lfdr.de>; Mon,  2 Oct 2023 17:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbjJBO62 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 10:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbjJBO61 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 10:58:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B47AB7;
        Mon,  2 Oct 2023 07:58:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 29E241F37C;
        Mon,  2 Oct 2023 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696258702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pbbS97LKBoLnUphLCc+wCqBwCujHRrwtZZFMWJk2Q3s=;
        b=DByYXLBNO625TR7THAZ3A1ENKm5AGNc/51X+rknPe7tUQbICiLFq2Gx+rkuXHA0uBlX70U
        p843Tbr0ThKfR1kaIddlxX5+BEWuhI66XM3QdvqPFHJK/axMxE2WdB/lMYs44GDCZObPHj
        Lj0jHnh/xEb4UWv6qlmyXZdSch+iDDo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B09D13434;
        Mon,  2 Oct 2023 14:58:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IXxEO43aGmWpdAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 02 Oct 2023 14:58:21 +0000
Date:   Mon, 2 Oct 2023 16:58:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        riel@surriel.com, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, yosryahmed@google.com, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 0/2] hugetlb memcg accounting
Message-ID: <ZRrajQSHrwNLnXSe@dhcp22.suse.cz>
References: <20230926194949.2637078-1-nphamcs@gmail.com>
 <ZRQQMABiVIcXXcrg@dhcp22.suse.cz>
 <20230927184738.GC365513@cmpxchg.org>
 <20231001232730.GA11194@monkey>
 <20231002144250.GA4414@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002144250.GA4414@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 02-10-23 10:42:50, Johannes Weiner wrote:
> On Sun, Oct 01, 2023 at 04:27:30PM -0700, Mike Kravetz wrote:
> > On 09/27/23 14:47, Johannes Weiner wrote:
> > > On Wed, Sep 27, 2023 at 01:21:20PM +0200, Michal Hocko wrote:
> > > > On Tue 26-09-23 12:49:47, Nhat Pham wrote:
> > > 
> > > So that if you use 80% hugetlb, the other memory is forced to stay in
> > > the remaining 20%, or it OOMs; and that if you don't use hugetlb, the
> > > group is still allowed to use the full 100% of its host memory
> > > allowance, without requiring some outside agent continuously
> > > monitoring and adjusting the container limits.
> > 
> > Jumping in late here as I was traveling last week.  In addition, I want
> > to state my limited cgroup knowledge up front.
> > 
> > I was thinking of your scenario above a little differently.  Suppose a
> > group is up and running at almost 100% memory usage.  However, the majority
> > of that memory is reclaimable.  Now, someone wants to allocate a 2M hugetlb
> > page.  There is not 2MB free, but we could easily reclaim 2MB to make room
> > for the hugetlb page.  I may be missing something, but I do not see how that
> > is going to happen.  It seems like we would really want that behavior.
> 
> But that is actually what it does, no?
> 
> alloc_hugetlb_folio
>   mem_cgroup_hugetlb_charge_folio
>     charge_memcg
>       try_charge
>         !page_counter_try_charge ?
>           !try_to_free_mem_cgroup_pages ?
>             mem_cgroup_oom
> 
> So it does reclaim when the hugetlb hits the cgroup limit. And if that
> fails to make room, it OOMs the cgroup.
> 
> Or maybe I'm missing something?

I beleve that Mike alludes to what I have pointed in other email:
http://lkml.kernel.org/r/ZRrI90KcRBwVZn/r@dhcp22.suse.cz and a situation
when the hugetlb requests results in an acutal hugetlb allocation rather
than consumption from the pre-allocated pool. In that case memcg is not
involved because the charge happens only after the allocation happens.
That btw. means that this request could disrupt a different memcg even
if the current one is at the limit or it could be reclaimed instead.

Also there is not OOM as hugetlb pages are costly requests and we do not
invoke the oom killer.

-- 
Michal Hocko
SUSE Labs
