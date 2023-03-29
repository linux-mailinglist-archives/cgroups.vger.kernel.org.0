Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FFC6CF315
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 21:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjC2TWr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 15:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC2TWm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 15:22:42 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EBD4201
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 12:22:37 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5416698e889so312519657b3.2
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 12:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680117757;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MD5vx/bj0saF4TqNG1nIF/YU28Jg42gUeejN+X2NCpY=;
        b=jT/j7PjxyG20P2CKl37aHA/z29PlP5r8hnouR7V1cEBZfIyQle/ffgyZ7SeY8TFDTN
         LriKUchyJMzRZTZfx2Ra1tFVLAY+IMhcDrjzjdXPhFcyX9wQ7Iq+ch1Lp8XCUn+PP+XT
         mDo99xFXTYufeJOx6O5lkcrR1KnrVe7fdgkK5wdj2U9WZ56B4j+7MKNJrYUu3YvPOJMS
         ddD10ubhfVeY9zNjMGsO05U3lUzlkLtHm4GWbA1tvIzVEXeRefinLhNUJ5Dyd+qyBevy
         Xp/QTExSKgMNuwRvOPQ7LHvWnn4acK885eIH7mW88e7D4Z3v4p2DeFo9+nXpGm8NXh8t
         I/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680117757;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MD5vx/bj0saF4TqNG1nIF/YU28Jg42gUeejN+X2NCpY=;
        b=ORxzOqLkn3qVXaaOmrdTPLeAXkDP1rbPVYM1TnF+lUULJ+h4fmXkCY5fYmdyb5G0tv
         atd9PDgJg5ZRQC/IKL9WCYkpvc0zMdQa+WG9cHhDUC35twdgda005ogROANosSh335AG
         Ii3O0gXSA9hvnuZpimsYshslKIUaRCvjW2nxKLFY8FDTGLvsL5fzn1pprr1AtptL5Fuc
         YB6+cEWzQEfSXXAsWP5Xh6Tkx1GnjrkEQODa6X+KxSw2++apZCyanplOtO8fk+O/Svyc
         MN0Rt4Mb7fmi7yo66RcQffrUKImzFPocYi0msCNwgdUt7bjRIie84SdJHPfqFDNXC2pi
         cETA==
X-Gm-Message-State: AAQBX9eGQt5W+ulgvd+Suh6VP79NCjcZifetVFjUT/0+peuVLdtJMEc2
        /PKbvh6/1Ald+2Q17s7AgcTk+Q==
X-Google-Smtp-Source: AKy350aGXqku0wFHBwnbv0ayIqkfKZQbDVwnxlDtv6ud72FCuk4s6YtJqZ1NSL1cWoc/4AVWoTxyWQ==
X-Received: by 2002:a81:920c:0:b0:52e:e095:3a00 with SMTP id j12-20020a81920c000000b0052ee0953a00mr21208691ywg.25.1680117756881;
        Wed, 29 Mar 2023 12:22:36 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d8-20020a81d808000000b00545a08184dcsm3092357ywj.108.2023.03.29.12.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 12:22:35 -0700 (PDT)
Date:   Wed, 29 Mar 2023 12:22:24 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Tejun Heo <tj@kernel.org>
cc:     Yosry Ahmed <yosryahmed@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
In-Reply-To: <ZCSJDpPPOVvBYfOy@slm.duckdns.org>
Message-ID: <f9b6410-ee17-635f-a35d-559fa0191dc3@google.com>
References: <20230323040037.2389095-1-yosryahmed@google.com> <20230323040037.2389095-2-yosryahmed@google.com> <ZBz/V5a7/6PZeM7S@slm.duckdns.org> <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com> <ZB5UalkjGngcBDEJ@slm.duckdns.org>
 <CAJD7tkYhyMkD8SFf8b8L1W9QUrLOdw-HJ2NUbENjw5dgFnH3Aw@mail.gmail.com> <CALvZod6rF0D21hcV7xnqD+oRkn=x5NLi5GOkPpyaPa859uDH+Q@mail.gmail.com> <CAJD7tkY_ESpMYMw72bsATpp6tPphv8qS6VbfEUjpKZW6vUqQSQ@mail.gmail.com> <CALvZod41ecuCKmuFBNtAjoKJjQgWYzoe4_B8zRK37HYk-rYDkA@mail.gmail.com>
 <CAJD7tkZrp=4zWvjE9_010TAG1T_crCbf9P64UzJABspgcrGPKg@mail.gmail.com> <ZCSJDpPPOVvBYfOy@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

On Wed, 29 Mar 2023, Tejun Heo wrote:
> On Mon, Mar 27, 2023 at 04:23:13PM -0700, Yosry Ahmed wrote:
> > Tejun, if having the lock be non-irq is a non-starter for you, I can
> 
> This is an actual hazard. We see in prod these unprotected locks causing
> very big spikes in tail latencies and they can be tricky to root cause too
> and given the way rstat lock is used it's highly likely to be involved in
> those scenarios with the proposed change, so it's gonna be a nack from my
> end.

Butting in here, I'm fascinated.  This is certainly not my area, I know
nothing about rstat, but this is the first time I ever heard someone
arguing for more disabling of interrupts rather than less.

An interrupt coming in while holding a contended resource can certainly
add to latencies, that I accept of course.  But until now, I thought it
was agreed best practice to disable irqs only regretfully, when strictly
necessary.

If that has changed, I for one want to know about it.  How should we
now judge which spinlocks should disable interrupts and which should not?
Page table locks are currently my main interest - should those be changed?

Thanks,
Hugh
