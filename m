Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3CA59656A
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 00:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbiHPWUH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 18:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbiHPWTY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 18:19:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3A17AC3A;
        Tue, 16 Aug 2022 15:19:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso175402pjd.3;
        Tue, 16 Aug 2022 15:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=v/EIdBGUkUPtNpLpVOdmRMecyshYK7WIwF9D88OOScU=;
        b=XFz549JzgGby3QShSMg1u6ld0qYxrMD3+idlLFNetfD3Uf4CUVmSJzQwu21B0nSuY3
         DE4olgojem8eez9w5KVGDNKI9NvFlyOpx319HD1Xz0JPYqZ7GtDaO4Vyu517VUEk0vBa
         3EPbHmc4qV8pUgXU3pMJS7zvviFi4hykmH28LUfjweBN4/f1jde/ZTjmWze/tOVxcjiD
         4wVtggFwXqgarGqZBPJL4V5dNiKgZShkmuN19HOl8yD0CjcppHuDpJIaW2fOtUgfImf7
         O+dicxS87PkLT0yR/gQzPEFBhH8VvmUxwvw6Z992mJ3fcqgr6NEgfIBdiJy8L84CfIGW
         C8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=v/EIdBGUkUPtNpLpVOdmRMecyshYK7WIwF9D88OOScU=;
        b=PHunzgMkHWkSQGfpeSAxGHQNhMl4Xl2Mpzn2Wgz7ucL3OaPAQDcF3L8PwXFs8UWC4b
         DgnIRhiQio7glLlV6Q0dPed1LpUhxxreK2VMvAgiJxjG9dOgiZYCexhN2BFvTsxO5+I6
         Iiyetls0j7V9KuOoXpUK6Lby9aN2ktEbJlVQqMcAjAR2TmvamBBJ7CwR31bojmagZOKc
         hUzAXkKHXxrq5HLeVnTAopdC0QW+G4DjjkVSOeQ/qYkbzC438W7t8851lRVxHdbGGypH
         MTWGYP7t1w2f/aDpbKDHGES6t9W1ObNF1+UJVLH9xRwj5Ty77GAKGnmxhyyqLoRsOIB1
         nxbA==
X-Gm-Message-State: ACgBeo0QYxxhwIZFHC7UarjbotFsI/0sFU0khOUh9ucz3jWQKAiaF1hX
        izQiOEHloUQgxB+gmGqNJCM=
X-Google-Smtp-Source: AA6agR5444hR3/D5RFxnx5aA31sSW3PzrPcGowK1Az0EUVJCo7nNYyNnIRaopp2BUk8/pmHkiVzyjg==
X-Received: by 2002:a17:90b:180f:b0:1f5:160c:a656 with SMTP id lw15-20020a17090b180f00b001f5160ca656mr693043pjb.193.1660688349662;
        Tue, 16 Aug 2022 15:19:09 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7229])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b0016cbb46806asm9595537plc.278.2022.08.16.15.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 15:19:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 16 Aug 2022 12:19:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 3/3] cgroup/cpuset: Keep user set cpus affinity
Message-ID: <YvwX24GXadKQNp6V@slm.duckdns.org>
References: <20220816192734.67115-1-longman@redhat.com>
 <20220816192734.67115-4-longman@redhat.com>
 <Yvv66EWygCwHUCqy@slm.duckdns.org>
 <c10e4f69-9951-6c38-6e28-fafcaec00d89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10e4f69-9951-6c38-6e28-fafcaec00d89@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Aug 16, 2022 at 06:11:03PM -0400, Waiman Long wrote:
> It is hard to synchronize different subsystems atomically without running
> into locking issue. Let me think about what can be done in this case.

I have a hard time seeing why this would be particularly difficult. cpuset
just needs to make the latest cpumask available to sched core in an easily
accessible form and whenever that changes, trigger a set_cpus_allowed call.
There's no need to entangle operations across the whole subsystems. All
that's needed to be communicated is the current cpumask.

> Is using a sequence number to check for race with retry good enough?

It seems unnecessarily fragile and complicated to me. If we're gonna change
it, let's change it right.

Thanks.

-- 
tejun
