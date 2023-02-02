Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A65687453
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 05:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjBBEQz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 23:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjBBEQz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 23:16:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D5979F03
        for <cgroups@vger.kernel.org>; Wed,  1 Feb 2023 20:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675311370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Evaq+uKsw2JRl30GbWwAirFdc+12RiKunGeodqBwPs=;
        b=f9KOh7U5KNO9sxhmoFUSwqcQkT3LKhlscMA6qKmZ86vf1MZQRJLDj4eDMrWxMUpGnSnyKL
        fphp+BIMvSnyQtddMmcCq0xhOAtwgfl2GawyyDvHKF3/ztqLdQsLUXMqWEvPCGs+3PRY5x
        IgJfClZyjc89EChUhEaLDD1+NnQlHBA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-180-PDaMvEVqNfKTVNph2AOpwQ-1; Wed, 01 Feb 2023 23:16:07 -0500
X-MC-Unique: PDaMvEVqNfKTVNph2AOpwQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27A7F800050;
        Thu,  2 Feb 2023 04:16:06 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7E90140EBF4;
        Thu,  2 Feb 2023 04:15:57 +0000 (UTC)
Date:   Thu, 2 Feb 2023 12:15:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        ming.lei@redhat.com
Subject: Re: [PATCH v4 2/2] blk-cgroup: Flush stats at blkgs destruction path
Message-ID: <Y9s4+Nop1eluWmJ4@T590>
References: <20221215033132.230023-1-longman@redhat.com>
 <20221215033132.230023-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215033132.230023-3-longman@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 14, 2022 at 10:31:32PM -0500, Waiman Long wrote:
> As noted by Michal, the blkg_iostat_set's in the lockless list
> hold reference to blkg's to protect against their removal. Those
> blkg's hold reference to blkcg. When a cgroup is being destroyed,
> cgroup_rstat_flush() is only called at css_release_work_fn() which
> is called when the blkcg reference count reaches 0. This circular
> dependency will prevent blkcg and some blkgs from being freed after
> they are made offline.
> 
> It is less a problem if the cgroup to be destroyed also has other
> controllers like memory that will call cgroup_rstat_flush() which will
> clean up the reference count. If block is the only controller that uses
> rstat, these offline blkcg and blkgs may never be freed leaking more
> and more memory over time.
> 
> To prevent this potential memory leak, a new cgroup_rstat_css_cpu_flush()
> function is added to flush stats for a given css and cpu. This new
> function will be called at blkgs destruction path, blkcg_destroy_blkgs(),
> whenever there are still pending stats to be flushed. This will release
> the references to blkgs allowing them to be freed and indirectly allow
> the freeing of blkcg.
> 
> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
>  block/blk-cgroup.c     | 16 ++++++++++++++++
>  include/linux/cgroup.h |  1 +
>  kernel/cgroup/rstat.c  | 18 ++++++++++++++++++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index ca28306aa1b1..a2a1081d9d1d 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1084,6 +1084,8 @@ struct list_head *blkcg_get_cgwb_list(struct cgroup_subsys_state *css)
>   */
>  static void blkcg_destroy_blkgs(struct blkcg *blkcg)
>  {
> +	int cpu;
> +
>  	/*
>  	 * blkcg_destroy_blkgs() shouldn't be called with all the blkcg
>  	 * references gone.
> @@ -1093,6 +1095,20 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
>  
>  	might_sleep();
>  
> +	/*
> +	 * Flush all the non-empty percpu lockless lists to release the
> +	 * blkg references held by those lists which, in turn, will
> +	 * allow those blkgs to be freed and release their references to
> +	 * blkcg. Otherwise, they may not be freed at all becase of this
> +	 * circular dependency resulting in memory leak.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
> +
> +		if (!llist_empty(lhead))
> +			cgroup_rstat_css_cpu_flush(&blkcg->css, cpu);
> +	}

I guess it is possible for new iostat_cpu to be added just after the
llist_empty() check.


Thanks,
Ming

