Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B72F476DB0
	for <lists+cgroups@lfdr.de>; Thu, 16 Dec 2021 10:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbhLPJpP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Dec 2021 04:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbhLPJpP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Dec 2021 04:45:15 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153D4C061401
        for <cgroups@vger.kernel.org>; Thu, 16 Dec 2021 01:45:15 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id x32so63034786ybi.12
        for <cgroups@vger.kernel.org>; Thu, 16 Dec 2021 01:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A1MFole7nFko6XzmDNfgE5E+/1W8AedAM5ImSr4t3Mo=;
        b=nsmQ/apsKdQztyc0yc5tiUuptN+9XlsBEAr0qz+gI5SZ+IV3uSUUFj52fE9YbQVI8n
         SMbjtHrTJA6hukMVpoe9h0y6Rmfyrl+OHG/iOHic+VH5G02tOBfDdwGMpC7FfUrBGTu3
         8XpRGgzs7x86Dl8C0S2EHzI480i8bV0jQS8+RviV1BOSx6kp/P/aMy3Hx325lxQFnmHw
         X0cG1oWo6GktwZFd78AaZBgbbhnACTQenYXojWdQRhiJtzNFPn30D0eC0JI1ooH1p6wQ
         p1NWPJE7pjmTIGoCX0RY9/cuWQjZRO11Ex/D2pnSThLbuR6dO5PA2wjt+xORpiYjw6W8
         bveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A1MFole7nFko6XzmDNfgE5E+/1W8AedAM5ImSr4t3Mo=;
        b=mZggUxE4ESzhZ0y7Fn5RKsCsPaVHVweIOstmpPJZXVMhjaQfqm3meXU1fXVHdAxyQi
         9K3X1geXpDTDHofvMfbVHnEkdw+aCTDRDSmgbg8sf4FKCf1lnCW9cCA+3zx6YSQJHGMB
         7FHt+ji4TGiCu+Ijk5gMyer/PkUV4h5ZgUJ4Khf4Av8h08UNKUA+TvfblXT4UnJ00qdn
         CARrkaVyorhKC2wlkzXfuA5N6lJJMaMxPdWKcd6fj3qP5G+sf1HVGBf6RpyZ5NvKzr4J
         T3y4HxoI2vF92w6WJ5NxpS8dWQMzhqUq+sMZ4/P1D2SJlCKh7aXF+W1t9yrYXMfzDabD
         WnJg==
X-Gm-Message-State: AOAM532andf0oAU8+JxPjglXBs4p6hsFYloEar1tCwTUqLScs6+IkV9q
        YdaC8NNXdvpzwPcgnVgPf1RmqAEfG7B56mqfRExgpA==
X-Google-Smtp-Source: ABdhPJytpY6IKx476YQCSWtivg98+adXT5ZH0jbr+l9j/D8Pt8zWvBRmB8J/jyRv6XgbIY/CqxeyMFRbwZaiwwEiQw8=
X-Received: by 2002:a25:9c81:: with SMTP id y1mr12149005ybo.49.1639647914325;
 Thu, 16 Dec 2021 01:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20211216022024.127375-1-wangweiyang2@huawei.com>
In-Reply-To: <20211216022024.127375-1-wangweiyang2@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 16 Dec 2021 17:44:38 +0800
Message-ID: <CAMZfGtUBSqgnHM+DSG7na=7tbNMyj_qS8pEOCn9nDdkPEzi-4g@mail.gmail.com>
Subject: Re: [PATCH -next] mm/memcg: Use struct_size() helper in kzalloc()
To:     Wang Weiyang <wangweiyang2@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 16, 2021 at 10:21 AM Wang Weiyang <wangweiyang2@huawei.com> wrote:
>
> Make use of the struct_size() helper instead of an open-coded version, in
> order to avoid any potential type mistakes or integer overflows that, in
> the worst scenario, could lead to heap overflows.
>
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
