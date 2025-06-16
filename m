Return-Path: <cgroups+bounces-8535-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D604FADA991
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 09:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47AD3AAC63
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 07:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3D41F3BB5;
	Mon, 16 Jun 2025 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrEuGApi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057843A8F7;
	Mon, 16 Jun 2025 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750059483; cv=none; b=YiSbTdrbiWyCwmBzyKgBn8XOG8KNYYe11KClCDAnLkg+94AfhPr5yeWscsuFmOyFEvLjB7Bpbrch7tY5WeBpXrLIzAQxqlZVHLgO5XO51Lk4NIhqp5fcjLcyv0JlfWcXcwinnwMwke9jTTRGcYeUATEBl2KCZFipbuzK4E5BIsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750059483; c=relaxed/simple;
	bh=+Kbml8DI2Ml+zFBZv+cp/R9QEncgiePszIZEyF6Rgkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqFufKTHqfLMtDZDkUoirIMWHkzwaV6CtSLrZX8smXgL0Ypm17Ohefu7m/+mr1eoP6YIeqvWkzbGCQBZxDs08S+9VIW6xSVzTifWq4kVDWt9OP6KqNXfsvq3e0tN9fLkONUoHUeZ818haDPvpJiOjcu99kcuOs059qWLEBdHaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrEuGApi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE470C4CEEE;
	Mon, 16 Jun 2025 07:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750059482;
	bh=+Kbml8DI2Ml+zFBZv+cp/R9QEncgiePszIZEyF6Rgkw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NrEuGApipQNbeCOMMbksfTH67GOmjLxb+EySAAlK/MLmAK3Sxs81+ghtDWKn7aSjq
	 liguZSr/LsJtfH+j85vhofUzPcpEtaK9KILt1X1qQJKSZZvwlwNcU2iaV18kKpgHdV
	 Z9AbcwmhZ5pQWfGbZqAN3PMEinZjDzIY2m2qg3UKVa4YzCAjtdLgDRsSTrAnWbT8xS
	 FCjAUuasFDgrVIchvU9OPiQp37sg3DDfAweN33/fc3VB/eNrPwMKX3j0csVje8Y63E
	 5hzFDO0wn+bkuor/2rq9POCxgD/YsqT/VKlABhRrmLwV3SPsQ2CvokY9rcjcH/vs2+
	 jaVJosBOZHKtA==
Message-ID: <27d2cd23-1c0e-4a21-975c-68be727220ec@kernel.org>
Date: Mon, 16 Jun 2025 16:37:59 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/5] blk-mq-sched: support request batch
 dispatching for sq elevator
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250614092528.2352680-1-yukuai1@huaweicloud.com>
 <9d3aee10-9eb3-4f2d-bb9a-1721c05ec3aa@kernel.org>
 <16fd5432-36b0-0a92-0caa-7374ce1464a5@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <16fd5432-36b0-0a92-0caa-7374ce1464a5@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 16:22, Yu Kuai wrote:
> I agree that lock contention here will not affect HDD performance.
> What I suspect the difference in my environment is that the order of rqs
> might be changed from elevator dispatching them and the disk handling
> them.
> 
> For example, the order can be easily revised if more than one context
> dispatch one request at a time:
> 
> t1:
> 
> lock
> rq1 = dd_dispatch_request
> unlock
> 			t2:
> 			lock
> 			rq2 = dd_dispatch_request
> 			unlock
> 
> lock
> rq3 = dd_dispatch_request
> unlock
> 
> 			lock
> 			rq4 = dd_dispatch_request
> 			unlock
> 
> //rq1,rq3 issue to disk
> 			// rq2, rq4 issue to disk
> 
> In this case, the elevator dispatch order is rq 1-2-3-4, however,
> such order in disk is rq 1-3-2-4.
> 
> And with batch requests dispatch, will this less likely to happen?

If you are running a write test with the HDD write cache enabled, such
reordering will most liley not matter at all. Running the same workload with
"none" and I get the same IOPS for writes.

Check your disk. If you do have the HDD write cache disabled, then sure, the
order will matter more depending on how your drive handles WCD writes (recent
drives have very similar performance with WCE and WCD).

-- 
Damien Le Moal
Western Digital Research

