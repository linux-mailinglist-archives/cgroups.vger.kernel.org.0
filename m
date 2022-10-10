Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C085FA63D
	for <lists+cgroups@lfdr.de>; Mon, 10 Oct 2022 22:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJJUar (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 16:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJJUaD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 16:30:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70AD4A10B;
        Mon, 10 Oct 2022 13:29:19 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso11311286pjk.1;
        Mon, 10 Oct 2022 13:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qr1zRzW9mIDZS/nVxaVGHN2uZpMu0+zVTkGmRH0RCk0=;
        b=eCblmHQH4kyDc1eYk4XHk4yv5M7ka130o2+oGxoV8jwDPHThtNZPex0/wfw3fFx6V5
         8KOVo4KL30D1u7o2Ml5xYgwgjmfLOQ9rCreqVe1R7811ITpYjqT3obRQrlUF9dPU9f1G
         1JYXHZouF9Wh/oQXgxqi2iYMGduftdCuGx5HJtQLoPmeX85KvGmJdixnplooQkslRqaR
         NbjyTeop3s4FJi2H4tsQTSWoz2ehNfudk0lKTwWtUHQ0YqoRCPAaPdRPHhkhf/UEnLzb
         MzLbw76gk5sa58/NTbRCF8ONslpZW+g74EIqDj/QIWOY5qChntmvRCBzZrFV7YGpSo1m
         ruXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qr1zRzW9mIDZS/nVxaVGHN2uZpMu0+zVTkGmRH0RCk0=;
        b=UD53Y2MgwAvSUsr9NmNaZKs+WhOMdooOPhu/nrh718/RgWXiTdsSVfwW+nvXIKLM4j
         2vqZuJYr9l2Yglc2blQaxBsJYYLBOYuZFuh8/Zjc2iMYxIIufhoR6FL9wn/9aV8IchCE
         M1VitHiuXA7q5T7gc0RwBL6SoNfsk+5MjVirh5/JKldtd6q67YuQrXfJoj2ZzZEgTK5b
         yFu0gkANOo/fV07tVM9sHhlqd+4ZjW8I4nRKaVCuhDpHTMnBJx0ppg6tVZ6J5rQubjZp
         ODG0fZUPmAmlDyim9L8bPS4CkIVdrHEezOVtoHQzpymL7LsH/hRkxRDAp85oQe3nG7UI
         OVyA==
X-Gm-Message-State: ACrzQf1LOKhhGsk0aui3Lyei4JP+gmqwpAMIr2LWKSybZoAhO2O6Rtcg
        caFJosXM+/j9L4FMQcm5zNE=
X-Google-Smtp-Source: AMsMyM5QZfvMNL3geDk0VyZBRfz4d9MhxQ8DeLzdTZP+kyfa+mlT+j5kCI75yYbPjej5H3CJ7115Cw==
X-Received: by 2002:a17:90b:1e46:b0:20a:f9d8:1ff7 with SMTP id pi6-20020a17090b1e4600b0020af9d81ff7mr29480230pjb.34.1665433759042;
        Mon, 10 Oct 2022 13:29:19 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j5-20020a170903024500b00178650510f9sm7084934plh.160.2022.10.10.13.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 13:29:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Oct 2022 10:29:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] blk-cgroup: Add NULL check of pd_alloc_fn in
 blkcg_activate_policy
Message-ID: <Y0SAneaJadYJwAkr@slm.duckdns.org>
References: <20221010023859.11896-1-shikemeng@huawei.com>
 <20221010023859.11896-4-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010023859.11896-4-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 10, 2022 at 10:38:58AM +0800, Kemeng Shi wrote:
> Function blkcg_policy_register only make sure pd_alloc_fn and pd_free_fn in
> pairs, so pd_alloc_fn could be NULL in registered blkcg_policy. Check NULL
> before use for pd_alloc_fn in blkcg_activate_policy to avoid protential
> NULL dereference.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
> ---
>  block/blk-cgroup.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 463c568d3e86..fc083c35dc42 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1404,6 +1404,9 @@ int blkcg_activate_policy(struct request_queue *q,
>  	if (blkcg_policy_enabled(q, pol))
>  		return 0;
>  
> +	if (pol->pd_alloc_fn == NULL)
> +		return -EINVAL;

This isn't the only place this function is called, so the above won't
achieve much. Given that this is rather trivially noticeable and all the
current users do implement pd_alloc_fn, I'm not sure we need to update this
now.

Thanks.

-- 
tejun
