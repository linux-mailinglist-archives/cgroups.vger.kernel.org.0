Return-Path: <cgroups+bounces-9513-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521B7B3C7EE
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 06:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C757586BF2
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 04:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD59E277CB8;
	Sat, 30 Aug 2025 04:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzzsMi4w"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B9942049;
	Sat, 30 Aug 2025 04:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756528728; cv=none; b=i92SrZprwG9CglUZOWbQvNuT07u2Dkrb2HE8s7PwmwA9MXjAOibJjm4TaUcfG3uSgMGWsy6CGNKvO+SoSpmyt8VIu2nJ5H0/knhPUwI0u0z/bYD3YvhPX0PDHvUcHVJIyAeWZ05pjhDcmlo+OdDmw0nlkh32UnO+NhBpVpYkZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756528728; c=relaxed/simple;
	bh=c82a1KYluoIERfAlGlVM+UwKKvey1HQBYLHa/x2Xrzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmS+x43ueeAcp+mA64xxWlIT9mpKiR9ICwFHsE3P/e7c5GAyjJ983XGSqzLYjQPuGV8Rmbops6A7lwR4GaCJoWqPNZO5aQn3ifIdltoSoEBoYVNeJCoRqc94YopuVRL9VeOZb+0e5wIK1VfzVrYSvz8dSuNQYCtPy1gmSyBXQIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzzsMi4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1CEC4CEEB;
	Sat, 30 Aug 2025 04:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756528727;
	bh=c82a1KYluoIERfAlGlVM+UwKKvey1HQBYLHa/x2Xrzk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BzzsMi4wwIevXis49EvkuaJq9d3MeH/Qp71v8drUiIWicRrJhHobXkXxfU4xJU6KE
	 u4TWnb6V1rxSbKptiQ3rdj9Nfpt/l+Eyqif5gTrQs4nS9uVlCywGMAHPHYxs106kVZ
	 FYslw00ZMqWMEyFWt6VTFkJRVtdaeHwop3CUtamMgoNtWG908j1rm/bTQrm5XDt1fC
	 cIt1GI+jkBTnFYcLguFyFwc3CdGGaVVO0zYYG/1peg4ME0ndO3Vnf8D6K10DcrRXFV
	 RrK0vSmt/O9HkCaLFCq7y+b1jwN++Xe4FTBN1IOdWEsyka8Pro4F9YeRLz0lmNhgsJ
	 Qkf5tSGWLzGPA==
Message-ID: <67d5b14f-25e3-4180-8917-f950b766d4dc@kernel.org>
Date: Sat, 30 Aug 2025 13:38:43 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 02/10] md/raid0: convert raid0_handle_discard() to
 use bio_submit_split_bioset()
To: Yu Kuai <hailan@yukuai.org.cn>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 neil@brown.name, akpm@linux-foundation.org, hch@infradead.org,
 colyli@kernel.org, hare@suse.de, tieren@fnnas.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250828065733.556341-1-yukuai1@huaweicloud.com>
 <20250828065733.556341-3-yukuai1@huaweicloud.com>
 <858e0210-1bbb-466b-98c3-d1a3c834519d@kernel.org>
 <e147e288-de38-4f2c-8068-53c5e37b2310@yukuai.org.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <e147e288-de38-4f2c-8068-53c5e37b2310@yukuai.org.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/30/25 13:10, Yu Kuai wrote:
> Hi,
> 
> 在 2025/8/30 8:41, Damien Le Moal 写道:
>> On 8/28/25 15:57, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> On the one hand unify bio split code, prepare to fix disordered split
>>> IO; On the other hand fix missing blkcg_bio_issue_init() and
>>> trace_block_split() for split IO.
>> Hmmm... Shouldn't that be a prep patch with a fixes tag for backport ?
>> Because that "fix" here is not done directly but is the result of calling
>> bio_submit_split_bioset().
> 
> I can add a fix tag as blkcg_bio_issue_init() and trace_block_split() is missed,
> however, if we consider stable backport, should we fix this directly from caller
> first? As this is better for backport. Later this patch can be just considered
> cleanup.

That is what I was suggesting: fix the blkcg issue first withe fixes tag and
then do the conversion to using bio_submit_split_bioset() in later patch that is
not to be backported.

-- 
Damien Le Moal
Western Digital Research

