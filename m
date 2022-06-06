Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C75153DFF6
	for <lists+cgroups@lfdr.de>; Mon,  6 Jun 2022 05:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242762AbiFFDQn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 Jun 2022 23:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbiFFDQm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 5 Jun 2022 23:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 650544F473
        for <cgroups@vger.kernel.org>; Sun,  5 Jun 2022 20:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654485400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k29yc7w9b88p8N/STUF61jAqzTNY+1ywx+KU40xq0aA=;
        b=GPOmoERIRU5zwlpWg8kZd70HxPMAM/J0PAb/aorTjxpdPdy0LLROj6iEoNm6Z5jLZWmnYo
        jkSKO8PtKbqG8LeefdXS3+Lgm9GCSHoVweEOWHNFeGIEjfXN9UA+Bq5aFTXxMVCcmimkQw
        R8utvyjLb1QU//AK84b6wyoraVjqeNk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-G2OsmNNaN5a1mKdR3Rp8sQ-1; Sun, 05 Jun 2022 23:16:39 -0400
X-MC-Unique: G2OsmNNaN5a1mKdR3Rp8sQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB2DD3C02187;
        Mon,  6 Jun 2022 03:16:38 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9020E2026D64;
        Mon,  6 Jun 2022 03:16:34 +0000 (UTC)
Date:   Mon, 6 Jun 2022 11:16:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] blk-cgroup: Optimize blkcg_rstat_flush()
Message-ID: <Yp1xjRyU9L5FiWXQ@T590>
References: <20220602192020.166940-1-longman@redhat.com>
 <20220602192020.166940-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602192020.166940-4-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 02, 2022 at 03:20:20PM -0400, Waiman Long wrote:
> For a system with many CPUs and block devices, the time to do
> blkcg_rstat_flush() from cgroup_rstat_flush() can be rather long. It
> can be especially problematic as interrupt is disabled during the flush.
> It was reported that it might take seconds to complete in some extreme
> cases leading to hard lockup messages.
> 
> As it is likely that not all the percpu blkg_iostat_set's has been
> updated since the last flush, those stale blkg_iostat_set's don't need
> to be flushed in this case. This patch optimizes blkcg_rstat_flush()
> by keeping a lockless list of recently updated blkg_iostat_set's in a
> newly added percpu blkcg->lhead pointer.
> 
> The blkg_iostat_set is added to the lockless list on the update side
> in blk_cgroup_bio_start(). It is removed from the lockless list when
> flushed in blkcg_rstat_flush(). Due to racing, it is possible that
> blk_iostat_set's in the lockless list may have no new IO stats to be
> flushed. To protect against destruction of blkg, a percpu reference is
> gotten when putting into the lockless list and put back when removed.
> 
> A blkg_iostat_set can determine if it is in a lockless list by checking
> the content of its lnode.next pointer which will be non-NULL when in
> a lockless list. This requires the presence of a special llist_last
> sentinel node to be put at the end of the lockless list.
> 
> When booting up an instrumented test kernel with this patch on a
> 2-socket 96-thread system with cgroup v2, out of the 2051 calls to
> cgroup_rstat_flush() after bootup, 1788 of the calls were exited
> immediately because of empty lockless list. After an all-cpu kernel
> build, the ratio became 6295424/6340513. That was more than 99%.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

