Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE311E4ECE
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2020 22:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgE0UF5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 May 2020 16:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgE0UF4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 May 2020 16:05:56 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8E2C05BD1E
        for <cgroups@vger.kernel.org>; Wed, 27 May 2020 13:05:56 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c12so789154qkk.13
        for <cgroups@vger.kernel.org>; Wed, 27 May 2020 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DWnL9S9WGTEGZuRBVdjP/jVDvy6htJ4NRm6fYZkzl3Y=;
        b=NTm+WSC85vpDh39BbXIYKURNZHjJKrwLhW+pSwDVbOMtLjTg+sROC2r1TgnVF1OQJT
         Z/+qWMAo9OaDwOtMZ35h9ZpEg8wgO3BAlWzDHpHSL5NVQUTCJ1bGJx6/6fy6SnXgg5Mm
         sRcUXPwwx6KDFyRWDqCOVko4xkFYLQeK0SUcGUMRAQwpQ8znovQguw8tU8jubSm8NX5k
         NN8fv1ZcfUBQ+ioRqagvGPVpPlH6peeyg50f2RCcHk36SNjEv1StDmpPr/igiJufMXgW
         r0OPMvAGHcAZuM+FcFT10yaa7c005AJgEA5QQNidQmLv5eEj1zntOfSGbVcYC3MSQDkq
         D0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DWnL9S9WGTEGZuRBVdjP/jVDvy6htJ4NRm6fYZkzl3Y=;
        b=bjD6tRNVZukx9B+qZV97zjsbKY9LXi+lpCFPfASlgSNHhp5NaS748oU9JualLJGu2g
         quObWhVyxdukR9Utq+y8epJ4URV3jy3qCS1pbZ+lQEHTkfmHeD4RxQAkAYMVcK/lRIWa
         +V4Fx99JSDjLBQ2j2RzZB28zRXo3am85NHI9nvvsUt2d4DemgqfHCZ7YwDLqpGedL6yG
         NHJEHyjqyEOcX5pMd4SorIze7y63sFVSk+1QoP2edWxw1VPt/DVyKp14h1kRw6ijrf3R
         poXfpczGeDXbCwuW6nQtBGlKZr4Xp6UOq6+O8D6TABNYynpdG8ulRuOE29TSjEHiebLS
         aSQA==
X-Gm-Message-State: AOAM533QqC1088fKNGBQDW039+D9rZ2XO1yjsTmULsa/RL5MGNXuOQir
        eT1uZZ34+56pUnu83rXEYUIzcg==
X-Google-Smtp-Source: ABdhPJyeQww6L2w9VuGgoNM/JrkQ+Pfmm5nu2uBvo3kyVTiYLPzYFVgO/6sMZP8jv39GOoqKsgyVoQ==
X-Received: by 2002:a37:7906:: with SMTP id u6mr3071168qkc.495.1590609955949;
        Wed, 27 May 2020 13:05:55 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2535])
        by smtp.gmail.com with ESMTPSA id x24sm3517886qth.57.2020.05.27.13.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 13:05:55 -0700 (PDT)
Date:   Wed, 27 May 2020 16:05:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kernel-team@fb.com,
        tj@kernel.org, chris@chrisdown.name, cgroups@vger.kernel.org,
        shakeelb@google.com, mhocko@kernel.org
Subject: Re: [PATCH mm v6 4/4] mm: automatically penalize tasks with high
 swap use
Message-ID: <20200527200530.GA49331@cmpxchg.org>
References: <20200527195846.102707-1-kuba@kernel.org>
 <20200527195846.102707-5-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527195846.102707-5-kuba@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 27, 2020 at 12:58:46PM -0700, Jakub Kicinski wrote:
> Add a memory.swap.high knob, which can be used to protect the system
> from SWAP exhaustion. The mechanism used for penalizing is similar
> to memory.high penalty (sleep on return to user space).
> 
> That is not to say that the knob itself is equivalent to memory.high.
> The objective is more to protect the system from potentially buggy
> tasks consuming a lot of swap and impacting other tasks, or even
> bringing the whole system to stand still with complete SWAP
> exhaustion. Hopefully without the need to find per-task hard
> limits.
> 
> Slowing misbehaving tasks down gradually allows user space oom
> killers or other protection mechanisms to react. oomd and earlyoom
> already do killing based on swap exhaustion, and memory.swap.high
> protection will help implement such userspace oom policies more
> reliably.
> 
> We can use one counter for number of pages allocated under
> pressure to save struct task space and avoid two separate
> hierarchy walks on the hot path. The exact overage is
> calculated on return to user space, anyway.
> 
> Take the new high limit into account when determining if swap
> is "full". Borrowing the explanation from Johannes:
> 
>   The idea behind "swap full" is that as long as the workload has plenty
>   of swap space available and it's not changing its memory contents, it
>   makes sense to generously hold on to copies of data in the swap
>   device, even after the swapin. A later reclaim cycle can drop the page
>   without any IO. Trading disk space for IO.
> 
>   But the only two ways to reclaim a swap slot is when they're faulted
>   in and the references go away, or by scanning the virtual address space
>   like swapoff does - which is very expensive (one could argue it's too
>   expensive even for swapoff, it's often more practical to just reboot).
> 
>   So at some point in the fill level, we have to start freeing up swap
>   slots on fault/swapin. Otherwise we could eventually run out of swap
>   slots while they're filled with copies of data that is also in RAM.
> 
>   We don't want to OOM a workload because its available swap space is
>   filled with redundant cache.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

This looks great to me now, thanks Jakub!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
