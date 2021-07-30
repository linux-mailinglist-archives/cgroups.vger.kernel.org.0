Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C6E3DB13E
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 04:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbhG3Cjr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 22:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbhG3Cjq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 22:39:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB32DC061765
        for <cgroups@vger.kernel.org>; Thu, 29 Jul 2021 19:39:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mt6so13047089pjb.1
        for <cgroups@vger.kernel.org>; Thu, 29 Jul 2021 19:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+arnXaTaJFGxX6D4lzafx9633DBfkJpPAK5Nf+O5Qw=;
        b=cBgyvqCISrEPhMOzj61PGUaSCvJs1xoa9d/Yx1CcLHIYtPm60B0d7pcJ7ynvT4w3I6
         se5akXAXqk5sZBpgoxuQXLy3LYgQZpIfK7dW/YFHdCWQd3lShO0vNt/hoEUZ5rtwQPfu
         BqAnum2fv6J8DX+qHj8ylDP9eXCw/rtQvCyWD/GyQG58JLNadwSrSURiX8L6vQNOi6wM
         BqCwpB2w+S8vdyG9+4r4PyDKTpxHtm7OOzw6kahoIDyUclDGepEOplKqWnrWqSYJJfY2
         bEv3Ip6h9ZSOwIJVzdXY4RZX8AYvZy7geUw2GguQgD9iQViLc9qSAq5H0LdjwxFOt0g3
         jrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+arnXaTaJFGxX6D4lzafx9633DBfkJpPAK5Nf+O5Qw=;
        b=ZU8GC8exsh31mnEsZMbH/tV9VuKem2VstNdZw8JteHozBTDldY0EkUCkFSeOnxyqqm
         0DKQAskJZCSOaW3QCGVG6aEysTiwv1X4x5xRr/OUsxqSHc28F8hBsMueMx9u4Ka0FCOo
         JpD4otpjJfBW5behsLHbBdpTKZenoSn7Eakzk0CWZ0puCCIc9Ai/0V/btjTwGZFgfdRb
         6WFkfkwZSUhS/on0tBVl/jC6ZGNAxQRW/1X2SYaKrtdT4Ms5OKar3vYmn2XsY3aLn5b2
         ETtO5XSDQ5TmdSTMw4yz2rjBF6awqXwuUClvRiN+3FhhBVH4rGIGoUdKOWxcjqbqaUmr
         0WoQ==
X-Gm-Message-State: AOAM531AMV5C/+yYTbtXgIOQlred/cdWEhVcuHugBkh3MUoqFHf0can9
        KOms2/v9isKPre85UHjpfTtJVPe8kD85Bx+ay/Lkvw==
X-Google-Smtp-Source: ABdhPJyu6dYRgQSLMyns1xiXublTREAjgu6OWdiz8ZH+NI8kpIyrJjuNnQfnjrMvIura6sul1XMUxaqQ9+EJu6hrhSs=
X-Received: by 2002:a63:cd4b:: with SMTP id a11mr195024pgj.273.1627612781609;
 Thu, 29 Jul 2021 19:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210729125755.16871-1-linmiaohe@huawei.com> <20210729125755.16871-2-linmiaohe@huawei.com>
In-Reply-To: <20210729125755.16871-2-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 30 Jul 2021 10:39:01 +0800
Message-ID: <CAMZfGtUon=R1EEW4Y33DQ1_DQg9ciUyyTJnxgUH5=MyAWLU+=w@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm, memcg: remove unused functions
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 29, 2021 at 8:57 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Since commit 2d146aa3aa84 ("mm: memcontrol: switch to rstat"), last user
> of memcg_stat_item_in_bytes() is gone. And since commit fa40d1ee9f15 ("mm:
> vmscan: memcontrol: remove mem_cgroup_select_victim_node()"), only the
> declaration of mem_cgroup_select_victim_node() is remained here. Remove
> them.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
