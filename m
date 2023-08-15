Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0043B77C45D
	for <lists+cgroups@lfdr.de>; Tue, 15 Aug 2023 02:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjHOASw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Aug 2023 20:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjHOASg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Aug 2023 20:18:36 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5621723;
        Mon, 14 Aug 2023 17:18:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686e0213c0bso3173737b3a.1;
        Mon, 14 Aug 2023 17:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692058714; x=1692663514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iI/z3p1z+oyuvkMoGO3dhSMxAz4pa3XR9N0pfdyH1rA=;
        b=ZetMe4wDM/zQ8LujISpxiJVpdhExK6n4UGgEYvahiHieWe6yvAO7zOlZjAC4rxGbwY
         g9SSYLFu5SjRyBybonkHUitUBuUvIQfMnTG7/Gyyj2c6NYX/Q4pbztzk9ZD/hIlHO9Dy
         hzLIsjmH1AezKGQfiDXTcKQmND/UMj7JD5sUVN27ODMpHKC9P5wTJspfkuj1SINQIm0U
         2Ye1n8dCGUvAEU68VXJ2qZ0uWcqjcFETeQQD94DHYJEtIodWwMujb3desP5BXnCnwY9K
         MqGr+SM97wwe6DnNprIF1WgArQITtdv5QCv290li2MZYGkyzF7V8Sbn1B/tB3dAMZJTQ
         56fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692058714; x=1692663514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iI/z3p1z+oyuvkMoGO3dhSMxAz4pa3XR9N0pfdyH1rA=;
        b=l2NNUJqCG+8y43kIAv4e3yFYFeNjE7dgpj/xh4PyRO6nrv8sUYlOQr5oKF+G047TrA
         XguBDzNA8JFdY1RZQOsUTzcijgMSI8Lw83h8JQzhhvNHRJAYxZiYiE/uk8MYo2SQd94q
         Sav495YMovULBCsNISd+g/2F/3l8w7nDXNxCTfLeMr/+hmsR2+YXNDK2aTEBv0FzjKaN
         79MjVVm+SPZkQxs5xqKE86+gIuYBOJ2hZIEhPiOTZYrU+kt5fkcDhVmP60YiSM26dlY2
         exFpZcfpc1a7Ud7WsUTOLdA5ntL+i+HI2YZGt47DGcjvTiY/MfW3eUGOXmzBofON5vEV
         4cJw==
X-Gm-Message-State: AOJu0Yx14HKwc+7i1Lh/GJLMZPbll0CFNzHgdgXPuQ1HlEZDk7aCu+Ff
        jf3aOEgCpy0w13QROdf+Lq4=
X-Google-Smtp-Source: AGHT+IEWCm2HUHkuK+xVRs3xx51ddukSML0RqtZ2nwhY4h6+zSHUXkqdaKAjIFhWZ13SsnxPXmuHqw==
X-Received: by 2002:a05:6a00:8cc:b0:688:48a9:c4ad with SMTP id s12-20020a056a0008cc00b0068848a9c4admr315573pfu.15.1692058713730;
        Mon, 14 Aug 2023 17:18:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:93bd])
        by smtp.gmail.com with ESMTPSA id x5-20020aa793a5000000b00682ad3613eesm8422492pff.51.2023.08.14.17.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 17:18:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Aug 2023 14:18:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Ivan Babrou <ivan@cloudflare.com>,
        Waiman Long <longman@redhat.com>,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Expensive memory.stat + cpu.stat reads
Message-ID: <ZNrEV1qEcQMUgztn@slm.duckdns.org>
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
 <20230706062045.xwmwns7cm4fxd7iu@google.com>
 <CABWYdi2pBaCrdKcM37oBomc+5W8MdRp1HwPpOExBGYfZitxyWA@mail.gmail.com>
 <d3f3a7bc-b181-a408-af1d-dd401c172cbf@redhat.com>
 <CABWYdi2iWYT0sHpK74W6=Oz6HA_3bAqKQd4h+amK0n3T3nge6g@mail.gmail.com>
 <CABWYdi3YNwtPDwwJWmCO-ER50iP7CfbXkCep5TKb-9QzY-a40A@mail.gmail.com>
 <CABWYdi0+0gxr7PB4R8rh6hXO=H7ZaCzfk8bmOSeQMuZR7s7Pjg@mail.gmail.com>
 <CAJD7tkaf5GNbyhCbWyyLtxpqmZ4+iByQgmS1QEFf+bnEMCdmFA@mail.gmail.com>
 <CAJD7tkb=dUfc=L+61noQYHymHPUHswm_XUyFvRdaZemo80qUdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkb=dUfc=L+61noQYHymHPUHswm_XUyFvRdaZemo80qUdQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Aug 11, 2023 at 05:01:08PM -0700, Yosry Ahmed wrote:
> There have been a lot of problems coming from this global rstat lock:
> hard lockups (when we used to flush atomically), unified flushing
> being expensive, skipping flushing being inaccurate, etc.
> 
> I wonder if it's time to rethink this lock and break it down into
> granular locks. Perhaps a per-cgroup lock, and develop a locking
> scheme where you always lock a parent then a child, then flush the
> child and unlock it and move to the next child, etc. This will allow
> concurrent flushing of non-root cgroups. Even when flushing the root,
> if we flush all its children first without locking the root, then only
> lock the root when flushing the top-level children, then some level of
> concurrency can be achieved.
> 
> Maybe this is too complicated, I never tried to implement it, but I
> have been bouncing around this idea in my head for a while now.
> 
> We can also split the update tree per controller. As far as I can tell
> there is no reason to flush cpu stats for example when someone wants
> to read memory stats.

There's another thread. Let's continue there but I'm a bit skeptical whether
splitting the lock is a good solution here. Regardless of locking, we don't
want to run in an atomic context for that long anwyay.

Thanks.

-- 
tejun
