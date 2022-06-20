Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961A755112C
	for <lists+cgroups@lfdr.de>; Mon, 20 Jun 2022 09:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbiFTHOm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Jun 2022 03:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239200AbiFTHOd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Jun 2022 03:14:33 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A26DE086
        for <cgroups@vger.kernel.org>; Mon, 20 Jun 2022 00:14:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id g8so8955253plt.8
        for <cgroups@vger.kernel.org>; Mon, 20 Jun 2022 00:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eje5eCQ8r99TF3Jk0Qo8Mipd7vUdFeKKOC/KwGU7LYo=;
        b=5rjycCsWpc48JYQSoB4UcNVOmG+xAyesyo1mdm5rRUN994NyEiZ9k1gWuZ8JtZpRMP
         +t2ea1U2dv3RAM5uPoEEheqmZOFdxYojQE4qK1jJiWODWj7qtMc9qreieOw7jgRi3Gru
         CPQKm469WxG0mK9uHF8ugLNBD9vNZqHP0iscnj9b6MT52CKIda2e4NasxL+5tUKOxTOh
         NyfiZR36HKx1Bor2GxITw1ZyRLZ4XW+Qdtc42fjrzuFgzmH9UkQ5/fN/NQv2MgLO8+mA
         ssZzqrrmOpBYjTaya8uuD4A6lIQrGOXoCTbtrCcSo3ZV+2R4u94IGcyvAyggnunAWW9a
         Pc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eje5eCQ8r99TF3Jk0Qo8Mipd7vUdFeKKOC/KwGU7LYo=;
        b=ztuQFguLqlnMhxO/SOOGHdIzl1xxkZkHO1xwKVAHwMq3xXoA0/d12KrfmfYaJUvxlS
         ZmUajsSNDMs5+0oepoJlsR9ZXGbIXFr5Ap4Sp6uzbxtxrLBvuQVoSG8PpTdjFsM3rqgI
         UFSw1YnHNNvdAPK0CFLN1s0LNV6XXegYvqZCv7OJQWi6l0yG0bfslz4WGSqEKq4iXJtc
         hgsqjVMbvggC5ck+BBaPfqDQ32TgBNbTccR2/wQ0Di5aDydrbQN+LMeXoo47Ymtccb65
         iM/8UUV0CXLbsyJVjN5iIDglHjgnHVxIUCZRZlyuBPrwrwGY9UZ894SxPrNd7FFG9wFd
         LnDg==
X-Gm-Message-State: AJIora9oEBsRZuzx5TWrjzYAIW8PDG4nQ5y7dpol5ekdfhSHBBksvlk5
        AHCCaLJ6KWRZGZsCU1U+4h5dHw==
X-Google-Smtp-Source: AGRyM1tSD/PcZEEst4MVznqWWeY3KmDeC0shEVp/6sGC9nq7iORMis0MpgAxZTqLlpVES7+Lm1YvQw==
X-Received: by 2002:a17:90b:38c8:b0:1e8:5202:f6d4 with SMTP id nn8-20020a17090b38c800b001e85202f6d4mr25245023pjb.149.1655709271470;
        Mon, 20 Jun 2022 00:14:31 -0700 (PDT)
Received: from localhost ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id j3-20020a170903024300b001624965d83bsm7892935plh.228.2022.06.20.00.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 00:14:31 -0700 (PDT)
Date:   Mon, 20 Jun 2022 15:14:27 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, longman@redhat.com
Subject: Re: [PATCH v5 08/11] mm: memcontrol: introduce memcg_reparent_ops
Message-ID: <YrAeU7yy6jhh+4zd@FVFYT0MHHV2J.usts.net>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <20220530074919.46352-9-songmuchun@bytedance.com>
 <Yq99W9ps1b/+XOwh@castle>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yq99W9ps1b/+XOwh@castle>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Jun 19, 2022 at 12:47:39PM -0700, Roman Gushchin wrote:
> On Mon, May 30, 2022 at 03:49:16PM +0800, Muchun Song wrote:
> > In the previous patch, we know how to make the lruvec lock safe when LRU
> > pages are reparented. We should do something like following.
> > 
> >     memcg_reparent_objcgs(memcg)
> >         1) lock
> >         // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
> >         spin_lock(&lruvec->lru_lock);
> >         spin_lock(&lruvec_parent->lru_lock);
> > 
> >         2) relocate from current memcg to its parent
> >         // Move all the pages from the lruvec list to the parent lruvec list.
> > 
> >         3) unlock
> >         spin_unlock(&lruvec_parent->lru_lock);
> >         spin_unlock(&lruvec->lru_lock);
> > 
> > Apart from the page lruvec lock, the deferred split queue lock (THP only)
> > also needs to do something similar. So we extract the necessary three steps
> > in the memcg_reparent_objcgs().
> > 
> >     memcg_reparent_objcgs(memcg)
> >         1) lock
> >         memcg_reparent_ops->lock(memcg, parent);
> > 
> >         2) relocate
> >         memcg_reparent_ops->relocate(memcg, reparent);
> > 
> >         3) unlock
> >         memcg_reparent_ops->unlock(memcg, reparent);
> > 
> > Now there are two different locks (e.g. lruvec lock and deferred split
> > queue lock) need to use this infrastructure. In the next patch, we will
> > use those APIs to make those locks safe when the LRU pages reparented.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> I've mixed feelings about this: it looks nice, but maybe too nice. I wonder
> if it's better to open-code it. Not very confident, I wonder what others are
> thinking.
>

I also thought about this. Open-code is not simplified than this since
memcg_reparent_ops can be used for 3 locks which simplifies code a lot.
I also want to hear others' thoughts on this.
 
> 1) Because the lock callback is first called for all ops, then relocate, then
> unlock, implicit lock dependencies are created. Now it depends on the order
> of elements in the memcg_reparent_ops array, which isn't very obvious.

Maybe we can add some comments explaining the lock dependency depends on the
element order in array.

> 2) Unlikely there will be a lot of new ops added in the future.
>

Yep. I think so.

Thanks.

> The code looks correct though.
> 
> Thanks!
> 
