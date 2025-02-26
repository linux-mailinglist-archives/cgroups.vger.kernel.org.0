Return-Path: <cgroups+bounces-6720-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E35A45BE4
	for <lists+cgroups@lfdr.de>; Wed, 26 Feb 2025 11:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EE51888D17
	for <lists+cgroups@lfdr.de>; Wed, 26 Feb 2025 10:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDF623815B;
	Wed, 26 Feb 2025 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOj13tc0"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D98B258CE0
	for <cgroups@vger.kernel.org>; Wed, 26 Feb 2025 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566075; cv=none; b=RUIrdOGd9ZubHdN49TZP0Iskmv3HYCx26SMwKqVQyr6eTIH0xLzhf0/MppOAwLNWnpwviT8bmEMJGFRRLnMCFIuz1DzPsw5J5ol0yZ5ahadXa2eKW+LJs1fINtSlWbJ+UUf3F7XL0LAz1wvXDtPS4ogIkdkYsBQobIFOwphVKms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566075; c=relaxed/simple;
	bh=ZwpbPAQDpfXXvC5bnx73RX9l87tEewCgIZFh7VoRISw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7+HYsUXcNpIdsde5jyqOBE+UsiyORzE78YgtZZQtoYVRDyPTvt4FsliM+0licztjYgL4yFud1OGpzRMxl4tJeGZuC+dHD5Uyrh4WWs+CdlO9ZXSJKKyd06wFPAp/3rkF3JcPKfQmzb1DgpahKEhXYY2TUVMv4Gqf6Eatijn/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOj13tc0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740566070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gFsFyW0JsFOyjdFU+q14/lZqV9kDgAqshzcYwesYMoE=;
	b=WOj13tc0pDCtAxGu9YgX+NM3u0dhMNAOYE7gRtSABvhY/rxuC6FG3u2U0r+4V5Q9pjIr0m
	ZnRLq+4O5ysgVALQzNfsEo0hecPHmqhnwlYdp/olchMYXalKp7h9rEY8vA4X3nRYVOoVcM
	f5hRii30klYo61bzTAW57Xh8kmhp6CA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-LTsIioOaPd6vuHmT1PKl7Q-1; Wed,
 26 Feb 2025 05:34:26 -0500
X-MC-Unique: LTsIioOaPd6vuHmT1PKl7Q-1
X-Mimecast-MFC-AGG-ID: LTsIioOaPd6vuHmT1PKl7Q_1740566063
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C33C91800875;
	Wed, 26 Feb 2025 10:34:22 +0000 (UTC)
Received: from fedora (unknown [10.72.120.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 685D8300018D;
	Wed, 26 Feb 2025 10:34:13 +0000 (UTC)
Date: Wed, 26 Feb 2025 18:34:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, vgoyal@redhat.com,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] blk-throttle: fix lower bps rate by throtl_trim_slice()
Message-ID: <Z77uID36yIvWDQEj@fedora>
References: <20250226011627.242912-1-yukuai1@huaweicloud.com>
 <Z77R_rqgDdAvFVgP@fedora>
 <021e6495-11e5-3b39-2786-d69cc4bf24f7@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <021e6495-11e5-3b39-2786-d69cc4bf24f7@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Feb 26, 2025 at 05:56:03PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/02/26 16:34, Ming Lei 写道:
> > On Wed, Feb 26, 2025 at 09:16:27AM +0800, Yu Kuai wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > The bio submission time may be a few jiffies more than the expected
> > > waiting time, due to 'extra_bytes' can't be divided in
> > > tg_within_bps_limit(), and also due to timer wakeup delay. In this
> > > case, adjust slice_start to jiffies will discard the extra wait time,
> > > causing lower rate than expected.
> > > 
> > > This problem will cause blktests throtl/001 failure in case of
> > > CONFIG_HZ_100=y, fix it by preserving one finished slice in
> > > throtl_trim_slice() and allowing deviation between [0, 2 slices).
> > 
> > I think it only can cover single default slice deviation, since
> > throtl_trim_slice() just keeps dispatch data in the previous single
> > default slice. Or can you add words on how to allow 2 default slices
> > deviation?
> > 
> > > 
> > > For example, assume bps_limit is 1000bytes, 1 jiffes is 10ms, and
> > > slice is 20ms(2 jiffies), expected rate is 1000 / 1000 * 20 = 20 bytes
> > > per slice.
> > > 
> > > If user issues two 21 bytes IO, then wait time will be 30ms for the
> > > first IO:
> > > 
> > > bytes_allowed = 20, extra_bytes = 1;
> > > jiffy_wait = 1 + 2 = 3 jiffies
> > > 
> > > and consider
> > > extra 1 jiffies by timer, throtl_trim_slice() will be called at:
> > > 
> > > jiffies = 40ms
> > > slice_start = 0ms, slice_end= 40ms
> > > bytes_disp = 21
> > > 
> > > In this case, before the patch, real rate in the first two slices is
> > > 10.5 bytes per slice, and slice will be updated to:
> > > 
> > > jiffies = 40ms
> > > slice_start = 40ms, slice_end = 60ms,
> > > bytes_disp = 0;
> > > 
> > > Hence the second IO will have to wait another 30ms;
> > > 
> > > With the patch, the real rate in the first slice is 20 bytes per slice,
> > > which is the same as expected, and slice will be updated:
> > > 
> > > jiffies=40ms,
> > > slice_start = 20ms, slice_end = 60ms,
> > > bytes_disp = 1;
> > > 
> > > And now, there is still 19 bytes allowed in the second slice, and the
> > > second IO will only have to wait 10ms;
> > > 
> > > Fixes: e43473b7f223 ("blkio: Core implementation of throttle policy")
> > > Reported-by: Ming Lei <ming.lei@redhat.com>
> > > Closes: https://lore.kernel.org/linux-block/20250222092823.210318-3-yukuai1@huaweicloud.com/
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > ---
> > >   block/blk-throttle.c | 13 +++++++++++--
> > >   1 file changed, 11 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > > index 8d149aff9fd0..cb472cf7b6b6 100644
> > > --- a/block/blk-throttle.c
> > > +++ b/block/blk-throttle.c
> > > @@ -599,14 +599,23 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
> > >   	 * sooner, then we need to reduce slice_end. A high bogus slice_end
> > >   	 * is bad because it does not allow new slice to start.
> > >   	 */
> > > -
> > >   	throtl_set_slice_end(tg, rw, jiffies + tg->td->throtl_slice);
> > >   	time_elapsed = rounddown(jiffies - tg->slice_start[rw],
> > >   				 tg->td->throtl_slice);
> > > -	if (!time_elapsed)
> > > +	/* Don't trim slice until at least 2 slices are used */
> > > +	if (time_elapsed < tg->td->throtl_slice * 2)
> > >   		return;
> > > +	/*
> > > +	 * The bio submission time may be a few jiffies more than the expected
> > > +	 * waiting time, due to 'extra_bytes' can't be divided in
> > > +	 * tg_within_bps_limit(), and also due to timer wakeup delay. In this
> > > +	 * case, adjust slice_start to jiffies will discard the extra wait time,
> > > +	 * causing lower rate than expected. Therefore, one slice is preserved,
> > > +	 * allowing deviation that is less than two slices.
> > > +	 */
> > > +	time_elapsed -= tg->td->throtl_slice;
> > 
> > Please document that default slice window size is doubled actually in
> > this way.
> 
> I said two slices because there is a round down:
> 
> >>   	time_elapsed = rounddown(jiffies - tg->slice_start[rw],
> >>   				 tg->td->throtl_slice);
> 
> Hence the deviation is actually between [1 ,2) jiffies, depends on the
> time start to wait and how long the delay is.
> 
> If start to wait at slice_start + n * throtl_slice - 1, the deviation is
> *at most 1 slice*
> 
> If start to wait at slice_stat + n * throtl_slice, the max deviation is
> *less than 2 slices* (2 slices not included)
> 
> Now, I agree allowing deviation at most 1 slice is more appropriate. :)

Actually the in-tree code already covers deviation from the rounddown(),
but turns out it is still not enough, so this patch increases one extra
def slice size. With this thing is documented, feel free to add:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


