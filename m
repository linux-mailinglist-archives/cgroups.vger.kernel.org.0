Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91152597560
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 19:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbiHQRyT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Aug 2022 13:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbiHQRyT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Aug 2022 13:54:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214C54B0E7;
        Wed, 17 Aug 2022 10:54:18 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 20so4011411plo.10;
        Wed, 17 Aug 2022 10:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=M9F5QNFdEfK57sV2UQvJmFf03hDAwzaS3TgU89Piblw=;
        b=LKm3raamiQttkOiXSxZhNzHXFXXkPDRQ+4So33YQ27Vizpu1Cu379NL61euS+MnNl3
         uB4IGY1VmCTQlXPdq0AlITppYn2+v8d+5T7Ij6Itk5QWQBHeDxdAnDkH6Y6oOp2/ocN9
         t40wnKzsqNYwfMf4PDSSN6XJHJf0tqOIPzrDSYRWQ0CqkO8+q5GW7afZmNxSwwNczKR0
         0gTeSv3QwwleUSv2qWBT5NZ7jZmJGlgDhYolxttNqWjfwyBzonaxlXQSzVBa5yPmW8Pw
         t65h/wtiBlWZ4GmzQebHBmX3XYeLm+gNygvcGB/uWweffCD6mNMKcOd2NmHQHf9s9zqb
         0k8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=M9F5QNFdEfK57sV2UQvJmFf03hDAwzaS3TgU89Piblw=;
        b=vFZVTuuDYJwfJHNY+jWd9MtiwEfxWy6bTFQkGzCtA4bVAg0RQwT8qO72jxDMBC9nBx
         PknQSiwm+j+jqPYQJTJM/59Bxw0eBWfBMYQU/bqDHvx/6/k77ZgJ6DjjdMGcuGgJ8gk4
         xHx9Yi8hDW23utECrZPa7/7mLLA0Jcqiq0E7ZMbEYQC5QUQkQhryzSTJpJXkNOda5A7l
         MXqzjfrcAC2Uzwl6q8EwkbOWCxl9rTSJmH3SoQPcRxA+wyDohBBXrFdMrg4w9ihrt9sL
         2kO78vc/pcBgdmw23Ee7K9D27UdnDpisOI4Hfpj8TyGQOhZ6qGJsrQ6F5sDiR2TyuLKz
         O8iA==
X-Gm-Message-State: ACgBeo2e+PuMVHoelldO4veCAxYbhvdCfOHJhB1M6e+GnpIBarzJ3qqk
        0+mNVyQ7ORTxhsyTX7Zih70=
X-Google-Smtp-Source: AA6agR5qMHofsSUL07MTl7OwYTG1h6IT6uARLAgbhonQ+t3XwizXEz/pr6vbk1I/6ma3K4CDKLi6QA==
X-Received: by 2002:a17:902:f548:b0:16f:9649:be69 with SMTP id h8-20020a170902f54800b0016f9649be69mr27164472plf.134.1660758857451;
        Wed, 17 Aug 2022 10:54:17 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001728eb339e2sm172415plh.286.2022.08.17.10.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 10:54:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 17 Aug 2022 07:54:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v7 9/9] blk-throttle: clean up flag 'THROTL_TG_PENDING'
Message-ID: <Yv0rR9gBL0qbYeXp@slm.duckdns.org>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
 <20220802140415.2960284-10-yukuai1@huaweicloud.com>
 <Yvv6kk/RD5LT+3dk@slm.duckdns.org>
 <65d93ec6-2465-35f1-314f-f092ce631100@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d93ec6-2465-35f1-314f-f092ce631100@huaweicloud.com>
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

Hello,

On Wed, Aug 17, 2022 at 09:45:13AM +0800, Yu Kuai wrote:
> > I don't know whether this is better or not. It's minutely less lines of code
> > but also makes the code a bit more fragile. I'm ambivalent. At any rate,
> > please move these trivial patches to the head of the series or post them
> > separately.
> 
> Can I ask why do you think this patch makes the code a bit more fragile?

It's just one step further removed. Before, the flag was trivially in sync
with the on queue status. After, the relationship is more indirect and
easier to break accidentally. Not that it's a major problem. Just not sure
what the benefit of the change is.

> By the way, I'll post these trivial patches separately.

Sounds great.

Thanks.

-- 
tejun
