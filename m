Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2E626A096
	for <lists+cgroups@lfdr.de>; Tue, 15 Sep 2020 10:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgIOIWJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Sep 2020 04:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgIOIWD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Sep 2020 04:22:03 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1DBC06174A
        for <cgroups@vger.kernel.org>; Tue, 15 Sep 2020 01:22:03 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c18so2559186qtw.5
        for <cgroups@vger.kernel.org>; Tue, 15 Sep 2020 01:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=qwBcvIBU5LOYe6OskRbMqT6V676HBWZDqSyC3uftkyQ=;
        b=HslBmbeWTZm7v2sAgaH6pYCFXZ7p24g+9zKdqnDAv0NOj2E9u3HBm4SN0fyl+ARwBj
         Br5Fx3dCbNIxlooxtHo2kNsfpAA33mhnz/XMM3D1dxVbbccet/Cdnq0YPagKQVeT5G5Z
         5SH4ZPg/M3NnYHJMnQwe1o7DHXDijfry/Hkk8TniFYcpFEVfJKPAsZffKXxLz4fx/GNH
         2OVlsrZpPKckQsTMFVXe21TmD0mXmiuVW6p7flm6WGT8oZNNGxB2AKQhZvouWtHvIIpY
         /kn4MMUMqvaAB/HZgmb8IUarJy4R+n76AjBbuU7Twv7P+yN6t7ZUO6irhAOPgT+OiJ1g
         DCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=qwBcvIBU5LOYe6OskRbMqT6V676HBWZDqSyC3uftkyQ=;
        b=VYFP3gVUkb8l2YbDSSGaU0tG+8S1jWrHAZo4NLg8wV2Rb6c6y+Qqat4GObk8tZ5/eH
         P8K9/iWKvBj5ScQEx+MQdhtQOpoMqYpLQkqR3qU1+HcF9NkNgAB1RuriXR4ad3mxKl9b
         lq5DRO6ARHHngIIDj33uxpum7RGXpdk0WlvhoLEyvqliqCHKFL9JWU14jGOQiuPQcXFj
         mMW2Xc5X0kGdnbhwIqIufezzkHQuB77nG4PUwkZo1fnMoaV8XJPWbjo+55/f69Lj3r7c
         Pcq37iTi8HNRyQmKWgCGdndbfO/qQDyuzoyErWiZzLbOg63kVtVO5cQJO9lkd5g9xTOh
         Oawg==
X-Gm-Message-State: AOAM530oTj1hmqqgTqX2o6a8WdQ2w4bueh8jdrYDlRm9fU1raOVF1RqB
        38qmAUtX25XBMnZr1ZowpcVObg==
X-Google-Smtp-Source: ABdhPJyR6bVIaKYKABqifQ5Rex4fbJICMbVfXkItWNXtNqfqKaF5g9X1runG34cKop5c62nQTd0riQ==
X-Received: by 2002:ac8:4a84:: with SMTP id l4mr4699277qtq.367.1600158122072;
        Tue, 15 Sep 2020 01:22:02 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l92sm14161168qte.38.2020.09.15.01.21.57
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 15 Sep 2020 01:22:00 -0700 (PDT)
Date:   Tue, 15 Sep 2020 01:21:56 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, vbabka@suse.cz, minchan@kernel.org, cai@lca.pw
Subject: Re: [PATCH v18 00/32] per memcg lru_lock: reviews
In-Reply-To: <5cfc6142-752d-26e6-0108-38d13009268b@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2009150112130.1550@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org> <alpine.LSU.2.11.2008241231460.1065@eggly.anvils> <alpine.LSU.2.11.2008262301240.4405@eggly.anvils>
 <alpine.LSU.2.11.2009081640070.7256@eggly.anvils> <61a42a87-eec9-e300-f710-992756f70de6@linux.alibaba.com> <alpine.LSU.2.11.2009091524260.10087@eggly.anvils> <855ad6ee-dba4-9729-78bd-23e392905cf6@linux.alibaba.com> <alpine.LSU.2.11.2009111634020.22739@eggly.anvils>
 <5cfc6142-752d-26e6-0108-38d13009268b@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, 13 Sep 2020, Alex Shi wrote:
> 
> IIRC, all of comments are accepted and push to 
> https://github.com/alexshi/linux.git lruv19

I just had to relax for the weekend, so no progress from me.
I'll take a look at your tree tomorrow, er, later today.

> If you don't minder, could you change everything and send out a new version
> for further review?

Sorry, no.  Tiresome though it is for both of us, I'll continue
to send you comments, and leave all the posting to you.

> Uh, I updated the testing with some new results here:
> https://lkml.org/lkml/2020/8/26/212

Right, I missed that, that's better, thanks.  Any other test results?

Hugh
