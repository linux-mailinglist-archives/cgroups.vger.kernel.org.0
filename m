Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1010965F8A6
	for <lists+cgroups@lfdr.de>; Fri,  6 Jan 2023 02:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjAFBJE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 20:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbjAFBIw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 20:08:52 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B6C6E406;
        Thu,  5 Jan 2023 17:08:50 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Np4wX3DgXz4f3jZN;
        Fri,  6 Jan 2023 09:08:44 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgDX9zGddLdjAipoBA--.21111S3;
        Fri, 06 Jan 2023 09:08:47 +0800 (CST)
Subject: Re: [PATCH v2 1/2] blk-iocost: add refcounting for iocg
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221227125502.541931-1-yukuai1@huaweicloud.com>
 <20221227125502.541931-2-yukuai1@huaweicloud.com>
 <Y7XzUee5Bq+DoIC1@slm.duckdns.org>
 <c63ee2ad-23d5-3be0-c731-28494398b391@huaweicloud.com>
 <Y7cX0SJ0y6+EIY5Q@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7dcdaef3-65c1-8175-fea7-53076f39697f@huaweicloud.com>
Date:   Fri, 6 Jan 2023 09:08:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y7cX0SJ0y6+EIY5Q@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX9zGddLdjAipoBA--.21111S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JF48WF15Kry8Cr1fWF48JFb_yoWfKrcE9F
        Wqv397Ca1kta1vvw1Ikr4kXrZxGr45XryDWaykGr97Xw1FqF4UWrsrWa4fZayrCay8ArZr
        JFWUtr47t34agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

在 2023/01/06 2:32, Tejun Heo 写道:
> On Thu, Jan 05, 2023 at 09:14:07AM +0800, Yu Kuai wrote:
>> 1) is related to blkg, while 2) is not, hence refcnting from blkg can't
>> fix the problem. refcnting from blkcg_policy_data should be ok, but I
>> see that bfq already has the similar refcnting, while other policy
>> doesn't require such refcnting.
> 
> Hmm... taking a step back, wouldn't this be solved by moving the first part
> of ioc_pd_free() to pd_offline_fn()? The ordering is strictly defined there,
> right?
> 

Moving first part to pd_offline_fn() has some requirements, like what I
did in the other thread:

iocg can be activated again after pd_offline_fn(), which is possible
because bio can be dispatched when cgroup is removed. I tried to avoid
that by:

1) dispatch all throttled bio io ioc_pd_offline()
2) don't throttle bio after ioc_pd_offline()

However, you already disagreed with that. 😔

Thanks,
Kuai

> Thanks.
> 
> --
> tejun
> .
> 

