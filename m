Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D152063E284
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 22:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiK3VJ1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 16:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiK3VJX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 16:09:23 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E0288B4F;
        Wed, 30 Nov 2022 13:09:22 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id f3so17243439pgc.2;
        Wed, 30 Nov 2022 13:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7v4d6zaC4L81hfiBNb2Cor9kyL3VqKmV3/kGNvOemQ4=;
        b=KkQfDW/gc08jpOQwU7UFqMKS7YNnQ9pn2xJKWk1O/71hBqhVuZvr0RPB+dmEmUL5ye
         xDpaMQ4XhbVldeIM5DIbTL0SLuUc1TY8tpvitVtwhxyYnuHHzufMBZLcTM0uWv4mUKg9
         WcjfkyG6DzHJOhP3nUpI7C0Kx9TooMPDylwUQ2yRjIsK4pbudxvzTQZYkV3I75xd38c8
         39fm+Z7m1U8xCTByy7ZY4l0ggq7zbR9Ilgwl6I/3X8P20eJd+68SaFY3ySEWh0o8/tZb
         V5X8HJayccgkIWTrGUSa2b0gTfKURFTnRcDDQ0h8qJqJV31igDseAKynOE7XcHHBW9Sn
         eXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7v4d6zaC4L81hfiBNb2Cor9kyL3VqKmV3/kGNvOemQ4=;
        b=jrO45cxDPOSn4/0pGRbkIGjsrGpRZ2GgLKRxGwtSXQKBmarXCEb3nw7zLQHEL2D3AO
         AR1tceYa9wf8xL36mVJ0KLZKqR40aXdG/s6s/RdQadluPszjftS2b4mzKXUCDck3q2rc
         cm9qrXP00YmDZQj08HcpN7cxCY/Efo9VJPonn9FwY0SONM2wKI4Sk8XkbqeQPpt3jkOJ
         p5tp52czK1+5WJJKQQDCWQpzOu54POFSrpRw9LXoK13BMibcFsSGdcJoDAm0G8gbHu85
         j9BRg03S03uyljkjBARgvNRO8gzQomrTNzQ0gfGRRYOdFbMGxUqzdSwHXc9QgJNjB0mP
         +wpg==
X-Gm-Message-State: ANoB5pmiy+HiWUiV2DhMWT1muG8NNQn8lwNh1OXYMsXqza7L9QlbcV5z
        HBnW2ba9xUByITQRmjKDACo=
X-Google-Smtp-Source: AA0mqf727J+qaCOMRUQATA0i/21bN+qxdroHDJhyjdFZ3e6lTo6Xn5AhSo1sN4FwwsiuajQVHmnPAA==
X-Received: by 2002:a63:525e:0:b0:477:bca8:1cd9 with SMTP id s30-20020a63525e000000b00477bca81cd9mr31590682pgl.581.1669842562016;
        Wed, 30 Nov 2022 13:09:22 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z17-20020aa79e51000000b0056c3d3f5a8dsm1812338pfq.56.2022.11.30.13.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:09:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 11:09:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] blk-throttle: Fix that bps of child could
 exceed bps limited in parent
Message-ID: <Y4fGgGaNBueotI1E@slm.duckdns.org>
References: <20221129030147.27400-1-shikemeng@huawei.com>
 <20221129030147.27400-3-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129030147.27400-3-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 29, 2022 at 11:01:39AM +0800, Kemeng Shi wrote:
> Consider situation as following (on the default hierarchy):
>  HDD
>   |
> root (bps limit: 4k)
>   |
> child (bps limit :8k)
>   |
> fio bs=8k
> Rate of fio is supposed to be 4k, but result is 8k. Reason is as
> following:
> Size of single IO from fio is larger than bytes allowed in one
> throtl_slice in child, so IOs are always queued in child group first.
> When queued IOs in child are dispatched to parent group, BIO_BPS_THROTTLED
> is set and these IOs will not be limited by tg_within_bps_limit anymore.
> Fix this by only set BIO_BPS_THROTTLED when the bio traversed the entire
> tree.
> 
> There patch has no influence on situation which is not on the default
> hierarchy as each group is a single root group without parent.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
