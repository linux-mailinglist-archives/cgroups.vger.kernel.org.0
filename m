Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E4C53736B
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 03:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiE3Bx5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 29 May 2022 21:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiE3Bx5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 29 May 2022 21:53:57 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E1DA1A045;
        Sun, 29 May 2022 18:53:55 -0700 (PDT)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Cxf+avI5RiXrQHAA--.38136S3;
        Mon, 30 May 2022 09:53:51 +0800 (CST)
Subject: Re: [PATCH] cgroup: wait for css offline when rmdir
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1653619158-27607-1-git-send-email-zhanghongchen@loongson.cn>
 <YpCQZ5RRnxwh7fmK@slm.duckdns.org>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <e74e03f1-cb54-b158-a085-2965fd088d1d@loongson.cn>
Date:   Mon, 30 May 2022 09:53:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YpCQZ5RRnxwh7fmK@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Cxf+avI5RiXrQHAA--.38136S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GryrCFWfKryfCry7Wry3Arb_yoWDtrX_Wa
        4Iyryku3sruF1DCayUtr43ZayagrWj9rykJFWkWw4IkFyfKFWDWF17ur1fXwnxWF43trnr
        GrZIyr1Sqw4avjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU5PpnJUUUUU==
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/5/27 下午4:48, Tejun Heo wrote:
> On Fri, May 27, 2022 at 10:39:18AM +0800, Hongchen Zhang wrote:
>> when remove a cgroup dir, make sure all the csses associated which
>> the cgroup are all offlined,so that we will be sure that the resources
>> allocated by the csses are all freed when rmdir exit successfully.
> 
> Offlining doesn't guarantee that resources are freed and there's no definite
> time limit on how long it'd take to free all resources. e.g. for memcg, if
> there isn't sufficient memory pressure, its page cache can remain
> indefinitely. Is there something practical you're trying to achieve?
> 
> Thanks.
> 
Hi Tejun,
   When I test the LTP's memcg_test_3 testcase at 8 Node server,I get 
the -ENOMEM error,which caused by no avaliable idr found in mem_cgroup_idr.
the reason is the use of idr in mem_cgroup_idr is too fast than the 
free.In the specific case,the idr is used and freed cyclically,so when 
we rmdir one cgroup dir, we can synchronize the idr free through wating 
for the memcg css offlined,and then we can use it the next cycle.

Thanks.

