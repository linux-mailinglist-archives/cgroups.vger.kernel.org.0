Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A6D53DFF3
	for <lists+cgroups@lfdr.de>; Mon,  6 Jun 2022 05:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbiFFDQC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 Jun 2022 23:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343764AbiFFDQC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 5 Jun 2022 23:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 327F24F9FE
        for <cgroups@vger.kernel.org>; Sun,  5 Jun 2022 20:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654485358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a3GZiqjzOQU3jcJYnFlk7GQp3wzOjfJX1PgQLpdIZe0=;
        b=ZghtTOD/FnBjQArZuem4K6Nos/eDtLQXaplClynOX8RWszNiDk4ODf3QxKqjQE62kGJ9T4
        VkCdn971L0iQcVYK5BkWr/UQfee6Frj1/hYYdTY8Npl4czVqNZcH0NAqo9iPreOLyy79cS
        f62AAjrEoX2iJjArjvakEKuogAj94eU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-gygSuDEuPm-Gam5zjv4OHw-1; Sun, 05 Jun 2022 23:15:55 -0400
X-MC-Unique: gygSuDEuPm-Gam5zjv4OHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41F4B802804;
        Mon,  6 Jun 2022 03:15:55 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC08640CFD0A;
        Mon,  6 Jun 2022 03:15:50 +0000 (UTC)
Date:   Mon, 6 Jun 2022 11:15:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] blk-cgroup: Optimize blkcg_rstat_flush()
Message-ID: <Yp1xYcASIrtSsI4v@T590>
References: <20220602192020.166940-1-longman@redhat.com>
 <20220602192020.166940-4-longman@redhat.com>
 <YprYgdV0IxAeJZsz@T590>
 <ee754359-cefd-7d4b-7861-1405860bba9b@redhat.com>
 <Yp1atoLkZPvA1Zd3@T590>
 <c9ab0e91-76db-430f-272c-558c269d62ce@redhat.com>
 <Yp1lFYc578SkraF/@T590>
 <9272d9ba-1b34-991b-78b5-beca5e170a23@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9272d9ba-1b34-991b-78b5-beca5e170a23@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Jun 05, 2022 at 10:58:15PM -0400, Waiman Long wrote:
> On 6/5/22 22:23, Ming Lei wrote:
> > On Sun, Jun 05, 2022 at 09:59:50PM -0400, Waiman Long wrote:
> > > On 6/5/22 21:39, Ming Lei wrote:
> > > > On Sun, Jun 05, 2022 at 07:15:27PM -0400, Waiman Long wrote:
> > > > > On 6/3/22 23:58, Ming Lei wrote:
> > > > > 
> > > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > > index abec50f31fe6..8c4f204dbf5b 100644
> > > > > > --- a/mm/memcontrol.c
> > > > > > +++ b/mm/memcontrol.c
> > > > > > @@ -622,7 +622,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
> > > > > >     {
> > > > > >     	unsigned int x;
> > > > > > -	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
> > > > > > +	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id(), NULL);
> > > > > >     	x = __this_cpu_add_return(stats_updates, abs(val));
> > > > > >     	if (x > MEMCG_CHARGE_BATCH) {
> > > > > I think the rstat set of functions are doing that already. So flush will
> > > > > only call CPUs that have called cgroup_rstat_updated() before. However, one
> > > > Yeah, I guess the detail is in cgroup_rstat_cpu_pop_updated(), but the
> > > > percpu lock(raw_spin_lock_irqsave) is still required, and cgroup_rstat_cpu_pop_updated()
> > > > is still called even through there isn't any update on this CPU.
> > > Yes, I think we may need to add a bitmask of what controllers have updates
> > > in cgroup_rstat_cpu structure.
> > > > > deficiency that I am aware of is that there is no bitmap of which controller
> > > > > have update. The problem that I saw in cgroup v2 is that in a cgroup with
> > > > > both memory controller and block controller enabled, a
> > > > > cgroup_rstat_updated() call from memory cgroup later causes the rstat
> > > > > function to call into block cgroup flush method even though there is no
> > > > > update in the block controller. This is an area that needs improvement.
> > > > > 
> > > > > Your code does allow the block controller to be aware of that and avoid
> > > > > further action, but I think it has to be done in the rstat code to be
> > > > > applicable to all controllers instead of just specific to block controller.
> > > > I guess it can be done by adding one percpu variable to 'struct cgroup'.
> > > > 
> > > > > There is another problem that this approach. Suppose the system have 20
> > > > > block devices and one of them has an IO operation. Now the flush method
> > > > > still needs to iterate all the 20 blkg's to do an update. The block
> > > > > controller is kind of special that the number of per-cgroup IO stats depends
> > > > > on the number of block devices present. Other controllers just have one set
> > > > > of stats per cgroup.
> > > > Yeah, and this one is really blkio specific issue, and your patch does
> > > > cover this one. Maybe you can add one callback to
> > > > cgroup_rstat_updated(), so the "blkg_iostat_set" instance is added into
> > > > percpu list under percpu lock of cgroup_rstat_cpu_lock, then the lockless
> > > > list isn't needed.
> > > The rstat API is generic. It may not be a good idea to put controller
> > > specific information into it. Yes, cgroup_rstat_cpu_lock is taken at the
> > > read side (flush). It may not taken on the write side (update). So it may
> > Both cgroup_rstat_flush_locked()/cgroup_rstat_updated() take the percpu
> > cgroup_rstat_cpu_lock, so the new invented lockless list can be
> > replaced with plain list.
> 
> cgroup_rstat_updated() should only take the percpu cgroup_rstat_cpu_lock the
> first time it transition from "!updated" to "updated". After that, it
> returns immediately without the the lock. With a regular list, you will have
> to take the lock every time a new block device has an update. So there isn't
> much saving on the update side. In general, the lock/unlock sequence has a
> bit more overhead than the lockless insertion. On the flush side, there may
> be a bit of saving, but it is not the fast path.

OK, got it, looks I misunderstood cgroup_rstat_updated(), and still the
point of N queue vs. 1 cgroup, then looks your patch is good.


Thanks,
Ming

