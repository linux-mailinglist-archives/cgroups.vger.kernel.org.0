Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB4151E82F
	for <lists+cgroups@lfdr.de>; Sat,  7 May 2022 17:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345751AbiEGPhq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 May 2022 11:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343852AbiEGPhp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 May 2022 11:37:45 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C6441631
        for <cgroups@vger.kernel.org>; Sat,  7 May 2022 08:33:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so9312099pjf.0
        for <cgroups@vger.kernel.org>; Sat, 07 May 2022 08:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKIrTDgFPzQoY+nQlkFGe6GXuT/mXqMIOBgKZEviWa0=;
        b=mM/QEyG8NRrxogssx348Xw9iuXFePPCxz8tD/ChHoVABmGa9Gd4j9lTAsRGn3NNyDx
         lLE+53P1YvhbEKq8ks3ha7QiBoEPsulerpQIV3rs6YO1z3IU5EJy4WpgJ+OUlq8bApJl
         nq4qk70mU++hxHK+ppYFPS7ICMK32ngwAwwbAks2652HVZ5+YaeEJb+3VCHR9xheSxMo
         Jw0DPaLDO3mh0mYxsPZYnKKAJoYtaKKZDlWysgfuwZKr5ZNhUb5w21H6hwZI0gC5y4Yr
         C7UkSnjzkcDMxeGNk+Hw3/sIVo+WCABP0JJpxOWIkbwwQrQZlnjf8fOGHROhVY7vQcis
         W/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKIrTDgFPzQoY+nQlkFGe6GXuT/mXqMIOBgKZEviWa0=;
        b=Fwh81Hslu1K0B18OSsXvKlimKrQmwi7dIkralam3MCGvCd6z4oaOU5qyAgg3fyBbK8
         1jN2htDUxzNtr0RlIorL1ojf+GJb3+rka5nB0CpWKWLQHY0d4+NyWmIrETuht5AHNRjO
         UlYNNfNoypYOyPnPFzn7DBrZZuN5qT0CRp+W53aw+rCPqJ7IB5BtfBZm5D2vP/Nwoe23
         NkQ1dqHlGe6H5RnKHiLHtjRM8SRWF5/kEUGjnJC8XtgCQR9M/uBIVeurUkSmDC5hIDvj
         UunlqWohf7ChKnZ3ZtVNnatsBHlTW7oMgEKwcYrzzHN5CuSiwgqqKVPZDG7TzOdmOOSy
         oi2g==
X-Gm-Message-State: AOAM5330Ln+vLg6WK9+d6i4UxEtusFfRQBzI+hPbFOlX8+jHprcPt/7H
        /aJt5ZifF9h6ORsFk3ebXZ8w2T81NOxj0DT5kzvzQg==
X-Google-Smtp-Source: ABdhPJxxarzdy4Wel7BXTduqXnRisdrUKriSUkL4BzvSAdCRoZXiZpI+1xGZMcwAdXXQp2RJkh7R/QEf4nvYu99soaE=
X-Received: by 2002:a17:902:f682:b0:15e:951b:8091 with SMTP id
 l2-20020a170902f68200b0015e951b8091mr8598773plg.106.1651937637817; Sat, 07
 May 2022 08:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220507050916.GA13577@us192.sjc.aristanetworks.com>
In-Reply-To: <20220507050916.GA13577@us192.sjc.aristanetworks.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 7 May 2022 08:33:46 -0700
Message-ID: <CALvZod6upThQzqDGs1DCG4GuSf=rhfOncMU5=_eEoX8HH5Ri_w@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memcontrol: Export memcg->watermark via sysfs for
 v2 memcg
To:     Ganesan Rajagopal <rganesan@arista.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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

On Fri, May 6, 2022 at 10:09 PM Ganesan Rajagopal <rganesan@arista.com> wrote:
>
> We run a lot of automated tests when building our software and run into
> OOM scenarios when the tests run unbounded. v1 memcg exports
> memcg->watermark as "memory.max_usage_in_bytes" in sysfs. We use this
> metric to heuristically limit the number of tests that can run in
> parallel based on per test historical data.
>
> This metric is currently not exported for v2 memcg and there is no
> other easy way of getting this information. getrusage() syscall returns
> "ru_maxrss" which can be used as an approximation but that's the max
> RSS of a single child process across all children instead of the
> aggregated max for all child processes. The only work around is to
> periodically poll "memory.current" but that's not practical for
> short-lived one-off cgroups.
>
> Hence, expose memcg->watermark as "memory.peak" for v2 memcg.
>
> Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
