Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A105D61575D
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 03:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKBCLf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Nov 2022 22:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiKBCL1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Nov 2022 22:11:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88BB1F2F3
        for <cgroups@vger.kernel.org>; Tue,  1 Nov 2022 19:11:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so652764pji.0
        for <cgroups@vger.kernel.org>; Tue, 01 Nov 2022 19:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SbmauVFQEmSan6s50E+MhbGNKyCBU02VL+TZxUeQNvc=;
        b=M+6ltjJ5juYg7+NGiSDbW3SJhCoF8ZcirhbqZgwnqfhdeVdnq1FE+jcF+gAUmbEzgT
         rSuyovaIt3fTj8NcAmCIK5xfoVJayD2gnhiSf16hf8Li+Yc1NjQLumbPCWcHZYqO+XdF
         70JydiNX8/oytfjKZu1L1vVAXNsT1GblP7RBnsquWb6JEJ2uSh8myzViPJp7DhRZy3ZV
         TxmKZNGoWjnhXzLaCiXtsslVCxYantmR2eF/MVu4y7AiwLx5cqdBlg9dpCvwYUybOBn9
         +6mkJWhTbD5eIIJ/sFblBn1EfXpJ5DdDvKWFIydo7dKhU1Jw5licT8E5O8COV9cSsU9Z
         OGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbmauVFQEmSan6s50E+MhbGNKyCBU02VL+TZxUeQNvc=;
        b=q879eswt70MGbV72SBsUbPIaHCOIRBGjbNNKngLN3Ur2Pp8nQEqRv+kdHV4VNR9Iqs
         /JxBBCBdRf5WtFNkImFIcnPhZzUpHB6q0aFHps0KIBt50xo9ap4u4UVpW9EkUcWve1pR
         au0i+Ys+C/jTW/8C7C4LkMWIk31gTBdPUwgnKd8mI9Fn/HAgvy9btgu8p9DZGJ4K2tQy
         thMdu38LnyxCZ/pk7sAsvrIRuc1qr1944s5rTMXlT2+B887vCWYrW7WsKtz4oSpQRoZs
         u3p7WZPahOWG7wwQBv0xMmuUJrjKROav/TuoeRNeSip5a4VEOc3sDDy4kyjscqOlEWGR
         j5IQ==
X-Gm-Message-State: ACrzQf1eUcfsHZ3Y1FRSUgjTbzWRjnumJs0q/pdav31mI+YjozkKbT0x
        OHwThoctDqQ9QMtMDMLNjmuh8Q==
X-Google-Smtp-Source: AMsMyM6wYADM1GOKososBsPffvmpio0j6uQg8CrGRaj0/JMxGsBOTUyfq1SQu+pxwjJSoGf+mb3a2Q==
X-Received: by 2002:a17:902:8212:b0:186:a260:50a0 with SMTP id x18-20020a170902821200b00186a26050a0mr22157997pln.157.1667355085207;
        Tue, 01 Nov 2022 19:11:25 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902e54100b00177ff4019d9sm7010977plf.274.2022.11.01.19.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 19:11:24 -0700 (PDT)
Message-ID: <ee543096-ae21-99d3-f3a5-483deab03a5f@kernel.dk>
Date:   Tue, 1 Nov 2022 20:11:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH -next v4 1/5] block, bfq: remove set but not used variable
 in __bfq_entity_update_weight_prio
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz,
        paolo.valente@linaro.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
References: <20221102022542.3621219-1-yukuai1@huaweicloud.com>
 <20221102022542.3621219-2-yukuai1@huaweicloud.com>
 <7f7e59cb-e0b8-0db5-7c46-11aea963bcfa@kernel.dk>
In-Reply-To: <7f7e59cb-e0b8-0db5-7c46-11aea963bcfa@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/1/22 8:09 PM, Jens Axboe wrote:
> On 11/1/22 8:25 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> After the patch "block, bfq: cleanup bfq_weights_tree add/remove apis"),
>> the local variable 'bfqd' is not used anymore, thus remove it.
> 
> Please add a Fixes tag.

Looks like the rest were good to go, so I added it myself.

-- 
Jens Axboe


