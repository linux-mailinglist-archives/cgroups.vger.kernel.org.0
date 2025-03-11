Return-Path: <cgroups+bounces-6992-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DC5A5CF7E
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 20:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0909E18899E4
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 19:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40162263F49;
	Tue, 11 Mar 2025 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlsVUps8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6D17591;
	Tue, 11 Mar 2025 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721661; cv=none; b=WUrvzCtC+sH8NGZqLE5F/yfm/5LxmYTd5wGey46j20E5zVDEii2SqB6Lqdc8pIsxrdEPEaykVTvM+b5teVMAD4mEUlKS8t+Zojriiu/ebcq0glnbPYhaLRkSkt3JXsI2R5jA9pdwSnmw7cNBVXpIdFKUJQWPPiX56poXJbND80Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721661; c=relaxed/simple;
	bh=p87FX0SnpPxZ9l1ZBDNa6QJprc90RiIs0UOFXGZGDxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKCF8Ga4tJWNW9LyOFMe7HjZvSglD3uG4JOA4VQS2yuKW0LNU/wXcSK3cL0/Cyf4g3n6HSIU8dfQnJhYLEFj3ynJ9LzFUK9VzyTM+tBRrSW10d8MXQ3pc46c7SlDTUHb+gwA7rJwmjDHasJzn9ZWj/KrH6DpQgQbjTkczOiPib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlsVUps8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C8FC4CEE9;
	Tue, 11 Mar 2025 19:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741721659;
	bh=p87FX0SnpPxZ9l1ZBDNa6QJprc90RiIs0UOFXGZGDxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OlsVUps8vrLIXM3DGWSr6KQfKDIbTTZV/i2KsDQ5w74YasGSAPZHdgYEGSpXG6eoI
	 AaFU3I652y/uAms2zTuP9rNq3cMsg+a4jnD/fZw9AZ3QhXuOGTUkSZ6fRhZWpENM8l
	 XpgfnHMC9vuPV1u8s+qXmCpY7hxwCWPOQPKXz/G2SteMk0H3kP+NraT4IL3ZkI++Qm
	 exbdtkzmMl1Uw9ylgaCthmVlxvVTYqeYG+yGeZwjjm3HzBEj21QN8nM5C2E3FVda8m
	 X+gGPUbFzXnM3FB+7pfM8uoucLf6jKBZzdHqHjNHxIP4G3sahe5GqbR4+G71yUk+Pz
	 Rt01Cw+xFgd2A==
Date: Tue, 11 Mar 2025 09:34:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, josef@toxicpanda.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] blk-throttle: support io merge over iops_limit
Message-ID: <Z9CQOuJA-bo4xZkH@slm.duckdns.org>
References: <20250307090152.4095551-1-yukuai1@huaweicloud.com>
 <Z8sZyElaHQQwKqpB@slm.duckdns.org>
 <5fc124c9-e202-99ca-418d-0f52d027640f@huaweicloud.com>
 <Z85LjhvkCzlqBVZy@fedora>
 <Z88K5JtR4rhhIFsY@slm.duckdns.org>
 <baba2f82-6c35-8c24-847c-32a002009b63@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baba2f82-6c35-8c24-847c-32a002009b63@huaweicloud.com>

Hello,

On Tue, Mar 11, 2025 at 11:08:00AM +0800, Yu Kuai wrote:
...
> > That said, I'm not sure about changing the behavior now. blk-throtl has
> > mostly used the number of bios as long as it has existed and given that
> > there can be a signficant difference between the two metrics, I'm not sure
> > the change is justified at this point.
> 
> If we really concern about the behavior change, can we consider a new
> flag that can switch to the old behavior? We'll see if any user will
> complain.

Yeah, that may be the right way to go about this, but let me turn this
around and ask you why adding a new behavior would be a good idea. What
problems are you trying to solve?

Thanks.

-- 
tejun

