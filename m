Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD291C4ED2
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2020 09:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgEEHNa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 May 2020 03:13:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41288 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgEEHNa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 May 2020 03:13:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id g13so1345504wrb.8;
        Tue, 05 May 2020 00:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D35mOJV49bWuGzt/JCgfa9WldwyA3q6GVvLou0MYSnM=;
        b=suYr2xGLoNNCGKNWfVZi/A9ZOmb+lvrS/qq+YXW3FJYtjj4/R7LNDg7gi6ptsVhIK6
         corfc2WjHdxOi0w27cACHwi0e2szdQa32jN+EXwH5va5Z/7uI+p7c9UhrSRZPdgXeoUq
         ugcWzU4sAlWGxIM8iDLIzJhG962d77CjXYheBS3LiTP456eYuSz+WX2tYZ/wc+87J/p1
         p87Cm3i+fpZ5U7I4KfIIRLGT+DPYdBhRMYPNe2nXUs9Spa66z2dVVjS4ipos62jUO7mg
         qbVo6HF/T/5HcdETMXQmFQ2/ExDLYRw/HDguWuPizoIOlDmaSyj2JZ0I2LF3/b+g68K+
         TCsA==
X-Gm-Message-State: AGi0PuYqxLq2jAYGcOjQhQ/aehJ2AdspaVwGIMqeMDKobpjioN3iWzSC
        61TRxo5wAVVFewbcSqnwhHM=
X-Google-Smtp-Source: APiQypKsJpn506doavmId1p49nfYK71RX13vklhQ6rOpXsgAEIhvXhgtE2o2L9CsVn2B81dhZFvhfw==
X-Received: by 2002:adf:f648:: with SMTP id x8mr1941180wrp.257.1588662807808;
        Tue, 05 May 2020 00:13:27 -0700 (PDT)
Received: from localhost (ip-37-188-183-9.eurotel.cz. [37.188.183.9])
        by smtp.gmail.com with ESMTPSA id u127sm2351710wme.8.2020.05.05.00.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 00:13:26 -0700 (PDT)
Date:   Tue, 5 May 2020 09:13:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200505071324.GB16322@dhcp22.suse.cz>
References: <20200430182712.237526-1-shakeelb@google.com>
 <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com>
 <20200504141136.GR22838@dhcp22.suse.cz>
 <CALvZod7Ls7rTDOr5vXwEiPneLqbq3JoxfFBxZZ71YWgvLkNr5A@mail.gmail.com>
 <20200504150052.GT22838@dhcp22.suse.cz>
 <CALvZod7EeQm-T4dsBddfMY_szYw3m8gRh5R5GfjQiuQAtCocug@mail.gmail.com>
 <20200504160613.GU22838@dhcp22.suse.cz>
 <CALvZod79hWns9366B+8ZK2Roz8c+vkdA80HqFNMep56_pumdRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod79hWns9366B+8ZK2Roz8c+vkdA80HqFNMep56_pumdRQ@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 04-05-20 12:23:51, Shakeel Butt wrote:
[...]
> *Potentially* useful for debugging versus actually beneficial for
> "sweep before tear down" use-case.

I definitely do not want to prevent you from achieving what you
want/need. Let's get back to your argument on why you cannot use
memory.high for this purpose and what is the actual difference from
memory.max on the "sweep before removal". You've said

: Yes that would work but remote charging concerns me. Remote charging
: can still happen after the memcg is offlined and at the moment, high
: reclaim does not work for remote memcg and the usage can go till max
: or global pressure. This is most probably a misconfiguration and we
: might not receive the warnings in the log ever. Setting memory.max to
: 0 will definitely give such warnings.

So essentially the only reason you are not using memory.high which would
effectively achieve the same level of reclaim for your usecase is that
potential future remote charges could get unnoticed. I have proposed to
warn when charging to an offline memcg because that looks like a sign of
bug to me. Having the hard limit clamped to 0 (or some other small
value) would complain loud by the oom report and no eligible tasks
message but it will unlikely help to stop such a usage because, well,
there is nothing reclaimable and we force the charge in that case. So
you are effectively in the memory.high like situation.

So instead of potentially removing a useful information can we focus on
the remote charging side of the problem and deal with it in a sensible
way? That would make memory.high usable for your usecase and I still
believe that this is what you should be using in the first place.
-- 
Michal Hocko
SUSE Labs
