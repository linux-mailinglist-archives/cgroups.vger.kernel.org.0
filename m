Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB774F1D04
	for <lists+cgroups@lfdr.de>; Mon,  4 Apr 2022 23:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382447AbiDDV3u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Apr 2022 17:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379455AbiDDRKw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Apr 2022 13:10:52 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43E31BE92
        for <cgroups@vger.kernel.org>; Mon,  4 Apr 2022 10:08:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j8so8652059pll.11
        for <cgroups@vger.kernel.org>; Mon, 04 Apr 2022 10:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXYG3Ps4LgSyecmtEkjB7IBmEX/53r1BKcEWnhV4WlY=;
        b=s4CMrkgH7my/reT6boSS8yl+kfuqsyuW+f1JH/k+5yIXMdHslsChfPbL4NUMHPqZix
         KdR9ph2X7IYOncO9Nplztcf1q9mtEgJP1Y6UsMxgR1beJRzUvrBp6ANO369YovHpmVdq
         2BGBW1PuagDvNO8qY4jV7AGNNT87QsO97aWQbHXwie/ZqjowUI/d2ISWG22WhANZxVeQ
         lT04QY1g8hr2moiJ3B2tVGObcfy9yn+vkPuRXQ98mGwLgRFQo4pjIN60/lEFGGD6loMc
         UNTzU7wMtCvSSt4SZE313BRItgkLW6uEcEnQtikscmC8CTKTE20RUhwAVqAYjKbwVVAM
         vgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXYG3Ps4LgSyecmtEkjB7IBmEX/53r1BKcEWnhV4WlY=;
        b=CdNOvGBX9zNvyHWha/+kdzL/jc/EqTAlQmBSzqrbjbXcnLrbgBfjP/BAJL8eS+N1ic
         kjuKLh5IyjENoMBTf/HwlfzYvHtZwBtwvoKV37quFI5lj0vsehBVJvanbjq2jqHNJTHk
         AHWPLR2GOWdc169exLTTaIjs7bqKqK++Goazx2VADbNd6VBbnFL79kPfyB+GZ8SRAumX
         UHAHqwfRZYR/CETHCQENYlt6R3yK1nom5VbxOMh0+34J8ehsJQs1jpBtVuVd8zW7E+Uk
         EfVlz0yN2l45Tr3cgaCojQo78JUO7DKLWW9HA9ZFpmtnLIwwM2dvsqogklKXZ2u6cOqt
         3AbA==
X-Gm-Message-State: AOAM531BmbfE3m0gHQFyQI8qR69rldSET5k79Q3gYlxN5bDM34RbXtuA
        LTsm7iDo+V5Eq1DmHkgqjxbW/Dlrqy3RA8GB8vA2BA==
X-Google-Smtp-Source: ABdhPJw+J54Cf+Ic9BirLs3NVMza9LBojr2USzUl4/qVFxAGsWR2VqpprijI+ObsHmL3rSo+fWzODR9vouPWAPRhZZ4=
X-Received: by 2002:a17:902:d0c9:b0:156:b0dd:999c with SMTP id
 n9-20020a170902d0c900b00156b0dd999cmr1019023pln.6.1649092135073; Mon, 04 Apr
 2022 10:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <CAAPL-u8g2qkhdTQtFtBS3GNYz0WnyahWEXvR4g_OSaKv+7EozA@mail.gmail.com>
 <YkcYq8F6MYlMi+yS@cmpxchg.org> <CAAPL-u-za-TTyyC5uMVev9eQyhxZS7q3pVqaUxCFjqk+Sv9+ig@mail.gmail.com>
In-Reply-To: <CAAPL-u-za-TTyyC5uMVev9eQyhxZS7q3pVqaUxCFjqk+Sv9+ig@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 4 Apr 2022 10:08:43 -0700
Message-ID: <CALvZod4-fKfv6vbZPZ3nCE=Bue4FUnC+9t27wsznmyd+JKgDbg@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Wei Xu <weixugc@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Thelen <gthelen@google.com>
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

On Fri, Apr 1, 2022 at 1:14 PM Wei Xu <weixugc@google.com> wrote:
>
[...]
>
> -EAGAIN sounds good, too.  Given that the userspace requests to
> reclaim a specified number of bytes, I think it is generally better to
> tell the userspace whether the request has been successfully
> fulfilled. Ideally, it would be even better to return how many bytes
> that have been reclaimed, though that is not easy to do through the
> cgroup interface.

What would be the challenge on returning the number of bytes reclaimed
through cgroup interface?
