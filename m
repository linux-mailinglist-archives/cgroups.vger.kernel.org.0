Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8724867E01D
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 10:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjA0J3f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 04:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjA0J3e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 04:29:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A248A79;
        Fri, 27 Jan 2023 01:29:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EF59121D67;
        Fri, 27 Jan 2023 09:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674811771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bEY5UCtEKCeTLdzAmSIUQZvUYZL+4hOTPkRByerNhaI=;
        b=d3UxIkYcjOecRmojVKRzC++3+Ldu/RdeTs9vhHpP3QlZwel4R8UkrVo/RGAv81LU0tBUB2
        abmN2m9OZnLCKqCTBqauh3umAFlA2jpYLBTXUIqyef0R7XUhLn8B3mkHnh8WlIPW9b/jSx
        MMfeL0YJkgibZC+S3aOyPha7Srcc/kI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEB46138E3;
        Fri, 27 Jan 2023 09:29:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +EwtMHuZ02OxHAAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 27 Jan 2023 09:29:31 +0000
Date:   Fri, 27 Jan 2023 10:29:31 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9OZezjUPITtEvTx@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
 <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
 <Y9MI42NSLooyVZNu@P9FQF9L96D.corp.robot.car>
 <55ac6e3cbb97c7d13c49c3125c1455d8a2c785c3.camel@redhat.com>
 <Y9N7UMrLTyZT71uA@dhcp22.suse.cz>
 <15c605f27f87d732e80e294f13fd9513697b65e3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15c605f27f87d732e80e294f13fd9513697b65e3.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 27-01-23 04:35:22, Leonardo Brás wrote:
> On Fri, 2023-01-27 at 08:20 +0100, Michal Hocko wrote:
> > On Fri 27-01-23 04:14:19, Leonardo Brás wrote:
> > > On Thu, 2023-01-26 at 15:12 -0800, Roman Gushchin wrote:
> > [...]
> > > > I'd rather opt out of stock draining for isolated cpus: it might slightly reduce
> > > > the accuracy of memory limits and slightly increase the memory footprint (all
> > > > those dying memcgs...), but the impact will be limited. Actually it is limited
> > > > by the number of cpus.
> > > 
> > > I was discussing this same idea with Marcelo yesterday morning.
> > > 
> > > The questions had in the topic were:
> > > a - About how many pages the pcp cache will hold before draining them itself? 
> > 
> > MEMCG_CHARGE_BATCH (64 currently). And one more clarification. The cache
> > doesn't really hold any pages. It is a mere counter of how many charges
> > have been accounted for the memcg page counter. So it is not really
> > consuming proportional amount of resources. It just pins the
> > corresponding memcg. Have a look at consume_stock and refill_stock
> 
> I see. Thanks for pointing that out!
> 
> So in worst case scenario the memcg would have reserved 64 pages * (numcpus - 1)

s@numcpus@num_isolated_cpus@

> that are not getting used, and may cause an 'earlier' OOM if this amount is
> needed but can't be freed.

s@OOM@memcg OOM@
 
> In the wave of worst case, supposing a big powerpc machine, 256 CPUs, each
> holding 64k * 64 pages => 1GB memory - 4MB (one cpu using resources).
> It's starting to get too big, but still ok for a machine this size.

It is more about the memcg limit rather than the size of the machine.
Again, let's focus on actual usacase. What is the usual memcg setup with
those isolcpus

> The thing is that it can present an odd behavior: 
> You have a cgroup created before, now empty, and try to run given application,
> and hits OOM.

The application would either consume those cached charges or flush them
if it is running in a different memcg. Or what do you have in mind?

> You then restart the cgroup, run the same application without an issue.
> 
> Even though it looks a good possibility, this can be perceived by user as
> instability.
> 
> > 
> > > b - Would it cache any kind of bigger page, or huge page in this same aspect?
> > 
> > The above should answer this as well as those following up I hope. If
> > not let me know.
> 
> IIUC we are talking normal pages, is that it?

We are talking about memcg charges and those have page granularity.

-- 
Michal Hocko
SUSE Labs
