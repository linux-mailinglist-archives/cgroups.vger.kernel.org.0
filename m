Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645C1664B64
	for <lists+cgroups@lfdr.de>; Tue, 10 Jan 2023 19:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbjAJSmy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Jan 2023 13:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbjAJSmY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Jan 2023 13:42:24 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BA91A3B1;
        Tue, 10 Jan 2023 10:36:09 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id c6so14132441pls.4;
        Tue, 10 Jan 2023 10:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mx/8qw1hk0L/Apnt3h31WEr91WdxE2C/9NCB2yBSTjc=;
        b=o2u7cWdt7toQAtBB1r2+RF8CrYllIElK6OiiBW7wEL36HiAiGM6Y5Y+GSqXBnLwxof
         J2CX/fG3C6YW+hxVwI3eD3mFXEqOg0pczDLmkdUuC7ijnZVTZ7zLy8TTI6d+2SWSJE0P
         mCu0rClnWtooXrdXjRBb8yufcNeAk4c5ASu97PPYq1oL91DFQ3NbFOeFtPDTcRxTIHV6
         0ZcAcwd7KaO6JwF8M6jRYCQZJZ4RdGVQVHB6czKnlkllG/V4R2epPHHYLQ7H3JDqT7kq
         XbFF1cm+bjAAjJG7jXWjXI6N0/DHD9dcbNGLAB3FHCwiCggwtAh63+EFIxdhADoi3qPZ
         yIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mx/8qw1hk0L/Apnt3h31WEr91WdxE2C/9NCB2yBSTjc=;
        b=mVbt596gOWi/X6C6mR2Orfg5kK1t0jYkQA97l1AY5Jg8Nl9GB6g2tFxssTCBRb8a9T
         ENx+vufP+tt4M8ztY7pvuc4LYJZ8Szk9aNwDuiy08Vak+6Rz4tSAFyS3mS78zW2yVYt1
         HjGULkzZomFrSlJ9KK8+32Du+YruaUTbOVTGWfTBL2xOClx1NyITgBhEWwSqyadHv7SQ
         LJ71nz766SCZfburfXOi3jM0Iw8CHN1W2ukUht/iZPHto16rj1awpz44KLp3u4wwDoXQ
         eC7D6fFR2dx2d453s/ML0kvF3entqbyh8hmfM7qTwI8vXtxxrACHsz7kMh2mfPeQHKG8
         mMjw==
X-Gm-Message-State: AFqh2kow/bhCmdvalKLzPWh9ky5UuhVM8HepdH5Wsn+PBf1OvqxNX9r5
        e35Zu9osEfwTvzj8IejmTzI=
X-Google-Smtp-Source: AMrXdXswPvuUZzjiQeCSIHXu5b7E+7xSQKPZzb3L4Aa1cDzvqY6vbRP36+lZVtpXaGaPBT/2hjKevA==
X-Received: by 2002:a05:6a20:d695:b0:a2:c1f4:3c70 with SMTP id it21-20020a056a20d69500b000a2c1f43c70mr81785231pzb.8.1673375769225;
        Tue, 10 Jan 2023 10:36:09 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g38-20020a635666000000b004768b74f208sm7108097pgm.4.2023.01.10.10.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:36:08 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 10 Jan 2023 08:36:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 1/2] blk-iocost: add refcounting for iocg
Message-ID: <Y72wF/b0/xNRmP7f@slm.duckdns.org>
References: <20221227125502.541931-1-yukuai1@huaweicloud.com>
 <20221227125502.541931-2-yukuai1@huaweicloud.com>
 <Y7XzUee5Bq+DoIC1@slm.duckdns.org>
 <c63ee2ad-23d5-3be0-c731-28494398b391@huaweicloud.com>
 <Y7cX0SJ0y6+EIY5Q@slm.duckdns.org>
 <7dcdaef3-65c1-8175-fea7-53076f39697f@huaweicloud.com>
 <Y7iCId3pnEnLqY8G@slm.duckdns.org>
 <875eb43e-202d-5b81-0bff-ef0434358d99@huaweicloud.com>
 <Y7xbpidpq7+DqJan@slm.duckdns.org>
 <a71f997f-6cae-d57b-85dd-2fd499d238f6@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71f997f-6cae-d57b-85dd-2fd499d238f6@huaweicloud.com>
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

On Tue, Jan 10, 2023 at 09:39:44AM +0800, Yu Kuai wrote:
> As I tried to explain before, we can make sure blkg_free() is called
> in order, but blkg_free() from remove cgroup can concurrent with
> deactivate policy, and we can't guarantee the order of ioc_pd_free()
> that is called both from blkg_free() and blkcg_deactivate_policy().
> Hence I don't think #3 is possible.

Hahaha, sorry that I keep forgetting that. This doesn't really feel like
that important or difficult part of the problem tho. Can't it be solved by
synchronizing blkg free work item against the deactivate path with a mutex?

Thanks.

-- 
tejun
