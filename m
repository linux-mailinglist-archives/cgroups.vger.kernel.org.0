Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B32B775FFF
	for <lists+cgroups@lfdr.de>; Wed,  9 Aug 2023 14:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjHIM6q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Aug 2023 08:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjHIM6p (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Aug 2023 08:58:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F041FF5;
        Wed,  9 Aug 2023 05:58:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 45D351F38C;
        Wed,  9 Aug 2023 12:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691585922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QVWr8XXVikYCh9tW7i2JMcKFQHyA2Ul51zZ7VG7gDMk=;
        b=qQ/BYlEykYjWP3ve2rOyS1R2CVAD0zcH+XiaHYHXrTSyZBaOWu5MEx9YCNGQLo34CDGhiq
        TlsnFjOvhVaRV6Y75dFlwrNBeMiX9QtdlVT24EHYvyYM2ig/6Y8uxc/G9h4IscJRDSrIhb
        kQn1NeGt9IJHsLituqZTT0ZUKdtS8Fs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D65B13251;
        Wed,  9 Aug 2023 12:58:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QxM9BIKN02QCfwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 09 Aug 2023 12:58:42 +0000
Date:   Wed, 9 Aug 2023 14:58:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
Message-ID: <ZNONgeoytpkchHga@dhcp22.suse.cz>
References: <20230809045810.1659356-1-yosryahmed@google.com>
 <ZNNTgZVPZipTL/UM@dhcp22.suse.cz>
 <CAJD7tkYhxbd2e+4HMZVKUfD4cx6oDauna3vLmttNPLCmFNtpgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYhxbd2e+4HMZVKUfD4cx6oDauna3vLmttNPLCmFNtpgA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 09-08-23 05:31:04, Yosry Ahmed wrote:
> On Wed, Aug 9, 2023 at 1:51 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 09-08-23 04:58:10, Yosry Ahmed wrote:
> > > Over time, the memcg code added multiple optimizations to the stats
> > > flushing path that introduce a tradeoff between accuracy and
> > > performance. In some contexts (e.g. dirty throttling, refaults, etc), a
> > > full rstat flush of the stats in the tree can be too expensive. Such
> > > optimizations include [1]:
> > > (a) Introducing a periodic background flusher to keep the size of the
> > > update tree from growing unbounded.
> > > (b) Allowing only one thread to flush at a time, and other concurrent
> > > flushers just skip the flush. This avoids a thundering herd problem
> > > when multiple reclaim/refault threads attempt to flush the stats at
> > > once.
> > > (c) Only executing a flush if the magnitude of the stats updates exceeds
> > > a certain threshold.
> > >
> > > These optimizations were necessary to make flushing feasible in
> > > performance-critical paths, and they come at the cost of some accuracy
> > > that we choose to live without. On the other hand, for flushes invoked
> > > when userspace is reading the stats, the tradeoff is less appealing
> > > This code path is not performance-critical, and the inaccuracies can
> > > affect userspace behavior. For example, skipping flushing when there is
> > > another ongoing flush is essentially a coin flip. We don't know if the
> > > ongoing flush is done with the subtree of interest or not.
> >
> > I am not convinced by this much TBH. What kind of precision do you
> > really need and how much off is what we provide?
> >
> > More expensive read of stats from userspace is quite easy to notice
> > and usually reported as a regression. So you should have a convincing
> > argument that an extra time spent is really worth it. AFAIK there are
> > many monitoring (top like) tools which simply read those files regularly
> > just to show numbers and they certainly do not need a high level of
> > precision.
> 
> We used to spend this time before commit fd25a9e0e23b ("memcg: unify
> memcg stat flushing") which generalized the "skip if ongoing flush"
> for all stat flushing. As far I know, the problem was contention on
> the flushing lock which also affected critical paths like refault.
> 
> The problem is that the current behavior is indeterministic, if cpu A
> tries to flush stats and cpu B is already doing that, cpu A will just
> skip. At that point, the cgroup(s) that cpu A cares about may have
> been fully flushed, partially flushed (in terms of cpus), or not
> flushed at all. We have no idea. We just know that someone else is
> flushing something. IOW, in some cases the flush request will be
> completely ignored and userspace will read stale stats (up to 2s + the
> periodic flusher runtime).

Yes, that is certainly true but why does that matter? Stats are always a
snapshot of the past. Do we get an inconsistent image that would be
actively harmful.

> Some workloads need to read up-to-date stats as feedback to actions
> (e.g. after proactive reclaim, or for userspace OOM killing purposes),
> and reading such stale stats causes regressions or misbehavior by
> userspace.

Please tell us more about those and why should all others that do not
require such a precision should page that price as well.

> > [...]
> > > @@ -639,17 +639,24 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
> > >       }
> > >  }
> > >
> > > -static void do_flush_stats(void)
> > > +static void do_flush_stats(bool full)
> > >  {
> > > +     if (!atomic_read(&stats_flush_ongoing) &&
> > > +         !atomic_xchg(&stats_flush_ongoing, 1))
> > > +             goto flush;
> > > +
> > >       /*
> > > -      * We always flush the entire tree, so concurrent flushers can just
> > > -      * skip. This avoids a thundering herd problem on the rstat global lock
> > > -      * from memcg flushers (e.g. reclaim, refault, etc).
> > > +      * We always flush the entire tree, so concurrent flushers can choose to
> > > +      * skip if accuracy is not critical. Otherwise, wait for the ongoing
> > > +      * flush to complete. This avoids a thundering herd problem on the rstat
> > > +      * global lock from memcg flushers (e.g. reclaim, refault, etc).
> > >        */
> > > -     if (atomic_read(&stats_flush_ongoing) ||
> > > -         atomic_xchg(&stats_flush_ongoing, 1))
> > > -             return;
> > > -
> > > +     while (full && atomic_read(&stats_flush_ongoing) == 1) {
> > > +             if (!cond_resched())
> > > +                     cpu_relax();
> >
> > You are reinveting a mutex with spinning waiter. Why don't you simply
> > make stats_flush_ongoing a real mutex and make use try_lock for !full
> > flush and normal lock otherwise?
> 
> So that was actually a spinlock at one point, when we used to skip if
> try_lock failed.

AFAICS cgroup_rstat_flush is allowed to sleep so spinlocks are not
really possible.

> We opted for an atomic because the lock was only used
> in a try_lock fashion. The problem here is that the atomic is used to
> ensure that only one thread actually attempts to flush at a time (and
> others skip/wait), to avoid a thundering herd problem on
> cgroup_rstat_lock.
> 
> Here, what I am trying to do is essentially equivalent to "wait until
> the lock is available but don't grab it". If we make
> stats_flush_ongoing a mutex, I am afraid the thundering herd problem
> will be reintroduced for stats_flush_ongoing this time.

You will have potentially many spinners for something that might take
quite a lot of time (sleep) if there is nothing else to schedule. I do
not think this is a proper behavior. Really, you shouldn't be busy
waiting for a sleeper.

> I am not sure if there's a cleaner way of doing this, but I am
> certainly open for suggestions. I also don't like how the spinning
> loop looks as of now.

mutex_try_lock for non-critical flushers and mutex_lock of syncing ones.
We can talk a custom locking scheme if that proves insufficient or
problematic.
-- 
Michal Hocko
SUSE Labs
