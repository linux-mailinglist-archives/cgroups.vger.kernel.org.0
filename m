Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B346875DF
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 07:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjBBGam (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 01:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjBBGal (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 01:30:41 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38797E6CD
        for <cgroups@vger.kernel.org>; Wed,  1 Feb 2023 22:30:39 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id d132so965770ybb.5
        for <cgroups@vger.kernel.org>; Wed, 01 Feb 2023 22:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jutdeR9oHL1XowdDfALeObIWjrp8V4004PfsmSQZg1g=;
        b=JK08Tze1A+Lyna644POZuDY/+OwdmSbAZVouxrTkjQWMsNtIsMYLDAlY5a+tX84mfe
         1KXk2GCLhu5jSM4PXK9gsNTvf/lE0Yee1v/RNeDL1i66dahCdni38Ic/HU4SNAhBd5Gu
         3lzmxA3Sa0P4ks7MMun8oeguoXBvx10wmPbjRuoyIEs63pKtLOwqgHVBRkie9pJAP2TL
         qgjgHXNYNRo6UB1a/HWfFm4hqHnLtQoO+CRpq8QrfmWDcPDel5V4s3RfGKOjexa99qCF
         Lapslwe1x8pNdKEvS5X9IWIwSim2KtcbNCvtwyBEWQ4lnDb8vvVx3xP7D2FMqYE7LnEL
         lofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jutdeR9oHL1XowdDfALeObIWjrp8V4004PfsmSQZg1g=;
        b=Svbw79ZVZE8YBzgrBmWVhDBxHnT1jk4VPb/5jIS060s/iQW/4z0CNOgCFcSWp+hc8z
         tTsLAPZow8q5txLGiws3v7HgY/YQV3rhTAVr7djUWutgpnMZj6lFqCw+A120lvJHaTZ6
         Fo9cAZYXoAyPSw0YRxJtEeiq/YRptJ4AbZ8Fv1q1Cw+XToq/7x0g/9IVQ70rzi3cxQfU
         an4y9LaRQgIged7KeqBwipm2QGplTJbJPR4RNpJ/PRkdnU8lCOL6b5W9OZcBUA2PYvMp
         QbSXVhPuiHjYKiBnFvq/70hm/ra8lPG1rETP7RURUxDG+YIWCt4HF70XQE99RfJ41f+U
         rbEg==
X-Gm-Message-State: AO0yUKWcb0ED/ZG+MGEbh05n6WA8yu2tTzR3T+lshYyKBgyjXNNeIVGc
        j6CFTk441l4g0h0D5R7Cko8V1JAHPZYUh24LvjZBNg==
X-Google-Smtp-Source: AK7set9PutndkdhyMqrd/cX5gWwVXXWDdH6UR8p65SBJYwM8YVjgQ9sxDOESpYulIoD/GmDMryCmb79QnJaRSdzkAw0=
X-Received: by 2002:a25:ae1c:0:b0:845:e6e7:6552 with SMTP id
 a28-20020a25ae1c000000b00845e6e76552mr464086ybj.363.1675319439054; Wed, 01
 Feb 2023 22:30:39 -0800 (PST)
MIME-Version: 1.0
References: <1675312377-4782-1-git-send-email-zhaoyang.huang@unisoc.com>
In-Reply-To: <1675312377-4782-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 1 Feb 2023 22:30:27 -0800
Message-ID: <CALvZod4Z5CCD-zgHgYt3iRR1JG60GXCuhWm+fpzXo4ivTJx09Q@mail.gmail.com>
Subject: Re: [PATCH] mm: introduce entrance for root_mem_cgroup's current
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 1, 2023 at 8:34 PM zhaoyang.huang <zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Introducing memory.root_current for the memory charges on root_mem_cgroup.

Why and how are you planning to use it?
