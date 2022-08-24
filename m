Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ED059F0BD
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 03:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiHXBPj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 21:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiHXBPg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 21:15:36 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E763B942;
        Tue, 23 Aug 2022 18:15:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MC7Qv4vmsz6S686;
        Wed, 24 Aug 2022 09:13:59 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgBXQLy0ewVjY6sPAw--.59906S3;
        Wed, 24 Aug 2022 09:15:33 +0800 (CST)
Subject: Re: [PATCH v8 1/4] blk-throttle: fix that io throttle can only work
 for single bio
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, mkoutny@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220823033130.874230-1-yukuai1@huaweicloud.com>
 <20220823033130.874230-2-yukuai1@huaweicloud.com>
 <YwUXTL+8E/sPcEUB@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <73c72914-e27d-b261-e040-2dd31e8a6b9f@huaweicloud.com>
Date:   Wed, 24 Aug 2022 09:15:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YwUXTL+8E/sPcEUB@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBXQLy0ewVjY6sPAw--.59906S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4xZr4fGr13Xr18Zr15CFg_yoWfWrc_ZF
        4YyrWxGw18uFs7AF1jyF45WrZIgrWfW3s7uw4vgFy7tw1rA3s09Fs5Kr92yrW5X3yrKr9I
        qw109ayrCryS9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j
        6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
        04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Tejun

ÔÚ 2022/08/24 2:07, Tejun Heo Ð´µÀ:
> Hello,
> 
> Should have asked you earlier but with the BIO_THROTTLED flag setting from
> clone removed, with single BIO_THROTTLED flag, does the fix still require
> bytes subtraction? If we can do single flag and we don't need the bytes
> subtraction, might as well just stay with single flag?

Do you mean 'compensate the over-accounting' for bytes subtraction? If
so, yes, it's not required.

This patch actually set two flags when bio is throttled and
dispatched, and only iops flag is cleared after the original bio is
split. If only one flag can be used, the way that I come up with is
that let iops limit become default, which means bio is always counted
for iops limit each time blk_throtl_bio() is called. I'm not quite
sure yet if iops limit can be counted excessively this way in some
special scenario...

Thanks,
Kuai
> 
> Thanks.
> 

