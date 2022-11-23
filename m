Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E77C635A43
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 11:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbiKWKin (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 05:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237648AbiKWKiW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 05:38:22 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776A55587;
        Wed, 23 Nov 2022 02:22:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NHHHm2nWcz4f3jJ2;
        Wed, 23 Nov 2022 18:22:28 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgBXTq1l9H1jf7LWAw--.34344S3;
        Wed, 23 Nov 2022 18:22:30 +0800 (CST)
Subject: Re: [PATCH v2 4/5] blk-iocost: fix sleeping in atomic context
 warnning
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de,
        josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221104023938.2346986-1-yukuai1@huaweicloud.com>
 <20221104023938.2346986-5-yukuai1@huaweicloud.com>
 <Y3K8MSFWw8eTnxtm@slm.duckdns.org>
 <3da991c6-21e4-8ed8-ba75-ccb92059f0ae@huaweicloud.com>
 <Y306xJV6aNXd94kb@slm.duckdns.org>
 <1f52ccb1-c357-a2a0-ef9d-48d7e2eb51f8@kernel.dk>
 <Y31sYFdA2lHIvjt3@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ec3754a6-3249-51ab-b659-fd795884e346@huaweicloud.com>
Date:   Wed, 23 Nov 2022 18:22:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y31sYFdA2lHIvjt3@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXTq1l9H1jf7LWAw--.34344S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZFW3JFyUJF1kWF13KFWktFb_yoWxZrcEq3
        yq9r4qqws8AFsakF1DtryUJFZakF4jqrW7XrW0qF13A340v3W5XrZFqFsagr13JrW0qFs8
        uryUArWYgr4xGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Tejun

ÔÚ 2022/11/23 8:42, Tejun Heo Ð´µÀ:
> On Tue, Nov 22, 2022 at 05:14:29PM -0700, Jens Axboe wrote:
>>>> Then match_strdup() and kfree() in match_NUMBER() can be replaced with
>>>> get_buffer() and put_buffer().
>>>
>>> Sorry about the late reply. Yeah, something like this.

Thanks for the feedback. I'll remove patch 4 from this seies and send a
new patch separately soon.

Thanks,
Kuai
>>
>> Doesn't local_irq_disable() imply preemption disable as well?
> 
> Right, I was thinking about spin_lock_irq() which doesn't imply disabling
> preemption in PREEMPT_RT. local_irq_disable() is actual irq disable even on
> RT. It should be fine on its own.
> 
> Thanks.
> 

