Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B99748A591
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 03:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346580AbiAKCYf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 21:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346562AbiAKCYe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jan 2022 21:24:34 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462EEC06173F
        for <cgroups@vger.kernel.org>; Mon, 10 Jan 2022 18:24:34 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id m6so33008931ybc.9
        for <cgroups@vger.kernel.org>; Mon, 10 Jan 2022 18:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QSQyDPVUrDTpPa0aeIkb88gZSvWQCxb+kxHI+54cFz0=;
        b=XP3yQrg8fDZpSWUZkuN/qfg9052nmszm/0Ms512ggngyobd7ttIvqnXRyrfbVQTWaf
         /zGqSCW6zCzW84h4JMDO76dAuixk4yxZqFqgmYbuFIecfy++oe16hNrJXFTIYI3h86rj
         7J7KqCLyp1LCIst+ibhYsv6zCd9IeG9Hlhapn40NZpRLtRAxXaJ3m9P3fifzHCfrX0+Z
         rYtTnG1Ldv3rswgr8S0TJTBmeTDEr5CdzTxhHwZdq0Y2dYKVSTgZVBR3bPP/PoKSsE6/
         h2T8vQYugkLWcuH4JEaXMIvSedPawB/waoT7n5CVkTpXpLBJCdawHZLGfukgzi3IKixh
         f8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSQyDPVUrDTpPa0aeIkb88gZSvWQCxb+kxHI+54cFz0=;
        b=oVgJdDcLeFuXfZxU2mYSXrFjRFoF7/RNcGmfrJMfwvPrFfz7eb9xbQP2mibLQoUD2k
         e/TwM49Kw6qIp6fhd3NLqhtJ1L3QOAyT02wvhejp6lEES+6SvqEL9EzYRRM519xRfxSt
         PTnMBVn+Owuf54g9pgQdfJCpTO/0edqR0T6Im/UCc+GeOQfEN3fFwemorqAIpik9kx5m
         3dlIYfpw9cG8rBomnxUA+K1RsASyynnChOWHJvO+0aNAKJiAIvW+f9DlvgiJoWRD3Oo7
         B3mSFDvS39zlpyEoscyw5tf9JKm6LmgSqBadRxXD4mcowSPUTyxfourgM8BIVIcKyr4Q
         k6lg==
X-Gm-Message-State: AOAM530MOMCrXnngWhbBlZn7MgmGOADfKiM09G3HMn4XcJ7g2Nw7TXsj
        8zul2hK6HTx4QMTYcB7QoxZ0hlrM+5wKnRDAW/Tz0A==
X-Google-Smtp-Source: ABdhPJx11qad2Hf5OTZtbqHBCOaZGNeOpypqrGIcE0GpoUrVWOkLl0m+W/NSQYpHxRry1mTn362lwgm3GWkaLMWghgc=
X-Received: by 2002:a25:abcb:: with SMTP id v69mr3517256ybi.317.1641867873454;
 Mon, 10 Jan 2022 18:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
In-Reply-To: <20220111010302.8864-1-richard.weiyang@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 11 Jan 2022 10:23:57 +0800
Message-ID: <CAMZfGtVR90mUTL_JgKwO_4ek_nk8CbZGPchn3GxvwtN9q+dxbg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/memcg: use NUMA_NO_NODE to indicate allocation
 from unspecified node
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 9:03 AM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> Instead of use "-1", let's use NUMA_NO_NODE for consistency.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
