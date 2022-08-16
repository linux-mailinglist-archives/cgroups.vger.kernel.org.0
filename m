Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E621C596392
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 22:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbiHPUOO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 16:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiHPUON (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 16:14:13 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AB57A776;
        Tue, 16 Aug 2022 13:14:13 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 12so10210957pga.1;
        Tue, 16 Aug 2022 13:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=On1R2Y8AoucYEJFBb7wUMfr4hWcYeJkV168ieP6Z2g4=;
        b=KCSRHVGOwuHJOs5RySQuX1ydgSX8WoQhwhNOSug+NPzjoTuHqcmpa9cH3RYLlUCMVT
         +uh87JahRJ4IuLXxnNILjXvjGSyG5KWEd+O4+tB0Nz+Ufx4YOtRwO6+nd7/lmF6SCpyT
         Q4oYoaelxxzQ4prHEyPmUK9joLJGMgVdmZZhssaZRscUjX9kxZABaACsWyI7ptN8wR+4
         BpIb4NHASyZdMM1tn9EgkSCQFJv+XuPW04lPWOUw4gZBgzVEPJX3E8jETyiYb1PF0Fkd
         1zf8OJ2VXIblEtXnpZKTxAKUbnqDt5f7CvSROs/RIvvbEw240Qe2bnbz80aOm5OrGfi/
         xh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=On1R2Y8AoucYEJFBb7wUMfr4hWcYeJkV168ieP6Z2g4=;
        b=xg4OtpJ/wTO2BzTUj9QnuCPO/Vr4tWmLxaP+d95cwlZXc430I8txFeAtBDwESB+8+W
         rCBEkVSejf6ovBfG6d8Ga74CWhpLgfkONBW9UeGKOygA1MS/mxE1hHTy2zqYIBUZIEJx
         37fgCdaULor/v04j1huGF8f4jtZ1zYb7EbvUEL9UUZ0S3I1Ah2ytnyOL5Lm6UsbDeGZ3
         1To8EwnK6a8ftB3Dlh3qEozEKtPpBXUoRLTCZBdD2GR0WJI7E0DNfaqc/viRo1t5f8F3
         5sQrQJitpi6y2byStHrjMG4cuXEPawG4LP+tTSVUsjaL5eEdaN4cs+nMduWg/dLtJIvA
         +qng==
X-Gm-Message-State: ACgBeo071AaUShhMQwApeIOgThMqTDe90N+h+fPfVngnogiuoml64zJO
        r9dEsAzuTO7IdlSHswVcvrw=
X-Google-Smtp-Source: AA6agR7kva8c6mpF61p33ryspyUqkCOCRDRFuZxDwca8/V6WyCa5jTLXkzW5ZfI1sVrJR1gCqkoIzA==
X-Received: by 2002:a05:6a00:2290:b0:52f:9293:afe6 with SMTP id f16-20020a056a00229000b0052f9293afe6mr23031813pfe.17.1660680852274;
        Tue, 16 Aug 2022 13:14:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7229])
        by smtp.gmail.com with ESMTPSA id t7-20020a634607000000b0041b5b929664sm7915644pga.24.2022.08.16.13.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 13:14:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 16 Aug 2022 10:14:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v7 9/9] blk-throttle: clean up flag 'THROTL_TG_PENDING'
Message-ID: <Yvv6kk/RD5LT+3dk@slm.duckdns.org>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
 <20220802140415.2960284-10-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802140415.2960284-10-yukuai1@huaweicloud.com>
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

On Tue, Aug 02, 2022 at 10:04:15PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> All related operations are inside 'queue_lock', there is no need to use
> the flag, we only need to make sure throtl_enqueue_tg() is called when
> the first bio is throttled, and throtl_dequeue_tg() is called when the
> last throttled bio is dispatched. There are no functional changes in
> this patch.

I don't know whether this is better or not. It's minutely less lines of code
but also makes the code a bit more fragile. I'm ambivalent. At any rate,
please move these trivial patches to the head of the series or post them
separately.

Thanks.

-- 
tejun
