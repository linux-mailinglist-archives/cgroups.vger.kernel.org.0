Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66736514BF
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 22:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiLSVWr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Dec 2022 16:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiLSVWg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Dec 2022 16:22:36 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DBF13F3D;
        Mon, 19 Dec 2022 13:22:34 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id v3so7061109pgh.4;
        Mon, 19 Dec 2022 13:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZ6E54gQso9A3AZTU5M12wLSIgrxkuCsiZqbTjl9O+k=;
        b=l3qDTyq/WO1/cjtxD3IaspFo1xRvEv77I/YPtlYY0faD0+9e55S301Keu5ZRn2BOAJ
         /06AfNo/vBoHZij1MSCG6Uv5+1+IiiBAgy2JIhC7QTpbMY0cZlMcpdNFXzr6mc4GHd2n
         d2rHms6UaQeM/CfhVjMj5K5PTDHw9ItNUw8UjI+cv9LXwbrIi5iIogfGJOkiUHCkBSxG
         3wkE9PfNcCfJoosdjppXgb4kwVXjOvgse+8quW9q5UjKI65S7hmjNgYCLObocfy4UJdu
         Y76S2/ind4Za8KgctFd1vblXIyRGQOhfNIEqIcwMDe9VPC82QSRH+yLCio90FvmxMza4
         auhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZ6E54gQso9A3AZTU5M12wLSIgrxkuCsiZqbTjl9O+k=;
        b=LEsrtlNPwtKgb8Ms9tcq7kqZN9LwfLsFIA4+pTFf0GOrnzdVA9rqDgF/fHuWUXlmOF
         qszc4Jbs3QYZ8UNtSk5dm74aC9Kc1SLU3yuHqVoHmKV7Bb6hfg0B/N88aWLsOlq7teMV
         R+klFN4Nsv3dOdWp5RUQG/FY6srgzdGOVns8g2TzrTeSD/DbANcrY/tnuGq7m86/VjH1
         R3m4PceR4etqVWUFlR8x09ZsoPUU/mrKmykpxklqU/BFtLeeyKzum5uoT6LELWDVC9SV
         IaprLIizsuLFE5Ht+Rva8yVYvh2o5j2vVYSMeOBF38nwJtRPvVEk0520oBJD4WlOM9t0
         Ckxg==
X-Gm-Message-State: ANoB5pk1Tmy2/j3S42ZcWAvvnkQOOyoE3I1DNsAbK8UmlyLDqlPvEYhz
        OvW/XM3SP+gKHpEEzR9+dl8=
X-Google-Smtp-Source: AA0mqf4GNUUgsa5NhaJR3cFapsTr3kZZBSqUFeHuXA63LQ9DzYn4iI6gzAmeuLTBTHWHv2CgPnW24w==
X-Received: by 2002:a62:6445:0:b0:577:51b1:375e with SMTP id y66-20020a626445000000b0057751b1375emr46370720pfb.26.1671484953947;
        Mon, 19 Dec 2022 13:22:33 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h18-20020aa79f52000000b00576df4543d4sm7038458pfr.166.2022.12.19.13.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 13:22:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 19 Dec 2022 11:22:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
Subject: Re: [PATCH] blk-throtl: Introduce sync and async queues for
 blk-throtl
Message-ID: <Y6DWGBQSP/DA7apC@slm.duckdns.org>
References: <20221218111314.55525-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221218111314.55525-1-hanjinke.666@bytedance.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

This looks generally fine to me. Some nits below.

> +static inline struct bio *throtl_qnode_bio_peek(struct throtl_qnode *qn)
> +{
> +	struct bio *bio1, *bio2;
> +
> +	/* qn for read ios */
> +	if (qn->dispatch_sync_cnt == UINT_MAX)
> +		return bio_list_peek(&qn->bios[SYNC]);
> +
> +	/* qn for write ios */
> +	bio1 = bio_list_peek(&qn->bios[SYNC]);
> +	bio2 = bio_list_peek(&qn->bios[ASYNC]);
> +
> +	if (bio1 && bio2) {
> +		if (qn->dispatch_sync_cnt == THROTL_SYNC_FACTOR)
> +			return bio2;
> +		return bio1;
> +	}
> +
> +	return bio1 ?: bio2;
> +}

Wouldn't it be simpler to write:

        if (qn->dispatch_sync_count < THROTL_SYNC_FACTOR)
                return bio1 ?: bio2;
        else
                return bio2 ?: bio1;

> +/**
> + * throtl_qnode_bio_pop: pop a bio from a qnode
> + * @qn: the qnode to pop a bio from
> + *
> + * For read io qn, just pop bio from sync queu and return.
> + * For write io qn, the target queue to pop was determined by the dispatch_sync_cnt.
> + * Try to pop bio from target queue, fetch the bio and return when it is not empty.
> + * If the target queue empty, pop bio from other queue instead.
> + */
> +static inline struct bio *throtl_qnode_bio_pop(struct throtl_qnode *qn)
> +{
> +	struct bio *bio;
> +
> +	/* qn for read ios */
> +	if (qn->dispatch_sync_cnt == UINT_MAX)
> +		return bio_list_pop(&qn->bios[SYNC]);
> +
> +	/* try to dispatch sync io */
> +	if (qn->dispatch_sync_cnt < THROTL_SYNC_FACTOR) {
> +		bio = bio_list_pop(&qn->bios[SYNC]);
> +		if (bio) {
> +			qn->dispatch_sync_cnt++;
> +			return bio;
> +		}
> +		bio = bio_list_pop(&qn->bios[ASYNC]);
> +		qn->dispatch_sync_cnt = 0;
> +		return bio;
> +	}
> +
> +	/* try to dispatch async io */
> +	bio = bio_list_pop(&qn->bios[ASYNC]);
> +	if (bio) {
> +		qn->dispatch_sync_cnt = 0;
> +		return bio;
> +	}
> +	bio = bio_list_pop(&qn->bios[SYNC]);
> +
> +	return bio;
> +}

This also seems like it can be simplified a bit.

Thanks.

-- 
tejun
