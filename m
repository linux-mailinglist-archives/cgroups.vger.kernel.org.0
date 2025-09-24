Return-Path: <cgroups+bounces-10407-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A37D9B97F26
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 02:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FC54A81DA
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 00:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477B81DF75B;
	Wed, 24 Sep 2025 00:52:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1071DF723;
	Wed, 24 Sep 2025 00:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675144; cv=none; b=uyvwvwO6HX4+0rg/xCXNUv12awtCPtdIwdj7P3B2/+Tm8/6gMvmqNHR8wwgONno4QttV/1DWkENgN7tjG70xXLPyZnHrtcZjw/neSZLz2m8Ohm/twDreu2Ir+ClRLpFx0QfxtLmAIm2Hs5SlgvzxLz4ozZZpSKZrwADQF9i7ZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675144; c=relaxed/simple;
	bh=/lt25bNflVEMIDdCisFY1BN5hH+sjlvDzXLhZfaSmsc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GL/JieepdyqIOcgc3aj0IB3boo5PBcNcqGvon4BctlAojCCpBAAMu+9AMAPcpkpz6UZNqjnnpX3KGXxXyavLOYfXDN2OjJiva7xWD+QTwQ9Pv3ye5y4jeIK4AnPgrl+FID7W2KaQCVtYgY1D2/Jwtacm8NaWAuseipFaCEM4mQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cWdbc2BfzzKHMjp;
	Wed, 24 Sep 2025 08:52:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 38BB51A0F42;
	Wed, 24 Sep 2025 08:52:18 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXKWHAQNNo02F0Ag--.29046S3;
	Wed, 24 Sep 2025 08:52:18 +0800 (CST)
Subject: Re: [PATCH for-6.18/block 1/2] blk-cgroup: allocate policy data with
 GFP_NOIO in blkcg_activate_policy()
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com,
 axboe@kernel.dk, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250923075520.3746244-1-yukuai1@huaweicloud.com>
 <20250923075520.3746244-2-yukuai1@huaweicloud.com>
 <CAFj5m9KSEvP_gqN5_51q_iaUrOS70xC5r-odJYLOami4EKDVUg@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7ae65be1-65b2-208c-ad25-68905c4f2331@huaweicloud.com>
Date: Wed, 24 Sep 2025 08:52:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFj5m9KSEvP_gqN5_51q_iaUrOS70xC5r-odJYLOami4EKDVUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXKWHAQNNo02F0Ag--.29046S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYt7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2js
	IEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrw
	CF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd
	HUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/23 19:03, Ming Lei 写道:
> On Tue, Sep 23, 2025 at 4:06 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Queue is freezed while activating policy, allocate memory with queue
>> freezed has the risk of deadlock because memory reclaim can issue new
>> IO.
> 
> blk_mq_freeze_queue() already covers it by calling memalloc_noio_save(),
> so this patch looks not necessary.
> 
Yes, this can just consider a cleanup, I'll remove this if we think this
is not necessary.

> Or do you have a lockdep warning?
> 

No.

Thanks,
Kuai

> Thanks,
> 
> 
> 
> .
> 


