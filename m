Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E64E788EE3
	for <lists+cgroups@lfdr.de>; Fri, 25 Aug 2023 20:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjHYSos (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Aug 2023 14:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjHYSoj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Aug 2023 14:44:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2EBCD2;
        Fri, 25 Aug 2023 11:44:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AEC8E2212A;
        Fri, 25 Aug 2023 18:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692989075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1xfjXtaNhAs9Izi3V9PNqgVBs7ebPlEYdTa0N1qxD5A=;
        b=TbmrwaVBm/U0VHuwzCOgDkcqjniSNFpKEEWwmXZrYN7A1bQ6fYTMCItlOCo2TyeRl5M05C
        V4xRAdw449tIc2Gvk+yGlQMlUqZeHRoKFhnTBd2sr4OHz94bIpF6j9SeAFdrK/omaWJnB3
        iLuCISHtWZvuk3bOJDuRo6pGC8KaBoU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E8E6138F9;
        Fri, 25 Aug 2023 18:44:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gSzGH5P26GSXBwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 25 Aug 2023 18:44:35 +0000
Date:   Fri, 25 Aug 2023 20:44:34 +0200
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
Message-ID: <ZOj2kiMVhf6LUEyg@dhcp22.suse.cz>
References: <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz>
 <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
 <ZOcDLD/1WaOwWis9@dhcp22.suse.cz>
 <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz>
 <CAJD7tkYPyb+2zOKqctQw-vhuwYRg85e6v2Y44xWJofHZ+F+YQw@mail.gmail.com>
 <ZOjwNR2wv5mOdWv0@dhcp22.suse.cz>
 <CAJD7tka=60_vPMY9Tg8tH+55g-feV1B24VNmDpp_3iMHqrUh7Q@mail.gmail.com>
 <ZOj2NeU5yYhrTZPJ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOj2NeU5yYhrTZPJ@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 25-08-23 20:43:02, Michal Hocko wrote:
> On Fri 25-08-23 11:21:16, Yosry Ahmed wrote:
> > On Fri, Aug 25, 2023 at 11:17 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 25-08-23 08:14:54, Yosry Ahmed wrote:
> > > > On Fri, Aug 25, 2023 at 12:05 AM Michal Hocko <mhocko@suse.com> wrote:
> > > [...]
> > > > > I might be wrong but the whole discussion so far suggests that the
> > > > > global rstat lock should be reconsidered. From my personal experience
> > > > > global locks easily triggerable from the userspace are just a receip for
> > > > > problems. Stats reading shouldn't be interfering with the system runtime
> > > > > as much as possible and they should be deterministic wrt runtime as
> > > > > well.
> > > >
> > > > The problem is that the global lock also serializes the global
> > > > counters that we flush to. I will talk from the memcg flushing
> > > > perspective as that's what I am familiar with. I am not sure how much
> > > > this is transferable to other flushers.
> > > >
> > > > On the memcg side (see mem_cgroup_css_rstat_flush()), the global lock
> > > > synchronizes access to multiple counters, for this discussion what's
> > > > most important are:
> > > > - The global stat counters of the memcg being flushed (e.g.
> > > > memcg->vmstats->state).
> > > > - The pending stat counters of the parent being flushed (e.g.
> > > > parent->vmstats->state_pending).
> > >
> > > I haven't digested the rest of the email yet (Friday brain, sorry) but I
> > > do not think you are adressing this particular part so let me ask before
> > > I dive more into the following. I really do not follow the serialization
> > > requirement here because the lock doesn't really serialize the flushing,
> > > does it? At least not in a sense of a single caller to do the flushing
> > > atomicaly from other flushers. It is possible that the current flusher
> > > simply drops the lock midway and another one retakes the lock and
> > > performs the operation again. So what additional flushing
> > > synchronization does it provide and why cannot parallel flushers simply
> > > compete over pcp spinlocks?
> > >
> > > So what am I missing?
> > 
> > Those counters are non-atomic. The lock makes sure we don't have two
> > concurrent flushers updating the same counter locklessly and
> > non-atomically, which would be possible if we flush the same cgroup on
> > two different cpus in parallel.
> 
> pcp lock (cpu_lock) guarantees the very same, doesn't it?

Nope, it doesn't. I really need to have a deeper look.

-- 
Michal Hocko
SUSE Labs
