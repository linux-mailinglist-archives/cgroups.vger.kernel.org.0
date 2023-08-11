Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43AA7797B3
	for <lists+cgroups@lfdr.de>; Fri, 11 Aug 2023 21:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbjHKTZR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Aug 2023 15:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjHKTZR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Aug 2023 15:25:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9995830EC;
        Fri, 11 Aug 2023 12:25:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 48B1F21882;
        Fri, 11 Aug 2023 19:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691781914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DYSaZij9cfUdCBuqrUqc1+Y+PRd4NdInFoGnuQLmux0=;
        b=A3BM/lsPngVZ7roG/Ji60vaGuiVh3cz6LkqPbAvpJv6iLFnlpcBq7NZS7wX8QmGVngxd3V
        bcvX+whg3krxrXoM/YVfwMRRnrbvVXypsKIwvR13zplA0JYw6oTqp4D7MY/iTe6hqDDLg8
        tlKexZ/4jjZHwscPP/5i7n7DjyAJbEo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 242EC138E2;
        Fri, 11 Aug 2023 19:25:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KWHpBRqL1mSYBwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 11 Aug 2023 19:25:14 +0000
Date:   Fri, 11 Aug 2023 21:25:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
Message-ID: <ZNaLGVUtPu7Ua/jL@dhcp22.suse.cz>
References: <20230809045810.1659356-1-yosryahmed@google.com>
 <ZNNTgZVPZipTL/UM@dhcp22.suse.cz>
 <CAJD7tkYhxbd2e+4HMZVKUfD4cx6oDauna3vLmttNPLCmFNtpgA@mail.gmail.com>
 <ZNONgeoytpkchHga@dhcp22.suse.cz>
 <CAJD7tkb9C77UUxAykw_uMQvkzGyaZOZhM0nwWn_kcPjV0umyuA@mail.gmail.com>
 <ZNOVS0Smp2PHUIuq@dhcp22.suse.cz>
 <CAJD7tkZFxbjas=VfhYSGU84Y5vyjuqHqGsRjiDEOSDWh2BxNAg@mail.gmail.com>
 <ZNYnx9NqwSsXKhX3@dhcp22.suse.cz>
 <CAJD7tkbJ1fnMDudtsS2xubKn0RTWz7t0Hem=PSRQQp3sGf-iOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbJ1fnMDudtsS2xubKn0RTWz7t0Hem=PSRQQp3sGf-iOw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 11-08-23 12:02:48, Yosry Ahmed wrote:
> On Fri, Aug 11, 2023 at 5:21 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 09-08-23 11:33:20, Yosry Ahmed wrote:
> > > On Wed, Aug 9, 2023 at 6:32 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Wed 09-08-23 06:13:05, Yosry Ahmed wrote:
> > > > > On Wed, Aug 9, 2023 at 5:58 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Wed 09-08-23 05:31:04, Yosry Ahmed wrote:
> > > > > > > On Wed, Aug 9, 2023 at 1:51 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > > >
> > > > > > > > On Wed 09-08-23 04:58:10, Yosry Ahmed wrote:
> > > > > > > > > Over time, the memcg code added multiple optimizations to the stats
> > > > > > > > > flushing path that introduce a tradeoff between accuracy and
> > > > > > > > > performance. In some contexts (e.g. dirty throttling, refaults, etc), a
> > > > > > > > > full rstat flush of the stats in the tree can be too expensive. Such
> > > > > > > > > optimizations include [1]:
> > > > > > > > > (a) Introducing a periodic background flusher to keep the size of the
> > > > > > > > > update tree from growing unbounded.
> > > > > > > > > (b) Allowing only one thread to flush at a time, and other concurrent
> > > > > > > > > flushers just skip the flush. This avoids a thundering herd problem
> > > > > > > > > when multiple reclaim/refault threads attempt to flush the stats at
> > > > > > > > > once.
> > > > > > > > > (c) Only executing a flush if the magnitude of the stats updates exceeds
> > > > > > > > > a certain threshold.
> > > > > > > > >
> > > > > > > > > These optimizations were necessary to make flushing feasible in
> > > > > > > > > performance-critical paths, and they come at the cost of some accuracy
> > > > > > > > > that we choose to live without. On the other hand, for flushes invoked
> > > > > > > > > when userspace is reading the stats, the tradeoff is less appealing
> > > > > > > > > This code path is not performance-critical, and the inaccuracies can
> > > > > > > > > affect userspace behavior. For example, skipping flushing when there is
> > > > > > > > > another ongoing flush is essentially a coin flip. We don't know if the
> > > > > > > > > ongoing flush is done with the subtree of interest or not.
> > > > > > > >
> > > > > > > > I am not convinced by this much TBH. What kind of precision do you
> > > > > > > > really need and how much off is what we provide?
> > > > > > > >
> > > > > > > > More expensive read of stats from userspace is quite easy to notice
> > > > > > > > and usually reported as a regression. So you should have a convincing
> > > > > > > > argument that an extra time spent is really worth it. AFAIK there are
> > > > > > > > many monitoring (top like) tools which simply read those files regularly
> > > > > > > > just to show numbers and they certainly do not need a high level of
> > > > > > > > precision.
> > > > > > >
> > > > > > > We used to spend this time before commit fd25a9e0e23b ("memcg: unify
> > > > > > > memcg stat flushing") which generalized the "skip if ongoing flush"
> > > > > > > for all stat flushing. As far I know, the problem was contention on
> > > > > > > the flushing lock which also affected critical paths like refault.
> > > > > > >
> > > > > > > The problem is that the current behavior is indeterministic, if cpu A
> > > > > > > tries to flush stats and cpu B is already doing that, cpu A will just
> > > > > > > skip. At that point, the cgroup(s) that cpu A cares about may have
> > > > > > > been fully flushed, partially flushed (in terms of cpus), or not
> > > > > > > flushed at all. We have no idea. We just know that someone else is
> > > > > > > flushing something. IOW, in some cases the flush request will be
> > > > > > > completely ignored and userspace will read stale stats (up to 2s + the
> > > > > > > periodic flusher runtime).
> > > > > >
> > > > > > Yes, that is certainly true but why does that matter? Stats are always a
> > > > > > snapshot of the past. Do we get an inconsistent image that would be
> > > > > > actively harmful.
> > > > >
> > > > > That can very well be the case because we may be in a state where some
> > > > > cpus are flushed and some aren't. Also sometimes a few seconds is too
> > > > > old. We have some workloads that read the stats every 1-2 seconds to
> > > > > keep a fresh state, and they certainly do not expect stats to be 2+
> > > > > seconds old when they read them.
> > > >
> > > > I hate to repeat myself but please be more specific. This all sounds
> > > > just too wavy to me.
> > >
> > > Sorry I didn't have the full story in mind, I had to do my homework.
> > > One example is userspace OOM killing. Our userspace OOM killer makes
> > > decisions based on some stats from memory.stat, and stale stats (a few
> > > seconds in this case) can result in an unrightful OOM kill, which can
> > > easily cascade.
> >
> > OK, but how is this any different from having outdated data because you
> > have to wait for memory.stat to read (being blocked inside the rstat
> > code)? Either your oom killer is reading the stats directly and then you
> > depend on that flushing which is something that could be really harmful
> > itself or you rely on another thread doing the blocking and you do not
> > have up-to-date numbers anyway. So how does blocking actually help?
> 
> I am not sure I understand.
> 
> The problem is that when you skip when someone else is flushing, there
> is a chance that the stats we care about haven't been flushed since
> the last time the periodic flusher ran. Which is supposed to be ~2
> seconds ago, but maybe more depending on how busy the workqueue is.

Yes, this is clear. You simply get _some_ snapshot of the past.

> When you block until the flusher finishes, the stats are being
> refreshed as you wait. So the stats are not getting more outdated as
> you wait in the general case (unless your cgroup was flushed first and
> you're waiting for others to be flushed).
> [Let's call this approach A]

Yes, but the amount of waiting is also undeterministic and even after
you waited your stats might be outdated already depending on how quickly
somebody allocates. That was my point.

> Furthermore, with the implementation you suggested using a mutex, we
> will wait until the ongoing flush is completed, then we will grab the
> mutex and do a flush ourselves.

Flushing would be mostly unnecessary as somebody has just flushed
everything. The only point of mutex is to remove the super ugly busy
wait for sleepable context construct.

[...]
> When running a test that is proactively reclaiming some memory and
> expecting to see the memory swapped, without this patch, we see
> significant inaccuracy. In some failure instances we expect ~2000
> pages to be swapped but we only find ~1200.

That difference is 3MB of memory. What is the precision you are
operating on? 

> This is observed on
> machines with hundreds of cpus, where the problem is most noticeable.
> This is a huge difference. Keep in mind that the inaccuracy would
> probably be even worse in a production environment if the system is
> under enough pressure (e.g. the periodic flusher is late).
> 
> For both approach A (wait until flusher finishes and exit, i.e this
> patch) and approach B (wait until flusher finishes then flush, i.e the
> mutex approach), I stop seeing this failure in the proactive reclaim
> test and the stats are accurate.
> 
> I have v2 ready that implements approach B with the mutex ready to
> fire, just say the word :)
> 
> >
> > In any case I do get the argument about consistency within a subtree
> > (children data largely not matching parents'). Examples like that would
> > be really helpful as well. If that is indeed the case then I would
> > consider it much more serious than accuracy which is always problematic
> > (100ms of an actively allocating context can ruin your just read numbers
> > and there is no way around that wihtout stopping the world).
> 
> 100% agreed. It's more difficult to get testing results for this, but
> that can easily be the case when we have no idea how much is flushed
> when we return from mem_cgroup_flush_stats().
> 
> >
> > Last note, for /proc/vmstat we have /proc/sys/vm/stat_refresh to trigger
> > an explicit refresh. For those users who really need more accurate
> > numbers we might consider interface like that. Or allow to write to stat
> > file and do that in the write handler.
> 
> This wouldn't be my first option, but if that's the only way to get
> accurate stats I'll take it.

To be honest, this would be my preferable option because of 2 reasons.
a) we do not want to guarantee to much on the precision front because
that would just makes maintainability much more harder with different
people having a different opinion of how much precision is enough and b)
it makes the more rare (need precise) case the special case rather than
the default.

> Keep in mind that the normal stats read path will always try to
> refresh, it's just that it will often skip refreshing due to an
> implementation-specific race. So having an interface for an explicit
> flush might be too implementation specific, especially if the race
> disappears later and the interface is not needed later.

That doesn't really matter because from the userspace POV it is really
not important how the whole thing is implemented and whether the
interface blocks in reality. It simply has count with blocking. It just
needs a coherent and up-to-date-at-the-flush semantic.
-- 
Michal Hocko
SUSE Labs
