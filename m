Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575461C5E15
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2020 18:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbgEEQ5v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 May 2020 12:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730415AbgEEQ5u (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 May 2020 12:57:50 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F43C061A0F
        for <cgroups@vger.kernel.org>; Tue,  5 May 2020 09:57:50 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g26so2507042qtv.13
        for <cgroups@vger.kernel.org>; Tue, 05 May 2020 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fEeh741pti+zQtUqiU+d//divWdQ0COuz+a61BTeqwc=;
        b=YSNRusfE9U5u8q3v9LefCY1rU6K93jnDg4I/Se7sXa6/yvJwAIFJruFuN/+VjtbSYG
         WLGgbW8jcLo909cVZHzUEp9Vl+j+1knpGhiLLF/8yO7xI4PhQHn2jKn/XZ+7gIEL8BH/
         PhBIW0QTlorsqAK3ECYQ7eylm0EjiRTeEix3nV7MDzfl4adlAlpi/WyRmqf5Ia/KQN4O
         w1BXffany2R/o7burzJHOvzi7xx7uGRaTy/SVArfU9go+3KLVzW3kV2yZOZWk8hdENnp
         gMwRI/VptGu32D36XJgI8z1S2S8eSXN0uchSFh2cN9VI3jrNmhOGTKXONkufx5pguBgZ
         O5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fEeh741pti+zQtUqiU+d//divWdQ0COuz+a61BTeqwc=;
        b=gF15A4/m5uXyk66sXZqUuqeSAyTWLlHIS803UWdWz6ghG+WkY4uNIKmrIZfvc8G291
         o72doWpHoHWmuCCuSbajQWprlfG41VJR40x+V/vaXWa97IRpcv+djGI/nHGpuMzWsTs0
         S+f+MkFKKPwnylAWMI1PmQCGEM879dszDMzUxSyM1jv/dzWSc4CMTB2LySsN8KjyLI2H
         3GBDMoUw8QK3v3RSNoSFsVd2mZrLm38k1oVkKGOgRG/eSK9ibgS69/Cqp5/MSS6U5wJE
         xMhbJKQULIUsdoufxqm/fnMW8jZwDZX5lumuypRzop29OtDzUsSIIh5KRratA7kzcKJv
         MTIg==
X-Gm-Message-State: AGi0PuY5UpKTH9NYJj600nZ+fLyGlR0OnPpcTcvpGPdZxdfmN4MCXhDp
        iTfozdl0FNOXmmG92sh/9qB5Ag==
X-Google-Smtp-Source: APiQypKo4D/DEYlsK/2z0fDu/HkNmZbZN2I+uP29hg08y0CiHEZZLic4UCq7t4Eov0dhnnf7ClF+Ug==
X-Received: by 2002:ac8:2f15:: with SMTP id j21mr3745654qta.259.1588697869788;
        Tue, 05 May 2020 09:57:49 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id z40sm2371728qtj.45.2020.05.05.09.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:57:48 -0700 (PDT)
Date:   Tue, 5 May 2020 12:57:34 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200505165734.GD58018@cmpxchg.org>
References: <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com>
 <20200504141136.GR22838@dhcp22.suse.cz>
 <CALvZod7Ls7rTDOr5vXwEiPneLqbq3JoxfFBxZZ71YWgvLkNr5A@mail.gmail.com>
 <20200504150052.GT22838@dhcp22.suse.cz>
 <CALvZod7EeQm-T4dsBddfMY_szYw3m8gRh5R5GfjQiuQAtCocug@mail.gmail.com>
 <20200504160613.GU22838@dhcp22.suse.cz>
 <CALvZod79hWns9366B+8ZK2Roz8c+vkdA80HqFNMep56_pumdRQ@mail.gmail.com>
 <20200505071324.GB16322@dhcp22.suse.cz>
 <CALvZod5H-fDbvu73=hkzN0Man_+03ZW0d5zc1N0YObVHSiy0Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5H-fDbvu73=hkzN0Man_+03ZW0d5zc1N0YObVHSiy0Tw@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 05, 2020 at 08:03:17AM -0700, Shakeel Butt wrote:
> On Tue, May 5, 2020 at 12:13 AM Michal Hocko <mhocko@kernel.org> wrote:
> > So instead of potentially removing a useful information can we focus on
> > the remote charging side of the problem and deal with it in a sensible
> > way? That would make memory.high usable for your usecase and I still
> > believe that this is what you should be using in the first place.
> 
> We talked about this at LSFMM'19 and I think the decision was to not
> fix high reclaim for remote memcg until it will be an actual issue. I
> suppose now we can treat it as an actual issue.
> 
> There are a couple of open questions:
> 1) Should the remote chargers be throttled and do the high reclaim?

I would say it depends on the caller. We may need both: a centralized
charger like a kthread that does work on behalf of many cgroups should
not be throttled, or we risk priority inversions - maybe not even held
up for reclaim, although that would need some thinking about
memory.max as well - whether remote charges should be allowed to
overrun memory.max temporarily, and we punt all reclaim from such
contexts to a worker. (Preferrably, in the future, with all the cpu
cycles of that worker accounted to the cgroup. We want that for
kswapd-style background reclaim as well).

We do similar things with IO for example, when offloading IO to a
central kthread. The kthread is allowed to proceed past a cgroup's
allowance in order to make forward progress, and the cgroup will be
forced to pay up retroactively when it comes back for more of the
resource.
