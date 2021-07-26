Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663953D68E2
	for <lists+cgroups@lfdr.de>; Mon, 26 Jul 2021 23:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhGZVGU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Jul 2021 17:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhGZVGS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Jul 2021 17:06:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BFBC061757;
        Mon, 26 Jul 2021 14:46:45 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so2051211pjd.0;
        Mon, 26 Jul 2021 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WjCY/wbfUK0zm4QOWZ0DfXs/wUDR97ZPxIRjy8ov/A8=;
        b=cvGQNlqXc9F1r7YAKDQI6gKQ+w7Tm1Ej6DWyxSVtVV7QCgNAknurz1XyI+O85DdhQ+
         MJ0B1NDkbdjFhHEH7zWz5hF0cwbQvSLN0/ePaEE6MW16fBOA2MzLBYxet2f3qJiE7EnW
         m+OWDz1TI31PyE6H7nhrBrBAXCYMmjTzarqj7nhPP6xU4SdQvuOnNEfS03iSRiQFIKzR
         mCfOnn0G5hjF3ZplGswQcxPC11oEpekR6J8FdX3b1POrATCU3vkakA4DYNdEzEU3ULiA
         SRyYLqldmtNKEnXT4soiRYkC3NC/cHvwC326jLTI9WcKv/U+urb0F+6Z1OFVUF1Hiz2K
         jmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WjCY/wbfUK0zm4QOWZ0DfXs/wUDR97ZPxIRjy8ov/A8=;
        b=XlNGKq/GSobmstmJbcolWbtNrdfdwNMKIX+iEUuqoxWOwvzmSqie7sY7spT0aWZp/s
         ihTla+HpzbwiTQNL0L4YZEH00WHgtg+BXfcZB/8EE8/WcVUuJCGZS5/AisfEoVBYuIQl
         SQ1reUPTpUZdLjaELJvRGOOXazLmZus3GaTAXd/VoBBj153unHN8fsi7gRw02aLYm7iW
         RPF/BuJxUpy0C7T3cNyYXmnNzjpwRIfGsQrCXSzeqR93HBe/6bsTIx064jV/F4koNQRB
         8z0dv0D/MMQKTiXLn+fERKAlO/ER8oe4mB4QakPfSAwvG4sWSAvAVApiZIt+iq1JZy/U
         w+/Q==
X-Gm-Message-State: AOAM5336qMbME2L2DrKnv+wjKP2h0+l9VRLjInWxfuDVS6dWh6iPd2i/
        ugtmZLJikTd/jArIdgRditA=
X-Google-Smtp-Source: ABdhPJw81HPawxf4d1zjmwCFjOgjrImnGU9ms6L2OKXzU4AsvSekTj80/x38kgXCjx2Ezgp8BWwY9A==
X-Received: by 2002:aa7:8c47:0:b029:340:aa57:f65 with SMTP id e7-20020aa78c470000b0290340aa570f65mr19748761pfd.56.1627336005187;
        Mon, 26 Jul 2021 14:46:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:428])
        by smtp.gmail.com with ESMTPSA id j13sm823374pgp.29.2021.07.26.14.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 14:46:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Jul 2021 11:46:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-throtl: optimize IOPS throttle for large IO scenarios
Message-ID: <YP8tPwkJNMAcjDqk@mtj.duckdns.org>
References: <1626416569-30907-1-git-send-email-brookxu.cn@gmail.com>
 <YPGvIzZUI+QxP1js@mtj.duckdns.org>
 <957ab14d-c4bc-32f0-3f7d-af98832ab955@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <957ab14d-c4bc-32f0-3f7d-af98832ab955@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Jul 20, 2021 at 12:35:54AM +0800, brookxu wrote:
> In order to avoid code duplication and IOPS stability problems caused by estimating
> the equivalent number of IOs, and to avoid potential deadlock problems caused by
> synchronization through queue_lock. I tried to count the number of splited IOs in
> the current window through two atomic counters. Add the value of the atomic variable
> when calculating io_disp[rw], which can also avoid the problem of inaccurate IOPS in
> large IO scenarios. How do you think of this approach? Thanks for your time.

I guess it's okay but am still not a big fan of adding another hook. This is
primarily because blk-throtl is sitting too early in the stack - e.g. rq_qos
is doing the same thing but sits after the split path - and it's a bit nasty
to add an additional hook for it.

Do you think it can be an option to relocate the blk-throtl hooks to the
same spots as rq-qos or, even better, make it use rq-qos?

Thanks.

-- 
tejun
