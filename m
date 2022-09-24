Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF405E87F3
	for <lists+cgroups@lfdr.de>; Sat, 24 Sep 2022 05:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiIXDcB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 23:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiIXDcA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 23:32:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C9712A495;
        Fri, 23 Sep 2022 20:31:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso7615204pjk.0;
        Fri, 23 Sep 2022 20:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=7UxaMSnoHFzKmnse8cgID7UiEyz32CZmEXoNfbymFKQ=;
        b=PcmPyGgiv4lXxe+D5CPejl9Scwfvp5/ZJtRkJGO2J9qugHSZFM7Afyn1mGXZ3xQp8S
         sSrY8GNFqbsAjwF6oyBd28uTehERinOP+wpQS/C9IwFIXCQ7g0jQkUECEK5jmCfrhuT3
         BtDIMNCQLsPdQ0vTm2nYuPzfAKKKCdAgTQ+luINniSNY0Hs8474Jtj6OAXJKLh4zWBFQ
         fzoGQshcv27S+NBTsS9PhIE8kNxA+NVQucj61j7skWo3KBt4OUsgb520mqHSXc1WAeBX
         Ie2mQ3u2E4cgY7x3WcYAbgit+OZMdg/w1fG0RO6sg+BTkoJNlfEkI7tLDw0lgQxiS5Ns
         XYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7UxaMSnoHFzKmnse8cgID7UiEyz32CZmEXoNfbymFKQ=;
        b=W6dkBMXf0vBKH5ntF62pyNWEnS/FqglM4kC3jlDDDldwe6urIVBucMwV8f4/OVKKRr
         Gt8Q12euYeWMW6QABDnspY4TRWWGlDq2UuQWoN/skN3wD2scW6r7Up/SpozzI9Hleyrt
         mG1AxuKPoA+9AWw1xGoHgQOxCFBmZ3aGYBghDKpIqW2iIFZLF7K/R5sEu5VH7hT2TI+g
         TTBFZLXhbxl38aile0us5kq0okcYOxxZtcPIP7SMS8pVqSXHBROqTgJi0cb6n1Fmrqj5
         ++d++QS5cvWhq7lR+Y3X4gTbdhnUYqnccBlUuNJjnli3cFkxreTBuQby84w/WuIOImMW
         rasQ==
X-Gm-Message-State: ACrzQf2POmIHdZ6y7m+JW0008RyoLvIvNdXQV29LOOySL4uUGZh1hOOp
        1JJFXPgwpdt5GVckC0U3L0ubIL2pE8gLJg==
X-Google-Smtp-Source: AMsMyM6ondJl4Xc76NThqvBpWH1ly6F4XqPTOEP/y8gTroRsFpUYQeU/OZFBQXlUae7TnXuGAcMUVg==
X-Received: by 2002:a17:90b:4ad1:b0:202:5f15:39fa with SMTP id mh17-20020a17090b4ad100b002025f1539famr24089148pjb.19.1663990318879;
        Fri, 23 Sep 2022 20:31:58 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t4-20020a625f04000000b00550724f8ea0sm7178231pfb.128.2022.09.23.20.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 20:31:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 23 Sep 2022 17:31:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH 1/2] blk-throttle: remove THROTL_TG_HAS_IOPS_LIMIT
Message-ID: <Yy56LetUKrB8ycLP@slm.duckdns.org>
References: <20220921095309.1481289-1-yukuai1@huaweicloud.com>
 <20220921095309.1481289-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921095309.1481289-2-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 21, 2022 at 05:53:08PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, "tg->has_rules" and "tg->flags & THROTL_TG_HAS_IOPS_LIMIT"
> both try to bypass bios that don't need to be throttled, however, they are
> a little redundant and both not perfect:
> 
> 1) "tg->has_rules" only distinguish read and write, but not iops and bps
>    limit.
> 2) "tg->flags & THROTL_TG_HAS_IOPS_LIMIT" only check if iops limit
>    exist, read and write is not distinguished, and bps limit is not
>    checked.
> 
> tg->has_rules will extended to distinguish bps and iops in the following
> patch. There is no need to keep the flag.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

> @@ -183,11 +182,6 @@ static inline bool blk_throtl_bio(struct bio *bio)
>  {
>  	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
>  
> -	/* no need to throttle bps any more if the bio has been throttled */
> -	if (bio_flagged(bio, BIO_BPS_THROTTLED) &&
> -	    !(tg->flags & THROTL_TG_HAS_IOPS_LIMIT))
> -		return false;
> -

This temporary removal would break the double accounting until the next
patch, right? That might be worth noting but this looks like an okay way to
go about it.

Thanks.

-- 
tejun
