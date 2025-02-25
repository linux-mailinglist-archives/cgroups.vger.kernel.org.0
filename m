Return-Path: <cgroups+bounces-6703-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F98A43792
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 09:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3DF189CC97
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 08:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005F119342E;
	Tue, 25 Feb 2025 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFC5HBQd"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3249D257441
	for <cgroups@vger.kernel.org>; Tue, 25 Feb 2025 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740471708; cv=none; b=Ad2W5Bi9IRXGUdryaUIStPnW84W0/DNmTA71kmSm3sJSb8Kh0eIECeQSYnT4eqToZ/XYcirOqxEjNEKs9/Vfex2gkwCEjgBS3tUvXKsgeX8VtldVamo915sAKGHgo3MW571bCCLmknRgHoKnngxfCjaSHJr1hlOSsbj0f9HvLGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740471708; c=relaxed/simple;
	bh=6LbLbk2Hi/cJhAyDERiL/9BQ/9IckNqbv1Bsg0nAn0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfvDnj7RLQhp5myvPpUNopY5StMFylBF+SBvIkxc0v4Wo8E2U2DaNPipvdH2qdlyQcmZcDdJrsBLdj92+qqs9ou0KXqZ6UlobOqPd1FIi1Vyg5bz3f3MZ/wA5N64UYKx4hUmDhcaRmOudha++7imOglY0GpFms6Cmq7TrNwu+DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFC5HBQd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740471706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JGVEBgr6yIICt4OFYjSxGo52A+94TcAFJZUxRZ8kPXw=;
	b=UFC5HBQdSV2OnuZ/6DM7oNkMATWNyCEYWPoufNXobVrlJwuFVupbLEHk4YhmkbDW8OTwlj
	kwnheHv6GhWS7M+NcgU0ZFVZzx/4DWn9Ah6sh63l3vU/qmCSylvN5Nl6nZqwQeZrrsrnFL
	h4kW+ovKVDDah87VytYe5IUfMxRSvVk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-V37hrS02P2u-zcID8-HCQw-1; Tue,
 25 Feb 2025 03:21:39 -0500
X-MC-Unique: V37hrS02P2u-zcID8-HCQw-1
X-Mimecast-MFC-AGG-ID: V37hrS02P2u-zcID8-HCQw_1740471697
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AC4C18EB2C3;
	Tue, 25 Feb 2025 08:21:36 +0000 (UTC)
Received: from fedora (unknown [10.72.120.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F6B01800358;
	Tue, 25 Feb 2025 08:21:27 +0000 (UTC)
Date: Tue, 25 Feb 2025 16:21:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/2] blk-throttle: fix off-by-one jiffies wait_time
Message-ID: <Z719gj8GOl0itRwV@fedora>
References: <Z7nAJSKGANoC0Glb@fedora>
 <f2f54206-b5c0-7486-d607-337d29e9c145@huaweicloud.com>
 <Z7vnTyk6Y6X4JWQB@fedora>
 <e6a29a6a-f5ec-7953-14e9-2550a549f955@huaweicloud.com>
 <Z7w0P8ImJiZhRsPD@fedora>
 <611f02a8-8430-16cf-46e5-e9417982b077@huaweicloud.com>
 <Z70btzRaN83FbTJp@fedora>
 <8473fca2-16ab-b2a6-ede7-d1449aa7d463@huaweicloud.com>
 <Z70qvZEBdq6L3-Yb@fedora>
 <084e25a1-5ed7-3097-5bae-b87addeaf01f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <084e25a1-5ed7-3097-5bae-b87addeaf01f@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Feb 25, 2025 at 11:12:24AM +0800, Yu Kuai wrote:
> Hi, Ming!
> 
> 在 2025/02/25 10:28, Ming Lei 写道:
> > Can you explain in details why it signals that the rate is expected now?
> > 
> > If rate isn't expected, it will cause trouble to trim, even just the
> > previous part.
> 
> Ok, for example, assume bps_limit is 1000bytes, 1 jiffes is 10ms, and
> slice is 20ms(2 jiffies).
> 

We all know how it works, but I didn't understand the behind idea why it
is correct. Now I figured it out: 

1) increase default slice window to 2 * td->throttle_slice

2) slice window is set as [jiffies - td->throttle_slice, jiffies + td->throttle_slice]

3) initialize td->bytes_disp[]/td->io_dis[] as actual dispatched bytes/ios
done [jiffies - td->throttle_slice, 0]

This approach looks smart, and it should work well for any deviation which is <= 1
throttle_slice.

Probably it is enough for fixing the issue in throtl/001, even though 2 jiffies
timer drift still may be observed, see the below log collected in my VM(HZ_100)
by just running one time of blktests './check throtl':

@timer_expire_delay:
[1, 2)               387 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[2, 3)                11 |@                                                   |

bpftrace -e 'kfunc:throtl_pending_timer_fn { @timer_expire_delay = lhist(jiffies - args->t->expires, 0, 16, 1);}'


Also I'd suggest to remove ->carryover_bytes/ios since blk-throttle algorithm is
supposed to be adaptive, and the approach I suggested may cover this area,
what do you think of this cleanup? I have one local patchset, which can
pass all blktest throtl tests with removing ->carryover_bytes/ios.



Thanks,
Ming


