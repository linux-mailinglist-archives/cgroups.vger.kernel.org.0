Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AF957A3B9
	for <lists+cgroups@lfdr.de>; Tue, 19 Jul 2022 17:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbiGSPyA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jul 2022 11:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239365AbiGSPx7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jul 2022 11:53:59 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D34554065
        for <cgroups@vger.kernel.org>; Tue, 19 Jul 2022 08:53:58 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n138so10901151iod.4
        for <cgroups@vger.kernel.org>; Tue, 19 Jul 2022 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=v1/mZ9f7cOQb8+ydXwQHj4wRnkN1M8Bc/FKE5w38Qoo=;
        b=TAy5/MJ1dGREUTw++0rn1OsT9njCelvr5d2NkxrRX43BITG0YKrQAyqJizhPcyflpY
         +NkzAKjawOfO12hI2a54ONGCIYwM4mGbTv3H8uADXh8QLGkgB76Hpa8koUrU3/D5yWsh
         Z7nsOAI40BxnHcTuB844wOBee7bp8nEJwl1q61tbUnrjtdP/81PyZXtG8zpVnvZ7X01O
         wqmupWWlWIM8vdG3/9/7Az9v9QdqPk192VEXnvs6RktHQ0fmvjdsca32UyWa/pIQ4qKA
         nyhXXHGUvSedFCDzOpAvxSapKw6BQz3EWLlkvk/6tR1qD8Ug5Y0qgZUxH23b606dOuK8
         mILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v1/mZ9f7cOQb8+ydXwQHj4wRnkN1M8Bc/FKE5w38Qoo=;
        b=3CiotiJZ/EDmje4hVRX6VwPWO1GOtf6bwk8+7gBJmbV5/BTW8p8MUXR7exTEjcZbW0
         8VlgvjQkveiHKfrjmSxJm9UAh0o1hBYBUr4I+eOfRz76xEiEQ7+GI0UMRVnodRqA30nO
         H3nGo6m1i5ftHlNJmrTtNUEWEythN5qHT9gXnT97EQzg8DIVj8pjbJ19Mw/cP7/G91ms
         AvydbdiNp83fQZE1c4C5bkvnNJYjAO+eocrBXl17MX2wn8qk473+liKCEq69UkFSTb+Z
         j2PptknF+0d7LATk13Xh6OTzcIg9ULlAy8WC+atN7Y0qbjpFTPCXmJQ6YNkqIpNgAx6o
         jKbA==
X-Gm-Message-State: AJIora9BN5t3WbJZt1GxgjUQ4aM6ipP+WHs7NGA8HKcgTE2vJn9CLaUj
        87Gt3GIkrqIA1hVzyn+YTxdNHg==
X-Google-Smtp-Source: AGRyM1uNh9xokZg13JMUA6Inpkfv83YkDREhinJsCHDu/K6Y656SAZ38DSvmaA00FqT4+Jo6uwLKdQ==
X-Received: by 2002:a05:6638:13d0:b0:33f:8aa8:194b with SMTP id i16-20020a05663813d000b0033f8aa8194bmr16295587jaj.268.1658246037493;
        Tue, 19 Jul 2022 08:53:57 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x1-20020a0566380ca100b0033f42a99fafsm6846245jad.121.2022.07.19.08.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 08:53:57 -0700 (PDT)
Message-ID: <724b2b60-d32c-0785-dfe9-79e208f8f662@kernel.dk>
Date:   Tue, 19 Jul 2022 09:53:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] block: don't allow the same type rq_qos add more than
 once
Content-Language: en-US
To:     Jinke Han <hanjinke.666@bytedance.com>, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <20220719070258.25721-1-hanjinke.666@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220719070258.25721-1-hanjinke.666@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/19/22 1:02 AM, Jinke Han wrote:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> In our test of iocost, we encounttered some list add/del corrutions of

encountered and corruptions

> inner_walk list in ioc_timer_fn.
> 
> The reason can be descripted as follow:

described

> cpu 0						cpu 1
> ioc_qos_write					ioc_qos_write
> 
> ioc = q_to_ioc(bdev_get_queue(bdev));
> if (!ioc) {
>         ioc = kzalloc();			ioc = q_to_ioc(bdev_get_queue(bdev));
> 						if (!ioc) {
> 							ioc = kzalloc();
> 							...
> 							rq_qos_add(q, rqos);
> 						}
>         ...
>         rq_qos_add(q, rqos);
>         ...
> }
> 
> When the io.cost.qos file is written by two cpu concurrently, rq_qos may

two cpus

> be added to one disk twice. In that case, there will be two iocs enabled
> and running on one disk. They own different iocgs on their active list.
> In the ioc_timer_fn function, because of the iocgs from two ioc have the
> same root iocg, the root iocg's walk_list may be overwritten by each
> other and this lead to list add/del corrutions in building or destorying

leads to, corruptions, destroying.

Outside of the spelling and grammer which I typically just fix up while
applying, this one doesn't apply to for-5.20/block. Please check and
resend it.

-- 
Jens Axboe

