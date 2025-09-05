Return-Path: <cgroups+bounces-9753-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 516E5B464F7
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 22:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1928E5603A2
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 20:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E9C2E03EE;
	Fri,  5 Sep 2025 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="imhL5mzb"
X-Original-To: cgroups@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309AB19343B;
	Fri,  5 Sep 2025 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105446; cv=none; b=fWjsr+Q3lo1d5bYHwH0NvzO2f04VOo/bNcii+eHobYXM0etgl6RmtXl3SdlciinfqDJlkpbfOg65eKVlE8Y37I9DsMV6FmhLwsJNHzDxz4hPg0Xmcdg8HiRigVs2AW6HTnLl/gVK27iBrnBxNNzquauMZS2iwLE9ULdzcL8BGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105446; c=relaxed/simple;
	bh=tWkwMGoYxGkya0CrNMsTmb7F0BOoTjuQ2SkOa28z63s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9FfghpLMZb3sGlJpWuPAqOgE4geoqzUIBpDB+PtewGie0kxIpK+ugV45iFDfy/D8wcYs7m62kTelZqfW10b8L+f91PNg2sn89cX5pVYj6DQV2HXa8qeo4oYOiLcGmPpbyhfC0v+elneb06PpePl5fHDIGakU2sSyZCtJQ/oQ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=imhL5mzb; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cJT5J1WzPzm174D;
	Fri,  5 Sep 2025 20:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1757105433; x=1759697434; bh=tWkwMGoYxGkya0CrNMsTmb7F
	0BOoTjuQ2SkOa28z63s=; b=imhL5mzbf2kgMpOZsPq+wDL/1C9/31hSv1666+W2
	Zich6l+kU+fyScUxne6LmTbzRjS1LQiqo2LBCMd4yn1J1rfB5ZwNp0ieXsm42o2L
	EXkBzvNA0FxyZaU2k8kYdKcIRuddzgVoaDApMw6gMW0cL9zkC9abd5+eL7e6hoLo
	yTO4E9jAKJFf/HGEDwz4g6pMIuxOfi0NCBtcGSKMzDk+B2LPf3YVNihcT81KsolT
	a64cIGSh2FK0pk3vapibVin5meKiffQO2XVEWJix/6zdCXsqPwEMSHNQZfPc1ACJ
	xUK4H+Zm45HyT2Z+gPZ80nBXf9VQ6cQmrf3lTXuysqk5aA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wm8SpLmOCYYK; Fri,  5 Sep 2025 20:50:33 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cJT4n4fryzm1745;
	Fri,  5 Sep 2025 20:50:16 +0000 (UTC)
Message-ID: <d9c6bf32-4131-476a-aebf-c31f549368f2@acm.org>
Date: Fri, 5 Sep 2025 13:50:15 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 13/16] blk-crypto: convert to use
 bio_submit_split_bioset()
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org, yukuai3@huawei.com,
 satyat@google.com, ebiggers@google.com, kmo@daterainc.com,
 akpm@linux-foundation.org, neil@brown.name
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-14-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250905070643.2533483-14-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/25 12:06 AM, Yu Kuai wrote:
> Unify bio split code, prepare to fix reordered split IO.

reordered split IO -> reordering of split IO

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


