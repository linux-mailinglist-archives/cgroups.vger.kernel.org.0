Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC988405B97
	for <lists+cgroups@lfdr.de>; Thu,  9 Sep 2021 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbhIIQ6F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Sep 2021 12:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbhIIQ6F (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Sep 2021 12:58:05 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC0FC061574
        for <cgroups@vger.kernel.org>; Thu,  9 Sep 2021 09:56:55 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h1so4025720ljl.9
        for <cgroups@vger.kernel.org>; Thu, 09 Sep 2021 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZVjhQf4Wc5qDwKc6Wxkb4xPFLHy4YamVgNh/i3e/aqg=;
        b=sV1HzMzIqQ847QSIIUoHp201jmkdi8+7JMKKQdM8EinRPUqW6MxoJPuy/M2sRh2YX8
         xGwcv5MvtoepmTeQz63R00ZU3mkodxx8Vtuf7cefIh7JiddrNc0Yd+HLcMnE0u5OAfR/
         fweeDgDPOYX5WlQZwmnM8z7OYcNcHK5+OUWA6PU/YOo3Ef1EPu2B782teb163N0EMh5v
         mjd6zGLdXtWdZIVYySo5svms0Bzb+9s5hNCnj2sj2n75/Y3AjSmdyyKIMNTBPT1kXSVH
         /V0DIbMAyvMrgOFxygJGca5bv4qaGEU//VC0F8i/MejvgsFhmMA+lFU74x5dSN7tsYCr
         da0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZVjhQf4Wc5qDwKc6Wxkb4xPFLHy4YamVgNh/i3e/aqg=;
        b=xpvkrWM0g+T8QRVJ+7zRaRnbb2J+f58Fhy59cZaN6WDbGhbTSAK8fcnr0CmT20ivTJ
         znXN+ped7bG+ZznRtF/A9GsmqF+JyPx5PS+3l4mG8Hn6e5ueMOYBtgm2e8RZdXDqsyF6
         baMMtlq3p7PraZ4Y4M4Twksyo/Nlj2t6QoXnnx3nkbphLr9DJru4QrjqIukpPGNl+51z
         46JtkrL9w75P9QSKLekNHgpEAjKu5TS2KRi+eqJElRLxRc20nJufaPOzsfi2RiYTAaH3
         jnkMqZFa7x0WEDuyKk3glQP8cCscE+Ssg8gLk37mPNOXDY3NoNvIiOsnwW07U5/rcpYt
         cP1g==
X-Gm-Message-State: AOAM532rDZ4D8wnwQQeODXeSlAh2hKHPleNSCPNJu57FQ/ZPhuREV5/6
        uwQ/n9B1t64Zfe2cyQVPZUagYnW9+svM5/aBw6z2gQ==
X-Google-Smtp-Source: ABdhPJyBVMMchSS0qFtishSD9a5wrolWJ8ciw91FaTTuYLkugS9n2LgQcH50i9XKqfmx+Hyck1TZPoAOaz3VPVWAemY=
X-Received: by 2002:a2e:858e:: with SMTP id b14mr677223lji.508.1631206613776;
 Thu, 09 Sep 2021 09:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
In-Reply-To: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Thu, 9 Sep 2021 09:56:17 -0700
Message-ID: <CAHVum0cGkzLg_5fZNFNTG=RRqGYW-8YG2V3gst1TevjtQ4YdBA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] misc_cgroup: introduce misc.events and misc_events.local
To:     brookxu <brookxu.cn@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mkoutny@suse.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 7, 2021 at 10:24 PM brookxu <brookxu.cn@gmail.com> wrote:
>
> From: Chunguang Xu <brookxu@tencent.com>
>
> Introduce misc.events and misc.events.local to make it easier for
> us to understand the pressure of resources. The main idea comes
> from mem_cgroup.
>
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
>  include/linux/misc_cgroup.h |  9 +++++++
>  kernel/cgroup/misc.c        | 50 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 58 insertions(+), 1 deletion(-)

Thanks for the changes. Please also update the documentation at
Documentation/admin-guide/cgroup-v2.rst for the new changes in the
misc cgroup.
