Return-Path: <cgroups+bounces-5116-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F46D99CC9A
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 16:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EC728219E
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 14:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69701AA7A5;
	Mon, 14 Oct 2024 14:17:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323DA19CC3A;
	Mon, 14 Oct 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915438; cv=none; b=KeNvMT53pNuQN2KH3nyeUXkNqcN752ozyHpB4o6ZFyGDJ81lJFwN6QhmrGpcEpw+w9LVmfjYrc+M32KZAgpyTSIqnPSg2stcMjKA4geUarsbg6nitBpUh+yUQnyhvXKIlQy3I8oEYE/z2G/tCYyNLWBAjhLOZYUjhv1YCE67r0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915438; c=relaxed/simple;
	bh=wi9fyt2BlbMY+3avwtkBNher3B5sE1dQ+eNeNs0/KTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvsWSYMEipV4wzgu/ohmmZIV7hU1fU/cWnUXlVadIPvFhxXt6BVdWE4mxvEx/m40LUHdMSSBls41/7r2K2CnNm8kCs1yIrB5mcvCy0q2N7Hm4y0zM/6UCYV43hiAGgugVgyrQ79Ai7OB2Vg3gCf3toxUrhiFck2N0/hCBCHj3s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XRznL6xz5z4f3lfq;
	Mon, 14 Oct 2024 22:16:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C8DF61A08DC;
	Mon, 14 Oct 2024 22:17:12 +0800 (CST)
Received: from [10.67.110.112] (unknown [10.67.110.112])
	by APP1 (Coremail) with SMTP id cCh0CgAnUi7nJw1nE+vaDw--.31727S2;
	Mon, 14 Oct 2024 22:17:12 +0800 (CST)
Message-ID: <f7ce461f-9e8c-29a0-4376-f1a61742d9cb@huaweicloud.com>
Date: Mon, 14 Oct 2024 22:17:11 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] cgroup: Fix potential overflow issue when checking
 max_depth
Content-Language: en-US
To: =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
References: <20241012072246.158766-1-xiujianfeng@huaweicloud.com>
 <hbkgbz3cmnd5e5qftzlmulc2so6jhvn6k7klpuqkod5hi3l6sp@53xgyxqgwhg2>
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
In-Reply-To: <hbkgbz3cmnd5e5qftzlmulc2so6jhvn6k7klpuqkod5hi3l6sp@53xgyxqgwhg2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnUi7nJw1nE+vaDw--.31727S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFW8Wr45Xr1rJFyUur1UGFg_yoWftFb_G3
	W8Zrn7AF45ta1Ik3Z8CFW3Zr98Gr4xWFs8Cr93GrW5XryUtFWkXrZ7Gr93AFs5XFs7trnr
	uas0ya92yr1IgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

Hi Michal,

On 2024/10/14 21:37, Michal Koutný wrote:
> Hello.
> 
> On Sat, Oct 12, 2024 at 07:22:46AM GMT, Xiu Jianfeng <xiujianfeng@huaweicloud.com> wrote:
>> It's worth mentioning that this issue is unlikely to occur in reality,
>> as it's impossible to have a depth of INT_MAX hierarchy, but should be
>> be avoided logically.
> 
> Strictly speaking the overflow would be undefined behavior (Out of curiousity --
> have you figured this out with a checker tool or code reading?)

Thanks for your review, I figured it out with code reading.


> Logically (neglecting UB), max_depth=INT_MAX would behave like intended
> (no limit).

Agreed, this is the real 'no limit'.

> 
>> Fixes: 1a926e0bbab8 ("cgroup: implement hierarchy limits")
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>  kernel/cgroup/cgroup.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Michal Koutný <mkoutny@suse.com>


