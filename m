Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451FC3B321E
	for <lists+cgroups@lfdr.de>; Thu, 24 Jun 2021 17:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhFXPDF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Jun 2021 11:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbhFXPDF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Jun 2021 11:03:05 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83376C061756
        for <cgroups@vger.kernel.org>; Thu, 24 Jun 2021 08:00:45 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x24so10746467lfr.10
        for <cgroups@vger.kernel.org>; Thu, 24 Jun 2021 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VEtW/m2G4JMnkRazKy7NH/xx9Lmp9+147gFKq1PM9Yg=;
        b=WAWI8So/qhhVeppsIvdijPvUzdKdS80W6KrQW/YiWqHSSLQfZqqWsi1EBJnzuaRtvQ
         uwilI74b1Rj2CMfhicSt0oPI4F1Xekqj4XfrQLsepNL76BJ8xBCOBMSkY3Y1x6Gqw2sj
         7lvnVcUcP93CrANK0OjxaCB9Zt34DH2PHf5vKOMNRYu5V5fvB00/TP3EnPOIhIxca6Zl
         P+N/bo1Uu48b6MI43s1/NQYwIej3Cl/5IKT4nCsxBXfmhsKkx3WsExXRF4YkWlBeBjCu
         K43gwfpaWSvIznaF14eSVUglFjETBkIwB6IrOSXTcfm8yUGeHyxDJ3fgOm99lLecLaBD
         MiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VEtW/m2G4JMnkRazKy7NH/xx9Lmp9+147gFKq1PM9Yg=;
        b=uD+Td3zJNzdpKmKxo1n8mIyfD5vkPk2/AqVM2RXGXnEHzxYBpE7/Qcb39GeJGOk2Jy
         kNeUbzSktHUcanSa57A3ehSFGaZhWo/4ZzQhqihAM4D0Kn87asLuB2F3zPd69uNa2O+O
         sR0unjoLv9gXhdNRbb267gsm6qmbuKSR84Xje2/3lLZJRy0Loo8X2EEYKuFY880SI1BE
         aD6IKfDeFxiH8CUGZy0LogSZR094WkhvlDGQmRLWn6uiMAyOTAJY2ZmEKwK1klJ78bXP
         rGDmMTa6mS2f/xq/BFT5md4UU26q0Eh0finSNs2K+L/Yp4a/rjrDPBymPMiiOI5bvuXI
         4I/A==
X-Gm-Message-State: AOAM533MVE7XjJqtCJKmV2reM199O47HztszCrnXhrF+AXjcWzGtKUyc
        vK5q9Waqtl8YXwRVWIW5ZW2TcEKWpLFdBCRPf/W85g==
X-Google-Smtp-Source: ABdhPJycOg00GNdG4YJ4aGl9RCigJVkD9ALTczBVbkVgHKy7VLUFW33L9S9Uoh8460AKd9LLPMgakQpyXeA4ZPVT9aA=
X-Received: by 2002:ac2:545a:: with SMTP id d26mr4103361lfn.83.1624546843227;
 Thu, 24 Jun 2021 08:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210615174435.4174364-1-shakeelb@google.com> <20210615174435.4174364-2-shakeelb@google.com>
 <YNSQNu4ZW7mEX6LW@blackbook>
In-Reply-To: <YNSQNu4ZW7mEX6LW@blackbook>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 24 Jun 2021 08:00:31 -0700
Message-ID: <CALvZod4zaJZ1VjSQNvV7oUDZ58VYWvEUBa5WsGU4SYWnT70vbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] memcg: periodically flush the memcg stats
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 24, 2021 at 7:01 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> Hello Shakeel.
>
> On Tue, Jun 15, 2021 at 10:44:35AM -0700, Shakeel Butt <shakeelb@google.c=
om> wrote:
> > At the moment memcg stats are read in four contexts:
> >
> > 1. memcg stat user interfaces
> > 2. dirty throttling
> > 3. page fault
> > 4. memory reclaim
>
> Sorry for being dense or ignorant -- what do you refer to with the point
> no. 3 (memcg stats reader during page fault)?
>

Yes, specifically workingset_refault() which reads lruvec stats
directly through lruvec_page_state and indirectly through
lru_note_cost_page.
