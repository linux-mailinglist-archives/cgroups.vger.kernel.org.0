Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED216368D2
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 19:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbiKWSaV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 13:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239221AbiKWS3w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 13:29:52 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B457B6A;
        Wed, 23 Nov 2022 10:29:51 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso2912856pjt.0;
        Wed, 23 Nov 2022 10:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQVPLKYFSJ4QgW7SluwF8mIfyxsYEuGishngmx0s4yI=;
        b=EBWluekWbdhZB0XWgYo6kN7mgHPwsTZJrKzgmUs8vlIN+toDkOZB3gh8SghcH4Pdw9
         aetVZ1tDqRGd1wbMXS1qQYE5bitUukYhkFNFOimSTAziveZAdtvbr5L9NemY/FbCbSz1
         XNX+coHGs2w8DymzXAPofEJU3+sZ7WHwveRNlINCZXNlZyourTP1tXxgi3DJrifrLPhP
         4CucWDTHDSMTcDjSvcOw07KUm4WSMcMQMhnhdzg+/WDShWJ0l6gh2Lsbua6JJNZnj0+d
         DWXHTdA13OqZkuSNA7/VfpvnLJ/CwTxdFJLGyj9oFQnz5u6RGexuKuyRixkee+IppZNv
         VNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQVPLKYFSJ4QgW7SluwF8mIfyxsYEuGishngmx0s4yI=;
        b=1qaccWJKkmC3HBW3T9G2HrAMj+QY7rxVVfPxDUN3CAZbl5IvO4WypfbzxiTJp0xqoe
         kuRKSpVjCwQJDpr3P8GYN/SeAzml4RGhdyaF6RYO/zwyVteyD7gM7KlJoAZzdwl/kkqz
         cX1Av01m0QR2frGHssLhCft7q9lSDCClLPan3IIedILkC5sT2tjsGuKn7c0as2z/kM6A
         zVGplOQO5wajPQfoYz6+MPG68CZfQjdK1U+JQF64LF4/F8ojfdz0tnQfGH4Hqgfd5ID6
         G2nCSjzUYzBSTkMXsNhLFSN/CE7xiUD4++vfMcSQEd+zxUqeek0jjWocVlstLqWEF/qK
         kEJQ==
X-Gm-Message-State: ANoB5plpVQqRH6pCGXsZmoCubTRsrrBV/0f2znC47B+zwAJQ6QF0trZ6
        4q7ZyXDU6f0erq80xgXpPo9yNePiO8o=
X-Google-Smtp-Source: AA0mqf74SDNHCyHcKlwOhqBiZBZOuExgy93tSZmyZ6fZTOphJPB/an1X+KuS4KQN8jhUXINZbD+3UQ==
X-Received: by 2002:a17:902:bf06:b0:188:5688:828b with SMTP id bi6-20020a170902bf0600b001885688828bmr13311929plb.129.1669228190841;
        Wed, 23 Nov 2022 10:29:50 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j11-20020a170902da8b00b001894881842dsm1837953plx.151.2022.11.23.10.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:29:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Nov 2022 08:29:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] blk-throttle: Use more siutable time_after check
 for update slice_start
Message-ID: <Y35mnXMNg8HeHXbb@slm.duckdns.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-12-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123060401.20392-12-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 02:04:01PM +0800, Kemeng Shi wrote:
> Use more siutable time_after check for update slice_start

Why is it more suitable?

-- 
tejun
