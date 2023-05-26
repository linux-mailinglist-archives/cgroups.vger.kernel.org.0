Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ADA711B50
	for <lists+cgroups@lfdr.de>; Fri, 26 May 2023 02:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbjEZAfK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 May 2023 20:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbjEZAfJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 May 2023 20:35:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A7E199
        for <cgroups@vger.kernel.org>; Thu, 25 May 2023 17:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685061260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3HkhSmcztqk7WRQegC24K1K8Fj702Fn4WVYpg4vLlng=;
        b=CF3AVpPmm2IFmrlocxx08P3YoXCCVK1WwiW4YJfbZJZPECz0g21oV1sWLNWQvGzmKf2W6i
        SdBAAzK4tnhdKQrbbQ4JC+VHK39RBCvZMl/2EHs+NB5L56e7PCcINKtN0Taw6OdHCNhX7q
        9cARyB8q9XYW08benkI+2BpWpvwifgs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-Wm6kMQb3MvW3FH1f-sushQ-1; Thu, 25 May 2023 20:34:17 -0400
X-MC-Unique: Wm6kMQb3MvW3FH1f-sushQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF9E680120A;
        Fri, 26 May 2023 00:34:16 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A576400F1F;
        Fri, 26 May 2023 00:34:09 +0000 (UTC)
Date:   Fri, 26 May 2023 08:34:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Jay Shin <jaeshin@redhat.com>, stable@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH] blk-cgroup: Flush stats before releasing blkcg_gq
Message-ID: <ZG/+fB+f8Lf2PKc7@ovpn-8-21.pek2.redhat.com>
References: <20230525043518.831721-1-ming.lei@redhat.com>
 <20230525160105.1968749-1-longman@redhat.com>
 <64f20e27-0927-334d-5414-9bb81d639cec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64f20e27-0927-334d-5414-9bb81d639cec@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 25, 2023 at 12:06:07PM -0400, Waiman Long wrote:
> On 5/25/23 12:01, Waiman Long wrote:
> > As noted by Michal, the blkg_iostat_set's in the lockless list hold
> > reference to blkg's to protect against their removal. Those blkg's
> > hold reference to blkcg. When a cgroup is being destroyed,
> > cgroup_rstat_flush() is only called at css_release_work_fn() which
> > is called when the blkcg reference count reaches 0. This circular
> > dependency will prevent blkcg and some blkgs from being freed after
> > they are made offline.
> > 
> > It is less a problem if the cgroup to be destroyed also has other
> > controllers like memory that will call cgroup_rstat_flush() which will
> > clean up the reference count. If block is the only controller that uses
> > rstat, these offline blkcg and blkgs may never be freed leaking more
> > and more memory over time.
> > 
> > To prevent this potential memory leak:
> > 
> > - flush blkcg per-cpu stats list in __blkg_release(), when no new stat
> >    can be added to avoid use-after-free of the percpu blkg_iostat_set in
> >    futue cgroup_rstat_flush*() calls.
> > 
> > - add a cgroup_rstat_flush_acquire() helper and call it to acquire
> >    cgroup_rstat_lock to block concurrent execution of other
> >    cgroup_rstat_flush*() calls
> > 
> > - don't grab bio->bi_blkg reference when adding the stats into blkcg's
> >    per-cpu stat list since all stats are guaranteed to be consumed before
> >    releasing blkg instance, and grabbing blkg reference for stats was
> >    the most fragile part of original patch
> > 
> > Based on Waiman's patch:
> > 
> > https://lore.kernel.org/linux-block/20221215033132.230023-3-longman@redhat.com/
> > 
> > Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> > Cc: stable@vger.kernel.org
> > Reported-by: Jay Shin <jaeshin@redhat.com>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: mkoutny@suse.com
> > Cc: Yosry Ahmed <yosryahmed@google.com>
> > Co-developed-by: Ming Lei <ming.lei@redhat.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > ---
> >   block/blk-cgroup.c     | 57 +++++++++++++++++++++++++++++++-----------
> >   include/linux/cgroup.h |  1 +
> >   kernel/cgroup/rstat.c  | 15 ++++++++++-
> >   3 files changed, 57 insertions(+), 16 deletions(-)
> 
> This is my counter-proposal to Ming's v3 patch. The major difference is that
> I used the existing cgroup_rstat_lock instead of adding a new internal lock.
> This minimizes performance impact to existing cgroup_rstat_flush*() call

The added internal lock has ~zero perf impact on rstat flush cause
the lock won't be contended basically.

> while achieving the same objective. I am fine with Ming current v3 patch if
> we decide to go that way.

As I mentioned, the main motivation with internal lock is to make the fix as
simple as possible since cross-subsystem change isn't involved, and I am fine
with any following cleanup or improvement on current blkg rstat flush.

Another benefit with this internal lock is that race in blkcg_reset_stats()
can be avoided.


Thanks, 
Ming

