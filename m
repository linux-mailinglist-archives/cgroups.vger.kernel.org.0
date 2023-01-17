Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7465566D3BB
	for <lists+cgroups@lfdr.de>; Tue, 17 Jan 2023 02:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjAQBCJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Jan 2023 20:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjAQBCH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Jan 2023 20:02:07 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E85D222E0;
        Mon, 16 Jan 2023 17:02:04 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NwrFd6mJ2z4f3tDB;
        Tue, 17 Jan 2023 09:01:57 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgA35CGG88VjI6vKBg--.26932S3;
        Tue, 17 Jan 2023 09:02:00 +0800 (CST)
Subject: Re: [PATCH] blk-cgroup: fix missing pd_online_fn() while activating
 policy
To:     Yu Kuai <yukuai1@huaweicloud.com>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230103112833.2013432-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1d490092-09b2-d1ec-ebfe-195113cef0a3@huaweicloud.com>
Date:   Tue, 17 Jan 2023 09:01:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230103112833.2013432-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgA35CGG88VjI6vKBg--.26932S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JF1kur1fGrW8Wr15Kw1rZwb_yoWfCFc_ua
        4kZFy7tFsxA3WI9F1vyFyrXrZYkrW0qr42gF95KryxJF1DJay2yw1agw1UWay7CFyfGFyr
        uFyqgr4ktr95ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
        VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Jens

ÔÚ 2023/01/03 19:28, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> If the policy defines pd_online_fn(), it should be called after
> pd_init_fn(), like blkg_create().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Can you apply this patch?

Thanks,
Kuai
> ---
>   block/blk-cgroup.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index ce6a2b7d3dfb..4c94a6560f62 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1455,6 +1455,10 @@ int blkcg_activate_policy(struct request_queue *q,
>   		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
>   			pol->pd_init_fn(blkg->pd[pol->plid]);
>   
> +	if (pol->pd_online_fn)
> +		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
> +			pol->pd_online_fn(blkg->pd[pol->plid]);
> +
>   	__set_bit(pol->plid, q->blkcg_pols);
>   	ret = 0;
>   
> 

