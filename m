Return-Path: <cgroups+bounces-6653-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD414A417F8
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 09:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DACC1894DF3
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F43B242916;
	Mon, 24 Feb 2025 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLFAt6s/"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389DC241CA6
	for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387414; cv=none; b=Z8mVvvXDAP+vBllb0is8fNRp8RsBvhoqn3uaKYMxfopd1SK/otUm2qNY0IvWLL8m46VJvRSOYGPVJkwsn5nB7MeZCA+ladlHhRk9+toXMvlACXGI1prvdtGssddnOArD4j+q5rCu/t62NsS5OEYP+Ij72JoSPskPsuIXImzaTp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387414; c=relaxed/simple;
	bh=xq0dUbIsObricEpN11IBCCHbKywJQ6xYZeXU20Lj/+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqYHfgJX7R7LGqo45uoSeXt6gLvHbM01a1xCwYOdIOkwWbpgFcd8kz6zqDMlhCSP78NzICuFlsw3ekAkT09adNIXogebEGNt44mZUno5DKsa178eAP9r32AL6kL//a05bGH05DdD3GmqAmq9TZLzUaZLWltZbXPZ8X1aXB6Ijas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLFAt6s/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740387412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIqgti8JhQLr3gDPSlEgz2+yjZL8zWhP7BiX1sRX38w=;
	b=SLFAt6s/1JuE7UtCkDY9nwp5gjG5G+7IoyQFguB0pklt39jfzgR6hdQgPf1T5C8dMj5qj9
	5/jyfjwqS5Ej80x9aBsSwv3R5Phc5Jm6R7K8AAtWZ7WMAPd52dq63Ro9jQuRTHHfBzR5bB
	Zil6N3GpebesH8oWQHmWXgKgq6lTs0Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-OwCJXigTMgC20E-ONEoOvA-1; Mon,
 24 Feb 2025 03:56:48 -0500
X-MC-Unique: OwCJXigTMgC20E-ONEoOvA-1
X-Mimecast-MFC-AGG-ID: OwCJXigTMgC20E-ONEoOvA_1740387407
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31E171800871;
	Mon, 24 Feb 2025 08:56:46 +0000 (UTC)
Received: from fedora (unknown [10.72.120.33])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D38351800358;
	Mon, 24 Feb 2025 08:56:37 +0000 (UTC)
Date: Mon, 24 Feb 2025 16:56:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/2] blk-throttle: fix off-by-one jiffies wait_time
Message-ID: <Z7w0P8ImJiZhRsPD@fedora>
References: <20250222092823.210318-1-yukuai1@huaweicloud.com>
 <20250222092823.210318-3-yukuai1@huaweicloud.com>
 <Z7nAJSKGANoC0Glb@fedora>
 <f2f54206-b5c0-7486-d607-337d29e9c145@huaweicloud.com>
 <Z7vnTyk6Y6X4JWQB@fedora>
 <e6a29a6a-f5ec-7953-14e9-2550a549f955@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6a29a6a-f5ec-7953-14e9-2550a549f955@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Feb 24, 2025 at 03:03:18PM +0800, Yu Kuai wrote:
> Hi, Ming!
> 
> 在 2025/02/24 11:28, Ming Lei 写道:
> > throtl_trim_slice() returns immediately if throtl_slice_used()
> > is true.
> > 
> > And throtl_slice_used() checks jiffies in [start, end] via time_in_range(),
> > so if `start <= jiffies <= end', it still returns false.
> 
> Yes, I misread the code, by thinking throtl_slice_used() will return
> true if the slice is still used. :(
> 
> 
> > > BTW, throtl_trim_slice() looks like problematic:
> > > 
> > > -       if (bytes_trim <= 0 && io_trim <= 0)
> > > +       if (bytes_trim <= 0 || io_trim <= 0 ||
> > > +           tg->bytes_disp[rw] < bytes_trim || tg->io_disp[rw] < io_trim)
> > >                  return;
> > That is exactly what my patch is doing, just taking deviation and
> > timeout into account, also U64_MAX limit has to be excluded.
> Yes, perhaps you can add some comments in the last two conditions of
> your patch.

Yes, we need to add comment on the check, how about the following words?

```

If actually rate doesn't match with expected rate, do not trim slice
otherwise the present rate control info is lost, we don't have chance
to compensate it in the following period of this slice any more.

Add one deviation threshold since bio size is usually not divisible by
present rate, and bio dispatch should be done or nothing

Also limit max slice size for avoiding to extend the window too big.

```


> I think maybe you're concerned about the case IO is
> throttled by IOs and bytes_disp should really erase extra bytes that
> does not reach bps_limit.
> 
> > 
> > If you test the patch, it works just fine. My patch controls bytes_exp
> > <= 1.5 * disp, then throtl/001 can be completed in 1.5sec, and if it is
> > changed to 1.25 * disp, the test can be completed in 1.25sec.
> > 
> > With this fix, why do we have to play the complicated carryover
> > trick?
> > 
> 
> I understand your code now. carryover_bytes in this case is wrong, as
> long as new slice is not started, and trim slice doesn't erase extra
> bytes by mistake, throttle time should be accurate over time because
> bytes_disp is accurate.

Yes.

More or less wait for handling single bio can just affect instantaneous rate,
but the algorithm is adaptive so it can adjust the following wait if the
slice isn't over.

> 
> And root cause really is throtl_trim_slice().
> 
> However, by code review, I think throtl_start_new_slice() should be
> handled as well, the same as throtl_trim_slice(), if the old bio is
> dispatched with one more jiffies wait time, issue a new bio in the same
> jiffies will have the same problem. For example:

throtl_start_new_slice() is called when nothing is queued and the current
slice is used, so probably it is fine.

throtl_start_new_slice_with_credit() is called when dispatching one
bio, and it is still called when the current slice is used.

> 
> Caller do sync IO, with io size: (bps_limit / (HZ / throtl_slice) + 1),

This will cause wait for every single IO.

But once the IO is throttled because of the wait, throtl_start_new_slice()
won't succeed any more, meantime throtl_trim_slice() will try to fix the
rate control for the extra 1 jiffies.

So in-tree code with trim fix works just fine if consecutive IOs are
coming.

> and caller will issue new IO when old IO is done. Then in this case,
> each IO will start a new slice and wait for throtl_slice + 1 jiffies. I
> believe this can be fixed as well so that BIOs after the first one will
> only wait for throtl_silce jiffies.

I guess the above case only exists in theory when you submit new IO
after the old IO is dispatched immediately. Not sure this case is really
meaningful because submission period/latency is added/faked by user.


Thanks,
Ming


