Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F9B59342B
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 19:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiHORrV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 13:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHORrT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 13:47:19 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247532654C
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 10:47:18 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id m5so6068420qkk.1
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 10:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Kk1le+XvE3D7VTktFKWjawEbexVd49xc8A2KpMO7iq8=;
        b=eQKsJ8stLgyyQXvUP/E7q4Wlp+v19noK96fAZX3mr1P14cj6AK0dtNCRHwiSjq8W1l
         F8ZvkF96Q5GjKKQVwJmHra/4F8MrB1pugUURKfQIqnqMjnOPth5Dp4M5Uff4f3gq6qYY
         3vtXQk1lAyet/XMy+J3dj6NBxEc9umEp/KX4uUH8ncLTYut8nnYwzxnMWSZIK0ndAXUh
         IR6I2kwQxzUoxKaGK3s2qONIQKu4KpEBk4MvJ8tcq+A8apZYOV1GBg2xwo7n9eamEnd+
         2qSM2leEG3F8LydH6TQ7qn3yJR4IY11gT6d+X8TAgKKmaTZ7RMFCdgvCO6u+ocW8oaqL
         ajTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Kk1le+XvE3D7VTktFKWjawEbexVd49xc8A2KpMO7iq8=;
        b=i3kmF4tCGSxm9SI/r5In/zQiSyBDG9ZCDmzGP6TWk70Fj28B1TOaR6HDPfM1x5i2Hk
         bbHJxfRyRxm+AODf64bBYDaa2Hdwlif+ZJgJZiihcA1ncmz1rQaa4KEc8p0Ec6YswFNh
         2RCMmkckd0OnRmT2NNKWHuDePgJVo19gLW+GyNIL4wZQwwwP9MNZHL/RuCSHRdubJH15
         EUpj8PQPTSNtfTVJ22dhnwD+fb8oem2LXkWKm7db2Zx9luuzxEDwWUBNN6cnTfo8hRti
         bSS51dAQSf9iE4xc8gF/9jFHj5GVd5NYzGmVAgZQOZISXCnAsxjNFro74IrReoK0REf9
         fp0w==
X-Gm-Message-State: ACgBeo1MJcqV4d7xE8vVfyHL6rnP5UlxeF17PcxM1jPNKMb02slMLyQc
        kFmgZVm3MNi27m5NQ8VlKDDIbA==
X-Google-Smtp-Source: AA6agR5gyGmmvLQOzu94ClYMxnOheRicWl4RTmWep+ox0M3u1C8LTRBWcfDQNLeGag4zBRQQV+arug==
X-Received: by 2002:a05:620a:2545:b0:6b6:6773:f278 with SMTP id s5-20020a05620a254500b006b66773f278mr12704133qko.390.1660585637278;
        Mon, 15 Aug 2022 10:47:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a23e])
        by smtp.gmail.com with ESMTPSA id l3-20020a05620a28c300b006bb2661f3fasm4125935qkp.133.2022.08.15.10.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 10:47:16 -0700 (PDT)
Date:   Mon, 15 Aug 2022 13:47:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     "Li,Liguang" <liliguang@baidu.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH] mm: correctly charge compressed memory to its memcg
Message-ID: <YvqGoxfs25bEyQGJ@cmpxchg.org>
References: <YvWa9MOQWBICInjO@P9FQF9L96D.corp.robot.car>
 <CALvZod4nnn8BHYqAM4xtcR0Ddo2-Wr8uKm9h_CHWUaXw7g_DCg@mail.gmail.com>
 <CAJD7tkbrCNDMkE8dJDWHiTfi=nJJzrZwepaWb3YioRHMrSEuQA@mail.gmail.com>
 <1704B09B-F758-47DF-BDDE-FEA9AB227E12@baidu.com>
 <CAJD7tkaW7qtaNpc3UHuQAcJAjdjzjmWZCqCMafT-nUES+2QtYg@mail.gmail.com>
 <E0E6FD3B-242B-4187-B4B4-9D4496A5B19A@baidu.com>
 <CAJD7tkYdJrakJGp8XMt49ixZJuf=qpGm=vSxH6G_GWeenk35dQ@mail.gmail.com>
 <Yvpm3cubIRAqUUJn@cmpxchg.org>
 <CAJD7tkaSS61YqYHKztqimASEaEakAdV0XqMs_k0ooJhUbX0+=g@mail.gmail.com>
 <CAJD7tkbVz44d64yPm15kUMmpFEQwFtut6Ye8D8oO1jiS9s_tBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbVz44d64yPm15kUMmpFEQwFtut6Ye8D8oO1jiS9s_tBw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 15, 2022 at 09:16:08AM -0700, Yosry Ahmed wrote:
> On Mon, Aug 15, 2022 at 8:42 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Mon, Aug 15, 2022 at 8:31 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Mon, Aug 15, 2022 at 06:46:46AM -0700, Yosry Ahmed wrote:
> > > > Yeah I understand this much, what I don't understand is why we charge
> > > > the zswap memory through objcg (thus tying it to memcg kmem charging)
> > > > rather than directly through memcg.
> > >
> > > The charged quantities are smaller than a page, so we have to use the
> > > byte interface.
> > >
> > > The byte interface (objcg) was written for slab originally, hence the
> > > link to the kmem option. But note that CONFIG_MEMCG_KMEM is no longer
> > > a user-visible option, and for all intents and purposes a fixed part
> > > of CONFIG_MEMCG.
> > >
> > > (There is the SLOB quirk. But I'm not sure anybody uses slob, let
> > > alone slob + memcg.)
> >
> > Thanks for the clarification, it makes sense to use the byte interface
> > here for this, and thanks for pointing out that CONFIC_MEMCG_KMEM is
> > not part of CONFIG_MEMCG.
> >
> > One more question :) memcg kmem charging can still be disabled even
> > with !CONFIG_MEMCG_KMEM, right? In this case zswap charging will also
> > be off, which seems like an unintended side effect, right?
> 
> memcg kmem charging can still be disabled even
> with CONFIG_MEMCG_KMEM***

Yes, indeed, if the host is booted with the nokmem flag. Doing so will
turn off slab, percpu, and (as of recently) zswap.

The zswap backing storage *is* kernel memory, so that seems like the
correct semantics for the flag.

That said, the distinction between kernel and user memory is becoming
increasingly odd. The more kernel memory we track, the more ridiculous
the size of the hole you punch into resource control by disabling it.

Maybe we should just deprecate that knob altogether.
