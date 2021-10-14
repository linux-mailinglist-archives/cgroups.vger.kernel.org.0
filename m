Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCFD42E482
	for <lists+cgroups@lfdr.de>; Fri, 15 Oct 2021 01:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhJNXER (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Oct 2021 19:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhJNXEQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Oct 2021 19:04:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5E7C061570;
        Thu, 14 Oct 2021 16:02:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y1so5164162plk.10;
        Thu, 14 Oct 2021 16:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=elTbg3LLUd0tVBsGRe2KL6JIDNTTkS+yo5Y7KpMBtaI=;
        b=cUpF41cCqBEdQM5Vy4oXPwRIalVbBy7qZLhMjEI1uIlTteb5LmN/H00giAunB22XcQ
         Rb1T6P5WxAbwd/9Z3VHFzv4bIkr+VLMZVbLZ5qYjwr4VTnONXCk+/+m3hgaIxZSS28Ll
         UPaRwwh3tga2xx+TEa/l+627I105dRlbE/h5kG91JTNhUTqK8VearSHYK2danHujFqv+
         /LCziI12wgBbNMkW2eLkVRb1OSr5fL8183BjyY9XTk2En4YutFwbN092cFqqBznkKIaJ
         UJ/2JRMxeZVoo716OzXfoHL3DgrprJ0Vc0zt8fiv7FwJKbKroFAVG8bG0XDtnjBVsbvs
         o9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=elTbg3LLUd0tVBsGRe2KL6JIDNTTkS+yo5Y7KpMBtaI=;
        b=sDe710UG/aLkjXrEWhXa2CuyTfc5t0W7r9hYI7MmmgRMivcEZWkeYk+8FRpPDcT4Rb
         +8EuZJRMGcLAqEoqpjqoQOtWSdIlp/OYIrQMOD9sTf0IvejAJ8AMG+GBiDeYW3DfC9dc
         uJ8ma6Xl63CoX5ozh9PicgmUSxyvVi854ZUgMiK0ca+j4IxEKarXD9bZxo1N87pIgjXr
         rYH/AwvWplyvCwJA28pmZmyU4HzHplkfXJTXnX5VU//1mXPCyNbSSoFVo6Uywwk1pfxQ
         kL1Ci5BtFD4nUVpeVMNbWOnyhN/1YpNfPM/1gpvgFHKZyzjIqPNfjoov2RyG07+3Rd1x
         jjZA==
X-Gm-Message-State: AOAM531+pj2if62yzORgwDAkioKZmQ2//AmrSEmiPTxLkDzKkwSm1neH
        PXzbmGY2zi0ET5Kl00Skl1Q=
X-Google-Smtp-Source: ABdhPJwF36h78Uv3hhK6clWu6wpJ3llzJ4CbV8Rc0b4yJOcFirr1LmZ637DSMk29qLAaSrvaIgV4yw==
X-Received: by 2002:a17:90a:8b8d:: with SMTP id z13mr23578422pjn.214.1634252530863;
        Thu, 14 Oct 2021 16:02:10 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id t11sm3407027pfj.173.2021.10.14.16.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 16:02:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 14 Oct 2021 13:02:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, paolo.valente@linaro.org, fchecconi@gmail.com,
        avanzini.arianna@gmail.com, mkoutny@suse.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v2 -next] blk-cgroup: synchoronize blkg creation against
 policy deactivation
Message-ID: <YWi27oAU0v5v86eN@slm.duckdns.org>
References: <20211013124456.3186005-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013124456.3186005-1-yukuai3@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 13, 2021 at 08:44:56PM +0800, Yu Kuai wrote:
> @@ -1401,6 +1406,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
>  	if (queue_is_mq(q))
>  		blk_mq_freeze_queue(q);
>  
> +	mutex_lock(&q->blkg_lock);
>  	spin_lock_irq(&q->queue_lock);

Given that deactivation drains q_usage_counter through
blk_mq_freeze_queue(), can't the blkg_conf_prep() just pin the usage count?

Thanks.

-- 
tejun
