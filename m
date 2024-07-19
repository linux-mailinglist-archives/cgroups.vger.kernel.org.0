Return-Path: <cgroups+bounces-3814-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB80937AEE
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 18:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD761C21B70
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 16:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732CA145B32;
	Fri, 19 Jul 2024 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SO0XmLEs"
X-Original-To: cgroups@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB902AF12;
	Fri, 19 Jul 2024 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406416; cv=none; b=VFYMbqv7XgdjoXJJqIytg4ILqoKyv1TOOwDMt/yGDgc0dPFA/pGqynL69HiTKdrgjHPLtkapk9qYgxvy7SiHd4gjnauNkTBz5hK0tOyCJAQ69TYpYnqAmpby5fb77S1xZnldt9QD46pJ1BizOIsDewctBX9HSo+dB6hpU0g1N64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406416; c=relaxed/simple;
	bh=jj+E4B3z4DoQtdLdCfokCz3LD8O9EiZOe9nPObsXGHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kw8kZw4a1d7duqWjO4Wz9qJhhuc+9SO9nLcMFnP1PZeYNxOUHr/PSyVK2WofzoW5ocnbumY0ciJvYe7FVh+tmuScyjA6L9DxqdTkw1JLEOi5SjLf06huYCfEjK1GVEYA9r2+jvVBGVKDEL4QIVi5KoB4hILbtkb4F+cc6RNsrIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SO0XmLEs; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WQZnN4ZHszlgVnW;
	Fri, 19 Jul 2024 16:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1721406405; x=1723998406; bh=jj+E4B3z4DoQtdLdCfokCz3L
	D8O9EiZOe9nPObsXGHI=; b=SO0XmLEsv8PG91EVIksIqwq0CGQ5N/aan2IuWvuV
	JlGhM1YH+jXqm6GZzFsTTC/qc1wYjQPItQJgL+BLLtPVmp9jX+MVr/GHHudv1Y2R
	4LOT0eLllrQdFbm+r1G5pmWe1QV0cESHBpFXZLWJdF7eUCSJKBSFC/J7PM6A+k5m
	rraQOMC/PC8AeAP6QPDArtlD2hckspkvXnA3maOfZ54rh9tbSRk4nObacx6TnQD4
	6kB2Co7eqfp+IDmGuArNeLeD6d1b+7KT7jguNTmsMN2y/sY22woGUflxQCRlgGVM
	QHvXqse60qhLqgIaPb02G/RDb9qYnQj9aJzHv0Y7MMgViw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id shfOcTnR-oZg; Fri, 19 Jul 2024 16:26:45 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WQZnG3BVKzlgVnN;
	Fri, 19 Jul 2024 16:26:42 +0000 (UTC)
Message-ID: <a1dca460-76e9-4428-8f30-768afd5f0ea4@acm.org>
Date: Fri, 19 Jul 2024 09:26:40 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] blk-ioprio: remove ioprio_blkcg_from_bio()
To: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@infradead.org,
 tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com
References: <20240719023431.3800647-1-yukuai1@huaweicloud.com>
 <20240719023431.3800647-3-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240719023431.3800647-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 7:34 PM, Yu Kuai wrote:
> Currently, if config is enabled, then ioprio is always enabled by
> default from blkcg_init_disk(), hence there is no point to check if
> the policy is enabled from blkg in ioprio_blkcg_from_bio(). Hence remove
> it and get blkcg directly from bio.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


