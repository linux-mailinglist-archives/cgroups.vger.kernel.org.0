Return-Path: <cgroups+bounces-5033-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C85498F8D1
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 23:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42BFD1C21B94
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 21:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870C51AF4EF;
	Thu,  3 Oct 2024 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0I1mRUr"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B048748D;
	Thu,  3 Oct 2024 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990531; cv=none; b=FO+Vz8Khi0D+XhBE60jZXFqbIiL3XqZOfgNUk3Jk8jbqt5+wORjXRSVWxR7THbXbSlOvCtixvW69phmYjypkQKBmnWztw2Nuukc+KZW4mS4uDKJIQNNEJG7yMw2WFl+HZoNKyQVEYwjqN1nAebF7aG+shm13lBYoGBjdNxVEpu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990531; c=relaxed/simple;
	bh=myhzGuyZHVPOOzMuS6ujT2baNB9f6+kd036ZBWUO22w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTX+R8tFm4Iwppk+SyphxuOSzpNO0wpAJR4bgmdHr83l1KIx1EGZhCe1pk9J+WcZTfvRQLlf5AYO6tz+38/y8iS7Yox6SIyQ9sDCIG1ASLVa5MbuPTz29GYhgm/Zj4kAj2fGZsSUqbCaLJMd3etWlCL3mkGnTpwpfBy6avuVUOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0I1mRUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20A5C4CEC5;
	Thu,  3 Oct 2024 21:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727990530;
	bh=myhzGuyZHVPOOzMuS6ujT2baNB9f6+kd036ZBWUO22w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I0I1mRUrF5WQkvwsAwVjK9ucFIwj5abD5OgkBMlmN2ZR9Bh/8XJmH57i8lhGObRmZ
	 8jpYcPk9QY9ueQxrG91roKLdbr4KmbuVUKqGFa7m+qxwCS7Bhq6X4S/ZtvUQ4VN+aE
	 4nLTSPEfDBL6c39CxmVNRLEZNauzDtpI1EQQw7Fy5HLJNs3Y25EqgWYK4bT1nGTtWN
	 JdOd4u/351RIawkJii/27WI91Hr1O73Tg53NJQn8qacOwyGHahaGErmgMuP7UeDch4
	 ZTTHr3WMx69jM6xzIKRAxHzvGvJ5VB+ZGjNwxZKGDQL9jspF9IuC/BI8IEbjWEFp0+
	 HiFVa10GeHE1g==
Date: Thu, 3 Oct 2024 11:22:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Waiman Long <longman@redhat.com>, Yu Kuai <yukuai3@huawei.com>,
	Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq disable/enables
Message-ID: <Zv8LAaeuJQkvscWF@slm.duckdns.org>
References: <Zv0kudA9xyGdaA4g@stanley.mountain>
 <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>
 <925f3337-cf9b-4dc1-87ea-f1e63168fbc4@stanley.mountain>
 <df1cc7cb-bac6-4ec2-b148-0260654cc59a@redhat.com>
 <3083c357-9684-45d3-a9c7-2cd2912275a1@stanley.mountain>
 <fe7ce685-f7e3-4963-a0d3-b992354ea1d8@kernel.dk>
 <68f3e5f8-895e-416b-88cf-284a263bd954@stanley.mountain>
 <c26e5b36-d369-4353-a5a8-9c9b381ce239@kernel.dk>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c26e5b36-d369-4353-a5a8-9c9b381ce239@kernel.dk>

Hello,

On Thu, Oct 03, 2024 at 08:38:48AM -0600, Jens Axboe wrote:
...
> >>>   3144          spin_lock(&iocg->ioc->lock);
> >>>
> >>> But why is this not spin_lock_irq()?  I haven't analyzed this so maybe it's
> >>> fine.
> >>
> >> That's a bug.
> >>
> > 
> > I could obviously write this patch but I feel stupid writing the
> > commit message. My level of understanding is Monkey See Monkey do.
> > Could you take care of this?
> 
> Sure - or let's add Tejun who knows this code better. Ah he's already
> added. Tejun?

Yeah, that should be spin_lock_irq() for consistency but at the same time it
doesn't look like anything is actually grabbing that lock (or blkcg->lock
nesting outside of it) from an IRQ context, so no actual deadlock scenario
exists and lockdep doesn't trigger.

> > So somewhere we're taking a lock in the IRQ handler and this can lead
> > to a deadlock? I thought this would have been caught by lockdep?
> 
> It's nested inside blkcg->lock which is IRQ safe, that is enough. But
> doing a quick scan of the file, the usage is definitely (widly)
> inconsistent. Most times ioc->lock is grabbed disabling interrupts, but

Hmm... the only place I see is the one Dan pointed out.

> there are also uses that doesn't disable interrupts, coming from things
> like seq_file show paths which certainly look like they need it. lockdep
> should certainly warn about this, only explanation I have is that nobody
> bothered to do that :-)

The locks are intended to be IRQ-safe but it looks like they don't need to
be at least for now. I'll send a patch to update the ioc_weight_write()
pair.

Thanks.

-- 
tejun

