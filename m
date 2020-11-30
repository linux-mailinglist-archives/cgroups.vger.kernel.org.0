Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9EB2C8E9A
	for <lists+cgroups@lfdr.de>; Mon, 30 Nov 2020 21:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgK3UDN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 Nov 2020 15:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgK3UDM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 Nov 2020 15:03:12 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41334C0613CF;
        Mon, 30 Nov 2020 12:02:32 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m16so17980635edr.3;
        Mon, 30 Nov 2020 12:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wkgGZlXFTsc7rTynWbLSdwUFsTUmKl5GnDvKV+LtZYY=;
        b=PJ3KLIGamaGWru818Udw4jyMnVi7uD8Q1uTb8kV+YBiT8qN7akbLHVgO0WLRSFdVi6
         UAodIxUJbgfUcH2vqemO+bsC75Qjcdfx/N2ACm805ScjGXWrtLDfoze8RcOF0QepVLR2
         sqb/KPY2atxNIKr+MgTkoIDK3x4gM17F1F0lVClMCY+WKrrvpuQxJ0p51DsHF4/kcPeD
         Q8VnB221mfw4f3xKn6W1W7YwsanYztAiIlCAh4c/4PS6iaHNBuB8d7XReDv6V7MqHI05
         dyAcUVNB+U52efW/K8hRDKbuKmvoy643zzMZ/6P+SMLmC78+V3A2qbDqGhKH5ZBBVRvF
         Ctlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkgGZlXFTsc7rTynWbLSdwUFsTUmKl5GnDvKV+LtZYY=;
        b=fWCrh2VGL3RKhgpPSQRA5H5D0yMFiSoyeJg/Wbo8ZgePlxKEFPwdOUTUUMRzL+HJnL
         mh+YAoWBUrPOkN6wqf/9nF4fsKxOC/C1gUdaB4DcALPrm2HKsT5aUFeGe8dWoLCYvuIE
         7DKaoFdYoxyD1wlm6iSXHMKyGxp2nKmoPGigsnEAso3F8v8fxkFLoCpvTy7O9R8KpFMi
         oakA7Ie50cInJzsGOIQNQcIQbp1b98qHvI/EPcU0XstJfsGSAElsi0Snr4cELh+P6atZ
         XSPnZwuOegPxjzetO9jnsJ8ZKeYM9TwJkWcpZhgYitIg3arb9epaqwLUaNrm2vJWk0ww
         KARQ==
X-Gm-Message-State: AOAM5309hK4q0TYKhfFKnb3TPsFL1ImXyQrrjRaMRLk4DUB25WF6HT1W
        x2esslowWfML5nJjCrqskFVQFYRsNgBzMlMEchU=
X-Google-Smtp-Source: ABdhPJwHIuqK4ERjf3h8hnoUvfTUBi4YeRiMoPaRdAwh8zM/moiXdvG8RmXSVTdsXLTvqMNgpojjbcBCCuYeAGpP21w=
X-Received: by 2002:a50:d490:: with SMTP id s16mr23385494edi.187.1606766550997;
 Mon, 30 Nov 2020 12:02:30 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtk3fKy7ct-rT=T8iFDhE4CbjGgdfxsOBrKT9y8ntwXyg@mail.gmail.com>
In-Reply-To: <CA+G9fYtk3fKy7ct-rT=T8iFDhE4CbjGgdfxsOBrKT9y8ntwXyg@mail.gmail.com>
From:   Lorenzo Stoakes <lstoakes@gmail.com>
Date:   Mon, 30 Nov 2020 20:02:20 +0000
Message-ID: <CAA5enKbujU+PRwA3qeYqx-Ydcj7owJnYkeTYJFdBweQJjWU78w@mail.gmail.com>
Subject: Re: BUG: KASAN: null-ptr-deref in workingset_eviction+0xf2/0x1e0
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     inux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        alexander.h.duyck@linux.intel.com,
        Yafang Shao <laoar.shao@gmail.com>, richard.weiyang@gmail.co,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 30 Nov 2020 at 19:52, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> [  285.863025] BUG: kernel NULL pointer dereference, address: 00000000000000c8

This looks to be the same as
https://lore.kernel.org/linux-mm/20201130132345.GJ17338@dhcp22.suse.cz/T/#t
