Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FA067B1A7
	for <lists+cgroups@lfdr.de>; Wed, 25 Jan 2023 12:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjAYLkM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Jan 2023 06:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbjAYLjo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Jan 2023 06:39:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10B0CA29;
        Wed, 25 Jan 2023 03:39:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 64AD61FEB4;
        Wed, 25 Jan 2023 11:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674646766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oqqka9Owzafd2X56BISD/lkkMSHTDdTB9S6csfU4aLY=;
        b=KYsnXNxxrnUiZeznqoi+EbhT2L0rtf5QYqic6aQTX5P5VQ1STxtKjbDnMPgtlg7/Y1p61L
        KvRwG/pY12Ow/MVHYy249SOWJfTwl35GWdrSy9yvyhUV3hBWnCJBOumPvpNF2+dJ1WFAWP
        qn7IAe/rCU0k7ivrlr77GeNUyPbpS2M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 432E61339E;
        Wed, 25 Jan 2023 11:39:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Uts0D+4U0WNkZAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 25 Jan 2023 11:39:26 +0000
Date:   Wed, 25 Jan 2023 12:39:25 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marcelo Tosatti <mtosatti@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9EU7awmpZaqbFtP@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 25-01-23 08:06:46, Leonardo Brás wrote:
> On Wed, 2023-01-25 at 09:33 +0100, Michal Hocko wrote:
> > On Wed 25-01-23 04:34:57, Leonardo Bras wrote:
> > > Disclaimer:
> > > a - The cover letter got bigger than expected, so I had to split it in
> > >     sections to better organize myself. I am not very confortable with it.
> > > b - Performance numbers below did not include patch 5/5 (Remove flags
> > >     from memcg_stock_pcp), which could further improve performance for
> > >     drain_all_stock(), but I could only notice the optimization at the
> > >     last minute.
> > > 
> > > 
> > > 0 - Motivation:
> > > On current codebase, when drain_all_stock() is ran, it will schedule a
> > > drain_local_stock() for each cpu that has a percpu stock associated with a
> > > descendant of a given root_memcg.
> > > 
> > > This happens even on 'isolated cpus', a feature commonly used on workloads that
> > > are sensitive to interruption and context switching such as vRAN and Industrial
> > > Control Systems.
> > > 
> > > Since this scheduling behavior is a problem to those workloads, the proposal is
> > > to replace the current local_lock + schedule_work_on() solution with a per-cpu
> > > spinlock.
> > 
> > If IIRC we have also discussed that isolated CPUs can simply opt out
> > from the pcp caching and therefore the problem would be avoided
> > altogether without changes to the locking scheme. I do not see anything
> > regarding that in this submission. Could you elaborate why you have
> > abandoned this option?
> 
> Hello Michal,
> 
> I understand pcp caching is a nice to have.
> So while I kept the idea of disabling pcp caching in mind as an option, I first
> tried to understand what kind of impacts we would be seeing when trying to
> change the locking scheme.
> 
> After I raised the data in the cover letter, I found that the performance impact
> appears not be that big. So in order to try keeping the pcp cache on isolated
> cpus active, I decided to focus effort on the locking scheme change.
> 
> I mean, my rationale is: if is there a non-expensive way of keeping the feature,
> why should we abandon it?

Because any locking to pcp adds a potential contention. You haven't been
able to trigger that contention by your testing but that doesn't really
mean it is non-existent.

Besided that opt-out for isolated cpus should be a much smaller change
with a much more predictable behavior. The overall performance for
charging on isolated cpus will be slightly worse but it hasn't been seen
this is anything really noticeable. Most workloads which do care about
isolcpus tend to not enter kernel much AFAIK so this should have
relatively small impact.

All that being said I would prefer a simpler solution which seems to be
to simply opt out from pcp caching and if the performance for real
world workloads shows regressions then we can start thinking about a
more complex solution.
-- 
Michal Hocko
SUSE Labs
