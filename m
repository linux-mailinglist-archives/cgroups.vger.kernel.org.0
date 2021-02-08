Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7203128F8
	for <lists+cgroups@lfdr.de>; Mon,  8 Feb 2021 03:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhBHC3p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 7 Feb 2021 21:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhBHC3h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 7 Feb 2021 21:29:37 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C24C061786
        for <cgroups@vger.kernel.org>; Sun,  7 Feb 2021 18:28:51 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id q14so5426256ljp.4
        for <cgroups@vger.kernel.org>; Sun, 07 Feb 2021 18:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prVjlOxJgxegYr5WyW9Puejur2UOLsJUAHlf/hcHxi4=;
        b=P3vCF0PGHm1O1esy5AM5oRBJYOvhkYL9KaghBGfStowxVodRdE6aeYoKVs07gQqCRV
         /KDTE5iE1GBcC277I9pstoXCyEU29eULNB63ExV6UmFLrRdZgK8cat9bk3XBYQWEqBKZ
         /u53kzhG9DHRjLKqrk6f1wV8sTD2D+qeNK6tUSVqb8+zFZWF61kH4Xc8fRs9lLv3r3MI
         6HdoVrX+/2iVx51pPmhaEOfLaGjMlZY73hR6+llJr0bs/KK4S8dT42noXnH9cMoNKDav
         oH6zlOgD5ZCAqGqOIFzXdtV42/msvCRIF4YGwFet67mFYidyVgIrsOpZ9fhTmaF0qdpd
         wr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prVjlOxJgxegYr5WyW9Puejur2UOLsJUAHlf/hcHxi4=;
        b=ZLHoPou79Zh8fLNmc/SwgaacZj/7QjvVNrpbHfI1v97aFeo3itAh7+nYvkAXhigLA9
         WEo7zwx+3PZLLx0mhvQabKy0rFW7cJ7JH2c6MuqCpuJMNPf8hYiT3sjnDPwSmt/SKlF0
         bFV5mtiEDgjtWi3cSaNlS9uJDCSSxXPCSNs/wudFwG3Ov9dKlfuDHOukRNGOzQlvHmE3
         N5zqcHCrCqfJtYP/UOsL7b62ThB+8H315DYrNVzFEfnHWskG7ucPaWok1FTSE0/cMhAU
         NIgLV7hEzyrZ1M0sSAv1RCh6lLXgt/3Doaea22mghxeh8FI4EOjqrpq5Pd+OodMC4Wn4
         8a2Q==
X-Gm-Message-State: AOAM531lucSWeivHeSYq7MqLOyXlwKUOkxIGgcAPpBt0Wu9JEN36vUIb
        dDiI+52PdNvy1us0ODh69CdCiY2hfDUH/AcinVomjA==
X-Google-Smtp-Source: ABdhPJyR2XSql3j3ajSmpY3/49a+HuQOKrA+Qf06VGVaO4rMyCBZU/zvyKPc/CticUgxxzDHes9zb693NtXnPSTSvbw=
X-Received: by 2002:a2e:9801:: with SMTP id a1mr10029568ljj.122.1612751329278;
 Sun, 07 Feb 2021 18:28:49 -0800 (PST)
MIME-Version: 1.0
References: <20210205182806.17220-1-hannes@cmpxchg.org> <20210205182806.17220-8-hannes@cmpxchg.org>
In-Reply-To: <20210205182806.17220-8-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 7 Feb 2021 18:28:37 -0800
Message-ID: <CALvZod4ex5V2Xs_6YHmmLJw91rjKTSZ9XobXiRx4ftj=L=A6MA@mail.gmail.com>
Subject: Re: [PATCH 7/8] mm: memcontrol: consolidate lruvec stat flushing
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 5, 2021 at 10:28 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> There are two functions to flush the per-cpu data of an lruvec into
> the rest of the cgroup tree: when the cgroup is being freed, and when
> a CPU disappears during hotplug. The difference is whether all CPUs or
> just one is being collected, but the rest of the flushing code is the
> same. Merge them into one function and share the common code.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

BTW what about the lruvec stats? Why not convert them to rstat as well?
