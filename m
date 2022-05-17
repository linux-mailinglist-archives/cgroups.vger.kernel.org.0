Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9073452A8E2
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 19:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351325AbiEQRHl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 13:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349851AbiEQRHk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 13:07:40 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB872DD4F;
        Tue, 17 May 2022 10:07:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p12so17498509pfn.0;
        Tue, 17 May 2022 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fCK6k5MFQxA5ofqm3sgSZqcQRtroxcs0pcd/twtbxgs=;
        b=BXxc1xeYwvdZuKq+L1ImlO+eEzBSBJ/fuHX1PvyDFx/UsMhB8eldZQyePIueHxk1ka
         x0le8JCihnmd+lLB7lUun6Ik3LDS4/HKxDUiuAcMZCeXOuxH0+3S3IE+r/d/9SaMXfKQ
         EMsw2iFrg7ptTTeORMukmKhFNWRDNT0RPWhL764/LTok3qS+VphpXFzecwxLPFB2LyF+
         3JiroJGsKWPBB034qarLfZgooLAbbFMYXN/D6i3JUHj98KZcGRgaD1QEBO4npkIbGwjj
         W+U0CD3+H7Q7jFxZuIN8VRKxuFnf1dCjqf+G8HPTWDJQfweDmxHBW6sykhvjwf6DtWZF
         6x/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fCK6k5MFQxA5ofqm3sgSZqcQRtroxcs0pcd/twtbxgs=;
        b=7q8Q2ggkus4u0eHaE+VeIxfRv2ImA04Wg9iLX1khwUCW67eWB04jLoR0a0EpF2ZXsE
         C8SqL/LXht8vt3ZxIfmcjVMINlhmVLUo0RoqEosUFTAu+BXUVrpk1+CI1W3IphdKKcPk
         nTut1G8iP3+UD2q6eg7LnZe4z0KZMxIvb8oBxoLEGmgtVAPxJmxJgHlyVvaFJbJ//W3g
         1wYZIpgthYh6mh4qG6D02UtXMGt1MOMIfAuS+JjGPOtOaW9xFbT+ve1l3eEDwbx7QV8U
         omujZx9uvUv4XXpOOVfDkca5x73M9gdO4F7qaosw7B76w1avwRM6cAWOIQFPjaZ5h6yk
         qSTg==
X-Gm-Message-State: AOAM5309cdTc6QLPTRycBWNZA3TQA4PJglvA0shctVojq7v9JmuOvJZG
        6Hl+25etyFjvir2gnzdNPTQ=
X-Google-Smtp-Source: ABdhPJyNGwepD8x1cdj5gJZVkkmn4ELWeZkvnKu07JbvIhVyndcrPOzUTZ2WbCbPr7Fr0QudvMyLZA==
X-Received: by 2002:a63:6c0a:0:b0:3ab:894f:8309 with SMTP id h10-20020a636c0a000000b003ab894f8309mr20453802pgc.536.1652807258966;
        Tue, 17 May 2022 10:07:38 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:62fc])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a7f8b00b001cd4989fee6sm1895296pjl.50.2022.05.17.10.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 10:07:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 17 May 2022 07:07:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Shida Zhang <starzhangzsd@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, zhangshida@kylinos.cn,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup: fix potential null pointer risk
Message-ID: <YoPWWfoZ+6PrHuJl@slm.duckdns.org>
References: <20220517073106.1704628-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517073106.1704628-1-zhangshida@kylinos.cn>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 17, 2022 at 03:31:06PM +0800, Shida Zhang wrote:
> We previously assumed 'parent' could be null,
> so null pointer judgment should be added.
> 
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  kernel/cgroup/cgroup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index adb820e98f24..7f230b0ab644 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5701,7 +5701,8 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
>  	}
>  	spin_unlock_irq(&css_set_lock);
>  
> -	cgroup1_check_for_release(parent);
> +	if (parent)
> +		cgroup1_check_for_release(parent);

The function is never called for a root cgroup. The parent check up above in
the same function is superflous. So, maybe remove that?

Thanks.

-- 
tejun
