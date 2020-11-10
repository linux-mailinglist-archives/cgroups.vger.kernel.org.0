Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3CC2ADA56
	for <lists+cgroups@lfdr.de>; Tue, 10 Nov 2020 16:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbgKJPYy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Nov 2020 10:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731016AbgKJPYy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Nov 2020 10:24:54 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0F6C0613CF
        for <cgroups@vger.kernel.org>; Tue, 10 Nov 2020 07:24:53 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id v143so7222280qkb.2
        for <cgroups@vger.kernel.org>; Tue, 10 Nov 2020 07:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4K7M+yU2qQGJnBqVAjylDdUBTFCEnQjaCz6moXfYMEE=;
        b=on8OoPlw3VSXy8JNQfuM/sHMVZ8emLX5MZJzG0sTRRpgjWF3aRCwxgJSI9FEVC44qS
         4kQmG920BaTWRgy9W2+iS2syx5dG8Yg/RXtBHWoo/nKw12Ik/Ir0l7CSBjpeXHec2dph
         lNTHcg4fv8MpCEcu4c1MPc5PltE4KD+y6Lh3c2Wbsrd3pxKmW1K3nSqPVTtn/9yghgNO
         pM8A1l0COcK6/hiUfry60njJLbjv+PNmAhrx5oDAM/Um3Rwv00auj9hEJ+rr8/0YIKVG
         vTQ4g4GT+ArZWI37EDyK9bWNccjv5MrIbne6986cr4gqOKWA46X7OiN7nEmlRpHxIGJJ
         yFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4K7M+yU2qQGJnBqVAjylDdUBTFCEnQjaCz6moXfYMEE=;
        b=OMtiKgeODEHxrbk9dZHvINUUYSkTnbp81Z2s1D7nfP0ebRI9g0IFN41cebZht95h0V
         yhD522rnGI1iEd200Th8XJFBtiUCrXtH2gfJw0s0J9S35Pfbt6z3GwXm77+KFAE8ygDM
         ryaO2UG9Y18oaSDHoRT22X3xxeZHntbD9ksixQVVWFxF1cztF+0s97E0t6Xw8MGsmNSk
         zSmPQsLzXhpzL3Ypwk3zVNKt0AjGUhTPttn8UAOtVsRQbSCWyHqT6cXPp60n9kEBMjSX
         Kz99i3I8/xt6wAaEsm59EHTsI0M7nrZzQq1bEEjNwzFO0MJ1/dsFZy0aYQcK7EKTqEbV
         WZUw==
X-Gm-Message-State: AOAM533aeauzrV1/nAbTeV7iALuLwglbuRWWAS0LO+XSMe1KMHKE+ULk
        IeChfRizNHPFeOOJYZj3J4gl2A==
X-Google-Smtp-Source: ABdhPJxuT7o7jGuflTbr/sPJgqp+0sOaR0b+eEindXqCvTJFRyfwlR+LPCGxtZ48m83DCNLhjDx0mA==
X-Received: by 2002:a37:8685:: with SMTP id i127mr19241385qkd.37.1605021893130;
        Tue, 10 Nov 2020 07:24:53 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:64f7])
        by smtp.gmail.com with ESMTPSA id o16sm589744qkg.27.2020.11.10.07.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 07:24:52 -0800 (PST)
Date:   Tue, 10 Nov 2020 10:23:05 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, shakeelb@google.com,
        guro@fb.com, vbabka@suse.cz, laoar.shao@gmail.com,
        chris@chrisdown.name, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: memcg/slab: Fix root memcg vmstats
Message-ID: <20201110152305.GB842337@cmpxchg.org>
References: <20201110031015.15715-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110031015.15715-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 10, 2020 at 11:10:15AM +0800, Muchun Song wrote:
> If we reparent the slab objects to the root memcg, when we free
> the slab object, we need to update the per-memcg vmstats to keep
> it correct for the root memcg. Now this at least affects the vmstat
> of NR_KERNEL_STACK_KB for !CONFIG_VMAP_STACK when the thread stack
> size is smaller than the PAGE_SIZE.
> 
> Fixes: ec9f02384f60 ("mm: workingset: fix vmstat counters for shadow nodes")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
