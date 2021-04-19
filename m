Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB29364707
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 17:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbhDSPZE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Apr 2021 11:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240218AbhDSPZE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Apr 2021 11:25:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966A5C06174A
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 08:24:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x19so26173413lfa.2
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOD6fSTnJ0sxKqRv1Zy1j/kX7uLedN8DTQxW0wXJyco=;
        b=YIKlN/iaDDCGQNbzTFFfJP6sWsYrorpW3sSJSdyQ13T1gkKmdGshdBUhzC6EvKQYkW
         Sezawn45Mqj5pFAmBGbAKtgcUC6iww86lqDmCvh5MHPZu4FWm2R3fbRCCPvfwvSE5fZC
         Itpl/gk0GvzQi7KM8ITmoosf6SWDs0M8pijLME1h/JtzuGSnzou3Qaw6jlFfMlPv2dB/
         jRGZJvdl8wfywsIOUIufJN7PxOd1N65rEI2DJWwtyfMrS8KsoUt/mjDyaEZa7HSM213y
         srzXsAmBws2o5qdgVpks2Zm0Um9bglM1BB5nLxfl/3Lvjkqrgw2vwOM9i0zaLWicKYqo
         xZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOD6fSTnJ0sxKqRv1Zy1j/kX7uLedN8DTQxW0wXJyco=;
        b=h4khQh83dWUyExiBqcEkRDiKNglcQNoMXbgxOjCsE1QnZJpXibnu7/fmolitcUExMK
         AzP+Qhlz2FxIjaFerPKLj7UvhmDqm38qkzVm39ScnXf+mhs5WnuJCd2Sw4x/xYq+ZvVg
         7yDqHPkex34i6jkPL72DwNkXlje+dOU5tlrwRNGlmlwtEQh52W5HcBveELOotBWAdYAa
         a53We3tD8kDK/wXLKCEHwI7/beuPfY+/R+1AJTAZKa+ikKpf5bTAKjuN3RWKu6gO5Cy3
         MAT0Zdb/v/AHDHpAn1ekUwJqk/zSZBXPe6XWNfzBAUyzuR9oXzOJpzh98AiwnWPFVRUd
         XL7g==
X-Gm-Message-State: AOAM532SFcNbG9LTTtA6pXMqHVAmm6+TLAHV55G98+XtZojz2nuFq6Dl
        SV2GvLaWGCmqRb2duzz2FV1EBe/+eogSU/ndqRFhMw==
X-Google-Smtp-Source: ABdhPJx7EJY9h4WH50MMWBIXwdXTbTWJ1Uz9pWT4DlTaQM5CznOLoh4WZFhNlh99+ISICMNBSBnmbkdWchMcguXKzIs=
X-Received: by 2002:a05:6512:92e:: with SMTP id f14mr6800461lft.347.1618845870988;
 Mon, 19 Apr 2021 08:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210419000032.5432-1-longman@redhat.com> <20210419000032.5432-2-longman@redhat.com>
In-Reply-To: <20210419000032.5432-2-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 19 Apr 2021 08:24:19 -0700
Message-ID: <CALvZod5rJ0b=tJ=7vK6osKu1rOjD+WSBYPBN9Dc_xtY_y_5Tyg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] mm/memcg: Move mod_objcg_state() to memcontrol.c
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Apr 18, 2021 at 5:00 PM Waiman Long <longman@redhat.com> wrote:
>
> The mod_objcg_state() function is moved from mm/slab.h to mm/memcontrol.c
> so that further optimization can be done to it in later patches without
> exposing unnecessary details to other mm components.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
