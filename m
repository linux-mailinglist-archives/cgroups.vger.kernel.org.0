Return-Path: <cgroups+bounces-8528-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 410F2ADA665
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 04:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E4D1886331
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 02:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FACC267714;
	Mon, 16 Jun 2025 02:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQX5hzVD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152A8B67A;
	Mon, 16 Jun 2025 02:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750041525; cv=none; b=NdvbCbOh4+yfkE2HYzYOzQe201+c+pK2InkGonl0OmpYJdGWtnAS3Zu1pXiajQo9g/IdEMg8tznjgxS71shU3M4wiYuii04UGx+2/gKrSfYNUWAZodQZP8xTSCZY6WqG9jZ7uF8Ai4qMlADSMtCdjGLIoqhdOScodaB167oOuJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750041525; c=relaxed/simple;
	bh=ys55S2md93TvWsY6uMrNg3ZM23Va1zW+kFPyLt9FT8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpbnaKxmmHtI/d8bmN9uJLk2A0BEYmLI8Pgs9SgdZuejLvWziGG0EAQb2kSh8y5MaGuJjt+XqeX3gVrD8fwODjN/pi1JKYQQ+0vXktH4NP9NjAbxcrLKriyvpZr3Tm7OCQ7k0EHn6SZoYa3uMZmely4RFn5UaZuvHauafifX4mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQX5hzVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C102FC4CEE3;
	Mon, 16 Jun 2025 02:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750041523;
	bh=ys55S2md93TvWsY6uMrNg3ZM23Va1zW+kFPyLt9FT8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fQX5hzVDAb3cqlxQuphdBKaHJvYdrNarOgzYXGQlEmii2cHZzdX1iLFRC8GfhK5Dr
	 +20I1YjZZMnilZQ6fmEyA8m4m+0UAkEPcciQao2oz0X/wNiHW/CoB230E4Eu/AUYse
	 WDeLPdafITOupYlATpqBkMXENab3bN9OJeA/3PViZfF9lOuhTjLj+pd/z9FUUhTweS
	 6aO28NH0YQDrKhMU9F/iRErVhwThMREjInO0Yhe6fzjmcgWA+8QKqfBOmFAWaxBuFB
	 sQD8Xepew7eRASuxsU1bk/DIPSS4//Agz95Nxr1/lnDlVr/CTgImbVFz/XZoAGzVcR
	 CfKQO3SQb22UA==
Message-ID: <5960be14-b2c1-4865-bd8b-952313a0c841@kernel.org>
Date: Mon, 16 Jun 2025 11:38:40 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/5] elevator: introduce global lock for sq_shared
 elevator
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com,
 yukuai3@huawei.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250614092528.2352680-1-yukuai1@huaweicloud.com>
 <20250614092528.2352680-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250614092528.2352680-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/14/25 18:25, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, both mq-deadline and bfq have internal global lock, prepare
> to convert them to use this high level lock and support batch request
> dispatching.

There is not enough explanations and what you have is misleading since this is
not just a "preparation" patch as you are adding a lock. So please explain that
in more details.

-- 
Damien Le Moal
Western Digital Research

