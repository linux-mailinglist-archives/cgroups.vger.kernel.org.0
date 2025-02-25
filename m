Return-Path: <cgroups+bounces-6699-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36129A43270
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 02:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AC41899F05
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 01:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4272110E;
	Tue, 25 Feb 2025 01:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScLY6hTR"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE13209
	for <cgroups@vger.kernel.org>; Tue, 25 Feb 2025 01:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740446671; cv=none; b=WEQZqnxtlHpwWYR5KYTq9dCuzDV8NnRQoZvoVfNtev8Uxr+J6u2i1Odtk1IWUWIzzvTHxuOjR03vd6xcOge9l7/sgiAsJHohzGZZ98t3UNn0Yfv9xxcKNLvBGnJkAZD6TDH0M/z7BupvbmPoDqv7ifEBjsfa81hOI9J5FvDdY9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740446671; c=relaxed/simple;
	bh=OTRcGeU7kGGgXpTtQsUzKusjg93W/6CQSsMA/m9BSZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPuQ2GTzdAH1MRywQd1fekxBhKJCHIifKb7rsCb9V/dRAiQ4eSSqe1GfToNAfPBCJiZKYC+z/AWg1BO4Qk59nwgLUWOln4ZUiZsX7VA9F2ma+VHo32PqZBJhCwnEt2v+1fiD4dkiNb/Jn3wezH5LI83f+Z0s66DtW5TYAaMHJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ScLY6hTR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740446669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPoneJrfASluLO99cJQRqFmreizeALplyvR20fuKNPQ=;
	b=ScLY6hTRK06apXK02JFakysKy6AAJlONKk4OUV+3KAvz2f6BseKrPZLj92kF7JJdI31hce
	VyV6fglnMKrDs1siE22z4mIgjQ8uhDqr3Mt5iI1irtMdr++ni+0g69abJQwAeaaCBVC9yZ
	mW79HbM1i2lgVhEWY5+qZIseTeGaA34=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-z7RIGHkGMtyUfOBsf1quFg-1; Mon,
 24 Feb 2025 20:24:24 -0500
X-MC-Unique: z7RIGHkGMtyUfOBsf1quFg-1
X-Mimecast-MFC-AGG-ID: z7RIGHkGMtyUfOBsf1quFg_1740446663
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 024C8196E078;
	Tue, 25 Feb 2025 01:24:22 +0000 (UTC)
Received: from fedora (unknown [10.72.120.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E45AC180035E;
	Tue, 25 Feb 2025 01:24:13 +0000 (UTC)
Date: Tue, 25 Feb 2025 09:24:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/2] blk-throttle: fix off-by-one jiffies wait_time
Message-ID: <Z70btzRaN83FbTJp@fedora>
References: <20250222092823.210318-1-yukuai1@huaweicloud.com>
 <20250222092823.210318-3-yukuai1@huaweicloud.com>
 <Z7nAJSKGANoC0Glb@fedora>
 <f2f54206-b5c0-7486-d607-337d29e9c145@huaweicloud.com>
 <Z7vnTyk6Y6X4JWQB@fedora>
 <e6a29a6a-f5ec-7953-14e9-2550a549f955@huaweicloud.com>
 <Z7w0P8ImJiZhRsPD@fedora>
 <611f02a8-8430-16cf-46e5-e9417982b077@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <611f02a8-8430-16cf-46e5-e9417982b077@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Feb 24, 2025 at 08:03:32PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/02/24 16:56, Ming Lei 写道:
> > On Mon, Feb 24, 2025 at 03:03:18PM +0800, Yu Kuai wrote:
> > > Hi, Ming!
> > > 
> > > 在 2025/02/24 11:28, Ming Lei 写道:
> > > > throtl_trim_slice() returns immediately if throtl_slice_used()
> > > > is true.
> > > > 
> > > > And throtl_slice_used() checks jiffies in [start, end] via time_in_range(),
> > > > so if `start <= jiffies <= end', it still returns false.
> > > 
> > > Yes, I misread the code, by thinking throtl_slice_used() will return
> > > true if the slice is still used. :(
> > > 
> > > 
> > > > > BTW, throtl_trim_slice() looks like problematic:
> > > > > 
> > > > > -       if (bytes_trim <= 0 && io_trim <= 0)
> > > > > +       if (bytes_trim <= 0 || io_trim <= 0 ||
> > > > > +           tg->bytes_disp[rw] < bytes_trim || tg->io_disp[rw] < io_trim)
> > > > >                   return;
> > > > That is exactly what my patch is doing, just taking deviation and
> > > > timeout into account, also U64_MAX limit has to be excluded.
> > > Yes, perhaps you can add some comments in the last two conditions of
> > > your patch.
> > 
> > Yes, we need to add comment on the check, how about the following words?
> > 
> > ```
> > 
> > If actually rate doesn't match with expected rate, do not trim slice
> > otherwise the present rate control info is lost, we don't have chance
> > to compensate it in the following period of this slice any more.
> 
> So, I just give your patch a test, and result is 1.3s while 1s is
> expected. While debuging, a new idea come up in mind. :)
> 
> How about keep at least one slice out of consideration from
> throtl_trim_slice()? With following patch, the result is between
> 1.01-1.03s in my VM.

That is easy to get the same result with the approach I suggested,
another big benefit: it is adaptive, and blk-throttle may get
simplified.

> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 8d149aff9fd0..5207c85098a5 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -604,9 +604,12 @@ static inline void throtl_trim_slice(struct throtl_grp
> *tg, bool rw)
> 
>         time_elapsed = rounddown(jiffies - tg->slice_start[rw],
>                                  tg->td->throtl_slice);
> -       if (!time_elapsed)
> +       /* don't trim slice until at least 2 slice is used */
> +       if (time_elapsed < tg->td->throtl_slice * 2)
>                 return;

If you just want to fix throtl/001, the above patch might
work(sometimes, it might not, and timer may expire by 2 jiffies), but it
is easy to fail other tests, such as, reduce the bps limit a bit, and
increase BS a bit to make the IO cross exactly two slices.

Also the big question is that how you can make sure that rate is always
good when the window is >= 2 slice?


Thanks,
Ming


