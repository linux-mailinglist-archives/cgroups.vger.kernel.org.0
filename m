Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08C86885C5
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 18:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjBBR5v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 12:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBBR5v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 12:57:51 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA7F6A717;
        Thu,  2 Feb 2023 09:57:49 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so6346016pjd.2;
        Thu, 02 Feb 2023 09:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J868v/GWsw/sdOuEih4FZi6MVpQ5U6Xfy4+ZzeGKSSY=;
        b=WnuM3wG3BnaRK/PHa4g1RIcgwiErDE8gggba3If8Q8GnilHU08DD31ANGbVa8Q6KCs
         vbb6XzZNI9axv+/+M7kiweOTOm6aY901RBHzczpV0ay+u0bh/1uqFOqwhZALoT66eDWG
         YrA138bUs+3/EjIQjIogajqW5bzCGHwfqLHtTSZvjTAWoklFC919icaurVy9VVRgYg+L
         AcgkxPk9d23q3MbUyEkY0qQDegJobtaT46ivyBih+y0Kcj/z7mZi6fsMUigzgSrosMlW
         coCAfkX5CSUEdJUafUnEioT3kNqhN6X1exwcHtKqyQUd+dQBVjizzSkIEAY9cFxmPAXN
         B0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J868v/GWsw/sdOuEih4FZi6MVpQ5U6Xfy4+ZzeGKSSY=;
        b=6D5OBvcQTwhtVw8VEL3QmVqD+yRXVlOLSUVWoSoWlOaMY0P8DpVFzQT8FYLemsEpdB
         VBwgdMx7+c8sHpLizh8oV7PAWeX1vJ096XpvzGQkvR+GfB/vwmNENzOGDXKJDCbB4ASv
         Ft2MosqoW8pqKVnmOa7CS+AsxuIhDu2s9W7a1VOFOkfuaqsgUbYwdA7rfPT3SD6Oi4w+
         mRoTVoBYfieinqJFYi3p1ZLJ4x5d7LzFgrF9SIH8SKGF1y5SzV/qaB7vJ5yCex/JGlku
         CyGaEUGlyss7G1d7M1nWSS/Z5Ov/kNeCWJ8/qHmUV0diFlPcG7Twf5Trea+rO+6HtT54
         o5LA==
X-Gm-Message-State: AO0yUKWvt9SGTafXqpB8VltqwUGC0X9OKaLKzQOQbH3F3FQg2xGt2kDh
        +BM9cPsEwwyj6ly0+rSQDvw=
X-Google-Smtp-Source: AK7set/Da85a+Mm0WtxVlaZHGXS3I4G/f2zoKXhY/rOr1bdYa9xp/W+Ncugza1v5Nm/VwzlsFQaunQ==
X-Received: by 2002:a17:902:da8c:b0:196:897b:cded with SMTP id j12-20020a170902da8c00b00196897bcdedmr9979663plx.28.1675360668803;
        Thu, 02 Feb 2023 09:57:48 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:48a9])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902b68400b0019644d4242dsm7834143pls.82.2023.02.02.09.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 09:57:48 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Feb 2023 07:57:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 05/15] blk-cgroup: store a gendisk to throttle in struct
 task_struct
Message-ID: <Y9v5mqqd8tVy67KJ@slm.duckdns.org>
References: <20230124065716.152286-1-hch@lst.de>
 <20230124065716.152286-6-hch@lst.de>
 <Y9Rg0GuNAmJPlDri@slm.duckdns.org>
 <20230201080635.GA8112@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201080635.GA8112@lst.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Sorry about late reply.

On Wed, Feb 01, 2023 at 09:06:35AM +0100, Christoph Hellwig wrote:
> On Fri, Jan 27, 2023 at 01:40:00PM -1000, Tejun Heo wrote:
> > So, we're shifting the dead test from schedule to the actual throttle path,
> > which makes sense but I think this should at least be mentioned in the
> > description if not put in its own patch.
> 
> That's what I tried to say with:
> 
> "Move the check for the dead disk to the latest place now that is is
>  unbundled from the reference grab."
> 
> what else would you want me to write?

It'd be better if the paragraph actually said where that change is being
made along with why and whether it causes any behavior difference.

This seems safe to me but I can't tell why it's being moved. Maybe it's
better because that's "latest" but that's a lot hanging on that single word.
If this is better because we're testing it later instead of to accomodate
other changes being made, this should be a separate patch, right? It's a
subtle behavior change which is buried with a bunch of other mechanical
changes.

Thanks.

-- 
tejun
