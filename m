Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569D45832E6
	for <lists+cgroups@lfdr.de>; Wed, 27 Jul 2022 21:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbiG0THL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jul 2022 15:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbiG0TGs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jul 2022 15:06:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B407F30568;
        Wed, 27 Jul 2022 11:39:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p8so16754118plq.13;
        Wed, 27 Jul 2022 11:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=Ue/qng0G6/T7z25ofGVIpnj/GBz8+9KlthmZo7Y7nzA=;
        b=lVjgOWA3Yt4/zF583HvCtBgZmEUdV7jQ8kpUvthCo7bGHXr+5QzLvWBhq3vezRTzxP
         hmvEZlHshegK9r0H8gAnvU1NsNkHldzSXvPTOIxB26eK/pdbzXDWFOW16prZVrDQc8XL
         Oxz4Dd0r3vlqcyIpIOBv4ui19CHW8Hg5J2K+B291qp/KjvXSehj7yJQyAdVgfF5yV3pE
         grV7L/3XK1giJ7hK/HuymByfPovtngc1rLvxC2tyghK3y0eTt19URLbpzOOkPbCA6IIJ
         nOUUPL9ibblope8STVvu7gfCY5dmL20SOO3heSGj/3TV60qDwDG/7UAKF+/Ei5OiOR1b
         5EXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=Ue/qng0G6/T7z25ofGVIpnj/GBz8+9KlthmZo7Y7nzA=;
        b=n3XCA1hYdlpGFjqwfHySpdS0IYqamuV9h69TrmuDv1Ckn56iEyCsjti4VjIfBguDRa
         +KkxkRRgLf+f8vngyvpOiC0bLWicHHxuclWC430D7KCOkqbykG9Z1qp7NxOvmGIBhRe8
         +ExWaEphUAX0xmOqJqP9waNGA0kN7HXTTYqm/W8qOUAdbGcCbIUeBJj4ieXgaArG8SeH
         l2qGy3dj0ko+diUpUxANpSbV3RVtugVMyzaCnDW/Gu+1xjH/5/zPxV1yZQCOmS2bW8GF
         rNcM9Ve/Rk2Jw1gQxhZ9N8ARymR1VmTAvYwZp6ZXixHErTxxKsK+C/psIrdKOKXHvS7D
         q/GA==
X-Gm-Message-State: AJIora/QQlFrgNzN+qOTb+5SKGMEvnjwQq1QfTRnptLgvZ/QymsJgM/a
        xzp2R+ekeAG171GakWKLc1s=
X-Google-Smtp-Source: AGRyM1vnag1MmDolO7wRK7G+TcrLdHxEoHjar3DdNvxLLX1LCmVM/UZD7rS8xkfe11/eZw14RVZZqg==
X-Received: by 2002:a17:902:8f87:b0:16c:2c88:39ec with SMTP id z7-20020a1709028f8700b0016c2c8839ecmr23741337plo.52.1658947162020;
        Wed, 27 Jul 2022 11:39:22 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:5a55])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903121200b0016cd74e5f87sm14243712plh.240.2022.07.27.11.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 11:39:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Jul 2022 08:39:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH RESEND v6 4/8] blk-throttle: fix io hung due to config
 updates
Message-ID: <YuGGVxdlOVk/eF2l@slm.duckdns.org>
References: <20220701093441.885741-1-yukuai1@huaweicloud.com>
 <20220701093441.885741-5-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701093441.885741-5-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Jul 01, 2022 at 05:34:37PM +0800, Yu Kuai wrote:
> +static void __tg_update_skipped(struct throtl_grp *tg, bool rw)
> +{
> +	unsigned long jiffy_elapsed = jiffies - tg->slice_start[rw];
> +	u64 bps_limit = tg_bps_limit(tg, rw);
> +	u32 iops_limit = tg_iops_limit(tg, rw);
> +
> +	/*
> +	 * Following calculation won't overflow as long as bios that are
> +	 * dispatched later won't preempt already throttled bios. Even if such
> +	 * overflow do happen, there should be no problem because we are using
> +	 * unsigned here, and bytes_skipped/io_skipped will be updated
> +	 * correctly.
> +	 */
> +	if (bps_limit != U64_MAX)
> +		tg->bytes_skipped[rw] +=
> +			calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
> +			tg->bytes_disp[rw];
> +	if (iops_limit != UINT_MAX)
> +		tg->io_skipped[rw] +=
> +			calculate_io_allowed(iops_limit, jiffy_elapsed) -
> +			tg->io_disp[rw];

I'm not quiet sure this is correct. What if the limit keeps changing across
different values? Then we'd be calculating the skipped amount based on the
last configuration only which would be incorrect.

It's probably more straight-forward if the code keeps track of the total
budget allowed in the period somewhere and keeps adding to it whenever it
wanna calculates the current budget - sth like:

  tg->bytes_budget[rw] += calculate_bytes_allowed(limit, jiffies - tg->last_budget_at);
  tg->last_budget_at = jiffies;

then, you'd always know the correct budget.

> +}
> +
> +static void tg_update_skipped(struct throtl_grp *tg)
> +{
> +	if (tg->service_queue.nr_queued[READ])
> +		__tg_update_skipped(tg, READ);
> +	if (tg->service_queue.nr_queued[WRITE])
> +		__tg_update_skipped(tg, WRITE);
> +
> +	throtl_log(&tg->service_queue, "%s: %llu %llu %u %u\n", __func__,
> +		   tg->bytes_skipped[READ], tg->bytes_skipped[WRITE],
> +		   tg->io_skipped[READ], tg->io_skipped[WRITE]);
> +}

Also, please add a comment explaining what this is all about. What is the
code trying to achieve, why and how?

Thanks.

-- 
tejun
