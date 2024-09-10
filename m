Return-Path: <cgroups+bounces-4832-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACFD974478
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 23:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93765B221A2
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 21:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001BF1A76A6;
	Tue, 10 Sep 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO+C1LVy"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9445183CA0;
	Tue, 10 Sep 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726002173; cv=none; b=JhD+fpbXeR/yJVpYo9nwVH2Q2w1LXjwRLhXYsPXhdrARC2VxgYCq1tyAzWf2HT1zkGkvtsP04YCmZFdtCHqx5fI+eY8azEM7kKw/jI0Prf7f9eI+JKI3nVXdu5W8u7QZFnsVJpEcwPKi423+wFZMRzqgsjqZ+D9k2cnXPn8mZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726002173; c=relaxed/simple;
	bh=Mdk9uocvCavX/AUVPG9mg9fDvdwM7XlTmIKbXB+pCvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWC58ly8ogZ/RTjLkSJC7DhhCcGSN2wC+u+jQz36fQLV5yjcoIYrturCe6M+G0hmEeY9Kc8l699zg2CLVGFNtBD2TwjKxC5WNfMY2w00heTxBmMGtYrTPNJU19oLYSsNcr5tDrSzs3scmmoBDr1JZ8TAjOk2+iYYdWIdYSWpwkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO+C1LVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A094C4CEC3;
	Tue, 10 Sep 2024 21:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726002173;
	bh=Mdk9uocvCavX/AUVPG9mg9fDvdwM7XlTmIKbXB+pCvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VO+C1LVy7A0DGORAQUsPk4gImOQ67uVVYUr0UQffw2xQKOv6WFR/tG7/eY+bawknH
	 36rKr16sLDLRpElUHQjkiKPYdcjHQ6IcpVIv6w/jMB44KOWzlfFAbjAlJSsNbXkSiE
	 UCp3RpAAGm99oxXJo9cCnZmLAhsXWgc6gccwrxpSGcJUqWd4zjTO0dDsjon2tZHeUY
	 NQ2VCCOO3Tz13BWkmWGrJen0vsY5H1cUHaQG5PLkddGlV8KAtSw2v/GNgy5ly1U0m3
	 U4qkq1BCQXKraowMDxGTrKHrR5FQcei7dzu9BiW/pzQgVvu6Y3qIXCNqBYFddAFK8a
	 y99IKe94aOc3w==
Date: Tue, 10 Sep 2024 11:02:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH for-6.12 1/2] blk-throttle: remove last_low_overflow_time
Message-ID: <ZuCz_Gmot59hM-SZ@slm.duckdns.org>
References: <20240903135149.271857-1-yukuai1@huaweicloud.com>
 <20240903135149.271857-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903135149.271857-2-yukuai1@huaweicloud.com>

On Tue, Sep 03, 2024 at 09:51:48PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> last_low_overflow_time is not used anymore after commit bf20ab538c81
> ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW").
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

