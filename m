Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35C56514F0
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 22:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiLSVcB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Dec 2022 16:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiLSVbp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Dec 2022 16:31:45 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1211CDFB5;
        Mon, 19 Dec 2022 13:31:44 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gt4so10438705pjb.1;
        Mon, 19 Dec 2022 13:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BomEC32AM6ovoRGRoa2VDMC3YGhwNtq2L7oOB+Yvsps=;
        b=hCitRNCAgCMGc3lcKkdvYuqgyJSbzuhh31Zq8cJgEQT9EaoWFJ4aaOrosn+xToc3qi
         i1v64YtOXP8bUBG2wBWvL3mACkuvAEqwNgDKAG6u4/MgUwZ5ofzcTqTlTzO/cafayrhX
         uuoevjjPURg+Ytr/7jBe4iZ071G7h9or/VaEgqEhoC9cxHoQALhUfGrA6q/OK33NDmwW
         Nhvldk7qZX1BtpNwDwRXjvJsUUwiVSDEmZYFfa4e4fD9V7uRTWxS0fX7QN63JVA/ov7x
         wSFKzrHlRIyTMaFo/oCDtArYOtAWDuYathCiaB4iq0hsIW9+zQ8SamE8trjHALAgXHL6
         aTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BomEC32AM6ovoRGRoa2VDMC3YGhwNtq2L7oOB+Yvsps=;
        b=mfGwH3Pw9WvwKJ8c2ZuN2G4YCwOoPf1927N4UVmzm8PRy29659QJHQ/n6Np2cbIv7G
         gcMZ74T1M5HcyqpmtkXbyhbDf1IgeU0kkfyz/bado+t3q0YTcgcUk/l4VKy2rPjHDbxq
         +u8kRwE22et/ZpuhCbhirigWE92kBQAaTduf9OoPYFGkyyLeH3/jwD1M63+vC5CyLbfJ
         /aI65NNmc0PX8hj0Az7AifYshPdAeytBhoVO8APuJYh/tJhM/xrVjqu8vHR/wN+sgIVx
         mrl1wP9U0t2wA3gxyOHFF/rvTgbhybouPF/Rhpa/vFlvhgnGshcGFU5LvQlanRRzSwa1
         XMzQ==
X-Gm-Message-State: ANoB5pmN9wJWHsAmYPtrKO5utW/EjmrpGw7lnVjpOHgVQbC8/2ZwFnvg
        qI3a4J/AL7LgS1FBqB3cGFQ=
X-Google-Smtp-Source: AA0mqf5C3DCy52F4RhlKBSSQx08e7sswRSHWI5ALknED64q7XQN1PpKUj9UthgLFpr86oXElbB+1hA==
X-Received: by 2002:a17:902:bb8a:b0:189:abdd:400a with SMTP id m10-20020a170902bb8a00b00189abdd400amr48029480pls.15.1671485503409;
        Mon, 19 Dec 2022 13:31:43 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y3-20020a655a03000000b00478b2d5d148sm6806566pgs.5.2022.12.19.13.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 13:31:43 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 19 Dec 2022 11:31:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 3/4] blk-iocost: dispatch all throttled bio in
 ioc_pd_offline
Message-ID: <Y6DYPRWtEAfUrH4Q@slm.duckdns.org>
References: <20221217030527.1250083-1-yukuai1@huaweicloud.com>
 <20221217030527.1250083-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217030527.1250083-4-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Dec 17, 2022 at 11:05:26AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, if cgroup is removed while some bio is still throttled, such
> bio will still wait for timer to dispatch. On the one hand, it
> doesn't make sense to throttle bio while cgroup is removed, on the other
> hand, this behaviour makes it hard to guarantee the exit order for
> iocg(in ioc_pd_free() currently).

Yeah, idk about this. So, now if you're in a cgroup with IO restriction, you
can create a sub-cgroup shove all the IOs in there and then kill the cgroup
and escape control and do so repeatedly.

The refcnting is rather complicated in blkcg world because it gets pulled
from several different directions but the problem you're trying to address
likely should be addressed through refcnting.

Thanks.

-- 
tejun
