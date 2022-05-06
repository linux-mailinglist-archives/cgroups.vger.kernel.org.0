Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01D351DCA1
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 17:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443224AbiEFQA1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 May 2022 12:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443225AbiEFQA0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 May 2022 12:00:26 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD176D1AD
        for <cgroups@vger.kernel.org>; Fri,  6 May 2022 08:56:42 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g3so6453409pgg.3
        for <cgroups@vger.kernel.org>; Fri, 06 May 2022 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m81d4j0n4jrU8+EkDRIdTToCet26p62xWOxrVZBvafg=;
        b=S1iVkf0yZxiaHzRBF42XNyBBVYQtqIWrWcb4akJVYnJMmXnItPsVLmg4coDg8m/z67
         zbApxIKZInjNBYxMJw8GIMzyj7M3bgKFUnKdDhR/ihqiUbAQkrfwyXdCvuTc/G/2I+4h
         dWxhx4OhlpzjbIwrxJblu6/FndBQSKOCVwpoCXNUsiWW/IMOJmsWE/bLctyGJdeaJOCb
         aRQE95Jbf47BWzr6ax2qXBxI7K+cBRdcaxoFdUKc5y16WUBwk0VM2M5GNhyCZqOk4Wkw
         F9Bvu8K6Ft+b68SNWYjQMKhxpzKetTu3oAOcHDoSa/7tlueVVUgn83GnY5mOciJpzE0O
         Y9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m81d4j0n4jrU8+EkDRIdTToCet26p62xWOxrVZBvafg=;
        b=P6mKXDfMgjAmkyC86TKW+QJvamoQDSRhyoxATSDyHAdEWEbADY9eoDQrOaL41Yjf1D
         kK8dHYycyv4YCu5ibigX9E8BTe3lFC+wCfawnaSE96GleeMlNqf/CJKrObnoO4z/PFq3
         dEAS77NykOOsuPvUsimHIaH7e61cOHAF8+T2TW8eyxA2Bd87+tdvFYjGyBajFt2WEBaB
         I2r3P4hHrwkOj6yecMVHDpjeIF2PZBQcLXg0tccw4YZ4rEA6wfD9RwJt3bMeupE+kx1U
         bhwN1bYVl425cy5KNroa6xtasy0+Z0nlYeBJ/RBEMoBW4xl36AJwd58s7yrA7Y/+Hf50
         da0Q==
X-Gm-Message-State: AOAM533Hc6uSDGJkgxjbvqFhNhiZJ5qn3R+feLJwa5zA985q6WL2uOls
        noNKGdAbhjNqimatUZrN5yrYHRI0gTb9TiPXJOTH5Q==
X-Google-Smtp-Source: ABdhPJziffrcGvlPDxqjGz/Vr0ekqIFtG6zrGIg+rMwoZp9uSB2un9q9wNrJB1PRhDQhf9QHDrzZV/ayRSY3fzj/qso=
X-Received: by 2002:a63:382:0:b0:3c2:1669:e57b with SMTP id
 124-20020a630382000000b003c21669e57bmr3299293pgd.509.1651852602162; Fri, 06
 May 2022 08:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220505121329.GA32827@us192.sjc.aristanetworks.com> <YnU3EuaWCKL5LZLy@cmpxchg.org>
In-Reply-To: <YnU3EuaWCKL5LZLy@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 6 May 2022 08:56:31 -0700
Message-ID: <CALvZod6jcdhHqFEo1r-y5QufA+LxeCDy9hnD2ag_8vkvxXtp2Q@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: Export memcg->watermark via sysfs for v2 memcg
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ganesan Rajagopal <rganesan@arista.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 6, 2022 at 7:57 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, May 05, 2022 at 05:13:30AM -0700, Ganesan Rajagopal wrote:
> > v1 memcg exports memcg->watermark as "memory.mem_usage_in_bytes" in
> > sysfs. This is missing for v2 memcg though "memory.current" is exported.
> > There is no other easy way of getting this information in Linux.
> > getrsuage() returns ru_maxrss but that's the max RSS of a single process
> > instead of the aggregated max RSS of all the processes. Hence, expose
> > memcg->watermark as "memory.watermark" for v2 memcg.
> >
> > Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>
>
> This wasn't initially added to cgroup2 because its usefulness is very
> specific: it's (mostly) useless on limited cgroups, on long-running
> cgroups, and on cgroups that are recycled for multiple jobs. And I
> expect these categories apply to the majority of cgroup usecases.
>
> However, for the situation where you want to measure the footprint of
> a short-lived, unlimited one-off cgroup, there really is no good
> alternative. And it's a legitimate usecase. It doesn't cost much to
> maintain this info. So I think we should go ahead with this patch.
>
> But please add a blurb to Documentation/admin-guide/cgroup-v2.rst.

No objection from me. I do have two points: (1) watermark is not a
good name for this interface, maybe max_usage or something. (2) a way
to reset (i.e. write to it, reset it).
