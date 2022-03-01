Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F894C894D
	for <lists+cgroups@lfdr.de>; Tue,  1 Mar 2022 11:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiCAKaG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Mar 2022 05:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbiCAKaF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Mar 2022 05:30:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACCDF8EB4C
        for <cgroups@vger.kernel.org>; Tue,  1 Mar 2022 02:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646130556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MyK8CGeqc8W1ttSv05bq0b6rSbbQ2JkU82/9ujV/uPI=;
        b=jORoIMPJ2MC0KT+04w0PMGCB6tc6bPPatRJx0ToEJl+be2vE+E/38UMDW8RDl6AzoGWo/7
        twPGjOENWQhzYUKPWbffN9eMAF/xWwU/nu6XR5l99xg/e/KLwbmvVNzTOmeXbYpsiIH1Zc
        b02C7EGDKNXucLTp14RFgFXcYQ3yXFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-vtR9JpqPPUqdZT2yhI3tpw-1; Tue, 01 Mar 2022 05:29:13 -0500
X-MC-Unique: vtR9JpqPPUqdZT2yhI3tpw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4D4CFC80;
        Tue,  1 Mar 2022 10:29:11 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE0596F965;
        Tue,  1 Mar 2022 10:29:06 +0000 (UTC)
Date:   Tue, 1 Mar 2022 18:29:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yu Kuai <yukuai3@huawei.com>, tj@kernel.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v9] block: cancel all throttled bios in del_gendisk()
Message-ID: <Yh31bQu3gbXoDBuK@T590>
References: <20220210115637.1074927-1-yukuai3@huawei.com>
 <YhuyBgZSS6m/Mwu6@infradead.org>
 <Yhxnkg0AEaj36t+a@T590>
 <YhyYpWHGVhs3J/dk@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhyYpWHGVhs3J/dk@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 28, 2022 at 01:40:53AM -0800, Christoph Hellwig wrote:
> On Mon, Feb 28, 2022 at 02:11:30PM +0800, Ming Lei wrote:
> > > FYI, this crashed left rigt and center when running xfstests with
> > > traces pointing to throtl_pending_timer_fn.
> > 
> > Can you share the exact xfstests test(fs, test)? Or panic log?
> > 
> > I can't reproduce it when running './check -g auto' on XFS, meantime
> > tracking throtl_pending_timer_fn().
> 
> From a quick run using f2fs:
> 
> generic/081 files ... [  316.487861] run fstests generic/081 at 2022-02-28 09:38:40

Thanks for providing the reproducer.

The reason is that the pending timer is deleted in blkg's release
handler, so the timer can still be live after request queue is released.

The patch of 'block: cancel all throttled bios in del_gendisk()' should just
make it easier to trigger.

After patch of "block: move blkcg initialization/destroy into disk allocation/
release handler" lands, the issue can be fixed easily by:

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index fa063c6c0338..e8d4be5e1de3 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -82,6 +82,7 @@ static void blkg_free(struct blkcg_gq *blkg)
 		if (blkg->pd[i])
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
 
+	blk_put_queue(blkg->q);
 	free_percpu(blkg->iostat_cpu);
 	percpu_ref_exit(&blkg->refcnt);
 	kfree(blkg);
@@ -297,9 +298,10 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 	blkg->online = true;
 	spin_unlock(&blkcg->lock);
 
-	if (!ret)
+	if (!ret && blk_get_queue(q))
 		return blkg;
-
+	else if (!ret)
+		ret = -ENODEV;
 	/* @blkg failed fully initialized, use the usual release path */
 	blkg_put(blkg);
 	return ERR_PTR(ret);


Thanks,
Ming

