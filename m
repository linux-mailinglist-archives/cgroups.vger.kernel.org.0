Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751991E6D5F
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2020 23:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407512AbgE1VOr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 17:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407477AbgE1VOo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 17:14:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5C9C08C5C7
        for <cgroups@vger.kernel.org>; Thu, 28 May 2020 14:14:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r7so914010wro.1
        for <cgroups@vger.kernel.org>; Thu, 28 May 2020 14:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Md5HCLgP2FEvxYLu9x06BehC1qjXovJHaXEUB6IGroo=;
        b=tVtux6suf22nedoh998nr2nUX5JUphMEZFx1Mo5ltS8yQR6kIabLVyb+3YEpbDz5OG
         vQXWDGS1o1GyJcdyLG/lH+pz8BSLyVItVBFyS1IDgO033yA5fsTuAysRfzYRrHiwtbxP
         t9F33VrCQRi12tf3yFgiOPMHjDXOjcKQ8rFW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Md5HCLgP2FEvxYLu9x06BehC1qjXovJHaXEUB6IGroo=;
        b=G6skPqKCD5CVPgILM0B8Djbk5EMHpU2BmgCuNQrnM9VgR+ubYhI72u9CDlRG+xiYgg
         4szFsuGLws/ZBoeYyZdGo8KHulsBIZcp2VRq0dHtbTl3Di+F4VP88eV/jzaacWQO9Cys
         P8/TDX1Lve9gUNqbNAZ08lIm0L2ZqbRSBCVnBnVjHfcdq8vbizrPBk0vCNRRv8crGp1w
         iirAvjtENM2AQY31NUhFL+Ae9mb+9r6TCutEx6sDS3E48g8oSEldWLiT4XWR0GmFzD09
         UznTCeHwIJwllwKhS2nIfAIXvq4AwyNdu6oLkFRKXNQM3J0JGlzj5LltmYgvf5YrCfCY
         r8vw==
X-Gm-Message-State: AOAM532+Av8ApJdEczlrkfFKRBP90RGZcFSPyqJ6zUHdjGGp76mqhEuj
        3/wcEORaWYHtOerwwVwZyR2XFQ==
X-Google-Smtp-Source: ABdhPJy9x8tatjpCo/n0+suEu+dHg+NV6QVGsjjs9Au1vBlu6M/wADBmns2Aje7ULPrXqU9Km8vpNQ==
X-Received: by 2002:adf:ed51:: with SMTP id u17mr4889766wro.285.1590700482631;
        Thu, 28 May 2020 14:14:42 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id k26sm8205312wmi.27.2020.05.28.14.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 14:14:41 -0700 (PDT)
Date:   Thu, 28 May 2020 22:14:41 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200528211441.GA3410@chrisdown.name>
References: <20200520143712.GA749486@chrisdown.name>
 <CALvZod7rSeAKXKq_V0SggZWn4aL8pYWJiej4NdRd8MmuwUzPEw@mail.gmail.com>
 <20200528194831.GA2017@chrisdown.name>
 <20200528202944.GA76514@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200528202944.GA76514@cmpxchg.org>
User-Agent: Mutt/1.14.2 (2020-05-25)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Johannes Weiner writes:
>> I don't feel strongly either way, but current->memcg_nr_pages_over_high can
>> be very large for large allocations.
>>
>> That said, maybe we should just reclaim `max(SWAP_CLUSTER_MAX, current -
>> high)` for each loop? I agree that with this design it looks like perhaps we
>> don't need it any more.
>>
>> Johannes, what do you think?
>
>How about this:
>
>Reclaim memcg_nr_pages_over_high in the first iteration, then switch
>to SWAP_CLUSTER_MAX in the retries.
>
>This acknowledges that while the page allocator and memory.max reclaim
>every time an allocation is made, memory.high is currently batched and
>can have larger targets. We want the allocating thread to reclaim at
>least the batch size, but beyond that only what's necessary to prevent
>premature OOM or failing containment.
>
>Add a comment stating as much.
>
>Once we reclaim memory.high synchronously instead of batched, this
>exceptional handling is no longer needed and can be deleted again.
>
>Does that sound reasonable?

That sounds good to me, thanks. I'll change that in v2 soonish and update the 
changelog.
