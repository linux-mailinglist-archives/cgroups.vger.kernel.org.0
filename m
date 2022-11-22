Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C636348F0
	for <lists+cgroups@lfdr.de>; Tue, 22 Nov 2022 22:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKVVKc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Nov 2022 16:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiKVVKb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Nov 2022 16:10:31 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBAE7CB95;
        Tue, 22 Nov 2022 13:10:30 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f9so10896209pgf.7;
        Tue, 22 Nov 2022 13:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+KEqUPpt9nBZhy2l32eLRwk2q2Rg4+1eaxUkvjjhgg=;
        b=hC1R8VpRUm1vtCVrxmHeI+RFvGrfUTgxzJDsTjqJnYDMfgLrcdlSQuqYhPvY/Ngiq8
         YsJqRaFeRDIFWRDrW9MQKFf+YhGpvvEE5JQp6I7LE/fbFPycigIFZVC50Mn7T81Rc0ip
         SpacCnKP0Cv8PWm/lx6EslA0e0XeGhuBFY1S80wuP3an5Ehy7+Du23j1TktTHFLf3g/X
         xqpe587AjbUhmVWzf7e8zF8uXlCPo3vftSKmyF+LypLxS97o0nf1yo/ZCnmc70DYJF2C
         xCNElSexSwgXjaNE3Ig8aTcZB/CYj0DlUtMBK+bALBMYuDlHh711uqPYnLmKjKocyIR5
         DyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+KEqUPpt9nBZhy2l32eLRwk2q2Rg4+1eaxUkvjjhgg=;
        b=iMwfLciWIW2zFcp08JYbyorkU/18boVs50jlDqcjgrQ43oKz9KeDpZ+uW0+uoctAD9
         p7OlD+f4lKqPurUiEfz9DYtMVDLAcTBWTiRL2L89bMKJY1GTxTK10JRZZwFUQx2tlmEB
         HqSFGglmlRn6MelvE9Px2ZMG9dxmpNvF4GsEBS4qv50l+R5bFBIivf7f8CVgpANiVJMB
         96Xi54+lFCFm/3lmXtekLM8M17yzRZ5M9e71fSZHnrB5XBd3G5KA5E0M9LmBpvoWuFdW
         4Q/WwELjuG1XAtxiCEkpBSL4Bwo9gVRTNZvUU6r82KQaxOMifTlEfHjHaAoiwVJnzYvQ
         He6g==
X-Gm-Message-State: ANoB5pkORTFZkm4VSqpcreETztTfkPc8ne2KJKz+rXsYFgS6y111cKEC
        9iOGyRqBHuJJv7qM1Dqz3Zg=
X-Google-Smtp-Source: AA0mqf6TsDpRKKyxDHKrpggRE8TEmiZt0DJaKX3yDhZBcH1LKsFTJaLXufIb42rblcCx6ncdMDdGYQ==
X-Received: by 2002:a62:16d3:0:b0:562:c1d4:e287 with SMTP id 202-20020a6216d3000000b00562c1d4e287mr5701810pfw.80.1669151430256;
        Tue, 22 Nov 2022 13:10:30 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:bb3])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f54900b00176a2d23d1asm12659611plf.56.2022.11.22.13.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 13:10:29 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Nov 2022 11:10:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 4/5] blk-iocost: fix sleeping in atomic context
 warnning
Message-ID: <Y306xJV6aNXd94kb@slm.duckdns.org>
References: <20221104023938.2346986-1-yukuai1@huaweicloud.com>
 <20221104023938.2346986-5-yukuai1@huaweicloud.com>
 <Y3K8MSFWw8eTnxtm@slm.duckdns.org>
 <3da991c6-21e4-8ed8-ba75-ccb92059f0ae@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3da991c6-21e4-8ed8-ba75-ccb92059f0ae@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 17, 2022 at 07:28:50PM +0800, Yu Kuai wrote:
> Hi, Tejun!
> 
> 在 2022/11/15 6:07, Tejun Heo 写道:
> 
> > 
> > Any chance I can persuade you into updating match_NUMBER() helpers to not
> > use match_strdup()? They can easily disable irq/preemption and use percpu
> > buffers and we won't need most of this patchset.
> 
> Does the following patch match your proposal?
> 
> diff --git a/lib/parser.c b/lib/parser.c
> index bcb23484100e..ded652471919 100644
> --- a/lib/parser.c
> +++ b/lib/parser.c
> @@ -11,6 +11,24 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
> 
> +#define U64_MAX_SIZE 20
> +
> +static DEFINE_PER_CPU(char, buffer[U64_MAX_SIZE]);
> +
> +static char *get_buffer(void)
> +{
> +       preempt_disable();
> +       local_irq_disable();
> +
> +       return this_cpu_ptr(buffer);
> +}
> +
> +static void put_buffer(void)
> +{
> +       local_irq_enable();
> +       preempt_enable();
> +}
> +
> 
> Then match_strdup() and kfree() in match_NUMBER() can be replaced with
> get_buffer() and put_buffer().

Sorry about the late reply. Yeah, something like this.

Thanks.

-- 
tejun
