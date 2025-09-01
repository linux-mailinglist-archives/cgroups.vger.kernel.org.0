Return-Path: <cgroups+bounces-9545-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A9EB3DA11
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 08:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928191795EF
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 06:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDBD258CCC;
	Mon,  1 Sep 2025 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+2sP87H"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE6C18EB0;
	Mon,  1 Sep 2025 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756708633; cv=none; b=HSI0kwaJF1WJE2EP4RSfhzeVUHMhcFetUsRYlFU2vZH4V1KMTZDKN9glhzuDDZM4M1CNd37qoQZO0No2phauBDp1cuqqDT5qgKqMPCXv4pDY+oxAupZG1COFlFPc8F0Ww+uS7nUkfEFz/J5Jm4AUrRUuTK0lfpKwc5MQqvY+3iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756708633; c=relaxed/simple;
	bh=/fNlLK1sat8ALrgDSklq2kPeY+cEjpCD5QhGb0EjTqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8ORPfxX1UJW2spVhvVzU9g4OOEgZqwwZFuF/aeeArHbQ9euoaw6aaKVWtpLvjmHCE9/P69tUW9ICEOhy/KKebOSGSLvoiA3ade6T3qrZ5UJs8ln337ZzGLmI4is2xBdIje4XuTR5ycqM3EgohCfjKCODda7kqoXEM9/YdZSEh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+2sP87H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A956CC4CEF0;
	Mon,  1 Sep 2025 06:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756708632;
	bh=/fNlLK1sat8ALrgDSklq2kPeY+cEjpCD5QhGb0EjTqQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e+2sP87HqcJuhpOxmV5bxmT0Wd2ClaAoLYK8KsLvLExNffznOUxggyGvJLwMrwAkL
	 tvBPVYetUce+umvaUp5daAuVViDr6FiBtO3tPTiAq784HZ4lgMXQhnOslmAtapCpZ/
	 5K+tUxLCyqU/rP+viYDOCvgkl+RqX59DFm8jhUs8PxPHoquuuHnie8QGVqiO7xxXWk
	 ofcCS8oV8jyb5APIr5PdB4o6CLjdhPOdMG9xzZxqaVgkpCrAoucre3YseeCGZ1Ip2d
	 DTMsUCBFpbHoh1Gt5tp2kidrsR1F1TN7aFYFPszjHubckpiLbInFZdrYvl7gsejqql
	 nyOtyAC10TYuw==
Message-ID: <aadb0215-cab5-42cd-bb21-bcf5d855c728@kernel.org>
Date: Mon, 1 Sep 2025 15:34:15 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 05/15] block: factor out a helper
 bio_submit_split_bioset()
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, song@kernel.org, kmo@daterainc.com, satyat@google.com,
 ebiggers@google.com, neil@brown.name, akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-6-yukuai1@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250901033220.42982-6-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 12:32 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> No functional changes are intended, some drivers like mdraid will split
> bio by internal processing, prepare to unify bio split codes.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

