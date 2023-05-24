Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1510570EEB9
	for <lists+cgroups@lfdr.de>; Wed, 24 May 2023 08:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239772AbjEXG6C (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 May 2023 02:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239779AbjEXG5a (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 May 2023 02:57:30 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C39F1A7;
        Tue, 23 May 2023 23:57:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QR26n3Hwrz4f41V7;
        Wed, 24 May 2023 14:57:05 +0800 (CST)
Received: from [10.67.110.112] (unknown [10.67.110.112])
        by APP1 (Coremail) with SMTP id cCh0CgBHsixBtW1kQx8JJg--.55618S2;
        Wed, 24 May 2023 14:57:06 +0800 (CST)
Message-ID: <c56473be-facb-e0ea-246c-bdd5bf74c7cd@huaweicloud.com>
Date:   Wed, 24 May 2023 14:57:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] cgroup: Remove out-of-date comment in
 cgroup_migrate()
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230523111456.146053-1-xiujianfeng@huaweicloud.com>
 <ZG0PYH7a9Mw50bEl@slm.duckdns.org>
From:   Xiu Jianfeng <xiujianfeng@huaweicloud.com>
In-Reply-To: <ZG0PYH7a9Mw50bEl@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgBHsixBtW1kQx8JJg--.55618S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr48tFy7JrWUCrWrKFyfWFg_yoWxuFc_Wr
        4jv3y8Zr95W3W7Kr1SvF4fZFn5Gr15Wr15Gw4Fka43u3WUta4rXFn7CF9aqrWrXFsF9wn8
        CFnYv3yUXr12yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/5/24 3:09, Tejun Heo wrote:
> On Tue, May 23, 2023 at 07:14:56PM +0800, Xiu Jianfeng wrote:
>> From: Xiu Jianfeng <xiujianfeng@huawei.com>
>>
>> Commit 674b745e22b3 ("cgroup: remove rcu_read_lock()/rcu_read_unlock()
>> in critical section of spin_lock_irq()") has removed the rcu_read_lock,
>> which makes the comment out-of-date, so remove it.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> So, that removed rcu_read_lock() because it's implied by the irq disable but
> the comment content is still useful in describing what's preventing
> use-after-free. Can you please update the comment accordingly instead?

sure, I would send a v2.

> 
> Thanks.
> 

