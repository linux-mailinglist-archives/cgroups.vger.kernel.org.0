Return-Path: <cgroups+bounces-10709-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 461FBBD81B9
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 10:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FA71922C98
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 08:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0983830F7F5;
	Tue, 14 Oct 2025 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TP7YA9jl"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D2230F55F
	for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429239; cv=none; b=RB4aRnE27JcaFK1kUvRng6/Rp5lP1hRu2ZGANH6O59bW8ME0OLeyU4bXve9S8wQVwBaMJFU4W2TjeTDbgtmpCCyeqbIZ/EhtP4DZW2UjvJEW01BOQsQhnFeQV4zw1nVAKQYMQOQ+h0ZvsgR6aNxKDvl3d/bpojbLYIG799aXCak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429239; c=relaxed/simple;
	bh=W/8qUuXfRe1sI3GhG5HJ/sXq7n9SBQbq5yaCU3/GG28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn1JqlfRBwITEEcrIdpfKbKyj16tAQ89Sw4DMVFazfFnBw8rEFcjiMAtPkliHqKdxP+Ra8PzuWo8ACEMZDJv4EbElBhkAs9UQKlA8wKCDaEFs4Hrx1bsWzoq8sY8giRJvuW4WwrYjR2Jmo3Bof9OfZkuKR3M2fPVM2pdFXRODU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TP7YA9jl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760429237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tTrkuFKTla2K+L8YNXA54XVUf+zQx19gGP/m/Y+qRUc=;
	b=TP7YA9jlz/HLwMb7+ILSvyk6sCN2RSj2i6lA3ZViNKCklh7uZOUve8A3ZxSOk6RSEyzyxo
	rntGBrTBejrPBBIAbF1MXeUj4g17UUIzI3stqe8FsFjUeFnvb42guWKn8EQeInBiW9Ee4Y
	JRBhHamxlLf9bcM3WfYfkzRGAQ/3NBA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-XofPY518O7e8QPEJScQ0TQ-1; Tue,
 14 Oct 2025 04:07:10 -0400
X-MC-Unique: XofPY518O7e8QPEJScQ0TQ-1
X-Mimecast-MFC-AGG-ID: XofPY518O7e8QPEJScQ0TQ_1760429228
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF95D180045C;
	Tue, 14 Oct 2025 08:07:06 +0000 (UTC)
Received: from fedora (unknown [10.72.120.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D33F19560B8;
	Tue, 14 Oct 2025 08:06:58 +0000 (UTC)
Date: Tue, 14 Oct 2025 16:06:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai3@huawei.com>
Cc: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com,
	axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: Re: [PATCH 1/4] blk-mq-debugfs: warn about possible deadlock
Message-ID: <aO4EniFy63IlWM_-@fedora>
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <20251014022149.947800-2-yukuai3@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014022149.947800-2-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Oct 14, 2025 at 10:21:46AM +0800, Yu Kuai wrote:
> Creating new debugfs entries can trigger fs reclaim, hence we can't do
> this with queue freezed, meanwhile, other locks that can be held while
> queue is freezed should not be held as well.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-mq-debugfs.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 4896525b1c05..66864ed0b77f 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -608,9 +608,23 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
>  	{},
>  };
>  
> -static void debugfs_create_files(struct dentry *parent, void *data,
> +static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
> +				 void *data,
>  				 const struct blk_mq_debugfs_attr *attr)
>  {
> +	/*
> +	 * Creating new debugfs entries with queue freezed has the rist of
> +	 * deadlock.
> +	 */
> +	WARN_ON_ONCE(q->mq_freeze_depth != 0);
> +	/*
> +	 * debugfs_mutex should not be nested under other locks that can be
> +	 * grabbed while queue is freezed.
> +	 */
> +	lockdep_assert_not_held(&q->elevator_lock);
> +	lockdep_assert_not_held(&q->rq_qos_mutex);

->rq_qos_mutex use looks one real mess, in blk-cgroup.c, it is grabbed after
queue is frozen. However, inside block/blk-rq-qos.c, the two are re-ordered,
maybe we need to fix order between queue freeze and q->rq_qos_mutex first?
Or move on by removing the above line?

Otherwise, this patch looks good.


Thanks,
Ming


