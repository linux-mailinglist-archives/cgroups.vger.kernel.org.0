Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9277305E7C
	for <lists+cgroups@lfdr.de>; Wed, 27 Jan 2021 15:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhA0Okd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jan 2021 09:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhA0Oi3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jan 2021 09:38:29 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2CBC06174A;
        Wed, 27 Jan 2021 06:37:49 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id o18so1474960qtp.10;
        Wed, 27 Jan 2021 06:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RAjQSGWWGLdiLLcdLbe3VngHBT6cZLdVl1RZlBUtV9Y=;
        b=A8ZmzDYNExX2+4/EkVTAG8V8v88i62t0xqSgY8RGP7xW9jzlCLRiAsbhy+UB8xkDxG
         RFBWXxlM0ad/OuCDSiCN7/3R0d/aqQTgBnrPVdIZEAGV8HpcuZm7Th0hURZT+VfcgVYM
         2g/vr/vYsBdRDq7QfZFkkwjTFZ7omKsM2f6kICs4Iy+VNa37xaXA8k7Ie8pC3bP3YQIb
         gJ0nEGZc1iH4WZLsOBnv8OB1FbjUYkQUtUCRz+Ts2R4+m9Gq+WwDpK0fh7yuMAeIuEB8
         wRRCA3+iT1E3DMhNRCrPggdWwV+1QRNo2KcZJoU23h/8yiK1+8YMfMCP4FOu55YCbuut
         PECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=RAjQSGWWGLdiLLcdLbe3VngHBT6cZLdVl1RZlBUtV9Y=;
        b=Tu55zOU2ptdEl2Td3AQy2ckRgZr11pMREgcV4s2+Uu9ez4WbPLinLKFLwtK0w2eV5W
         DDgC0FZQp0ufPgr4q/UPYj9LJwH9n9wlqbVGH8l21WI7exNzYGTYugiosGyDaXpyAwlL
         wAbno/T93Fos04w3GeMvILP436gAfoUmUePrKW1MT8FEF3JF8LYfgK2PvoDICAfETtQ2
         spvttTEEF8RAlr7dikQDUThjWZ0i0xaYiKJThWUDnzMg6ie1Wb5xBrWJ4OcIX/a2HfOm
         oalnCy/aegcvMCjSlq16Kf7t+vWp3leY5DR+BGhNqWBGXA0ph+mMlgbZDu37T1Fc9UjM
         sqMA==
X-Gm-Message-State: AOAM532nFcYtZQF8FbuRx9+olwzoft7DYR8XyuLQu3LrMkRgj5nHhEfJ
        pACMK9Jy9JXxAkm7acO9EOA=
X-Google-Smtp-Source: ABdhPJy1+pDHmqIQO+0hmCBkhU/0pSMsdKmOEuzYoaPLn+5BNbsrKCu3SBWYAWJuhnJ21gU79bckUQ==
X-Received: by 2002:ac8:16f2:: with SMTP id y47mr10023957qtk.96.1611758268304;
        Wed, 27 Jan 2021 06:37:48 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id c12sm240672qkm.69.2021.01.27.06.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:37:47 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Jan 2021 09:37:46 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, joseph.qi@linux.alibaba.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup: Use cond_resched() when destroy blkgs
Message-ID: <YBF6uiFcU8k4u0Da@slm.duckdns.org>
References: <8f4fb91ced02e58ef425189c83214086f1154a0c.1611664710.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f4fb91ced02e58ef425189c83214086f1154a0c.1611664710.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Baolin.

On Tue, Jan 26, 2021 at 09:33:25PM +0800, Baolin Wang wrote:
> On !PREEMPT kernel, we can get below softlockup when doing stress
> testing with creating and destroying block cgroup repeatly. The
> reason is it may take a long time to acquire the queue's lock in
> the loop of blkcg_destroy_blkgs(), thus we can use cond_resched()
> instead of cpu_relax() to avoid this issue, since the
> blkcg_destroy_blkgs() is not called from atomic contexts.
> 
> [ 4757.010308] watchdog: BUG: soft lockup - CPU#11 stuck for 94s!
> [ 4757.010698] Call trace:
> [ 4757.010700]  blkcg_destroy_blkgs+0x68/0x150
> [ 4757.010701]  cgwb_release_workfn+0x104/0x158
> [ 4757.010702]  process_one_work+0x1bc/0x3f0
> [ 4757.010704]  worker_thread+0x164/0x468
> [ 4757.010705]  kthread+0x108/0x138
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

* Can you please add might_sleep() at the top of the function?

* Given that the system can accumulate a huge number of blkgs in
  pathological cases, I wonder whether a better way to go about it is
  explicitly testing need_resched() on each loop and release locks and do
  cond_resched() if true?

Thanks.

-- 
tejun
