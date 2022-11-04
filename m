Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923F06192E0
	for <lists+cgroups@lfdr.de>; Fri,  4 Nov 2022 09:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiKDIlV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Nov 2022 04:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKDIlV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Nov 2022 04:41:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EBE275F4;
        Fri,  4 Nov 2022 01:41:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 821FC1F88F;
        Fri,  4 Nov 2022 08:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667551278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4eYXI+v91C6UMV4JDFYPXhsb0OglU6TPm28ARvvnQc0=;
        b=ignxq6jJhyE/tP3iqNKVyIiU2gyTbpXAnLQ+1lHoEkIuWks2akbLfofAqjF2DaKV8sA1Kx
        FYeeJibPxdNJ1SNhKyCHXBpg/Xc3DoyVSssg1TULNGwebyqN90bDOIaITJRFBBxGDGkhXs
        f/8b3x8DoQCzaDnzbi9VGaVO1Uz+WIo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B12513216;
        Fri,  4 Nov 2022 08:41:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K3vmEy7QZGM6ZgAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 04 Nov 2022 08:41:18 +0000
Date:   Fri, 4 Nov 2022 09:41:17 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 0/3] Avoid scheduling cache draining to isolated cpus
Message-ID: <Y2TQLavnLVd4qHMT@dhcp22.suse.cz>
References: <20221102020243.522358-1-leobras@redhat.com>
 <Y2IwHVdgAJ6wfOVH@dhcp22.suse.cz>
 <07810c49ef326b26c971008fb03adf9dc533a178.camel@redhat.com>
 <Y2Pe45LHANFxxD7B@dhcp22.suse.cz>
 <0183b60e79cda3a0f992d14b4db5a818cd096e33.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0183b60e79cda3a0f992d14b4db5a818cd096e33.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 03-11-22 13:53:41, Leonardo Brás wrote:
> On Thu, 2022-11-03 at 16:31 +0100, Michal Hocko wrote:
> > On Thu 03-11-22 11:59:20, Leonardo Brás wrote:
[...]
> > > I understand there will be a locking cost being paid in the isolated CPUs when:
> > > a) The isolated CPU is requesting the stock drain,
> > > b) When the isolated CPUs do a syscall and end up using the protected structure
> > > the first time after a remote drain.
> > 
> > And anytime the charging path (consume_stock resp. refill_stock)
> > contends with the remote draining which is out of control of the RT
> > task. It is true that the RT kernel will turn that spin lock into a
> > sleeping RT lock and that could help with potential priority inversions
> > but still quite costly thing I would expect.
> > 
> > > Both (a) and (b) should happen during a syscall, and IIUC the a rt workload
> > > should not expect the syscalls to be have a predictable time, so it should be
> > > fine.
> > 
> > Now I am not sure I understand. If you do not consider charging path to
> > be RT sensitive then why is this needed in the first place? What else
> > would be populating the pcp cache on the isolated cpu? IRQs?
> 
> I am mostly trying to deal with drain_all_stock() calling schedule_work_on() at
> isolated_cpus. Since the scheduled drain_local_stock() will be competing for cpu
> time with the RT workload, we can have preemption of the RT workload, which is a
> problem for meeting the deadlines.

Yes, this is understood. But it is not really clear to me why would any
draining be necessary for such an isolated CPU if no workload other than
the RT (which pressumably doesn't charge any memory?) is running on that
CPU? Is that the RT task during the initialization phase that leaves
that cache behind or something else? Sorry for being so focused on this
but I would like to understand on whether this is avoidable by a
different startup scheme or it really needs to be addressed in some way.

> One way I thought to solve that was introducing a remote drain, which would
> require a different strategy for locking, since not all accesses to the pcp
> caches would happen on a local CPU. 

Yeah, I am not supper happy about additional spin lock TBH. One
potential way to go would be to completely avoid pcp cache for isolated
CPUs. That would have some performance impact of course but on the other
hand it would give a more predictable behavior for those CPUs which
sounds like a reasonable compromise to me. What do you think?
-- 
Michal Hocko
SUSE Labs
