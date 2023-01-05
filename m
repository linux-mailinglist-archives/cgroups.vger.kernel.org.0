Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D645365E297
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 02:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjAEBnL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 20:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjAEBnH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 20:43:07 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957702F7BD;
        Wed,  4 Jan 2023 17:43:06 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NnTkY1FMDz4f4371;
        Thu,  5 Jan 2023 09:43:01 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbAnK7ZjJJR7BA--.63803S3;
        Thu, 05 Jan 2023 09:43:03 +0800 (CST)
Subject: Re: [PATCH] blk-cgroup: fix missing pd_online_fn() while activating
 policy
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230103112833.2013432-1-yukuai1@huaweicloud.com>
 <20230104151241.GA13268@blackbody.suse.cz>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4b559d1d-31e4-6049-4548-451bf7afb4f4@huaweicloud.com>
Date:   Thu, 5 Jan 2023 09:43:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230104151241.GA13268@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbAnK7ZjJJR7BA--.63803S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1rGFy7Cw4DGF1rJw13Jwb_yoWkJFX_Wr
        409rnrta1fXan7uFW3JryrXF95KrWIqrWUZr18t3yxJwn7tFZIkr10gryxuasxuw13AFy8
        GrWUWa10kryfWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
        Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Michal

在 2023/01/04 23:12, Michal Koutný 写道:
> Hello.
> 
> On Tue, Jan 03, 2023 at 07:28:33PM +0800, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>> If the policy defines pd_online_fn(), it should be called after
>> pd_init_fn(), like blkg_create().
> 
> Is this based only on code review or has it some negative effects?

This is based only on code review, currently the only negative effects
is that root blkg from blk-throtl won't call pd_online_fn().
> 
> I assume this would affect hot-plugged (read after cgroup creation) devices.
> 
> I took a cursory look at:
> 
> 	blkcg_init_disk
> 	  blkg_create
> 	    pol->pd_init_fn(blkg->pd[i]);
> 	    pol->pd_online_fn(blkg->pd[i]);
> 	  blk_throtl_init
> 	    blkcg_activate_policy
> 	      pol->pd_init_fn(blkg->pd[i]);
> 	      ?? pol->pd_online_fn(blkg->pd[i]);
> 
> I.e. the pd_online_fn is already called and pd_init_fn is called 2nd
> time?

No, this is not true, before blkcg_activate_policy() is called,
blkg_create() won't see this policy, hence pd_init_fn/pd_online_fn won't
be called from blkg_create().

Thanks,
Kuai
> 
> Thanks,
> Michal
> 

