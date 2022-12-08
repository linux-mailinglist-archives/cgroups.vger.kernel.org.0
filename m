Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6AD6465F0
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 01:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiLHAgX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Dec 2022 19:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiLHAgW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Dec 2022 19:36:22 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF768DBD8
        for <cgroups@vger.kernel.org>; Wed,  7 Dec 2022 16:36:20 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id y135so20356250yby.12
        for <cgroups@vger.kernel.org>; Wed, 07 Dec 2022 16:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hnwjKeWBS3gGbPLTonrsO/3QESDmxRzIhrG9LgstSBg=;
        b=NlFKm5a2bnfBu0WaavUk4T4534i2Ffeaod/IcsY3hbfl5pfgAHlWwatoI96o/JhxVY
         wv4jmxKJolkcLNfPjePOus4PgAoxfKxZa11QwswwKUrxbVgfpHCGZsLmLLpLRBARa5FD
         KNO2NlvY1X3gGX7GblLaLaMZ6NYgxW2EGxv2OS1UPupWVD0MOlRVlBmqHZ/ZU6UtEOYh
         XmzzI29PN659tu4HW9S9xkSazS6K1wt/sjeiwL4GMroztNtIq1BewgZTmaHVRqjEebmV
         rsbYmjDqi2YDUT9xod5OiRzgobIh9Oc1bvJH3yUAIXl2GAmgY4Qg039o4TksWbGj30XX
         26lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnwjKeWBS3gGbPLTonrsO/3QESDmxRzIhrG9LgstSBg=;
        b=5QtevFP7Ooyykh16flVDhMaVFoLG9iUgx958xg3mxpiWvOkabWbIpOI8P6sKWFIugu
         BwbtbLul65VpGQRlKd5dXTkblT4ZxAEyqj/Ei1yIcxbWan9VigERyEby6KroV7dBxFid
         VdlXhOSVXpiGVOfDYOToM3LUyksdve/j843SKj/63dpU+puKL3re7jB8eRMBZJgfgE8R
         vZ4vakX34xnmKXv6xQyiSKK6gcQlimsvLxcP+KFM06Yc0IJJlHadR1dwIT7hZ2gt9HwC
         sNCT0TNL002+Dp3OI2esEoapRZV+UtTMhY2dx22Xb4QE77e5qUlhTOEyJR2eMfjNPTBw
         YfvA==
X-Gm-Message-State: ANoB5pmkdaW4j910tZcDCJTBGNudUxF/9MMVzPy2OWEtR+tfmxVl843r
        W3yPLzZs8Ql57INUZBrOPu7ggFlS/oLLy90s/kyLAg==
X-Google-Smtp-Source: AA0mqf44mxItNX5PwT9MTa3hg1zlUCr++yyxhZxDgD0aQCIBH9N+vMHnKh56DdTmLwzu6ryOqzvZ33Tn8sstjnmqriQ=
X-Received: by 2002:a25:cb4e:0:b0:6f0:b3ae:6392 with SMTP id
 b75-20020a25cb4e000000b006f0b3ae6392mr63654400ybg.245.1670459779288; Wed, 07
 Dec 2022 16:36:19 -0800 (PST)
MIME-Version: 1.0
References: <20221206171340.139790-1-hannes@cmpxchg.org> <20221206171340.139790-2-hannes@cmpxchg.org>
In-Reply-To: <20221206171340.139790-2-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 7 Dec 2022 16:36:07 -0800
Message-ID: <CALvZod4RxpYOeVurV-vrTc7MY7m8tDCJPOsX+JNGv5BsuFMEFA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: memcontrol: skip moving non-present pages that
 are mapped elsewhere
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 6, 2022 at 9:14 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> During charge moving, the pte lock and the page lock cover nearly all
> cases of stabilizing page_mapped(). The only exception is when we're
> looking at a non-present pte and find a page in the page cache or in
> the swapcache: if the page is mapped elsewhere, it can become unmapped
> outside of our control. For this reason, rmap needs lock_page_memcg().
>
> We don't like cgroup-specific locks in generic MM code - especially in
> performance-critical MM code - and for a legacy feature that's
> unlikely to have many users left - if any.
>
> So remove the exception. Arguably that's better semantics anyway: the
> page is shared, and another process seems to be the more active user.
>
> Once we stop moving such pages, rmap doesn't need lock_page_memcg()
> anymore. The next patch will remove it.
>
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
