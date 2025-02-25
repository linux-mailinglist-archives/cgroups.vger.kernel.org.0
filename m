Return-Path: <cgroups+bounces-6710-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F97AA43EB4
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 13:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734ED3B2B99
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62D4268692;
	Tue, 25 Feb 2025 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/REEnBX"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBAD267F46
	for <cgroups@vger.kernel.org>; Tue, 25 Feb 2025 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484827; cv=none; b=sOoMN8BQ8MQnB9BxiKxRyjlMR4Km53mkpfEjT7Gsg54yp5kZ1PkbWg8qIircEK+M8NYeIYvW8VDu5MXwEJgh9+xpXZIm2N8Fh5MbPXwVCS536DpfomMiXGfgXCrPQV7cdcYCMqBK3vRQ82kRxdROzrMaQZQk0ZYaXwak7pXLeTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484827; c=relaxed/simple;
	bh=Vl3YJ7NZKaOS7tm3cHbI+ad4q0uOHnev1jlszYmFH8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+ppiV8SPpPZK/8Gexo/3zThjBcNwxOBRjZa5cYfpT3frWHRYrubFtNmCsbCzPy8qyBYVDoDWc6QqRujfT9/Z7Fz3usK5dsZTRe6U+7KYDEzsFDRMHot+7fYhyQeGJLDexjdKvqq6gH6A+kGLJ0RvJ8KlDqE/WzN2BQCQCURIsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/REEnBX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740484824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0gU6eM4HHU/IeYFpUt81mKnAbJ6+bXQSqYVXAmQ0M0=;
	b=F/REEnBXKibFfRbF+r8wazTQvGz4soYecYhPnCOzsSQ7zE0oTh7XsUHrEdHaPFES9ooD3v
	Ewyk+5/cke4VFgia3VQG7OQJqKodzj2olaiAfapAgpQWpIvgEzwkucZOD7woWSLRu4GP7X
	aZ+lPCXO3YKhfqpNnAh13q+hgzKDUCw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-QbAXr5rKNfmpAFoLk17z5w-1; Tue,
 25 Feb 2025 07:00:19 -0500
X-MC-Unique: QbAXr5rKNfmpAFoLk17z5w-1
X-Mimecast-MFC-AGG-ID: QbAXr5rKNfmpAFoLk17z5w_1740484817
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67A2919560AF;
	Tue, 25 Feb 2025 12:00:16 +0000 (UTC)
Received: from fedora (unknown [10.72.120.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67D24180035E;
	Tue, 25 Feb 2025 12:00:08 +0000 (UTC)
Date: Tue, 25 Feb 2025 20:00:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/2] blk-throttle: fix off-by-one jiffies wait_time
Message-ID: <Z72ww9f8MCSqiTy0@fedora>
References: <Z7vnTyk6Y6X4JWQB@fedora>
 <e6a29a6a-f5ec-7953-14e9-2550a549f955@huaweicloud.com>
 <Z7w0P8ImJiZhRsPD@fedora>
 <611f02a8-8430-16cf-46e5-e9417982b077@huaweicloud.com>
 <Z70btzRaN83FbTJp@fedora>
 <8473fca2-16ab-b2a6-ede7-d1449aa7d463@huaweicloud.com>
 <Z70qvZEBdq6L3-Yb@fedora>
 <084e25a1-5ed7-3097-5bae-b87addeaf01f@huaweicloud.com>
 <Z719gj8GOl0itRwV@fedora>
 <dc2b3a40-b33b-0bc5-3a73-18b288b4283f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc2b3a40-b33b-0bc5-3a73-18b288b4283f@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Feb 25, 2025 at 07:09:30PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/02/25 16:21, Ming Lei 写道:
> > On Tue, Feb 25, 2025 at 11:12:24AM +0800, Yu Kuai wrote:
> > > Hi, Ming!
> > > 
> > > 在 2025/02/25 10:28, Ming Lei 写道:
> > > > Can you explain in details why it signals that the rate is expected now?
> > > > 
> > > > If rate isn't expected, it will cause trouble to trim, even just the
> > > > previous part.
> > > 
> > > Ok, for example, assume bps_limit is 1000bytes, 1 jiffes is 10ms, and
> > > slice is 20ms(2 jiffies).
> > > 
> > 
> > We all know how it works, but I didn't understand the behind idea why it
> > is correct. Now I figured it out:
> > 
> > 1) increase default slice window to 2 * td->throttle_slice
> > 
> > 2) slice window is set as [jiffies - td->throttle_slice, jiffies + td->throttle_slice]
> > 
> > 3) initialize td->bytes_disp[]/td->io_dis[] as actual dispatched bytes/ios
> > done [jiffies - td->throttle_slice, 0]
> > 
> > This approach looks smart, and it should work well for any deviation which is <= 1
> > throttle_slice.
> > 
> > Probably it is enough for fixing the issue in throtl/001, even though 2 jiffies
> > timer drift still may be observed, see the below log collected in my VM(HZ_100)
> > by just running one time of blktests './check throtl':
> > 
> > @timer_expire_delay:
> > [1, 2)               387 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > [2, 3)                11 |@                                                   |
> > 
> > bpftrace -e 'kfunc:throtl_pending_timer_fn { @timer_expire_delay = lhist(jiffies - args->t->expires, 0, 16, 1);}'
> > 
> > 
> > Also I'd suggest to remove ->carryover_bytes/ios since blk-throttle algorithm is
> > supposed to be adaptive, and the approach I suggested may cover this area,
> > what do you think of this cleanup? I have one local patchset, which can
> > pass all blktest throtl tests with removing ->carryover_bytes/ios.
> > 
> 
> It's always welcome for such cleanup. BTW, do you have plans to support
> bio merge for iops limit in blk-throttle?
> Since bio split is handled. I
> was thinking about using carryover_ios, perhaps you can handle this as
> well.

I don't know the two problems.

Let's focus on fixing throtl/001 first.

I raised the cleanup on carryover_ios because the fix I proposed in [1]
may help to cover carryover_ios too.

But I guess your patch of doubling splice window is better for fixing
throtl/001, can you send a formal patch with comment for fixing this
issue first?


[1] https://lore.kernel.org/linux-block/Z7nAJSKGANoC0Glb@fedora/



Thanks,
Ming


