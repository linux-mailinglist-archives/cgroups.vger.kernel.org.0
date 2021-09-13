Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A908F409B55
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 19:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbhIMR6H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 13:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239541AbhIMR6H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 13:58:07 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0983DC061574;
        Mon, 13 Sep 2021 10:56:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 5so6355054plo.5;
        Mon, 13 Sep 2021 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gSVJ2eIM6ASF+/M1pUdi7A7u/9wBqdKyPf+MuRt4P3o=;
        b=Q5ZThgVUFT2XJy9ZZ3JHUMd3INTVtkMLE2tXoNIME6xo30Bw5fDiF0A0WqMV2fdkZV
         BtZ7myHUs0imcosnzwMnUq/q2JJsNmF9burZEPbMTfpuPHjMkKRT7raxg56pxr+QuzDJ
         USkCq2o5S5nOGPi9GYHJBfHMi8uF2+J3rdZnTj/NocsKytqfpuldL87dU+fVK6k03sLF
         xYvhVXyZSA6fGGvfpydGgNsWRGAsakrFG1rhVIlKfXrmx8ejdb9Xq8LUDB6DMh9r9hSQ
         LHjD9wDUCrLi+U8jQR1RRVW4AYr12LLlcnuHkKNbaQg9DT2rLf5lCE90J5GlOFVmVsYv
         m+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gSVJ2eIM6ASF+/M1pUdi7A7u/9wBqdKyPf+MuRt4P3o=;
        b=Fym2pWkbKG6xuYaIvbNvvIpYevLgYE6oMqNa2/ijQuHzCKC5nEcXEIyhWjIDPDM5R2
         PiVASAGR+TUgut4JYmZMJuSr6CmEGumOmsVUzlDPPb8XVb9MWWXgWqk2C8ZztBggRxJG
         jRShhP2SXy3RUz+a0Kdek7WqQQjQ3SJxOQz4+G7kOpMdJbfmn6HooThMwojhpklbuyQI
         Mb/ueDECLszPf/CyxyZrEDlyxkfrJ+SZGrvDUMMbBZl2hyfLxi+Gqui/sDS5jJj9CC5I
         dq2Fmr5KX1COIG6zwWA5ZgI6IszPky0GG3K3atiGSQwqJXWfThsUGI3Mv9d2fM+E1rZn
         xKXw==
X-Gm-Message-State: AOAM533j9FhHYQk2crZxDDUGdQnE0DZ/ArQoNRnZhDPK1F3Adz1ALida
        MOBNtCAeiD6gkv2o6a6I8nE=
X-Google-Smtp-Source: ABdhPJwtDcUg39mwwF/D8YbWMstFXMVh+eKxdXmlOmUlK+VWyUxulXfLPxZu6UGS+UAWqZp/7jSc4Q==
X-Received: by 2002:a17:90a:6282:: with SMTP id d2mr792160pjj.189.1631555810344;
        Mon, 13 Sep 2021 10:56:50 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id k190sm7942168pfd.211.2021.09.13.10.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 10:56:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Sep 2021 07:56:48 -1000
From:   Tejun Heo <tj@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs/cgroup: remove some duplicate words
Message-ID: <YT+Q4Gr7Ky1Tt9w8@slm.duckdns.org>
References: <1631509754-21485-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631509754-21485-1-git-send-email-brookxu.cn@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 13, 2021 at 01:09:14PM +0800, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> When I tried to add some new entries to cgroup-v2.rst, I found that
> the description of memory.events had some repetitive words, so I
> tried to delete them.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Applied to cgroup/for-5.15-fixes.

Thanks.

-- 
tejun
