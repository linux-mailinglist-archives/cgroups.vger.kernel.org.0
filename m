Return-Path: <cgroups+bounces-10455-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58450BA07F6
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 17:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4FD4C5497
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 15:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1156302760;
	Thu, 25 Sep 2025 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3lNIDf7v"
X-Original-To: cgroups@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD201CA84;
	Thu, 25 Sep 2025 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815846; cv=none; b=mChVx7Sd4b9cKCarM7vLuKToiMjADrhVpoQ/08GnJVToME48OWZ+8BGQ0ZLeSR/slGJoIXlWb3lc1V9Lzqu9pU8Mbo+Oq2j1WOeFfFAbnwkalg3SCjNQkX9SGF93pvYqB2S+InxyYDLrKoBkvde+jNcx2HOWCHCZ+QCqSN0Vwq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815846; c=relaxed/simple;
	bh=oMhd05x9x0tqhBXT4WmE2ln8stlPQG2l6//8/VqTYig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwBJfVIpT9jTv5k+v6DaTXNQ/GG9CScMXocp4SPLbRMK47HkkgPO/IiD8QbcetHtyAkF8GOTP+FUukIxafRM22ZCZqNdICsYyiIJTTmyaKOvZSc2hCU5bqUVEdxn+44fr38fihphxxHMZrukDKn21f1OxVJmh/rMR+iryXl2OQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3lNIDf7v; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cXddb4QcFzm10fx;
	Thu, 25 Sep 2025 15:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1758815840; x=1761407841; bh=oMhd05x9x0tqhBXT4WmE2ln8
	stlPQG2l6//8/VqTYig=; b=3lNIDf7vxDukhEwY745QPQncxYUtWSWnx+YuCZJ2
	ioFsjKFelGmM3GkA6ZhXCsAJcUUU5DQKDFk5xOWhn5D2InHRKynPstX/OYS1ZHub
	AEQNc62ighYT5fmrDOArIiH6OMyISaXCcTSkazZW45+9C/cVPGE3fVJwUJ+uAaxE
	8cyWBxCCOFI3l8AbiQ8tNuxNESIrOF5/pcmyL/26HPJvM9CXP4hsxeNr9E7KGbVs
	JdVTtuyQCALcAevFo/LDtbpVcHlzvJseGr67fUOCDRchDmwiknYCuTvcjN1/0rKj
	+c7UfBHWk9N+9dJEIIc2PmitHNFqQ4uYLHZDuwgFPnz/8A==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XGOV8JsgHmdF; Thu, 25 Sep 2025 15:57:20 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cXddF1vjbzm0pKm;
	Thu, 25 Sep 2025 15:57:04 +0000 (UTC)
Message-ID: <bc6fe04d-3245-40dd-aa30-c3a3acb670c2@acm.org>
Date: Thu, 25 Sep 2025 08:57:03 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] blk-cgroup: use cgroup lock and rcu to protect
 iterating blkcg blkgs
To: Yu Kuai <yukuai1@huaweicloud.com>, tj@kernel.org, ming.lei@redhat.com,
 nilay@linux.ibm.com, hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk,
 akpm@linux-foundation.org, vgoyal@redhat.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250925081525.700639-1-yukuai1@huaweicloud.com>
 <20250925081525.700639-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250925081525.700639-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/25 1:15 AM, Yu Kuai wrote:
> It's safe to iterate blkgs with cgroup lock or rcu lock held, prevent
> nested queue_lock under rcu lock, and prepare to convert protecting
> blkcg with blkcg_mutex instead of queuelock.

Iterating blkgs without holding q->queue_lock is safe but accessing the
blkg members without holding that lock is not safe since q->queue_lock
is acquired by all code that modifies blkg members. Should perhaps a new
spinlock be introduced to serialize blkg modifications?

Thanks,

Bart.

