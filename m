Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1487B6801D7
	for <lists+cgroups@lfdr.de>; Sun, 29 Jan 2023 22:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbjA2Vsy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 29 Jan 2023 16:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjA2Vsy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 29 Jan 2023 16:48:54 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDBF199EE
        for <cgroups@vger.kernel.org>; Sun, 29 Jan 2023 13:48:52 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o13so9454822pjg.2
        for <cgroups@vger.kernel.org>; Sun, 29 Jan 2023 13:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3orRjVyl8TlIILy5P9DmDDw4aLYfFk+iiK2J9hLXKM8=;
        b=K1fLjf+3hEV58xhvHFnsNkPRmfFbB/yPlBUiSkM2CGxnZWzGSqtk3KPkx/ha0qH3ZL
         UKBWyX3E+s/0xU9Zz8QEPIxguy8r0W4uChf90dCI7oDJs7z6Xit2L4Ta5Xze4aK5G7tv
         FOsD3TnzR8xOKdHZEO4CsX2VJFgrAz5On4sCtcTX21R/BUdUqP0BMQ3GZNfUpClv8w4J
         xWlqFlMyL2XxrVsk/HOj/vTQrXWSJwPmqqgCiOqy/yPTe8WtXA5FWBlcar420KcW7b/o
         gdPKdWaDk9ql92NcXajcU66E8LOcwnb3ynt0bPiEOJ7CuBm/IzYAQVKhHDDRheSz+Lav
         ESxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3orRjVyl8TlIILy5P9DmDDw4aLYfFk+iiK2J9hLXKM8=;
        b=0ip4nA4W4C6RwC6z0Gt1xcXBSwYHBXGZZ2ezxfUFthPaogDKB3cAilg2bMGM4ekk8V
         eYLdL4nkcGW3iwwWHuAv8ldv+zLNgvYeMC6drp/+KOFXlXG8HJiGAaJXQbVnb7j2Dghj
         iJry7wL6JktsebxIEMEp0CYwXuCdK3aIsT66BUJpo5y34UKY9tQ4Pd9XiFhsoXHnIET/
         J6iDa33FS75qJ8SyFXHOput4MIKUqA44j8DF6upYlKMvaXpiaHk1oEvwc8FFzcPhhk9O
         F8s74qKZfQ16IkdNf8XQi7XGu1idLD/CBGClbo5gqP1+e6v2gpxafQdD/aZG/jr9NJ/z
         sAGg==
X-Gm-Message-State: AO0yUKWwd+x3aygsuYfe3UBtb9AUPDCRO+51qTPnb1f91cezSCVAGiok
        xJJTgu8CxFXt3CFV7tkh0223ag==
X-Google-Smtp-Source: AK7set8sn285dS0tWhTaXsZyp4VGl6Ck61LRwry33MMUVU7h5UKben3xxPKsHAiLBzReoMqefybw0g==
X-Received: by 2002:a05:6a20:93a1:b0:bc:f665:8656 with SMTP id x33-20020a056a2093a100b000bcf6658656mr522892pzh.6.1675028932258;
        Sun, 29 Jan 2023 13:48:52 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w127-20020a628285000000b005939fe1719fsm2546003pfd.39.2023.01.29.13.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 13:48:51 -0800 (PST)
Message-ID: <7f3221eb-d5c1-5018-cdcc-979d436fa386@kernel.dk>
Date:   Sun, 29 Jan 2023 14:48:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH -next v3 0/3] blk-cgroup: make sure pd_free_fn() is called
 in order
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, tj@kernel.org, hch@lst.de,
        josef@toxicpanda.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230119110350.2287325-1-yukuai1@huaweicloud.com>
 <bd1c347b-cbf8-3917-401a-ed85c6ccb956@kernel.dk>
 <0ddce9e4-d027-0bb0-d260-093ccc4c2d4d@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0ddce9e4-d027-0bb0-d260-093ccc4c2d4d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/28/23 11:06 PM, Yu Kuai wrote:
> Hi, Jens
> 
> 在 2023/01/20 2:54, Jens Axboe 写道:
>> On 1/19/23 4:03 AM, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Changes in v3:
>>>   - add ack tag from Tejun for patch 1,2
>>>   - as suggested by Tejun, update commit message and comments in patch 3
>>>
>>> The problem was found in iocost orignally([1]) that ioc can be freed in
>>> ioc_pd_free(). And later we found that there are more problem in
>>> iocost([2]).
>>>
>>> After some discussion, as suggested by Tejun([3]), we decide to fix the
>>> problem that parent pd can be freed before child pd in cgroup layer
>>> first. And the problem in [1] will be fixed later if this patchset is
>>> applied.
>>
>> Doesn't apply against for-6.3/block (or linux-next or my for-next, for
>> that matter). Can you resend a tested one against for-6.3/block?
>>
> 
> This is weird, I just test latest linux-next, and I can apply this
> patchset on the top of following commit:
> 
> For latest for-6.3/block, this patch 2 can't be applied because
> following commit is not here:
> 
> e3ff8887e7db blk-cgroup: fix missing pd_online_fn() while activating policy
> 
> But this patch is already merged into 6.2-rc5.

Since I have one more conflict, I think we'll just rebase for-6.3/block
when -rc6 is out, and then it should apply cleanly.

-- 
Jens Axboe


