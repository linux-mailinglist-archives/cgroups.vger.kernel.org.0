Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC585788E73
	for <lists+cgroups@lfdr.de>; Fri, 25 Aug 2023 20:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjHYSRx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Aug 2023 14:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjHYSRq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Aug 2023 14:17:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C1A2D4C;
        Fri, 25 Aug 2023 11:17:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4B7ED2211E;
        Fri, 25 Aug 2023 18:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692987446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ujuMMocBltnOMhznVm766I5QPcNC5qT9zu3nsGMBN7k=;
        b=M4FFeikAxZfvdQpVl5oyAbEUXrkd22eQQW0u3Q3anuDTciGLnuliGADRpNoIGawDN1ZmMY
        6fAymp2LCV4dgFGDtXNjsddXL0o3f+R+xKxtTKxVi40aMLSo8p7XCC5kHcMte/K+8dKowN
        dLGqToSCjHoMOQ+TElfmbfSRoxpUA+E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27E68138F9;
        Fri, 25 Aug 2023 18:17:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vPnBBjbw6GRQfAAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 25 Aug 2023 18:17:26 +0000
Date:   Fri, 25 Aug 2023 20:17:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
Message-ID: <ZOjwNR2wv5mOdWv0@dhcp22.suse.cz>
References: <20230821205458.1764662-4-yosryahmed@google.com>
 <ZOR6eyYfJYlxdMet@dhcp22.suse.cz>
 <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
 <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz>
 <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
 <ZOcDLD/1WaOwWis9@dhcp22.suse.cz>
 <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz>
 <CAJD7tkYPyb+2zOKqctQw-vhuwYRg85e6v2Y44xWJofHZ+F+YQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYPyb+2zOKqctQw-vhuwYRg85e6v2Y44xWJofHZ+F+YQw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 25-08-23 08:14:54, Yosry Ahmed wrote:
> On Fri, Aug 25, 2023 at 12:05 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > I might be wrong but the whole discussion so far suggests that the
> > global rstat lock should be reconsidered. From my personal experience
> > global locks easily triggerable from the userspace are just a receip for
> > problems. Stats reading shouldn't be interfering with the system runtime
> > as much as possible and they should be deterministic wrt runtime as
> > well.
> 
> The problem is that the global lock also serializes the global
> counters that we flush to. I will talk from the memcg flushing
> perspective as that's what I am familiar with. I am not sure how much
> this is transferable to other flushers.
> 
> On the memcg side (see mem_cgroup_css_rstat_flush()), the global lock
> synchronizes access to multiple counters, for this discussion what's
> most important are:
> - The global stat counters of the memcg being flushed (e.g.
> memcg->vmstats->state).
> - The pending stat counters of the parent being flushed (e.g.
> parent->vmstats->state_pending).

I haven't digested the rest of the email yet (Friday brain, sorry) but I
do not think you are adressing this particular part so let me ask before
I dive more into the following. I really do not follow the serialization
requirement here because the lock doesn't really serialize the flushing,
does it? At least not in a sense of a single caller to do the flushing
atomicaly from other flushers. It is possible that the current flusher
simply drops the lock midway and another one retakes the lock and
performs the operation again. So what additional flushing
synchronization does it provide and why cannot parallel flushers simply
compete over pcp spinlocks?

So what am I missing?
-- 
Michal Hocko
SUSE Labs
