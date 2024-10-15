Return-Path: <cgroups+bounces-5127-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F7E99E548
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 13:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325E8283E3A
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 11:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3943B1E377E;
	Tue, 15 Oct 2024 11:13:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684801D89F3;
	Tue, 15 Oct 2024 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990782; cv=none; b=bFPf8EPjeNOAgcNfgEN3AVGjlAgZNmN83rng3YVgzbtIl36ohx+3HFzj1tIPMOUSjBaz4Tl18NJQKRwICZm+sCV9NMH89KaKf5WS0l/BfFrtRkjNoYrvNpuKXFDWLuQYDQbl9BFgisr2+iXK38iwmi3mU9evUy8fdtpxoJWKWNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990782; c=relaxed/simple;
	bh=blOj5kaVfqgH/c/QOxdEfAHq0oDfRJ5JzIeLxGB40ak=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HrDoep0dorw9B2ai1QJqW2lxXqnhHnrCTew0W7WaVaQh7VK9iDPwEZ5yEVNlmiEgt5P95NypYUp4ix05ABbkLmd/pt04u+/TlNdER+UT/vHLcx8yYsTFuENe2gJgTUo7H8ocr8j6Z8hF2MWi4SCCOwKjr5u4Y1rQZ/okLM7zqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XSWfL6PC1z4f3kK5;
	Tue, 15 Oct 2024 19:12:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DEADF1A018D;
	Tue, 15 Oct 2024 19:12:54 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgAXTMg1Tg5nUMijEA--.19818S3;
	Tue, 15 Oct 2024 19:12:54 +0800 (CST)
Subject: Re: [PATCH] Revert "blk-throttle: Fix IO hang for a corner case"
To: Xiuhong Wang <xiuhong.wang@unisoc.com>, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: niuzhiguo84@gmail.com, ke.wang@unisoc.com, xiuhong.wang.cn@gmail.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20241011014724.2199182-1-xiuhong.wang@unisoc.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6a7cb48f-e3a2-8583-151b-423f85aabd17@huaweicloud.com>
Date: Tue, 15 Oct 2024 19:12:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241011014724.2199182-1-xiuhong.wang@unisoc.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXTMg1Tg5nUMijEA--.19818S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1UtFWfury8uF1fZry5Arb_yoW8XrWUp3
	4fGryj9r1Utwn0ka13ta43Was7Gws3KryxJF98Ar1Fqry3GryqgFsYkr1Y93WIvFZa9anF
	gF1DZr1DAFnIvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2024/10/11 9:47, Xiuhong Wang Ð´µÀ:
> This reverts commit 5b7048b89745c3c5fb4b3080fb7bced61dba2a2b.
> 
> The throtl_adjusted_limit function was removed after
> commit bf20ab538c81 ("blk-throttle: remove
> CONFIG_BLK_DEV_THROTTLING_LOW"), so the problem of not being
> able to scale after setting bps or iops to 1 will not occur.
> So revert this commit that bps/iops can be set to 1.
> 
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   block/blk-throttle.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
LGRM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 2c4192e12efa..443d1f47c2ce 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -1485,13 +1485,13 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
>   			goto out_finish;
>   
>   		ret = -EINVAL;
> -		if (!strcmp(tok, "rbps") && val > 1)
> +		if (!strcmp(tok, "rbps"))
>   			v[0] = val;
> -		else if (!strcmp(tok, "wbps") && val > 1)
> +		else if (!strcmp(tok, "wbps"))
>   			v[1] = val;
> -		else if (!strcmp(tok, "riops") && val > 1)
> +		else if (!strcmp(tok, "riops"))
>   			v[2] = min_t(u64, val, UINT_MAX);
> -		else if (!strcmp(tok, "wiops") && val > 1)
> +		else if (!strcmp(tok, "wiops"))
>   			v[3] = min_t(u64, val, UINT_MAX);
>   		else
>   			goto out_finish;
> 


