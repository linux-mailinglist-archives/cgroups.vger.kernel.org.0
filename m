Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE3563DBEB
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 18:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiK3R0h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 12:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiK3R0g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 12:26:36 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6112B622
        for <cgroups@vger.kernel.org>; Wed, 30 Nov 2022 09:26:35 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id z9so8408616ilu.10
        for <cgroups@vger.kernel.org>; Wed, 30 Nov 2022 09:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04jXt74UY1VtpJun8zJvpOrg9ETd91QGiWVG7jWf27c=;
        b=WvC3pO7A3ARpOpPdif1K6HiRZlgxJ/CstMca+FL0z0mtnmuUqcKoo7VHwcnziQbl//
         jS+djIEAMLc6lTGvZY5l0345olBTCWEhjjBf2AwIsCgolZ6/oYAs4nRaDpNER5dVBDPX
         sMq55sqJV6jv7gUnQ9T9wCK5Ot9OmPWvJe6nVfnuDVVJ+yNpvB/rXR2CIqms+BoXDt/b
         cGMgh+Qnr74STBe8oISOcViGmkm95U61eut4IMPTZSmbN6vEEryfhATvELwBBA7mu2HZ
         M7HY7WxOOE05iMNJM1kZSIrGpPhFMAAZ6Ge2hcwHMejCi8rVAVCBXTEKfKbjqBx7pnTT
         MOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04jXt74UY1VtpJun8zJvpOrg9ETd91QGiWVG7jWf27c=;
        b=QH5RhGplIzOt2F8X5bDxftM7NOwlPRbCJxX8rp1IXy+DspqIh0U/3PFwvqLuOGqscH
         fOw40tVygrAlEdWdWK3tBeeDu0CXVA42AeTmvkNY8nkZS7BA1h31fNGSUoFtufd2oUqx
         ZuOvESdopydGtzA+4Cpk7+Vj8ZezOt8iwXMIXUCpvcqXwVxNNjpD3TgFntbBcPgDc0Il
         mrwxUE9KrqQl25W5jYgKLO8n1Dh2G6TJruBVQyXXVp6vlpCoQrfaAJ8gC5mQlnfTIix2
         ixjLc/yWlKmUH9jltdhXiXF8P0gK0F5EEDnzeU+llPIIgYhRPSSYHppRtmNdqk0MDe5o
         IbJA==
X-Gm-Message-State: ANoB5pl7co/6lTEd1J0hZ5nmaTVLZmHJMF3bm9LXn4TKeKyPeJxck8gd
        OtUu4CWDgM2yvdDklgMZ7Yia3Q==
X-Google-Smtp-Source: AA0mqf4+xJx0hE4uVatQ7H6ZQopio6F/vICz5HPoG9dJxBEnflwG6PUOg4lYyFxT+ASdvPdJ5OKkrg==
X-Received: by 2002:a05:6e02:80d:b0:303:afb:a98d with SMTP id u13-20020a056e02080d00b003030afba98dmr8960568ilm.74.1669829194557;
        Wed, 30 Nov 2022 09:26:34 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a92-20020a029465000000b003633748c95dsm750543jai.163.2022.11.30.09.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 09:26:34 -0800 (PST)
Message-ID: <c8a2fc0f-0bd3-b276-646f-cab97ba5bc34@kernel.dk>
Date:   Wed, 30 Nov 2022 10:26:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH -next v2 0/9] iocost bugfix
Content-Language: en-US
To:     Li Nan <linan122@huawei.com>, tj@kernel.org, josef@toxicpanda.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
References: <20221130132156.2836184-1-linan122@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221130132156.2836184-1-linan122@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/30/22 6:21 AM, Li Nan wrote:
> Li Nan (4):
>   blk-iocost: fix divide by 0 error in calc_lcoefs()
>   blk-iocost: change div64_u64 to DIV64_U64_ROUND_UP in
>     ioc_refresh_params()
>   blk-iocost: fix UAF in ioc_pd_free
>   block: fix null-pointer dereference in ioc_pd_init
> 
> Yu Kuai (5):
>   blk-iocost: cleanup ioc_qos_write() and ioc_cost_model_write()
>   blk-iocost: improve hanlder of match_u64()
>   blk-iocost: don't allow to configure bio based device
>   blk-iocost: read params inside lock in sysfs apis
>   blk-iocost: fix walk_list corruption
> 
>  block/blk-iocost.c | 117 ++++++++++++++++++++++++++++-----------------
>  block/genhd.c      |   2 +-
>  2 files changed, 75 insertions(+), 44 deletions(-)

Please include a changelog when posting later versions of a patchset.

-- 
Jens Axboe


