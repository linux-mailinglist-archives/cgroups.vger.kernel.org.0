Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B8740C18C
	for <lists+cgroups@lfdr.de>; Wed, 15 Sep 2021 10:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbhIOIW0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Sep 2021 04:22:26 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16259 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhIOIWZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Sep 2021 04:22:25 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H8Y7H3Zk7z8t9Q;
        Wed, 15 Sep 2021 16:20:27 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 16:20:55 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 15 Sep 2021 16:20:55 +0800
Subject: Re: [RFC PATCH] blk-throttle: enable io throttle for root in cgroup
 v2
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20210909140815.2600858-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <6ea924a3-6a19-ef9d-1741-26c8aaf6429e@huawei.com>
Date:   Wed, 15 Sep 2021 16:20:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210909140815.2600858-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/09/09 22:08, Yu Kuai wrote:
> We want to limit the overall iops/bps of the device in cgroup v2,
> however "io.max" or "io.min" do not exist in root cgroup currently,
> which makes it impossible.
> 
> This patch enables io throttle for root cgroup:
>   - enable "io.max" and "io.min" in root
>   - don't skip root group in tg_iops_limit() and tg_bps_limit()
>   - don't skip root group in tg_conf_updated()
> 
> I'm not sure why this feature is disabled in the first place, is
> there any problem or design constraint?
> 
Ping...

BTW, sorry about the misspell of "io.low".
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-throttle.c | 13 ++-----------
>   1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 55c49015e533..fffe072de538 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -302,9 +302,6 @@ static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
>   	struct throtl_data *td;
>   	uint64_t ret;
>   
> -	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
> -		return U64_MAX;
> -
>   	td = tg->td;
>   	ret = tg->bps[rw][td->limit_index];
>   	if (ret == 0 && td->limit_index == LIMIT_LOW) {
> @@ -332,9 +329,6 @@ static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
>   	struct throtl_data *td;
>   	unsigned int ret;
>   
> -	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
> -		return UINT_MAX;
> -
>   	td = tg->td;
>   	ret = tg->iops[rw][td->limit_index];
>   	if (ret == 0 && tg->td->limit_index == LIMIT_LOW) {
> @@ -1430,9 +1424,8 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
>   		struct throtl_grp *parent_tg;
>   
>   		tg_update_has_rules(this_tg);
> -		/* ignore root/second level */
> -		if (!cgroup_subsys_on_dfl(io_cgrp_subsys) || !blkg->parent ||
> -		    !blkg->parent->parent)
> +		/* ignore root level */
> +		if (!cgroup_subsys_on_dfl(io_cgrp_subsys) || !blkg->parent)
>   			continue;
>   		parent_tg = blkg_to_tg(blkg->parent);
>   		/*
> @@ -1771,7 +1764,6 @@ static struct cftype throtl_files[] = {
>   #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
>   	{
>   		.name = "low",
> -		.flags = CFTYPE_NOT_ON_ROOT,
>   		.seq_show = tg_print_limit,
>   		.write = tg_set_limit,
>   		.private = LIMIT_LOW,
> @@ -1779,7 +1771,6 @@ static struct cftype throtl_files[] = {
>   #endif
>   	{
>   		.name = "max",
> -		.flags = CFTYPE_NOT_ON_ROOT,
>   		.seq_show = tg_print_limit,
>   		.write = tg_set_limit,
>   		.private = LIMIT_MAX,
> 
