Return-Path: <cgroups+bounces-10715-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C38C7BD8329
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 10:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C40542364A
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 08:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEC530FC1B;
	Tue, 14 Oct 2025 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArJWl213"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37E2DCF5B
	for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430895; cv=none; b=JUnfLjcFa0CtotfoOLLUVhS4qOZiOt86QwietNUnPyWtgQx6iKm/tXd/1g8R9YhKkVBgkr9c8DRKsEWxNv0UerATRWVLCNWwiC3NgrVRfsV6sc8+afdmIOpnn+AnCyMa/mXTNCv1JrceZ7YZ07EUNkPUdECzfEzVjVSU1ulVSPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430895; c=relaxed/simple;
	bh=pRsTyfPJ9UJjbA5j1H/hTOwtZY7SmFyXvGs+UofQcTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beTrqzzU4uq5HkRsoYeOJPxDDB8hBy5p7Dre8oSG0s3wDHI3TuLJRoTsKkcGtSLVQncCihw1+vsjuaab/rhGRix4OfG1VuqJgLHSGTH/MG8YWtPJ3n5c3M0TP2AOPkz7NopPi6LfsEJ9D6zIgmvI6XWnjpTaqg0tsnDUL9jZeZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArJWl213; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760430893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPbpAfXFpG+F0XArG45/phfeDqh8oNdwtwM3KTn35LI=;
	b=ArJWl213jXY9HDl4iVoRRkk0PS1HgrxInpEyZ1iD/8HJSZNJKBCVdftbmddG+Je4OBnRP3
	ulnvIG6hMyg7lKmu88sA+0mw94L8CiuP9ZTMjl5c9j0TK0AfjAzst+LnJIZy+EbRcIzXX+
	QTyTa+38vfClvf1ZVsL7TsIKQ4slTwY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-SXWV4OF1NRKazgloSSdOFg-1; Tue,
 14 Oct 2025 04:34:48 -0400
X-MC-Unique: SXWV4OF1NRKazgloSSdOFg-1
X-Mimecast-MFC-AGG-ID: SXWV4OF1NRKazgloSSdOFg_1760430886
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 557011956089;
	Tue, 14 Oct 2025 08:34:45 +0000 (UTC)
Received: from fedora (unknown [10.72.120.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 674921955F21;
	Tue, 14 Oct 2025 08:34:37 +0000 (UTC)
Date: Tue, 14 Oct 2025 16:34:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com,
	axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 1/4] blk-mq-debugfs: warn about possible deadlock
Message-ID: <aO4LGJ6I49dydw2J@fedora>
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <20251014022149.947800-2-yukuai3@huawei.com>
 <aO4EniFy63IlWM_-@fedora>
 <33c009e6-0cc3-bfc3-f7e5-8227cb467696@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33c009e6-0cc3-bfc3-f7e5-8227cb467696@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Oct 14, 2025 at 04:21:30PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/10/14 16:06, Ming Lei 写道:
> > On Tue, Oct 14, 2025 at 10:21:46AM +0800, Yu Kuai wrote:
> > > Creating new debugfs entries can trigger fs reclaim, hence we can't do
> > > this with queue freezed, meanwhile, other locks that can be held while
> > > queue is freezed should not be held as well.
> > > 
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > ---
> > >   block/blk-mq-debugfs.c | 31 ++++++++++++++++++++++++-------
> > >   1 file changed, 24 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > > index 4896525b1c05..66864ed0b77f 100644
> > > --- a/block/blk-mq-debugfs.c
> > > +++ b/block/blk-mq-debugfs.c
> > > @@ -608,9 +608,23 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
> > >   	{},
> > >   };
> > > -static void debugfs_create_files(struct dentry *parent, void *data,
> > > +static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
> > > +				 void *data,
> > >   				 const struct blk_mq_debugfs_attr *attr)
> > >   {
> > > +	/*
> > > +	 * Creating new debugfs entries with queue freezed has the rist of
> > > +	 * deadlock.
> > > +	 */
> > > +	WARN_ON_ONCE(q->mq_freeze_depth != 0);
> > > +	/*
> > > +	 * debugfs_mutex should not be nested under other locks that can be
> > > +	 * grabbed while queue is freezed.
> > > +	 */
> > > +	lockdep_assert_not_held(&q->elevator_lock);
> > > +	lockdep_assert_not_held(&q->rq_qos_mutex);
> > 
> > ->rq_qos_mutex use looks one real mess, in blk-cgroup.c, it is grabbed after
> > queue is frozen. However, inside block/blk-rq-qos.c, the two are re-ordered,
> > maybe we need to fix order between queue freeze and q->rq_qos_mutex first?
> > Or move on by removing the above line?
> 
> Yeah, I see this reoder as well, and I tried to fix this in the other
> thread for blkg configuration.
> 
> - queue is freezed by new helper blkg_conf_start(), and unfreezed after
>   blkg_conf_end(), rq_qos_add() is now called between them.
> 
> And for wbt, there are two cases:
>  - for blk-sysfs, queue is alredy freezed before rq_qos_add() as well;
>  - for wbt_enable_default(), this looks still problemaic, we should fix
>    the reorder seperatly.
> 
> Perhaps, should I fix this simple problem first, and then rebase the
> thread to convert queue_lock to blkcg_mtuex?

As I mentioned, if you want to move on with patchset first, the line of
`lockdep_assert_not_held(&q->rq_qos_mutex);` shouldn't be added until
->rq_qos_mutex vs. freeze queue order is finalized.


Thanks,
Ming


