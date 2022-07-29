Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6265854E9
	for <lists+cgroups@lfdr.de>; Fri, 29 Jul 2022 20:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbiG2SFj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Jul 2022 14:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbiG2SFi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Jul 2022 14:05:38 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ED631239;
        Fri, 29 Jul 2022 11:05:37 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c139so5281293pfc.2;
        Fri, 29 Jul 2022 11:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=b3I3Wd5uoU2mw0WjpZItI4QYfcDbHg7o2KRFjsrrXS4=;
        b=MFZhFPxWjQT/AD66vBooRiM7DvdG0EMVeb1MZqQW1gnlohBjG0tG6G4gFQ8y5MQHHt
         wKJQh2aI7ESROLlHeYoPDqfSS2I9hYM9FOZu8veptRvbOb1WxOHAJKQLIGJITK0/WqYZ
         pMic5o6McoHyopQ6RFVu6maQc8DQYD9TeIINQcGLryUKh4ylJRS+EpYjSobPJtbqA9vv
         ZeP0t9Vvmg2sNBxzFVWUz05TEcIeskcViZqCXseCwuaJZJtIabY3zg4jGjbF39rHTQh5
         C6lQEDlokzoDRtPCiuPGArFalZgQe2y7s4kD0STJ14/qKc8/uQ/Jty84ioLsmPdNV/Uz
         IspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=b3I3Wd5uoU2mw0WjpZItI4QYfcDbHg7o2KRFjsrrXS4=;
        b=C+xsUHncEhnv4BX4xNImUlFZ59A+EQ8OUZkMClf0HcuJRLaS+r32UF08Axu3aUFsd4
         fZOnAC4c2Z/iWHyppDl7k7uYK0GYMpHuMMLekcUIhHe4LJrOqbxXobZfOBIkrulPSDar
         R5vHVG9myjiV0KLtkqjpN0wPcAMBWmRRUqt3sHtWbRpOU/S5e7aaNjWDRLoI32BMsWkO
         rncKkSVcN2qn0KxpkRZUmvY3e2PRMB7YOwhlE/kELGxumhoFOfaq5jKzSFDFLb5c01IJ
         mHI2lYNEkUH/LaNnpdSM+FfbGVealPHBfJj+NDAlPoIykqZ2/oIM9IZZDQs7sn3oQLbt
         T7VQ==
X-Gm-Message-State: AJIora84mTiazQ29ic+t/epA46YVWFqhoA6DOl+2ki/HHJSEZV6J3ey8
        TT1Zgpm+OCOW0fGKCaYArP8=
X-Google-Smtp-Source: AGRyM1u2p8AUnizcUl5ftfO9wRdYgBXshr4NmB6Ar2Ra7Re9Bha5QOx63KISDy/uchfYYzw1nD7mkA==
X-Received: by 2002:a63:d209:0:b0:41a:19a5:f8c0 with SMTP id a9-20020a63d209000000b0041a19a5f8c0mr3720588pgg.565.1659117936927;
        Fri, 29 Jul 2022 11:05:36 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:df80])
        by smtp.gmail.com with ESMTPSA id m1-20020a63fd41000000b00415320bc31dsm2832625pgj.32.2022.07.29.11.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 11:05:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 29 Jul 2022 08:04:42 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RESEND v6 1/8] blk-throttle: fix that io throttle can
 only work for single bio
Message-ID: <YuQhOjo02RX7uZ0K@slm.duckdns.org>
References: <20220701093441.885741-1-yukuai1@huaweicloud.com>
 <20220701093441.885741-2-yukuai1@huaweicloud.com>
 <YuGDjFkxDSsVrcRw@slm.duckdns.org>
 <7f01aba1-43ab-38ab-5755-7ac22d0a78d5@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f01aba1-43ab-38ab-5755-7ac22d0a78d5@huaweicloud.com>
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

On Fri, Jul 29, 2022 at 02:32:36PM +0800, Yu Kuai wrote:
> We need to make sure following conditions is always hold:
> 
> 1) If a bio is splited, iops limits should count multiple times, while
> bps limits should only count once.
> 2) If a bio is issued while some bios are already throttled, bps limits
> should not be ignored.
> 
> commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
> fixes that 1) is not hold, while it breaks 2). Root cause is that such
> bio will be flaged in __blk_throtl_bio(), and later
> tg_with_in_bps_limit() will skip flaged bio.
> 
> In order to fix this problem, at first, I change that flaged bio won't
> be skipped in tg_with_in_bps_limit():
> 
> -	if (!bio_flagged(bio, BIO_THROTTLED)) {
> -		tg->bytes_disp[rw] += bio_size;
> -		tg->last_bytes_disp[rw] += bio_size;
> -	}
> -
> +	tg->bytes_disp[rw] += bio_size;
> +	tg->last_bytes_disp[rw] += bio_size;
> 
> However, this will break that bps limits should only count once. Thus I
> try to restore the overaccounting in __blk_throtl_bio() in such case:
> 
> +		if (bio_flagged(bio, BIO_THROTTLED)) {
> +			unsigned int bio_size = throtl_bio_data_size(bio);
> +
> +			if (tg->bytes_disp[rw] >= bio_size)
> +				tg->bytes_disp[rw] -= bio_size;
> +			if (tg->last_bytes_disp[rw] >= bio_size)
> +				tg->last_bytes_disp[rw] -= bio_size;
> +		}
> 
> If new slice is not started, then the decrement should make sure this
> bio won't be counted again. However, if new slice is started and the
> condition 'bytes_disp >= bio_size' doesn't hold, this bio will end up
> accounting twice.
> 
> Pleas let me know if you think this suituation is problematic, I'll try
> to figure out a new way...

While a bit tricky, I think it's fine but please add comments in the code
explaining what's going on and why. Also, can you please explain why
__blk_throtl_bio() being skipped when iops limit is not set doesn't skew the
result?

Thanks.

-- 
tejun
