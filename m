Return-Path: <cgroups+bounces-2647-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875868AC928
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 11:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866E61C2131B
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 09:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0857E777;
	Mon, 22 Apr 2024 09:42:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402E4317E;
	Mon, 22 Apr 2024 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778946; cv=none; b=MulEGP7W6DiN9/am9TCY38sL6ax8EAPMAB/C48vV17CruWOWZL4JhSewwcw2TdZDzczKipf7zYAyKyf3iPbI4EAjWEdIVxOIBLRHvaZoLCamJDZUHZzT6f8hKtj6kUsWP5So2R4QPCxX3DZJf+WphuWXcV9b8p7qyZb8Rkx5lbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778946; c=relaxed/simple;
	bh=7TlHmQJp8aYautVPKOtFwpAv0Dci5ZNsjmzZvfk2+Ws=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=l3eS2jU81DwcXVsQ+z3gM+rjDzBC05vGu+31WuQJyD2zaXnQFG1LicJiO9557tz9jq5f3ruAnnE8AumfI6qrvxCRqLTBXjXCPurRYNFQomVQ/pDu0Dp86EX97oVaW25AJZgvdfRH2f8tAXLeWQu+3R1m85y6seR/ZtHXBbBVtgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VNKzC32hZz4f3jJK;
	Mon, 22 Apr 2024 17:42:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 363A01A0568;
	Mon, 22 Apr 2024 17:42:20 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxD6MCZmJOqaKg--.46870S3;
	Mon, 22 Apr 2024 17:42:20 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: fix repeat limit on bio with
 BIO_BPS_THROTTLED
To: =?UTF-8?B?5ZGo5rOw5a6H?= <zhoutaiyu@kuaishou.com>,
 Yu Kuai <yukuai1@huaweicloud.com>, "tj@kernel.org" <tj@kernel.org>
Cc: "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240419120747.38031-1-zhoutaiyu@kuaishou.com>
 <ea781ccc-c29e-894e-c54a-f44ea349edca@huaweicloud.com>
 <e2d291e6b6ed43d89930eb2a7d459ff8@kuaishou.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6ab1172f-2c9a-ede3-8020-13c73b91db84@huaweicloud.com>
Date: Mon, 22 Apr 2024 17:42:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e2d291e6b6ed43d89930eb2a7d459ff8@kuaishou.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxD6MCZmJOqaKg--.46870S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4rtryfZF47Jw17Xr4ruFg_yoWDAFX_ua
	yUW3W0qr13Aw4vyrykGF13urWjgr4IqwnFvw4j9Fy7JryUArn5GF43XFZ3ZFnxGa1kGr9x
	JrZ8Xa43Cr1UXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
	UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/04/22 11:33, 周泰宇 写道:
>>>                 /* throtl is FIFO - if bios are already queued, should queue */
>>> -             if (sq->nr_queued[rw])
>>> +             if (sq->nr_queued[rw] && !bio_flagged(bio, BIO_BPS_THROTTLED))
>>   No, this change is wrong. Split IO will not be throttled by iops limit
> anymore.
> 
> After this change, the split IO will be throttled by iops limit again if it reaches a tg's iops limit and will not be throttled in any cases if the sq->queue is not empty.

Forgot to reply here,

The ponit here is that you break the rules about FIFO, blk-throttle
only judge the bio from head if it's within limit. Current code to judge
if tg iops reaches limit on the condition that no bio is throttled. And
throtl time is always caculated by first throttled bio. But this patch
will ignore throttled bio case, and that's why I said IO will not be
throttled by iops limist anymore. You can test this with bps limit
disabled.

Thanks,
Kuai


