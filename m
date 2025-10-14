Return-Path: <cgroups+bounces-10718-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7614ABD84F2
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 10:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4EA03AAE2C
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 08:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5277C2E0411;
	Tue, 14 Oct 2025 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnPhkQ/c"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670DB2DF706
	for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432133; cv=none; b=Q1dBJKDP2MHuPwfZaFZjpw6OORidZwArxp0hSwG6MCZIQ82eDQsmSigCjX0UnL4tlUVsy4ZNU9/4dm+wr7uE+EpTnkFSvnVWdp7rEHZRAb8y+2pn8ILsg+lnC7hFs/B0duWKNtrHs1xyctnPcXcwVGBJPLjJx9JEAUbBVhoMNlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432133; c=relaxed/simple;
	bh=MMxriXDc8vMgRKXTLY/BEuuQfCNgW7+ZkriAu8GtKxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAajaLGv8zo7WuZO84JG7FxE6QOEJRf+Up1UvJcLoR91qcA/eyDhcuHkTDriY38pVaIw5uMMhS4bVNTN3xG8dXOZqdgzofmKP89kciVbnZXmdopXlQmm8+YKrimCx3b2Jq0Ee+e/WiIURGyEVaxuwJ/XNWLRRhqf+5BXbTShhKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HnPhkQ/c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760432130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwa8bTOFJEQ9KZgmpDkfmjTWpRXkCxQQorAAM5/0DZQ=;
	b=HnPhkQ/c6MtidvgkK9lIWgoHNBHLwXMvLLz21awW7Dw5yeycMN/zqcV16aJ1XdHudn/mrd
	llOSknNuKxAj9NRnsR3VJ39MpygJo5YS/5kGxeC4mzdosdcAvUk5Gv2mojRiAXkwE2fRCR
	vEyeKdiu3JZ3PmBRZEJxbaMqsR7JYLs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-sYHeLI-bNr-jlEvJtrohWQ-1; Tue,
 14 Oct 2025 04:55:26 -0400
X-MC-Unique: sYHeLI-bNr-jlEvJtrohWQ-1
X-Mimecast-MFC-AGG-ID: sYHeLI-bNr-jlEvJtrohWQ_1760432124
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61E4D19560A1;
	Tue, 14 Oct 2025 08:55:24 +0000 (UTC)
Received: from fedora (unknown [10.72.120.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A49130002D0;
	Tue, 14 Oct 2025 08:55:15 +0000 (UTC)
Date: Tue, 14 Oct 2025 16:55:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com,
	axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 3/4] blk-rq-qos: fix possible deadlock
Message-ID: <aO4P08Sw2YYjOYtu@fedora>
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <20251014022149.947800-4-yukuai3@huawei.com>
 <aO4GPKKpLbj7kMoz@fedora>
 <f0ab9c95-990b-a41d-477e-c1b20b392985@huaweicloud.com>
 <aO4L2THnLFM-_Fb8@fedora>
 <0351f07e-4ac4-a1e2-b4ee-08e49e7d0b6e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0351f07e-4ac4-a1e2-b4ee-08e49e7d0b6e@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Oct 14, 2025 at 04:42:30PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/10/14 16:37, Ming Lei 写道:
> > On Tue, Oct 14, 2025 at 04:24:23PM +0800, Yu Kuai wrote:
> > > Hi,
> > > 
> > > 在 2025/10/14 16:13, Ming Lei 写道:
> > > > On Tue, Oct 14, 2025 at 10:21:48AM +0800, Yu Kuai wrote:
> > > > > Currently rq-qos debugfs entries is created from rq_qos_add(), while
> > > > > rq_qos_add() requires queue to be freezed. This can deadlock because
> > > > > creating new entries can trigger fs reclaim.
> > > > > 
> > > > > Fix this problem by delaying creating rq-qos debugfs entries until
> > > > > it's initialization is complete.
> > > > > 
> > > > > - For wbt, it can be initialized by default of by blk-sysfs, fix it by
> > > > >     calling blk_mq_debugfs_register_rq_qos() after wbt_init;
> > > > > - For other policies, they can only be initialized by blkg configuration,
> > > > >     fix it by calling blk_mq_debugfs_register_rq_qos() from
> > > > >     blkg_conf_end();
> > > > > 
> > > > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > > > ---
> > > > >    block/blk-cgroup.c | 6 ++++++
> > > > >    block/blk-rq-qos.c | 7 -------
> > > > >    block/blk-sysfs.c  | 4 ++++
> > > > >    block/blk-wbt.c    | 7 ++++++-
> > > > >    4 files changed, 16 insertions(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > > > > index d93654334854..e4ccabf132c0 100644
> > > > > --- a/block/blk-cgroup.c
> > > > > +++ b/block/blk-cgroup.c
> > > > > @@ -33,6 +33,7 @@
> > > > >    #include "blk-cgroup.h"
> > > > >    #include "blk-ioprio.h"
> > > > >    #include "blk-throttle.h"
> > > > > +#include "blk-mq-debugfs.h"
> > > > >    static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);
> > > > > @@ -746,6 +747,11 @@ void blkg_conf_end(struct blkg_conf_ctx *ctx)
> > > > >    	mutex_unlock(&q->elevator_lock);
> > > > >    	blk_mq_unfreeze_queue(q, ctx->memflags);
> > > > >    	blkdev_put_no_open(ctx->bdev);
> > > > > +
> > > > > +	mutex_lock(&q->debugfs_mutex);
> > > > > +	blk_mq_debugfs_register_rq_qos(q);
> > > > > +	mutex_unlock(&q->debugfs_mutex);
> > > > > +
> > > > >    }
> > > > >    EXPORT_SYMBOL_GPL(blkg_conf_end);
> > > > > diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> > > > > index 654478dfbc20..d7ce99ce2e80 100644
> > > > > --- a/block/blk-rq-qos.c
> > > > > +++ b/block/blk-rq-qos.c
> > > > > @@ -347,13 +347,6 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
> > > > >    	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
> > > > >    	blk_mq_unfreeze_queue(q, memflags);
> > > > > -
> > > > > -	if (rqos->ops->debugfs_attrs) {
> > > > > -		mutex_lock(&q->debugfs_mutex);
> > > > > -		blk_mq_debugfs_register_rqos(rqos);
> > > > > -		mutex_unlock(&q->debugfs_mutex);
> > > > > -	}
> > > > > -
> > > > >    	return 0;
> > > > >    ebusy:
> > > > >    	blk_mq_unfreeze_queue(q, memflags);
> > > > > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > > > > index 76c47fe9b8d6..52bb4db25cf5 100644
> > > > > --- a/block/blk-sysfs.c
> > > > > +++ b/block/blk-sysfs.c
> > > > > @@ -688,6 +688,10 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
> > > > >    	mutex_unlock(&disk->rqos_state_mutex);
> > > > >    	blk_mq_unquiesce_queue(q);
> > > > > +
> > > > > +	mutex_lock(&q->debugfs_mutex);
> > > > > +	blk_mq_debugfs_register_rq_qos(q);
> > > > > +	mutex_unlock(&q->debugfs_mutex);
> > > > >    out:
> > > > >    	blk_mq_unfreeze_queue(q, memflags);
> > > > > diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> > > > > index eb8037bae0bd..a120b5ba54db 100644
> > > > > --- a/block/blk-wbt.c
> > > > > +++ b/block/blk-wbt.c
> > > > > @@ -724,8 +724,13 @@ void wbt_enable_default(struct gendisk *disk)
> > > > >    	if (!blk_queue_registered(q))
> > > > >    		return;
> > > > > -	if (queue_is_mq(q) && enable)
> > > > > +	if (queue_is_mq(q) && enable) {
> > > > >    		wbt_init(disk);
> > > > > +
> > > > > +		mutex_lock(&q->debugfs_mutex);
> > > > > +		blk_mq_debugfs_register_rq_qos(q);
> > > > > +		mutex_unlock(&q->debugfs_mutex);
> > > > > +	}
> > > > 
> > > > ->debugfs_mutex only may be not enough, because blk_mq_debugfs_register_rq_qos()
> > > > has to traverse rq_qos single list list, you may have to grab q->rq_qos_mutex
> > > > for protect the list.
> > > > 
> > > 
> > > I think we can't grab rq_qos_mutex to create debugfs entries, right?
> > 
> > It depends on the finalized order between rq_qos_mutex and freezing queue.
> > 
> > > With the respect of this, perhaps we can grab debugfs_mutex to protect
> > > insering rq_qos list instead?
> > 
> > No, debugfs_mutex shouldn't protect rq_qos list, and rq_qos_mutex is
> > supposed to do the job at least from naming viewpoint.
> 
> Ok, then we'll have to make sure the order is rq_qos_mutex before
> freezing queue, I was thinking the inverse order because of the helper
> blkg_conf_open_bdev_frozen().
> 
> I'll check first if this is possible.

You may misunderstand my point, I meant `debugfs_mutex` can't be used for
protecting rq_qos list because of its name. But order between rq_qos_mutex
and freeze queue might be fine in either way, just it has to be fixed.
Not look into it yet.

Thanks,
Ming


