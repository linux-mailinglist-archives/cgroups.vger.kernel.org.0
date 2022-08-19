Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EA859A3BD
	for <lists+cgroups@lfdr.de>; Fri, 19 Aug 2022 20:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351036AbiHSRzO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Aug 2022 13:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351220AbiHSRyu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Aug 2022 13:54:50 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4389184ECC;
        Fri, 19 Aug 2022 10:35:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id k14so4935413pfh.0;
        Fri, 19 Aug 2022 10:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=HJOADyjEijTZgHMmhk5s3Tca02tMu8m4cNUu2EhYaAU=;
        b=fdmiJtb9RMBLJTQ+Xgl/kx6fm6FmEyy0L/lYlYxIWJX5k3m+R5z3YbZgU7aYih8WAc
         sAmQjBqm9+W17s6M38OvDRgjiaSaOqlC0SCu+JBOU3BI1QYBGiJOsQ+t76kaxgeBcVGJ
         NuCOoSKl8ukmGAzUbJrV5NkBVynK+S6LGQjUYKInpZa7u/wu9ffgjzLdBX0VsxlKllze
         1VjABlNkXWdpcbqbtajq/AT7I3QwDIS9ZOX2ev3qXXy/waWCcM9UnVkD2OOyffE+BsUR
         ZRZQCqFQ25mZ5LqtHndedni2VRA0mWJ1bu8qjDcUWiWZEPkPcZiQmUfAl3l5vL+MdaJs
         46vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=HJOADyjEijTZgHMmhk5s3Tca02tMu8m4cNUu2EhYaAU=;
        b=fMpIqFjexyWXUNpjOBoyThm/LCu/sacwSJruEYbesWRFU3J3dCvR5kz3iGVZF7hZGF
         1t//iqk/lv37ZOqbj0yymmrD2F8YyqSM282mE1gBHqrbMx3NkJ37jEbxOAC+ojyhvjka
         W8zx3lt9KUMhVYzKRv4zdFb9hj5+bN69JITRyhPzNxt2+AoQmKrhPjC9KaE5zzdj3HdI
         ey9mr8rO98098U+7t4HHp1B00KTCgwO7NsAjlF84+NCSVOPt5TOEXpOY0GZaWuimkh47
         ewiesEvhWlAUZFl/QMvhCrhP7wAjBeqJ4j7OHdf+lUlW4aCcLsYaZNDwieaa3+GOuNfk
         XW3Q==
X-Gm-Message-State: ACgBeo1yoItwAIg4zkUFZf5Nz2WnAoffiCJfdqDFysglCHtuxfltawdF
        ZCbHJBmD0AKjpfdAHedc8pBfRecml7o=
X-Google-Smtp-Source: AA6agR4oZ1QImb2//4w2oB/fgGghUe4I3us2MzRuh0RNXn7NIGpxiEUSBf0ktiEmz2DtHEXYyrshdQ==
X-Received: by 2002:a63:dc56:0:b0:419:e9df:28ce with SMTP id f22-20020a63dc56000000b00419e9df28cemr7006612pgj.48.1660930522661;
        Fri, 19 Aug 2022 10:35:22 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:db7d])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902d48900b0016db43e5212sm3489712plg.175.2022.08.19.10.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 10:35:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 19 Aug 2022 07:35:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v7 9/9] blk-throttle: clean up flag 'THROTL_TG_PENDING'
Message-ID: <Yv/J2CXNdEimfqlv@slm.duckdns.org>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
 <20220802140415.2960284-10-yukuai1@huaweicloud.com>
 <Yvv6kk/RD5LT+3dk@slm.duckdns.org>
 <65d93ec6-2465-35f1-314f-f092ce631100@huaweicloud.com>
 <Yv0rR9gBL0qbYeXp@slm.duckdns.org>
 <841b7b5a-b908-649a-c09d-32c8de5f1c14@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <841b7b5a-b908-649a-c09d-32c8de5f1c14@huaweicloud.com>
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

On Thu, Aug 18, 2022 at 05:29:39PM +0800, Yu Kuai wrote:
> Hi, Tejun!
> 
> 在 2022/08/18 1:54, Tejun Heo 写道:
> > Hello,
> > 
> > On Wed, Aug 17, 2022 at 09:45:13AM +0800, Yu Kuai wrote:
> > > > I don't know whether this is better or not. It's minutely less lines of code
> > > > but also makes the code a bit more fragile. I'm ambivalent. At any rate,
> > > > please move these trivial patches to the head of the series or post them
> > > > separately.
> > > 
> > > Can I ask why do you think this patch makes the code a bit more fragile?
> > 
> > It's just one step further removed. Before, the flag was trivially in sync
> > with the on queue status. After, the relationship is more indirect and
> > easier to break accidentally. Not that it's a major problem. Just not sure
> > what the benefit of the change is.
> 
> If you are worried about that, I can keep the flag, then the last two
> patches will cleanup:

I wasn't necessarily worried. It's more that I couldn't tell why the code is
better afterwards. Maybe update the commit message to explain why the new
code is better?

Thanks.

-- 
tejun
