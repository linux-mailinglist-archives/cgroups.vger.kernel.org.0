Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF74528DE6
	for <lists+cgroups@lfdr.de>; Mon, 16 May 2022 21:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbiEPT3Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 May 2022 15:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiEPT3P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 May 2022 15:29:15 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBB72B195;
        Mon, 16 May 2022 12:29:14 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id a191so15013318pge.2;
        Mon, 16 May 2022 12:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mXWRWurGOojMt9BoJ/ZUzDoEo2cNP5eq4Kyj7hbR+eI=;
        b=YQsJY8b5fAVtiYmvMVSWoltJPRNnqMY3pKrwMyJDgJmEUKtZKCtCKahQQJM5+X8LC9
         uOmw7vSwYGbgzB4AqWOaQK3LVp9h+50SfmIuNtD8LYZYCYN9eIuZ/r/BGgpLsDcR4TEl
         FJXKlfrpNTlFkDGl3guVkFdEYjbxNgcBYkFkKYHnOb1EloheVPX8UnOQBM2Mu7DDqD8W
         EKsO+bc55zlCuxwpg3oKT/psVgapFxAezTVnF+ijUcwAMpPBOl/2GPkGi3Age9azCjnp
         v/QPcVVBo3hTi7jpSKCIvmm1xnN1VMaEGLLvdS5+Lsg9TSeduxOpSZh/h+Ego3oZrSU6
         OSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mXWRWurGOojMt9BoJ/ZUzDoEo2cNP5eq4Kyj7hbR+eI=;
        b=AIM99f5egRak9wjMFl53fDURiZTo0ReMrpAY6ZDpMVgkD3+Hk+nEHLcgaEcSF5dDZq
         kXrND9wogtYOFYdh2bcEoQzvBs4cJZLZaDH7dngNHn+xb9EzP0oyBMuz8MoVF7bO+aYJ
         WrwOx6NryuMnHyPlQRiBun8jrm5ZnC2aGoP8XL6PZNdRWOMtTynDmXJlSdOe9ZdF/rEf
         23MU9Uw/zDWHkvX+W01fdrCFmouiMbi+fy4CiZVDO8oOtQpIPhiJUD8M5rYpUBKdW2R+
         B9YULHVxGEdtQ0zzWZdwYJNK1krxpWTnZu6ZDv1JRfMR4naJ1FYgk599N1E+IAcB/poo
         p9Aw==
X-Gm-Message-State: AOAM5316U47RMIJqNWb7WSztIXwYQxu/TbI779ORcYTIt5TfLuJ1B+MR
        D0XJVvLo8W1uYs9Md5YUgrc=
X-Google-Smtp-Source: ABdhPJw6hBzA9K8aN7MLWKU4EqiK5gb5wqxfIjClPwNyTuXppc0KM+WyBWQFSU9cef1SAhHHjvKffg==
X-Received: by 2002:a62:170b:0:b0:50a:6901:b633 with SMTP id 11-20020a62170b000000b0050a6901b633mr18849708pfx.34.1652729354389;
        Mon, 16 May 2022 12:29:14 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:62fc])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b0015f2d549b46sm7397092plh.237.2022.05.16.12.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 12:29:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 16 May 2022 09:29:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zhang Wensheng <zhangwensheng5@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH -next] block: fix io hung of setting throttle limit
 frequently
Message-ID: <YoKmCOAzwzw3Lz7g@slm.duckdns.org>
References: <20220516014429.33723-1-zhangwensheng5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516014429.33723-1-zhangwensheng5@huawei.com>
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

On Mon, May 16, 2022 at 09:44:29AM +0800, Zhang Wensheng wrote:
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 469c483719be..8acb205dfa85 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -1321,12 +1321,14 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
>  	 * that a group's limit are dropped suddenly and we don't want to
>  	 * account recently dispatched IO with new low rate.
>  	 */
> -	throtl_start_new_slice(tg, READ);
> -	throtl_start_new_slice(tg, WRITE);
> +	if (!timer_pending(&sq->parent_sq->pending_timer)) {
> +		throtl_start_new_slice(tg, READ);
> +		throtl_start_new_slice(tg, WRITE);
>  
> -	if (tg->flags & THROTL_TG_PENDING) {
> -		tg_update_disptime(tg);
> -		throtl_schedule_next_dispatch(sq->parent_sq, true);
> +		if (tg->flags & THROTL_TG_PENDING) {
> +			tg_update_disptime(tg);
> +			throtl_schedule_next_dispatch(sq->parent_sq, true);
> +		}

Yeah, but this ends up breaking the reason why it's starting the new slices
in the first place explained in the commit above, right? I'm not sure what
the right solution is but this likely isn't it.

Thanks.

-- 
tejun
