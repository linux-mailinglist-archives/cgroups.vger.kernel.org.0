Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2D61230C1
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2019 16:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLQPqh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Dec 2019 10:46:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46560 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQPqh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Dec 2019 10:46:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so11789153wrl.13;
        Tue, 17 Dec 2019 07:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TuQqZHZA7F8zrUioSoTgrl1c8FOUxjce+qXhdDt9T1Q=;
        b=AxubpVzRcqYzO7BrUu3OqNk1eBOT7Cj+ci/3E5dMeMz276EcjSYNagr5/yfUPyh/Ze
         rG9A2JiltDk5it4ZI2OBm6Je4UucyaJbWs2SJUQdtroCIk063fPinJSb8xZNhqRSyvFq
         9dCDHs3hwJcTJb7y/Exzzkajbsz0WLVUK/6CWoRU2Ypa9MJFABSQE7BYl6b4XxAvg4um
         vITqTiwPYbGASobeL1OeQZb+oMgvLJ8w/l1pVqgzETuCOpjwal8h+tvTghnaHDFkcx4X
         uGPMGWJ6eU9bQ2fn14YEq0yesGQIpn086/io/XFMwgo6ilv0mbQirzTWWkkPKuDbC20f
         HF+Q==
X-Gm-Message-State: APjAAAVuf+1O6w1NoOz536FnS2lUgK7RJc3St7oaGqlQrLQGQpHznSHY
        NMsHXguU2CGBdfObs9J5UI4=
X-Google-Smtp-Source: APXvYqyaLlXC8wOzGI//HEchY8EnBI7KhMkSmqaaisJZeWL/y3zxtl1RZBwyNF+AYAa4cVtyJryIXw==
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr36372586wrp.110.1576597595052;
        Tue, 17 Dec 2019 07:46:35 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id z8sm26075799wrq.22.2019.12.17.07.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:46:34 -0800 (PST)
Date:   Tue, 17 Dec 2019 16:46:33 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Qian Cai <cai@lca.pw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under
 CONFIG_MMU
Message-ID: <20191217154633.GE7272@dhcp22.suse.cz>
References: <20191217135440.GB58496@chrisdown.name>
 <392D7C59-5538-4A9B-8974-DB0B64880C2C@lca.pw>
 <20191217144652.GA7272@dhcp22.suse.cz>
 <20191217150921.GA136178@chrisdown.name>
 <20191217151931.GD7272@dhcp22.suse.cz>
 <20191217152814.GB136178@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217152814.GB136178@chrisdown.name>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 17-12-19 15:28:14, Chris Down wrote:
> Michal Hocko writes:
> > On Tue 17-12-19 15:09:21, Chris Down wrote:
> > [...]
> > > (Side note: I'm moderately baffled that a tightly scoped __maybe_unused is
> > > considered sinister but somehow disabling -Wunused-function is on the table
> > > :-))
> > 
> > Well, I usually do not like to see __maybe_unused because that is prone
> > to bit-rot and loses its usefulness. Looking into the recent git logs
> > most -Wunused-function led to the code removal (which is really good
> > but the compiler is likely to do that already so the overall impact is
> > not that large) or more ifdefery. I do not really see many instance of
> > __maybe_unused.
> 
> Hmm, but __maybe_unused is easy to find and document the reasons behind
> nearby, and then reevaluate at some later time. On the other hand, it's much
> *harder* to reevaluate which functions actually are unused in the long term
> if we remove -Wunused-function, because enabling it to find candidates will
> result in an incredibly amount of noise from those who have missed unused
> functions previously due to the lack of the warning.

I usually git grep for the function and that covers many cases. But
realistically, I am more than skeptical people are going to do a regular
cleanup like that. And that is the biggest deal with this annotation.
Once it gets marked it will just stay that way and potentially get
really unused eventually. So the overall benefit is close the zero in
that case.

Maybe dropping -Wunused-function is an overreaction. Git log shows there
has been some code removed which is probably the most viable reaction to
those reports. Maybe we just want to add those for W=1 or something like
that.

> Maybe Qian is right and we should just ignore such patches, but I think that
> comes with its own risks that we will alienate perfectly well intentioned
> new contributors to mm without them having any idea why we did that.

I believe that both possitive and negative reaction to _any_ patch has
to be properly justified - same applies to the patch itself. A warning
report/fix is not an expcetion. In this particular case it has been pointed
out that the reported function is a general purpose one which just
happens to be used only for CONFIG_SWAP (rather than CONFIG_MMU) and
using additional ifdeferry is likely not going to help long term.
-- 
Michal Hocko
SUSE Labs
