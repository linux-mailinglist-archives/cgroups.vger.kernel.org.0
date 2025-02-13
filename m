Return-Path: <cgroups+bounces-6529-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 103DAA3349F
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 02:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BE7188A0E8
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 01:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EF6132103;
	Thu, 13 Feb 2025 01:27:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26D186349;
	Thu, 13 Feb 2025 01:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739410039; cv=none; b=Y/jIof7qHiLdpjmZ3pSo2w52v4ULeSKEfwcInZbNfvB1MPek8qe9xpPjfBvD4Z9Fv+Or5n6Jqcqx6BnSkGemedqMWKg525ay1rvNT2cw6HEpFZNniKuw83l0NJ3t+Ey9GPaw+OM5xuUZ5kkXIKp8e8leaxhiFy1hQaeB15/nlZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739410039; c=relaxed/simple;
	bh=TCm5BAMNTDYEnSG5kZoN/Oq2zatcj9gc5r0PcZI02qA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=l/+ljC5dX8+qitHFq6WcjuAd4MTqBOIktA3R87U15bcw5T8yzFHBUrRFyKaROtO6XjG0Aj6n297+gqXHL3JmLEEzZDeFPD+Xr0qu7BSt0rlDBhXZhzyqCJczgHieSaYDkesmyEYrCNb58WrC1S//ff6jdXn8Y6Un0SwQxYWG4ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YtcwT4588z4f3khS;
	Thu, 13 Feb 2025 09:26:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DC84E1A1743;
	Thu, 13 Feb 2025 09:27:10 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB32l5tSq1ndWXBDg--.7430S3;
	Thu, 13 Feb 2025 09:27:10 +0800 (CST)
Subject: Re: [PATCH] block: Check blkg_to_lat return value to avoid NULL
 dereference
To: Wentao Liang <vulab@iscas.ac.cn>, tj@kernel.org, josef@toxicpanda.com,
 axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250212083203.1030-1-vulab@iscas.ac.cn>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8793e238-1b12-5ce9-e9d6-e936750109b2@huaweicloud.com>
Date: Thu, 13 Feb 2025 09:27:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250212083203.1030-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB32l5tSq1ndWXBDg--.7430S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4ftFWUXw1fXr47ZrW5KFg_yoW8AFyxpw
	48WwsFy3yrWr47XF1xKa1rCryrCr4UKFyUCrs8A34FkF1S9F4rtF1rZ3W5tFWFyrWUCw4D
	Jr15tF9Yvr45C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsU
	UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/02/12 16:32, Wentao Liang Ð´µÀ:
> The function blkg_to_lat() may return NULL if the blkg is not associated
> with an iolatency group. In iolatency_set_min_lat_nsec() and
> iolatency_pd_init(), the return values are not checked, leading to
> potential NULL pointer dereferences.
> 
> This patch adds checks for the return values of blkg_to_lat and let it
> returns early if it is NULL, preventing the NULL pointer dereference.
> 
> Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
> Cc: stable@vger.kernel.org # 4.19+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   block/blk-iolatency.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index ebb522788d97..398f0a1747c4 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -787,6 +787,8 @@ static int blk_iolatency_init(struct gendisk *disk)
>   static void iolatency_set_min_lat_nsec(struct blkcg_gq *blkg, u64 val)
>   {
>   	struct iolatency_grp *iolat = blkg_to_lat(blkg);
> +	if (!iolat)
> +		return;
>   	struct blk_iolatency *blkiolat = iolat->blkiolat;
>   	u64 oldval = iolat->min_lat_nsec;

This is not needed, this is called from iolatency_set_limit() or
iolatency_pd_offline() where the policy data can't be NULL.
>   
> @@ -1013,6 +1015,8 @@ static void iolatency_pd_init(struct blkg_policy_data *pd)
>   	 */
>   	if (blkg->parent && blkg_to_pd(blkg->parent, &blkcg_policy_iolatency)) {
>   		struct iolatency_grp *parent = blkg_to_lat(blkg->parent);
> +		if (!parent)
> +			return;

blkg_to_pd() already checked, how can this be NULL?

Thanks,
Kuai
>   		atomic_set(&iolat->scale_cookie,
>   			   atomic_read(&parent->child_lat.scale_cookie));
>   	} else {
> 


