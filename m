Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3481C3F5D
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2020 18:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgEDQGS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 May 2020 12:06:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34631 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbgEDQGR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 May 2020 12:06:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id y3so2589956wrt.1;
        Mon, 04 May 2020 09:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gz77ioJv/9dXqW2LTks1m6BbwjIcuICrqOvb8PaySYQ=;
        b=iQKwJjj3+0ie9fpeFWGs8T1C+Lq8Qxc4ct/wLyo6VI4DvFxe833gQhPHKslE+mGtnl
         +f/GWr4qhw25/FGvcvn4nPhjgMgM6nre/fF6Yjh9jmDrACDD5l70GfrJKXAuxzWpXK2c
         yT9cBtr9qmk8cNYinWqAfEltshBhQ87Y9D1E/GflkPIVjuNL//K27ju4cnsFxAf+xMaW
         sA0xVZU7u6gc0udjEMxYB5UJP6+3qerbSCJ7/OeD4rnmPckvugPy/nszlHbHSbeRYwdy
         pP9cV2pkZ+z/VDOmj5n7pcV0fi7v4RyVwgUvK0tCrHpJlyYDPpZxnAtSyvgKFh4b1QAT
         vS+Q==
X-Gm-Message-State: AGi0Puadn+6ehpSEE1xHajTkV3/3gEmeI9OIDxkyTgqFIAo39LMFHESE
        DOHoq9JyJ2Qq6nuDrc+rimU=
X-Google-Smtp-Source: APiQypL3n2ecP7nnkYr0BLQZTWMzDfU3njXWsN19/uQWkLzxn3+828cKXcT1957AXYHlfWLL9ElbXw==
X-Received: by 2002:adf:f091:: with SMTP id n17mr30070wro.200.1588608375283;
        Mon, 04 May 2020 09:06:15 -0700 (PDT)
Received: from localhost (ip-37-188-183-9.eurotel.cz. [37.188.183.9])
        by smtp.gmail.com with ESMTPSA id s8sm16137860wrt.69.2020.05.04.09.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 09:06:14 -0700 (PDT)
Date:   Mon, 4 May 2020 18:06:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200504160613.GU22838@dhcp22.suse.cz>
References: <20200430182712.237526-1-shakeelb@google.com>
 <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com>
 <20200504141136.GR22838@dhcp22.suse.cz>
 <CALvZod7Ls7rTDOr5vXwEiPneLqbq3JoxfFBxZZ71YWgvLkNr5A@mail.gmail.com>
 <20200504150052.GT22838@dhcp22.suse.cz>
 <CALvZod7EeQm-T4dsBddfMY_szYw3m8gRh5R5GfjQiuQAtCocug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7EeQm-T4dsBddfMY_szYw3m8gRh5R5GfjQiuQAtCocug@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 04-05-20 08:35:57, Shakeel Butt wrote:
> On Mon, May 4, 2020 at 8:00 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 04-05-20 07:53:01, Shakeel Butt wrote:
[...]
> > > I am trying to see if "no eligible task" is really an issue and should
> > > be warned for the "other use cases". The only real use-case I can
> > > think of are resource managers adjusting the limit dynamically. I
> > > don't see "no eligible task" a concerning reason for such use-case.
> >
> > It is very much a concerning reason to notify about like any other OOM
> > situation due to hard limit breach. In this case it is worse in some
> > sense because the limit cannot be trimmed down because there is no
> > directly reclaimable memory at all. Such an oom situation is
> > effectivelly conserved.
> > --
> 
> Let me make a more precise statement and tell me if you agree. The "no
> eligible task" is concerning for the charging path but not for the
> writer of memory.max. The writer can read the usage and
> cgroup.[procs|events] to figure out the situation if needed.

I really hate to repeat myself but this is no different from a regular
oom situation. Admin sets the hard limit and the kernel tries to act
upon that.

You cannot make any assumption about what admin wanted or didn't want
to see. We simply trigger the oom killer on memory.max and this is a
documented behavior. No eligible task or no task at all is a simply a
corner case when the kernel cannot act and mentions that along with the
oom report so that whoever consumes that information can debug or act on
that fact.

Silencing the oom report is simply removing a potentially useful
aid to debug further a potential problem. But let me repeat this is not
reallly any different from a regular oom situation when the oom killer
is able to act.

-- 
Michal Hocko
SUSE Labs
