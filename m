Return-Path: <cgroups+bounces-6935-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 536ABA59A69
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 16:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31011887F36
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AF222DF82;
	Mon, 10 Mar 2025 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+JO9rRx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB9B22D4FA;
	Mon, 10 Mar 2025 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621990; cv=none; b=QMQYP0IigkW4A9/+iHAXJsHrGdSun86Hr3p2rHup1P+eM19kLWJaz1+0J+fVt48zubgk0+1TiUdsEKa8n3053YQGicncWbl7ufvib6kL6B+lyitbOWLoBXoZzdrUC6zdGcmTnRlVmWmG9o5ZPtPqF+e5ZB2996S/C06CUScdSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621990; c=relaxed/simple;
	bh=lF26eElOXDYH/1khOX1IrCW3xye3zUD/CDg2PngBW/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vr6ZdDHz5OSnmWvwnuP6UBI+LYFaiNWvPH3rqdOCxnp8Sn8y3W7Emkbg+faJ1ZHVVgWnbQhUsTApuCmEUACR6NzEwGQD7B3rOEjSbmEO69DQh85BSSg26/TmODhaY2JgGTrVhTmZE/Dd7+rWZ4X2aZlowUgUMB2/9STG5IO2Tzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+JO9rRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F075EC4CEE5;
	Mon, 10 Mar 2025 15:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741621990;
	bh=lF26eElOXDYH/1khOX1IrCW3xye3zUD/CDg2PngBW/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+JO9rRxtkmYaGaHJDRS7E29d8BwLm6Gn/E50rKjFZ3W4z4QYk/MUej5oLO66CKYf
	 2kMXYwxLLlXioUBj7eh5nksizl7e1M9+GGHYfrBVwI6NsPl3Su9LUaEgfto6m6qLhG
	 dgz9RB0/l7h0j1OmyrRowVVCUzVF8LwN41EJ6cxE4FGN7blfu0k2hwO7Ty84Mmldly
	 /e1aopSSKnjHRD20V62S0rbk9qYSuSGax9LsioBF0bliEY4QAmeReXqFtYFNgJgx9h
	 FmIQeOYC/PSkCZiD9ys52yb4fBsWECZmbbgqwtRDQearMEJ2F49fxms+ce9t+KW7S3
	 0F5nPJXR6SdOw==
Date: Mon, 10 Mar 2025 05:53:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
	josef@toxicpanda.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] blk-throttle: support io merge over iops_limit
Message-ID: <Z88K5JtR4rhhIFsY@slm.duckdns.org>
References: <20250307090152.4095551-1-yukuai1@huaweicloud.com>
 <Z8sZyElaHQQwKqpB@slm.duckdns.org>
 <5fc124c9-e202-99ca-418d-0f52d027640f@huaweicloud.com>
 <Z85LjhvkCzlqBVZy@fedora>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z85LjhvkCzlqBVZy@fedora>

Hello,

On Mon, Mar 10, 2025 at 10:16:46AM +0800, Ming Lei wrote:
...
> > Yes, but it's a litter hard to explain to users the differece between IO
> > split and IO merge, they just think IO split is the numer of IOs issued
> > to disk, and IO merge is the number of IOs issued from user.
> 
> Here it is really one trouble.
> 
> a) Sometimes people think IOs wrt. IOPS means that the read/write IO
> submitted from application, one typical example is `fio`.
> 
> b) Sometimes people think it is the data observed from `iostat`.
> 
> In a), io merge/split isn't taken into account, but b) does cover io
> merge and split.
> 
> So question is that what is the correct way for user to observe IOPS
> wrt. iops throttle?

If we could go back in time, I think the right metric to use is
hardware-seen IOPS as that's better correlated with the actual capacity
available (the correlation is very flawed but still better) and the number
of issued bio's can easily change depending on kernel implementation
details.

That said, I'm not sure about changing the behavior now. blk-throtl has
mostly used the number of bios as long as it has existed and given that
there can be a signficant difference between the two metrics, I'm not sure
the change is justified at this point.

Thanks.

-- 
tejun

