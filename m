Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBCB78C86D
	for <lists+cgroups@lfdr.de>; Tue, 29 Aug 2023 17:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjH2PRp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Aug 2023 11:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbjH2PR3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Aug 2023 11:17:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E9F194;
        Tue, 29 Aug 2023 08:17:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AD4CE21863;
        Tue, 29 Aug 2023 15:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693322244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BOigw10DFMaZ6FlTz/kuzcWWW1zJctEYt2mbUACfshw=;
        b=cf6cfut5qMHHLRMDbwkQ2gYlsH8BstjRGecp7d4wrj6kl1juJGA88uZVLY/nIkvn4joG6o
        yc1WtUrbFGH37RngP2icfs7mhlOiLLHfvX3nXod/VcciRd/wn+9pFBlSTbq9Qw6JFxynhg
        vLQnqh8YI4Amh1yo0orGgcpcoRZ6h+E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9863913301;
        Tue, 29 Aug 2023 15:17:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0DXgJAQM7mSfHAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 29 Aug 2023 15:17:24 +0000
Date:   Tue, 29 Aug 2023 17:17:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
Message-ID: <ZO4MBNzsbhsi7adb@dhcp22.suse.cz>
References: <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz>
 <CAJD7tkYPyb+2zOKqctQw-vhuwYRg85e6v2Y44xWJofHZ+F+YQw@mail.gmail.com>
 <ZOzBgfzlGdrPD4gk@dhcp22.suse.cz>
 <CAJD7tkakMcaR_6NygEXCt6GF8TOuzYAUQe1im+vu2F3G4jtz=w@mail.gmail.com>
 <CALvZod7uxDd3Lrd3VwTTC-SDvqhdj2Ly-dYVswO=TBM=XTnkcg@mail.gmail.com>
 <CAJD7tkbnvMCNfQwY_dmVe2SWR5NeN+3RzFhsVyimM1ATaX0D5A@mail.gmail.com>
 <599b167c-deaf-4b92-aa8b-5767b8608483@redhat.com>
 <ZO2d7dT8gulMyb8g@dhcp22.suse.cz>
 <5906501e-4dff-4c66-7ab3-e9193d312270@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5906501e-4dff-4c66-7ab3-e9193d312270@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 29-08-23 11:05:28, Waiman Long wrote:
> On 8/29/23 03:27, Michal Hocko wrote:
> > On Mon 28-08-23 13:27:23, Waiman Long wrote:
> > > On 8/28/23 13:07, Yosry Ahmed wrote:
> > > > > Here I agree with you. Let's go with the approach which is easy to
> > > > > undo for now. Though I prefer the new explicit interface for flushing,
> > > > > that step would be very hard to undo. Let's reevaluate if the proposed
> > > > > approach shows negative impact on production traffic and I think
> > > > > Cloudflare folks can give us the results soon.
> > > > Do you prefer we also switch to using a mutex (with preemption
> > > > disabled) to avoid the scenario Michal described where flushers give
> > > > up the lock and sleep resulting in an unbounded wait time in the worst
> > > > case?
> > > Locking with mutex with preemption disabled is an oxymoron.
> > I believe Yosry wanted to disable preemption _after_ the lock is taken
> > to reduce the time spent while it is held. The idea to use the mutex is
> > to reduce spinning and more importantly to get rid of lock dropping
> > part. It is not really clear (but unlikely) we can drop it while
> > preserving the spinlock as the thing scales with O(#cgroups x #cpus)
> > in the worst case.
> 
> As I have said later in my email, I am not against disabling preemption
> selectively on some parts of the lock critical section where preemption is
> undesirable. However, I am against disabling preemption for the whole
> duration of the code where the mutex lock is held as it defeats the purpose
> of using mutex in the first place.

I certainly agree this is an antipattern.
-- 
Michal Hocko
SUSE Labs
