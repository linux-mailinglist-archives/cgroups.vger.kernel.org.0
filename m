Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C86B63685C
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 19:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbiKWSOa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 13:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbiKWSNi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 13:13:38 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226D9DFAF;
        Wed, 23 Nov 2022 10:10:00 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso2859182pjt.0;
        Wed, 23 Nov 2022 10:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42jiVvL+Ts2qh8Knn9mc2OntlNZr+ruehTRXIYJtsgE=;
        b=kGEGxym2YsPDl+okJR+jAn9W99iCg2L5fctazVNfEVJQ6iw7n7XVcxJnKnNmYjd6g6
         u6u6XnwbjVrt0w8j72DAle4dZGDdtfBW8X9zTc81l5maOtamqMfUIaUQwafb8lOvrWGO
         qINUff3Ku+XIthIeKcEVc7busmkpJoMzZYZYaogshvbYljNoFzNiXCuVjwBalmvJcrBT
         RIfqC8i+i1MU6as4+/8XsNCXD8L1AVZJFkyLTtmZ81dFQjtaSLreuez9uTMsF/jZZw3n
         QQ7uwWxo01UW971auvwjUE1twN8Qs0LmIOAV+H8FsQetN7TJ3taVuownfeYPwHTjHQqC
         G7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42jiVvL+Ts2qh8Knn9mc2OntlNZr+ruehTRXIYJtsgE=;
        b=rL0Et8rbi5utMRm1jglbVoT20scF8yu09lounWABPOHCFD82LnkpOifrjL0b5wffWk
         zAH4OkcScRSWEogI0c4PLLzrbEijSx+eMilO0P7iQp3Q/5I8kbmge52N08RKx5iQwsy6
         8DST1boSqPbBq/h8+jDhpUGBBb82lQqqs3XYUz6J5baB09JpwEDMLs5Soyc5ExbT2WXU
         Pqrm87jdaV8ns/DQcRFArK5qtMUFpKCgwimnHSJtkgl6uurE2IUrhxsf2GnHCiTKW55F
         qZo2VK4PriHKUaTOBPVjk74a4sgyhfuiripe7uGxsVsLar3s213lMWXQVmLVwm+TX1Ni
         La6Q==
X-Gm-Message-State: ANoB5plYYOwB1ZPKTRJVrP/N7GmUQcWeJjWmn6Md5f2+V4q1YRxU0ot0
        8IxBYEDhq16bA+AtMhATqNc=
X-Google-Smtp-Source: AA0mqf5kuG7tARTAIVt0J36rhq6lFOFV3bxt97HboHYXGMYzhr0PyTXjm63gzdQX3EzbzSmCwQy7sw==
X-Received: by 2002:a17:902:ea06:b0:186:abaf:8fe with SMTP id s6-20020a170902ea0600b00186abaf08femr23078476plg.95.1669226999341;
        Wed, 23 Nov 2022 10:09:59 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w11-20020aa79a0b000000b0056bad6ff1b8sm12932685pfj.101.2022.11.23.10.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:09:58 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Nov 2022 08:09:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] blk-throttle: Fix that bps of child could exceed
 bps limited in parent
Message-ID: <Y35h9SmFeEJtBNgM@slm.duckdns.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-3-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123060401.20392-3-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 02:03:52PM +0800, Kemeng Shi wrote:
> @@ -964,10 +963,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
>  	unsigned int bio_size = throtl_bio_data_size(bio);
>  
>  	/* Charge the bio to the group */
> -	if (!bio_flagged(bio, BIO_BPS_THROTTLED)) {
> -		tg->bytes_disp[rw] += bio_size;
> -		tg->last_bytes_disp[rw] += bio_size;
> -	}
> +	tg->bytes_disp[rw] += bio_size;
> +	tg->last_bytes_disp[rw] += bio_size;

Are you sure this isn't gonna lead to double accounting? IIRC, the primary
purpose of this flag is avoiding duplicate accounting of bios which end up
going through the throttling path multiple times for whatever reason and
we've had numerous breakages around it.

To address the problem you're describing in this patch, wouldn't it make
more sense to set the flag only when the bio traversed the entire tree
rather than after each tg?

Thanks.

-- 
tejun
