Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9307E3DA5EA
	for <lists+cgroups@lfdr.de>; Thu, 29 Jul 2021 16:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbhG2OKF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 10:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239420AbhG2OIk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 10:08:40 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04F3C0617A0
        for <cgroups@vger.kernel.org>; Thu, 29 Jul 2021 07:08:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bp1so11339596lfb.3
        for <cgroups@vger.kernel.org>; Thu, 29 Jul 2021 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lwNLTldvysoG6tP7eIB3Yg8TEfTEJ3xDLJQLZ28G+x0=;
        b=ca8DsYUc24s41ooMqz6bT/mgYTru4NdbtwqBEbRuShpsTGyE31LKnPMoDmbN6HJgae
         T3XclT4Mp6G2PVuj3pAxbeBDiW8zQ5b0M8gOBAbQQ1kKb1evXN8CQOArbqXjCeQrNh4t
         5Fwwt93YDujobI3MgwpyuzQeNcJpOFC0A3R5AHrfpGp5BwqrXLaohpnhngja/9BPCg8K
         ATNtt/CjGXQp82sXcI8UXuSlFo3fBTtskkQWH/euvVFcgTl++V+fKe9hXFQK4G97jmxE
         G0PzqU3GabBA13Y0IQ40/T8ckbx6nKyWZ+69XG8cWNXqy/h3FzpZ74FKsD4xvbT5Z7q0
         NpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lwNLTldvysoG6tP7eIB3Yg8TEfTEJ3xDLJQLZ28G+x0=;
        b=rLjlvtX9fM4AG+hiKxJcZbcCG4fpZ1KyOP5a1iKtaggiyPgLMywVGVtq/wix6y90Qs
         +Q1dTnnnENpPTqcKswR8TSeBW1fOOoiOZB24VK7YoD8fRzmrFeEl53M0cOJINH9XV8R1
         XmL1NEHzEX9uu4lim40TSd2XWz9j3MXgac5JNQizGKtX/aZOqT4T4yXEbJN01Qoyuxgh
         JOLPfM1CZp5fpZYYKZLV3ntU6+GmT1q8Zxwh5DQJns/Mtf0N98pQ9PbKOilPtuuMIT/g
         Q4K/up2TTaT77hN9FaTF6pP2HrMusb4pox7i4I0i67z3EEQ0vuwtSnAhqnvATn5vB69A
         EDcg==
X-Gm-Message-State: AOAM532DWbbBW2iyIJYXX1EHx4nAoB6XNTIJJj/IIHnWvtHPnbfYroKd
        OLNgLQOgoWCuWKylJfsAwvh+dnWSRbyljs77RWmoTg==
X-Google-Smtp-Source: ABdhPJxzsVh6pp93QiKfxjIjrrpuuxS478uv8YrBKf6UNnyMlYtAAsGPSXEFCrLUZI+jfZaQNNAx9za8VUvfFCwbV3M=
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr4037438lfc.117.1627567688416;
 Thu, 29 Jul 2021 07:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210729125755.16871-1-linmiaohe@huawei.com> <20210729125755.16871-2-linmiaohe@huawei.com>
In-Reply-To: <20210729125755.16871-2-linmiaohe@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 29 Jul 2021 07:07:57 -0700
Message-ID: <CALvZod7Z0MNqDOVGEJSjXKmJdKYM2V4U7R1j0Z7vbW9Fn0TpJg@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm, memcg: remove unused functions
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>, alexs@kernel.org,
        Wei Yang <richard.weiyang@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 29, 2021 at 5:57 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Since commit 2d146aa3aa84 ("mm: memcontrol: switch to rstat"), last user
> of memcg_stat_item_in_bytes() is gone. And since commit fa40d1ee9f15 ("mm:
> vmscan: memcontrol: remove mem_cgroup_select_victim_node()"), only the
> declaration of mem_cgroup_select_victim_node() is remained here. Remove
> them.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
