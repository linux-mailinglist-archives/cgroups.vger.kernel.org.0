Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B82777E960
	for <lists+cgroups@lfdr.de>; Wed, 16 Aug 2023 21:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345704AbjHPTIn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Aug 2023 15:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345710AbjHPTIa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Aug 2023 15:08:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FC22701;
        Wed, 16 Aug 2023 12:08:29 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-268299d5d9fso3853288a91.1;
        Wed, 16 Aug 2023 12:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692212909; x=1692817709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oW5kqtKHBtVyg+Cd9YlZqPw+sEx2elEdwRVNVT4N6wk=;
        b=Gxeh8t9SikI1Mq11KBvKw76Om5qOdzGfIoltkKpAUl4vymSeUkeUy3KcgEcVZONd0o
         ijkR7PG61Z3sSrP7FjFfnMxlSJnkX2ePVH7AQ/YnoJZk/wJ0+/kOSMWT9ggracNjb5eN
         9/0yGwRSVDsvyu6XWfUmnQrNW51C2xDY45mYkllYGl1OMVGJ7vYfJHzRFZWVscJ9AByi
         mKkgeGOShggi0VSnfUbEIE/7BE1SnYI2G1ygiW4yJikjYAJj7oYP7/9G9zUwSBqTezyO
         YubAzVgBcAKx9ORYgcSg6yQUbIJ6DHYMTz3+erxAwxF2kyTXRzbjI6VOswRPo9JyTyB4
         FZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692212909; x=1692817709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oW5kqtKHBtVyg+Cd9YlZqPw+sEx2elEdwRVNVT4N6wk=;
        b=gYGs1JP7+nPItNh5NaLQ/1VZPWY9tvC1cjc3rvl995I6WqDTByJhfe4VNwcqWiCUjn
         Tqgg5D9ylYuT8exV25RAYhgtDytIvVdln6eAvigeQxUY/DZA/FsXfe5Ee6RJtS4CZIte
         jjJW6wyGbiyce5OATGNqOz6hmZ2CV93VHugWIDKwGXnytRIVTM1pz30t6+HEwWZBkvss
         4hI6uG5PNLCcM3YJZxX2pkymW0Nm3WK9S1+to/jk4pgoxAWrfJCjxDOUv8EAhvbgwR8+
         Xw5IuJJ1WDeE5CB89UOjuWR1c9pwelzOhCB4siZuh6lmWE+MjjJ1dEArA7tJhVdEaUDE
         FUVw==
X-Gm-Message-State: AOJu0Yz+6bJoHJvFvyGoZ6Tcz8H2mp0+fMpUIu+4Fqa8lozPGP05EyQB
        8oq6CLYYMVcHj6ezoe8OpT8=
X-Google-Smtp-Source: AGHT+IFMRgjqD6qS9RDkcPNKp+sp42EgRrn2cqRuywDmeHhg+7JiW8v5/V0EJlDvSLbC2qPcJRPEOw==
X-Received: by 2002:a17:90a:cc01:b0:263:f5fa:cf1b with SMTP id b1-20020a17090acc0100b00263f5facf1bmr2161321pju.30.1692212908713;
        Wed, 16 Aug 2023 12:08:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:93bd])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090a1fc200b0026b46ad94c9sm90263pjz.24.2023.08.16.12.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 12:08:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Aug 2023 09:08:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ivan Babrou <ivan@cloudflare.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
Message-ID: <ZN0eqq4hLRYQPHCI@slm.duckdns.org>
References: <CAJD7tkYBFz-gZ2QsHxUMT=t0KNXs66S-zzMPebadHx9zaG0Q3w@mail.gmail.com>
 <ZNrITZVTf2EILRJq@slm.duckdns.org>
 <CAJD7tkaXwoF-faApweAmm7Db7jAuS3EO7hVvdyVtqW_rE+T9Vg@mail.gmail.com>
 <ZNrLO5PAEZw4yjI9@slm.duckdns.org>
 <CAJD7tkYgCySTX28zK9GZiWwsabR4nv7M2hQ57y12si-fqtv7zg@mail.gmail.com>
 <CALvZod6KRxiDzrppCgx+=SHg2+96nFE5crwXCKwe9PZbWM_6cQ@mail.gmail.com>
 <CAJD7tkaUzhvZPohpo1F8TUKRPuXH7bjDeg9VCzN2CbywQbRutQ@mail.gmail.com>
 <CALvZod6HUtYhDaXiwXSrcwfxLSrZ37sZhKY1Mg4kmpDFk13aYw@mail.gmail.com>
 <CAJD7tkYzr2cg-aQ899vfqB4jR7iP83t8f-Z4AH8d9iW-yw-nnQ@mail.gmail.com>
 <CALvZod441xBoXzhqLWTZ+xnqDOFkHmvrzspr9NAr+nybqXgS-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod441xBoXzhqLWTZ+xnqDOFkHmvrzspr9NAr+nybqXgS-A@mail.gmail.com>
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

On Wed, Aug 16, 2023 at 10:11:20AM -0700, Shakeel Butt wrote:
> These options are not white and black and there can be something in
> between but let me be very clear on what I don't want and would NACK.

I'm not a big fan of interfaces with hidden states. What you're proposing
isn't strictly that but it's still a bit nasty. So, if we can get by without
doing that, that'd be great.

> I don't want a global sleepable lock which can be taken by potentially
> any application running on the system. We have seen similar global
> locks causing isolation and priority inversion issues in production.
> So, not another lock which needs to be taken under extreme condition
> (reading stats under OOM) by a high priority task (node controller)
> and might be held by a low priority task.

Yeah, this is a real concern. Those priority inversions do occur and can be
serious but causing serious problems under memory pressure usually requires
involving memory allocations and IOs. Here, it's just all CPU. So, at least
in OOM conditions, this shouldn't be in the way (the system wouldn't have
anything else to do anyway).

It is true that this still can lead to priority through CPU competition tho.
However, that problem isn't necessarily solved by what you're suggesting
either unless you want to restrict explicit flushing based on permissions
which is another can of worms.

My preference is not exposing this in user interface. This is mostly arising
from internal implementation details and isn't what users necessarily care
about. There are many things we can do on the kernel side to make trade-offs
among overhead, staleness and priority inversions. If we make this an
explicit userland interface behavior, we get locked into that semantics
which we'll likely regret in some future.

Thanks.

-- 
tejun
