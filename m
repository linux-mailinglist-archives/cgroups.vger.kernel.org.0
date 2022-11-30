Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027AB63E225
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 21:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiK3Uco (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 15:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiK3UcC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 15:32:02 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E7F54475;
        Wed, 30 Nov 2022 12:31:30 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so3470050pjj.4;
        Wed, 30 Nov 2022 12:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zERogrghEXBrjx46RlEGcBUab/oF8o5TSfDWdWk3204=;
        b=CbBJH1iSFlP/+nWb9lr6aDG63sPp/lrVxYD5U9xyWoQntUFWySjlkoLu5qHG6HjIGf
         XG+btjog3tUDwuH4Zx62q9zDDXiniyM0ILQ94Y8hyBEF5bAxpXwloJxWsNMeB2WTH2bW
         M0SWvKno+eCyw3zJIrlZPSVggxp0wo44y6OFZl1Wbg64Ds+TWOepX6dVmaBCvLPGo2zg
         VdWK8QSRqkSvOOwa4d3HX1VnjliG25vSJcSSHftki7wTOsmOjNYBaiQL6fC3nJNkKfkI
         PJA/7D1kOpFCnZaYehRAFxs8Lh3fRmjLMRRTMRSFAqjJG6PyRS6DAC82ODpJbPIMKiKY
         hH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zERogrghEXBrjx46RlEGcBUab/oF8o5TSfDWdWk3204=;
        b=KJOynGteEWKTvwQtX/AlZ60JeDhVeC7KOJDb4yEO0nkeqB8KB9uV+QKYkCTY4MTgn6
         UIbBDA9/lqnNTbTq+BLYym+VVx8/Yk3fqBsaCP7cGE3CjvYg46JRlb6rpsAxPwOLk0sm
         7h/bwi3CqgWhERStAEcmMnBUBCHJ8oZE4pNOu87ZHSfGjTGnq7sK+tJIVZZPLKqH98Kr
         6+5FSSlorwK3eRfn+G2GzSJsrLePV/AqdtBFqy0vh3Iwmfepr2WV2cvMGJTKdrrJHZdd
         Ef7m+70d4tOf+jMhNT9DlqhyAnu99i0EOTe9p9MrweU6pfw6B2h9WWgWpzgQ/tOufHV0
         XMrg==
X-Gm-Message-State: ANoB5pm3EzcRhU7Wyk3M5mKNoUvia/tD7wI+OlfJBS9WolQiM897rJC0
        RFAx6TwfIM4wT6VX3qJiDUw=
X-Google-Smtp-Source: AA0mqf4VM80Ds16sfnw7neteYzn/Ov1p8FE5iG3YyqDlZxPhDtrE9KPBjmNgn6cwqx3CRV7oc7Y4Ew==
X-Received: by 2002:a17:902:bf06:b0:17b:d6ad:94c8 with SMTP id bi6-20020a170902bf0600b0017bd6ad94c8mr57718162plb.110.1669840289398;
        Wed, 30 Nov 2022 12:31:29 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d13-20020aa797ad000000b00574a82bb877sm1760832pfq.203.2022.11.30.12.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:31:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 10:31:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Nan <linan122@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 1/9] blk-iocost: cleanup ioc_qos_write() and
 ioc_cost_model_write()
Message-ID: <Y4e9n89vJ45+9WD2@slm.duckdns.org>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-2-linan122@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130132156.2836184-2-linan122@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 30, 2022 at 09:21:48PM +0800, Li Nan wrote:
> @@ -3197,6 +3197,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
>  	enable = ioc->enabled;
>  	user = ioc->user_qos_params;
>  
> +	ret = -EINVAL;
>  	while ((p = strsep(&input, " \t\n"))) {
>  		substring_t args[MAX_OPT_ARGS];
>  		char buf[32];
> @@ -3218,7 +3219,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
>  			else if (!strcmp(buf, "user"))
>  				user = true;
>  			else
> -				goto einval;
> +				goto out_unlock;

So, I kinda dislike it. That's a lot of code to cover with one "ret =
-EINVAL" assignment which makes it pretty easy to make a mistake. People use
variables like i, ret, err without thinking much and it doesn't help that
you now can't tell whether a given exit condition is error or not by just
looking at it.

I don't know what great extra insight the return value from match_u64()
would carry (like, what else is it gonna say? and even if it does why does
that matter when we say -EINVAL to pretty much everything else) so I'm not
sure this matters but if you really want it just add a separate error return
label?

Thanks.

-- 
tejun
