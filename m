Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3CC8C3B7F
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2019 18:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390018AbfJAQoh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Oct 2019 12:44:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45513 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390012AbfJAQog (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Oct 2019 12:44:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id c21so22393670qtj.12
        for <cgroups@vger.kernel.org>; Tue, 01 Oct 2019 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7GPDFQWuJXwzJuqgdtkv8cWj1/rryU2amRMgaS7klwk=;
        b=UI4eNsI01cw12FCH1szI/WpOWDa4aYdcfwkvjF0IataQqplLO5GIZr4lLpKiTNA1Ay
         30U8FhzxOnozK/bML5k8xB8Vk/Mvr4T7avhwBHv7jt3G0Id/wFihN8VFw3eyKc8pGSLF
         vhJd5VxytmfI8W3SVJ6Y70mWApfvtdP0qOYh7jZjeIuXbqyZ30E6+7D8kBMzAJGnJwMj
         JO2DFGWYAm8+CuNdxW50PvPeOpgJUYiXllV7SB789XKFpeK9CDGSwG6iG7kBSIKxpHeE
         2GhuyBg5Imcu8wBPi3w4si8hU8R9pLqCkPmY8iyZyieAMvzcmNRhTOiCeB3x7VYWf7L3
         MWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7GPDFQWuJXwzJuqgdtkv8cWj1/rryU2amRMgaS7klwk=;
        b=DCQcf+77F7dIsmTwj7KELU7sxa8jwp3cGvWuG8N0C4Cp6uxoQ/bdBa9uf+v8PBACTZ
         SzYQxpXxjWFSt47sjcInM1fOZrYTIaVivqBBXv4OCV3zK+XrTBgP/yZJzFvE8KSq3Ym9
         2xnAoF0+WUofo8+VNNc+A2Nci+dAEdLrbY6VnTJUidwcJ1USwNDwys5CTxgwvIGmuNS9
         l0XUNk9u/53HnKid/An4HHuCchxwjTP5MpbZ74ALfii3S4R3Z0UoQ9h2+qqibndENdDC
         QLhvTkejcqR+J17sInWsr9I4R86pveaxAsFzwaoZSdaYqPsKddnCfR8WL6DyPjEvaDO8
         xJ6Q==
X-Gm-Message-State: APjAAAUQJSq/WggIYcnaIsPSepatiKy+i/AgiwfDFWXhCl5Ig55XqkEi
        NoKuVXXdhuPGSV5MR+5P/jvuBA==
X-Google-Smtp-Source: APXvYqyObNCYAzFu3jyjhNDjKUVhXypcTsi/L5PiHM0qUrfbw71DITAFbh7MVl2LtTvReBCYDaJLHQ==
X-Received: by 2002:ac8:1207:: with SMTP id x7mr22977563qti.247.1569948275773;
        Tue, 01 Oct 2019 09:44:35 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a11sm7923492qkc.123.2019.10.01.09.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 09:44:35 -0700 (PDT)
Message-ID: <1569948272.5576.259.camel@lca.pw>
Subject: Re: [PATCH] mm/memcontrol.c: fix another unused function warning
From:   Qian Cai <cai@lca.pw>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Tue, 01 Oct 2019 12:44:32 -0400
In-Reply-To: <CAK8P3a04nMwy3VpdtD6x_tdPC14LPPbt3JKrGN48qRo_sDVk-Q@mail.gmail.com>
References: <20191001142227.1227176-1-arnd@arndb.de>
         <1569940805.5576.257.camel@lca.pw>
         <CAK8P3a04nMwy3VpdtD6x_tdPC14LPPbt3JKrGN48qRo_sDVk-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 2019-10-01 at 18:00 +0200, Arnd Bergmann wrote:
> On Tue, Oct 1, 2019 at 4:40 PM Qian Cai <cai@lca.pw> wrote:
> > 
> > On Tue, 2019-10-01 at 16:22 +0200, Arnd Bergmann wrote:
> > > Removing the mem_cgroup_id_get() stub function introduced a new warning
> > > of the same kind when CONFIG_MMU is disabled:
> > 
> > Shouldn't CONFIG_MEMCG depends on CONFIG_MMU instead?
> 
> Maybe. Generally we allow building a lot of stuff without CONFIG_MMU that
> may not make sense, so I just followed the same idea here.

Those blindly mark __maybe_unused might just mask important warnings off in the
future, and they are ugly. Let's fix it properly.
