Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6993378BF34
	for <lists+cgroups@lfdr.de>; Tue, 29 Aug 2023 09:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjH2H14 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Aug 2023 03:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjH2H1p (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Aug 2023 03:27:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D44B5;
        Tue, 29 Aug 2023 00:27:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8B9F62184F;
        Tue, 29 Aug 2023 07:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693294061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQVt7ZAS3h7P9TWs6MRywImntPzLi7vWjCeWqczW/dg=;
        b=vRtPLaqq11XecAmTHq2dlcBEu/g6yqdBioRszoAaLNULFSMb19oU7qqGZT+5RLT0dTCl/s
        lSFUCG69b9+dF7PAvMR/seI8n+VXJUKB8Ske1TiNs6BC6TJryS8nzrbdYPEonTxhj3cNZ0
        ragBTYGG3uSYLX6fMD7g+XhiJe7VIdI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CF96138E2;
        Tue, 29 Aug 2023 07:27:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D1wLHu2d7WQRHAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 29 Aug 2023 07:27:41 +0000
Date:   Tue, 29 Aug 2023 09:27:41 +0200
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
Message-ID: <ZO2d7dT8gulMyb8g@dhcp22.suse.cz>
References: <ZOcDLD/1WaOwWis9@dhcp22.suse.cz>
 <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz>
 <CAJD7tkYPyb+2zOKqctQw-vhuwYRg85e6v2Y44xWJofHZ+F+YQw@mail.gmail.com>
 <ZOzBgfzlGdrPD4gk@dhcp22.suse.cz>
 <CAJD7tkakMcaR_6NygEXCt6GF8TOuzYAUQe1im+vu2F3G4jtz=w@mail.gmail.com>
 <CALvZod7uxDd3Lrd3VwTTC-SDvqhdj2Ly-dYVswO=TBM=XTnkcg@mail.gmail.com>
 <CAJD7tkbnvMCNfQwY_dmVe2SWR5NeN+3RzFhsVyimM1ATaX0D5A@mail.gmail.com>
 <599b167c-deaf-4b92-aa8b-5767b8608483@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <599b167c-deaf-4b92-aa8b-5767b8608483@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 28-08-23 13:27:23, Waiman Long wrote:
> 
> On 8/28/23 13:07, Yosry Ahmed wrote:
> > 
> > > Here I agree with you. Let's go with the approach which is easy to
> > > undo for now. Though I prefer the new explicit interface for flushing,
> > > that step would be very hard to undo. Let's reevaluate if the proposed
> > > approach shows negative impact on production traffic and I think
> > > Cloudflare folks can give us the results soon.
> > Do you prefer we also switch to using a mutex (with preemption
> > disabled) to avoid the scenario Michal described where flushers give
> > up the lock and sleep resulting in an unbounded wait time in the worst
> > case?
> 
> Locking with mutex with preemption disabled is an oxymoron.

I believe Yosry wanted to disable preemption _after_ the lock is taken
to reduce the time spent while it is held. The idea to use the mutex is
to reduce spinning and more importantly to get rid of lock dropping
part. It is not really clear (but unlikely) we can drop it while
preserving the spinlock as the thing scales with O(#cgroups x #cpus)
in the worst case.

-- 
Michal Hocko
SUSE Labs
