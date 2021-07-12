Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC8B3C62AA
	for <lists+cgroups@lfdr.de>; Mon, 12 Jul 2021 20:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhGLSeT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Jul 2021 14:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbhGLSeT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Jul 2021 14:34:19 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C080FC0613DD
        for <cgroups@vger.kernel.org>; Mon, 12 Jul 2021 11:31:30 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id ay16so231532qvb.12
        for <cgroups@vger.kernel.org>; Mon, 12 Jul 2021 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=91QVBsn60C5sxxxstdN+oyAoFM1Vz8Xrhf5wNCClAZ0=;
        b=a019hXVML1QTTEfMxq4xOcak1XJogepYRETIyj3+hyPTloWky9q429jsqUoXR7NVUp
         x0sleTMvkwrpFBp5Iq492/WoP65dbpZlQV0HMy3pWuYArruuTgwsz2kNgmgvcfB0Uf8A
         zDuf0ZV/XAINwDV7rOhVLr2StoZ41vBZMq4y+WzvgRTKLKILuFcPWYjse+WchS9SplIV
         aQi/Q0AzrsPNr6udTmAyz7xaxLOL4RHnMtQohfkumhs2UOheE+1WjeKcsex9RZix8MRU
         IVEcs/d+bN2CTr2OCyJfFWTq0bnSxNX0smTokjuWD78ZfZS/wzfyHrDGXqBkR8ux7Lx7
         4MOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=91QVBsn60C5sxxxstdN+oyAoFM1Vz8Xrhf5wNCClAZ0=;
        b=tOejfrz5gBNqnD8i6h+WY8h5Xw2gjZQu0KBhuObLWZwaaFe2veRBxgAhHXhQyS1htt
         B1S1JLbuTn0sp79FYYD4ckrxKA/QAV13QDEZ9LzFEcJrgsKQ+ukGW+h4O7QsJpxZcEY+
         1Z2/ZhciR1Ttj6CxlEp13kATnPnRyc8s0C16xexP7PSjAZuo7GFo8L9IDkuDGB/lT+aB
         6NG6plwMe6TY7Yyx1ANK0K//uBYUrHNatNmaRUKfnZoyrPSMMQxcbPe7CmN9kEjwuSxh
         matpAPWwW9u6PUSISm/BXioZsmm7gx/ujsdSkOcnkDfR45iMTxPgKjRpzvP/Cca4jYTm
         2xLg==
X-Gm-Message-State: AOAM531NmUn+M2KbmlxWSBo9yHnkAOw+/edqMT/7TNDiIkm/bMb9MWMT
        9gryLFadpnwAfpZjk17/rVvfWg==
X-Google-Smtp-Source: ABdhPJy1mAKtVsdu1BKkSpdIw3PhdMIO5F6wAuKWr6F1MoPxiv4FZkGIUcRiLa3CFNZlpp0QbqBqcQ==
X-Received: by 2002:a05:6214:224c:: with SMTP id c12mr431607qvc.7.1626114689982;
        Mon, 12 Jul 2021 11:31:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a40c])
        by smtp.gmail.com with ESMTPSA id 71sm5935964qtc.97.2021.07.12.11.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 11:31:28 -0700 (PDT)
Date:   Mon, 12 Jul 2021 14:31:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        songmuchun@bytedance.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, vbabka@suse.cz, axboe@kernel.dk,
        iamjoonsoo.kim@lge.com, david@redhat.com, willy@infradead.org,
        apopple@nvidia.com, minchan@kernel.org, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm, memcg: inline mem_cgroup_{charge/uncharge} to
 improve disabled memcg config
Message-ID: <YOyKfySwuBfgtEvW@cmpxchg.org>
References: <20210709171554.3494654-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709171554.3494654-1-surenb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 09, 2021 at 10:15:54AM -0700, Suren Baghdasaryan wrote:
> Inline mem_cgroup_{charge/uncharge} and mem_cgroup_uncharge_list functions
> functions to perform mem_cgroup_disabled static key check inline before
> calling the main body of the function. This minimizes the memcg overhead
> in the pagefault and exit_mmap paths when memcgs are disabled using
> cgroup_disable=memory command-line option.
> This change results in ~0.4% overhead reduction when running PFT test
> comparing {CONFIG_MEMCG=n} against {CONFIG_MEMCG=y, cgroup_disable=memory}
> configurationon on an 8-core ARM64 Android device.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!
