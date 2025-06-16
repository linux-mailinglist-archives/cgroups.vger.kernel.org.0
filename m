Return-Path: <cgroups+bounces-8531-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF23ADA682
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 04:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846F11890333
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 02:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991502882CA;
	Mon, 16 Jun 2025 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0SYV94N"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0BC23AD;
	Mon, 16 Jun 2025 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750042499; cv=none; b=p5P2Sh9W5Upj9P7dAI4w6y6z+amSWhgfBsXf9pBtUCglEZzMduQMNDw5EEENzYFHXnrYjtEXMI+hx0IVkSWb0qBN6cStSUZjU59vBrNAMs8qOgVQ+ps1LFKPZ2NDs3+KPleM458aEKwaKLsU52SnAgNZYk3BeWK2fwFA5cFfegk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750042499; c=relaxed/simple;
	bh=kb26pdyC2mhf/HxHHzF4lqYjFaP1Jqg1DRS4zwyBnq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMaGuUf5IenEQEve19y+JtZaM+bCpu4w16Q2KUP3YZ2NgjX3PcZv72n3sRGwGkTuH/A/qIagYb/9hKrj5CWxZbnWh1EvYgE1wqefzkwZ7WImEPrsW1ffeNHf+/0LvdkH1mu26GMGy2Qk2ERPT38Xk/Ocs5qiC5T9L5gq8Jm8qaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0SYV94N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CFCC4CEE3;
	Mon, 16 Jun 2025 02:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750042498;
	bh=kb26pdyC2mhf/HxHHzF4lqYjFaP1Jqg1DRS4zwyBnq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A0SYV94NKk1wZYHzwqZ8hnKPVE/PFf0Ksk5KcBT4inlMH0eIhMPmXllCBwZIqceD/
	 4FvArmKHDop9fA9zCDu/PUSciDyBbiIUoeGy39C+WsSzyJtVmg/7EzdKaoZ1M102fO
	 hH2gq69D+BkkNDDqM4Pjp3+bgpH+1KS8EQc477H/1M1GzxLypvti3lgGjRKQEjMWE1
	 hhgRtG6QhFpp1TG0bfTauAckJry5VlnSJ4EZJ0V6TI8xs6u5AG5ikvw4HQNnO/oP/G
	 r7BOROjxELcMESXP3A5KxuAFQb0oKFApRClMtLtgrqqeGgjh/Z66VP1K6ot9xanIpl
	 AsIpeOAs4myPw==
Message-ID: <62d47057-1ab4-4558-961c-8c8f7e170e4b@kernel.org>
Date: Mon, 16 Jun 2025 11:54:56 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 4/5] blk-mq-sched: refactor
 __blk_mq_do_dispatch_sched()
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com,
 yukuai3@huawei.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250614092528.2352680-1-yukuai1@huaweicloud.com>
 <20250614092528.2352680-5-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250614092528.2352680-5-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/14/25 18:25, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Introduce struct sched_dispatch_ctx, and split the helper into
> elevator_dispatch_one_request() and elevator_finish_dispatch(). Make
> code cleaner and prepare to support request batch dispatching.

It is not clear how this patch prepares for supporting batch dispatching. Since
this is only a refactor without any semantic change, I would either drop this
comment or explain more clearly what you mean. This patch can also probably come
earlier in the series.

> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>


> +static int elevator_finish_dispatch(struct sched_dispatch_ctx *ctx)

Please add a comment here to document the return values.

> +/*
> + * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
> + * its queue by itself in its completion handler, so we don't need to
> + * restart queue if .get_budget() fails to get the budget.
> + *
> + * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
> + * be run again.  This is necessary to avoid starving flushes.

And what is returned for the non error case ? (e.e. document the meaning of 0
and 1 return values).

> + */
> +static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)



-- 
Damien Le Moal
Western Digital Research

