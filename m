Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1507C63B28A
	for <lists+cgroups@lfdr.de>; Mon, 28 Nov 2022 20:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiK1Tu5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 14:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiK1Tu4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 14:50:56 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25BF2C642;
        Mon, 28 Nov 2022 11:50:54 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 82so3422570pgc.0;
        Mon, 28 Nov 2022 11:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcEtc6FEdThSJ79tsOLA2O9TxilKdXYytFRNDoxtA04=;
        b=Aw1VZ/t2cZu24hm4yg+tGuPK2iELH1xl3jtew5qH7h9YSqh8iFmCHquLUDH54gKQN4
         0afy7+2/I6ibVLxwN3XVSKTzJ5VDAv9OvhaQADeaGwNZxXa6Pijl1R1Uj3Y2qnn6qRmU
         uj5EshG1kfx+RglivS+2KsjQn+Be/uKUDHdqcfPpf/3QITRA1xPky2V2nfIpZBSs5n1D
         DdI0yI7hyJ6Pub4pQwX5Z1GsGnaot0QNT/CopFyGT4GBwjQ3pq2QJ5MSV3J/N0gjKh+L
         GAxgrtiTXbX7z3RLpRp6qNGiHAICpzqZijAeBzN5/Rd/KtVTHB7aBHWT9OT72ZNZiq3K
         nS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcEtc6FEdThSJ79tsOLA2O9TxilKdXYytFRNDoxtA04=;
        b=6DhRA6kxG7K8oYFHX1v0nda3oFVvO9ojSCIsAbkyx20XtXin97QEZcBJ5+MWVanwLU
         oA1/U1URC00N89t9M8tzPgq1zWB0t8iuu9lUGvV5BjF+f4J4n7KXDJQIV7n6VrRtsnOe
         o43NiFKOVYfWkEpnMPxDpQ45+xC2wXAxYf2My7Io7OjG3XpalXX3hAl7xe1aECt58jrl
         Tq3+YRK39zUc8sXBS9s5otKubo9JbCch0RgXxJOR4bUyUis49fAGzDaycNSbA8QjLlPV
         gn3xfCEm1dFXLFqhC/i/aiHHylPF2+WgNbrNpiG1mjp3srs5hM/Y6P2sInEWDgMSIHHg
         40gQ==
X-Gm-Message-State: ANoB5pk8UwxIhDAMLOHPE7QGlGQ3zKAjDBWViiVzcEbayz4LoEmq4zBR
        Se2YWPI8mBGxF2RQwl2HXsjjhhW/5s8=
X-Google-Smtp-Source: AA0mqf45N0ocNZyTMgbg+xjZ51Tl+QJ726m6JF5QQBG+t6t/xLrzdRdXbrRaujuTH4Z+X5svbZV5Kw==
X-Received: by 2002:a63:f012:0:b0:477:b658:c2ea with SMTP id k18-20020a63f012000000b00477b658c2eamr25589559pgh.598.1669665054083;
        Mon, 28 Nov 2022 11:50:54 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id jc21-20020a17090325d500b00189847cd4acsm3378537plb.237.2022.11.28.11.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 11:50:53 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 28 Nov 2022 09:50:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: Re: [RFC 11/13] cgroup/drm: Introduce weight based drm cgroup control
Message-ID: <Y4URHHISpZaFQmj6@slm.duckdns.org>
References: <20221109161141.2987173-1-tvrtko.ursulin@linux.intel.com>
 <20221109161141.2987173-12-tvrtko.ursulin@linux.intel.com>
 <Y30/MIsLmVAZ7pQi@slm.duckdns.org>
 <30f42096-3f42-594e-8ff1-c09341925518@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30f42096-3f42-594e-8ff1-c09341925518@linux.intel.com>
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

On Thu, Nov 24, 2022 at 02:32:25PM +0000, Tvrtko Ursulin wrote:
> > Soft limits is a bit of misnomer and can be confused with best-effort limits
> > such as memory.high. Prolly best to not use the term.
> 
> Are you suggesting "best effort limits" or "best effort <something>"? It
> would sounds good to me if we found the right <something>. Best effort
> budget perhaps?

A more conventional name would be hierarchical weighted distribution.

> Also, when you mention scalability you are concerned about multiple tree
> walks I have per iteration? I wasn't so much worried about that, definitely
> not for the RFC, but even in general due relatively low frequency of
> scanning and a good amount of less trivial cost being outside the actual
> tree walks (drm client walks, GPU utilisation calculations, maybe more). But
> perhaps I don't have the right idea on how big cgroups hierarchies can be
> compared to number of drm clients etc.

It's just a better way doing this kind of weight based scheduling. It's
simpler, more scalable and easier to understand how things are working. The
basic idea is pretty simple - each schedulable entity gets assigned a
timestamp and whenever it consumes the target resource, its time is wound
forward by the consumption amount divided by its absolute share - e.g. if
cgroup A deserves 25% of the entire thing and it ran for 1s, its time is
wound forward by 1s / 0.25 == 4s. There's a rbtree keyed by these timestamps
and anything wanting to consume gets put on that tree and whatever is at the
head of the tree is the next thing to run.

Thanks.

-- 
tejun
