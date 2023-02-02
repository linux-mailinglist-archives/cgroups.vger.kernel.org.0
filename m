Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025406872E1
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 02:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjBBBQ7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 20:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBBBQ6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 20:16:58 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9AEB468;
        Wed,  1 Feb 2023 17:16:57 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P6gqS19g3z4f3p1C;
        Thu,  2 Feb 2023 09:16:52 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyEED9tjk3haCg--.4548S3;
        Thu, 02 Feb 2023 09:16:54 +0800 (CST)
Subject: Re: [PATCH -next] block, bfq: cleanup 'bfqg->online'
To:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        paolo.valente@linaro.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230201120609.4151432-1-yukuai1@huaweicloud.com>
 <20230201131037.6frw2kpc54k4sx7a@quack3>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <76f00d0a-b8d9-ab04-329c-3ba33d12d884@huaweicloud.com>
Date:   Thu, 2 Feb 2023 09:16:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230201131037.6frw2kpc54k4sx7a@quack3>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyEED9tjk3haCg--.4548S3
X-Coremail-Antispam: 1UD129KBjvdXoWrur4kCF4xWw15AF1UZrW5Wrg_yoWxuwcEkF
        ZF9Fnayw13Ga1xZws8JF1YqFWkuw4agrZIgFWYg348Z3W8Xa92yFnrKF97Ar4fWFs7Gr1Y
        yay7uFW8tr13XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Jan!

ÔÚ 2023/02/01 21:10, Jan Kara Ð´µÀ:
> On Wed 01-02-23 20:06:09, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> After commit dfd6200a0954 ("blk-cgroup: support to track if policy is
>> online"), there is no need to do this again in bfq.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> So I agree this is nice to do but it isn't so simple. BFQ relies on the
> fact that 'online' is cleared under bfqd->lock so we cannot associate bio
> in bfq_bio_bfqg() with a bfqg that has already its bfq_pd_offline()
> function run.
> 
> Maybe if you set 'online' to false before calling ->pd_offline() things
> would work fine for BFQ.

Yes, you're right. Thanks for the explanation.

Kuai

