Return-Path: <cgroups+bounces-8529-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839F8ADA66A
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 04:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3218116C7E4
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 02:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A812882C7;
	Mon, 16 Jun 2025 02:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRjJdThA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B861BF58;
	Mon, 16 Jun 2025 02:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750041686; cv=none; b=i9Kq9NRX3XmLEmSUvI66r9lFZ8T7JAYfuqwD9adiyCMkxJdDxOK/ywJ4R35QXPPwuQMU+F2O2rjDp6ZB4dWCvGSjkaQWftonJvFXZfLr4q3nz/wvJoKLNyb284IPGjySH9gjR8saPopL/2NfEYZ77tYXqqVd9tiM0RZv9InSggA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750041686; c=relaxed/simple;
	bh=DXKcpPWlnoyXq5aFN6azXmWfbWTO8/NkagFnfyMQEgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uL/Y15AaYvDG76YeXXsqCm3NTx4VnjMA67/z4G/QiEt19TRg38xKcUUXO36gj81+24xsw4rkRL/lwzv3QRCK5bYFxJ9VkNuoILcn/Lg1w5mhcRpxa78Qa5gwXZq/uFgdd3sgttwkuE8rnGW7/hIcZ+JY9fXUVI4K7OX/nwU0fAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRjJdThA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A58FC4CEE3;
	Mon, 16 Jun 2025 02:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750041686;
	bh=DXKcpPWlnoyXq5aFN6azXmWfbWTO8/NkagFnfyMQEgY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qRjJdThARHE5vbBMk/5ipSBacFUC+nyHGZgTpPMQHz2LnZqMZWU8NPgjY1bYnjc2Q
	 RbOp+4o3m8WRVCj7bybLEoyHnUOP8mqMGr2vqfd0mKkhdTVJMhAHNmeCRVokCqFhgV
	 eLFDVa1Ojr+krE2pFKcyE9MYPeKLufc+EEMamD/q8xHZk9nubjIvkSOvIUFuf0ehok
	 upnXNnwcF0YoEx6RM/RO8ExZe72Qmil0f1woKDmo+6VmO+Fi9iJZSC7kUEw42r7oTC
	 nMnBwSMi10YWzoDBiCX8VgmU02DFJlpbH9uWir9RZBbXc00nZ+wchKlYtngv8S1Gly
	 l7EdO3jNAW9lA==
Message-ID: <3b8e8fda-6b57-4b96-ad21-e7173b403807@kernel.org>
Date: Mon, 16 Jun 2025 11:41:23 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/5] mq-deadline: switch to use elevator lock
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com,
 yukuai3@huawei.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250614092528.2352680-1-yukuai1@huaweicloud.com>
 <20250614092528.2352680-3-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250614092528.2352680-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/14/25 18:25, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Convert 'dd->lock' to high level 'q->elevator->lock', prepare to support
> batch requests dispatching.

Again here the explanation is rather light. You should mention that you can do
this conversion because now the elevator lock is already taken by the block
layer when calling the scheduler dispatch and merge methods.

As for the "prepare to support batch requests dispatching", it is unclear what
that is in this patch. So please explain that or remove this.

-- 
Damien Le Moal
Western Digital Research

