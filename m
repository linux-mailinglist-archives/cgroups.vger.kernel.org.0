Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7824248A61E
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 04:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbiAKDNU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 22:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiAKDNU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jan 2022 22:13:20 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545DEC06173F
        for <cgroups@vger.kernel.org>; Mon, 10 Jan 2022 19:13:20 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id h14so26154604ybe.12
        for <cgroups@vger.kernel.org>; Mon, 10 Jan 2022 19:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vePxboaj5Wzxcx+RQdgsE8w7bUmtQir6BsCsMhN8f0c=;
        b=ieCdWrzviTyUE7447aiXEbq7Rt8+vOuuPSLhn3BqOqU1oZG6sXDX+a7WFqsctJHyaA
         ftggmDSC1l1LOiLOUfTt2HTtmCfX0IqGvhiX6E2oNnaL92Sp4+6ZLshokZq+F/IQrxBP
         Y4Lbi8/N8rSslC2ktHdn5M8vuK4gWImnoyQ4xHxJWv7xOjIR8K3d0eq52b8qSDlk5nRS
         UeJiPGwXFKD3ErfN1RYhYXXyjN6qoU2dZkWxneN9bOKYcH0O26+bkzyuER3wnmBINvJa
         8xB+Z0jgKHtuO6V7z5iytxsXLRTVAR+70Bo3X1jS9nsDSDUqIRoJf5CwQrAEDV5RGjS1
         cE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vePxboaj5Wzxcx+RQdgsE8w7bUmtQir6BsCsMhN8f0c=;
        b=X4X33hksycnUv4sIeppzuINdqfwbXD3guWoDThESnoxoTkTxH45OEATJcL1hWJCgO8
         skZnPohen7AXItSC+0rVFRCOlw+1UJo8KLY079xh8iUXuhrzu0BSrryzaLW/TW0b6DQA
         A0UhRvC4JZX/WD+aey1GkHBQuejTnW2z6OtZ+wA66wT03Tj3X+3Or2z8kHplQ0Ja5pP6
         4BsL21WOMiiRop9BIs2cDygOuThiIirzipSh/J299ouBw2mKKS4LPgr+hrGtXgB5bmkV
         HESJo0CIAbYxlAHu0kZX14Svc2GEl8qG5O3rTU7OFooK3CYp4/u03J3D0WF8ZopWURCx
         IU8g==
X-Gm-Message-State: AOAM530g6GwamzpAB6hJB7C8LEi/IhqVG8FP3jCHXDtogQTnnoMFrKrK
        RUqs8QCTYjbVfTozQKrmGbnfaLQl70kAMNFpK6gbgA==
X-Google-Smtp-Source: ABdhPJxJ1BepqUyd1pzpNRrE6pPyLX0NLCHbYv7gA//bljqCSN0Jm91c1toWTFXb1LZT4CQq7q4HgxJF5bvwXhX8Ci4=
X-Received: by 2002:a25:abcb:: with SMTP id v69mr3684966ybi.317.1641870799625;
 Mon, 10 Jan 2022 19:13:19 -0800 (PST)
MIME-Version: 1.0
References: <20220111010302.8864-1-richard.weiyang@gmail.com> <20220111010302.8864-3-richard.weiyang@gmail.com>
In-Reply-To: <20220111010302.8864-3-richard.weiyang@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 11 Jan 2022 11:12:43 +0800
Message-ID: <CAMZfGtWmo62c0aeszxEjCTN8OVV8iAKiUytvwOMuZ9qD=Ke2Dg@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm/memcg: retrieve parent memcg from css.parent
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 9:03 AM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> The parent we get from page_counter is correct, while this is two
> different hierarchy.
>
> Let's retrieve the parent memcg from css.parent just like parent_cs(),
> blkcg_parent(), etc.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
