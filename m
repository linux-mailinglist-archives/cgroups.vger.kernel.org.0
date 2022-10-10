Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10765FA62B
	for <lists+cgroups@lfdr.de>; Mon, 10 Oct 2022 22:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJJU24 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 16:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiJJU2h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 16:28:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C44786ED;
        Mon, 10 Oct 2022 13:26:54 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id h13so10258072pfr.7;
        Mon, 10 Oct 2022 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVV8n5eD6h2TRn2sT93lXmeC6TkQyEPF4f8atiLgu/c=;
        b=IdIHWhIt/4LgFLk+ereoqBvDtQJrdY25MOknBRDc33BecqWtkmyV/jj6U4i8dWshGJ
         OUEqTDFnF0lZPvp3uWNQQK7tBMTGQPJo6as+UVRUem5njExsBj6X0E8zmiWJdIYM5Bvb
         5kklJ0NNraGUI4mKfH9xSMlvXi5dPm3Ldbns8rg6Y3S/mZt99lamxDMqZmtF6NGwc1vO
         txDWxxVQNZaKFn2zPbdP/t4jJvAm6xaEWGhGKgg/NxbKDypNmkbKPieOY9iGzHClSYeG
         lcg55CCl6gZtjHfvLr7yJvLNe+oZEc6Viuw8kLjCYFzdO0y3fSPWDlXm1jgJUdfLaHjD
         CYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVV8n5eD6h2TRn2sT93lXmeC6TkQyEPF4f8atiLgu/c=;
        b=ob9dJ69A9X7Gt4m+OCUCo6T6IHRz1QjKNzknQ98r1Bjcls2UESGvCz72+JtDCCwiTO
         /uFH0ARnXqYvtfQ63nhdhO6jibMUMfCGBE5n47SDuvUlYN7XuVYRNlHvzXYyZFKa+iv0
         M9Bj4+TtWHXoGGGI7Ee2k+dxvqia6ZMOV8uX9TweglnSyb+4JogMZ3wsfQGiEa6vm9Iu
         Nl1xD0NzE9JD3F+lFMAJQ6UzBPs/BDjeBfraKaXtcFinfWwGPmnALdXUPbxH+UIDSx0s
         +lpGDQoOEzEg6ouaKmBTguDD9UIs5/g3cRhd+8CT/WvAOQ48P1CLkIyMwM2Ero08Q/Lu
         ulqA==
X-Gm-Message-State: ACrzQf0XsRN1wDevpQBIDepAmZca+2+7hbztDiImgmGp2ctR6vVDxy1q
        hOeiLNSHYGUBZ++SyrLsUt0=
X-Google-Smtp-Source: AMsMyM5DUq8BBmtBCtYtnKq2ezJNl+BZ2BlgOTTciMu1ii3hZ3g5BY3VqNXOYXu2U64dlDaibqe1Pw==
X-Received: by 2002:a63:d54a:0:b0:454:395a:73d6 with SMTP id v10-20020a63d54a000000b00454395a73d6mr18340097pgi.531.1665433612539;
        Mon, 10 Oct 2022 13:26:52 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id kx14-20020a17090b228e00b0020d24a9ad1fsm3641084pjb.52.2022.10.10.13.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 13:26:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Oct 2022 10:26:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] blk-cgroup: correct comment for blk_alloc_queue and
 blk_exit_queue
Message-ID: <Y0SACpAv4+ETrS6Z@slm.duckdns.org>
References: <20221010023859.11896-1-shikemeng@huawei.com>
 <20221010023859.11896-3-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010023859.11896-3-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 10, 2022 at 10:38:57AM +0800, Kemeng Shi wrote:
> Since commit 1059699f87eb("block: move blkcg initialization/destroy into
> disk allocation/release handler"), blk_alloc_queue and blk_exit_queue is
> called directly from gendisk. Update the corresponding comment.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
> ---
>  block/blk-cgroup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index bc4dec705572..463c568d3e86 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1259,7 +1259,7 @@ static int blkcg_css_online(struct cgroup_subsys_state *css)
>   * blkcg_init_queue - initialize blkcg part of request queue
>   * @q: request_queue to initialize
>   *
> - * Called from blk_alloc_queue(). Responsible for initializing blkcg
> + * Called from gendisk. Responsible for initializing blkcg

Maybe be a bit more specific and say blk_alloc_disk()?

>   * part of new request_queue @q.
>   *
>   * RETURNS:
> @@ -1321,7 +1321,7 @@ int blkcg_init_queue(struct request_queue *q)
>   * blkcg_exit_queue - exit and release blkcg part of request_queue
>   * @q: request_queue being released
>   *
> - * Called from blk_exit_queue().  Responsible for exiting blkcg part.
> + * Called from gendisk.  Responsible for exiting blkcg part.

Ditto.

-- 
tejun
