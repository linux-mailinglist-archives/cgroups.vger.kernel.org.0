Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC9C686641
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 13:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjBAMwN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 07:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjBAMwM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 07:52:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CB845F7D;
        Wed,  1 Feb 2023 04:52:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DB2F920E60;
        Wed,  1 Feb 2023 12:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675255923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahdHEkL6cjj6jcOVThTdJ4/WM1AMyhpAQrlh1KA5/0o=;
        b=q+fnl7ogJjUTPNIHkdGClmlCT9ItWknSniWMYQh0SGW3jPjXK78Ua+YG0+KvM573mOv6jK
        sCGunPe5GGmeSesvLWg0ova+4WsytcXXKTMnFtxjkHfAwH4I3ccP+1UgWnQFqEb/CbSlLf
        DW7KBcRoMlRSRdZTCehZxHeZ0dEXESI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBC8313A10;
        Wed,  1 Feb 2023 12:52:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T8AgK3Ng2mNQRgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 01 Feb 2023 12:52:03 +0000
Date:   Wed, 1 Feb 2023 13:52:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9pgcu0uNOHR6DtR@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9IvoDJbLbFcitTc@dhcp22.suse.cz>
 <Y9LDAZmApLeffrT8@tpad>
 <Y9LQ615H13RmG7wL@dhcp22.suse.cz>
 <0122005439ffb7895efda7a1a67992cbe41392fe.camel@redhat.com>
 <Y9j9BnMwfm4TJks7@tpad>
 <5ba79c4feb829ed75cfd98cf5c8042dcb2ddea91.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ba79c4feb829ed75cfd98cf5c8042dcb2ddea91.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 01-02-23 01:36:07, Leonardo Brás wrote:
[...]
> Michal, Roman: Could you please review my argumentation below, so I can
> understand what exactly is wrong ?
> 
> > > 
> > > IIUC, we can approach this by dividing the problem in two working modes:
> > > 1 - Normal, meaning no drain_all_stock() running.
> > > 2 - Draining, grouping together pre-OOM and userspace 'config' : changing,
> > > destroying, reconfiguring a memcg.
> > > 
> > > For (1), we will have (ideally) only local cpu working on the percpu struct.
> > > This mode will not have any kind of contention, because each CPU will hold it's
> > > own spinlock only. 

You are still hitting locked atomic operations which is not the case for
a simple pcp access. As already mentioned page counter (which would be
taken in case of no pcp cache) is also about atomics (elbeit more of
them with a deeper cgroup hierarchy).

> > > For (2), we will have a lot of drain_all_stock() running. This will mean a lot
> > > of schedule_work_on() running (on upstream) or possibly causing contention, i.e.
> > > local cpus having to wait for a lock to get their cache, on the patch proposal.

Yes.

> > > Ok, given the above is correct:
> > > 
> > > # Some arguments point that (1) becomes slower with this patch.
> > > 
> > > This is partially true: while test 2.2 pointed that local cpu functions running
> > > time had became slower by a few cycles, test 2.4 points that the userspace
> > > perception of it was that the syscalls and pagefaulting actually became faster:
> > > 
> > > During some debugging tests before getting the performance on test 2.4, I
> > > noticed that the 'syscall + write' test would call all those functions that
> > > became slower on test 2.2. Those functions were called multiple millions of
> > > times during a single test, and still the patched version performance test
> > > returned faster for test 2.4 than upstream version. Maybe the functions became
> > > slower, but overall the usage of them in the usual context became faster.

It is hard to tell anything without proper analysis of those numbers.

> > > Is not that a small improvement?
> > > 
> > > # Regarding (2), I notice that we fear contention 
> > > 
> > > While this seems to be the harder part of the discussion, I think we have enough
> > > data to deal with it. 
> > > 
> > > In which case contention would be a big problem here? 
> > > IIUC it would be when a lot of drain_all_stock() get running because the memory
> > > limit is getting near. I mean, having the user to create / modify a memcg
> > > multiple times a second for a while is not something that is expected, IMHO.

We have already explained when that happens. You are right this is not
happening all that much in most workloads. But this is a user triggered
operation so you cannot really many assumptions. It will really depend
on the workload.

> > Considering that the use of spinlocks with remote draining is the more general solution,
> > what would be a test-case to demonstrate a contention problem?
> 
> IIUC we could try to reproduce a memory tight workload that keeps allocating /
> freeing from different cpus (without hitting OOM).
> 
> Michal, Roman: Is that correct? You have any workload like that so we can test?

It would be easy to create artificial workload that would hit this. All
you need is to trigger any of the code paths that have already been
mentioned elsewhere from the userspace.

Let me be clear here. Unless there are some real concerns about not
flushing remotely on isolated cpus then the spin lock approach is just
much less preferable. So I would much rather focus on the trivial patch
and investigates whether there are no new corner cases to be created by
that.
-- 
Michal Hocko
SUSE Labs
