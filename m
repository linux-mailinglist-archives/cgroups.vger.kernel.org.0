Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6A5725187
	for <lists+cgroups@lfdr.de>; Wed,  7 Jun 2023 03:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbjFGB3N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Jun 2023 21:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240449AbjFGB3J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Jun 2023 21:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87F71982
        for <cgroups@vger.kernel.org>; Tue,  6 Jun 2023 18:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686101300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1h0nXm4obQWr/nMN17xlxThI6u2crQzlPISlM1jWir0=;
        b=XaAwKWI8M34st32pDbwA7SxRgVZ813Ujx0f0R6yXS5VQ3Nb/7TkkY2TtQ9OB1A5Bs7rTZg
        H1JeEA47bkMUCZuN0+OPdGJM1FFV8I46CgFBDrApLt8ESwg4YkskKGzssqp5yISTiVLyA3
        KTx/yUieOnRU3OVXpzVqDqye3iMwh5Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-ITxAbywmO4unISCQRha-2w-1; Tue, 06 Jun 2023 21:28:17 -0400
X-MC-Unique: ITxAbywmO4unISCQRha-2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DEC5801182;
        Wed,  7 Jun 2023 01:28:17 +0000 (UTC)
Received: from ovpn-8-23.pek2.redhat.com (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E961440D1B66;
        Wed,  7 Jun 2023 01:28:12 +0000 (UTC)
Date:   Wed, 7 Jun 2023 09:28:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup: Reinit blkg_iostat_set after clearing in
 blkcg_reset_stats()
Message-ID: <ZH/dKFnTIHZqsjQa@ovpn-8-23.pek2.redhat.com>
References: <20230606180724.2455066-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606180724.2455066-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 06, 2023 at 02:07:24PM -0400, Waiman Long wrote:
> When blkg_alloc() is called to allocate a blkcg_gq structure
> with the associated blkg_iostat_set's, there are 2 fields within
> blkg_iostat_set that requires proper initialization - blkg & sync.
> The former field was introduced by commit 3b8cc6298724 ("blk-cgroup:
> Optimize blkcg_rstat_flush()") while the later one was introduced by
> commit f73316482977 ("blk-cgroup: reimplement basic IO stats using
> cgroup rstat").
> 
> Unfortunately those fields in the blkg_iostat_set's are not properly
> re-initialized when they are cleared in v1's blkcg_reset_stats(). This
> can lead to a kernel panic due to NULL pointer access of the blkg
> pointer. The missing initialization of sync is less problematic and
> can be a problem in a debug kernel due to missing lockdep initialization.
> 
> Fix these problems by re-initializing them after memory clearing.
> 
> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> Fixes: f73316482977 ("blk-cgroup: reimplement basic IO stats using cgroup rstat")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  block/blk-cgroup.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 90c2efc3767f..48084321e3e0 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -636,8 +636,13 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
>  			struct blkg_iostat_set *bis =
>  				per_cpu_ptr(blkg->iostat_cpu, cpu);
>  			memset(bis, 0, sizeof(*bis));
> +
> +			/* Re-initialize the cleared blkg_iostat_set */
> +			u64_stats_init(&bis->sync);
> +			bis->blkg = blkg;
>  		}
>  		memset(&blkg->iostat, 0, sizeof(blkg->iostat));
> +		u64_stats_init(&blkg->iostat.sync);
>  
>  		for (i = 0; i < BLKCG_MAX_POLS; i++) {
>  			struct blkcg_policy *pol = blkcg_policy[i];

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

