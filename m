Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D367BC48DF
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2019 09:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfJBHyy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Oct 2019 03:54:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:38696 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfJBHyx (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 2 Oct 2019 03:54:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21148ABF4;
        Wed,  2 Oct 2019 07:54:52 +0000 (UTC)
Date:   Wed, 2 Oct 2019 09:54:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] mm/memcontrol.c: fix another unused function warning
Message-ID: <20191002075451.GG15624@dhcp22.suse.cz>
References: <20191001142227.1227176-1-arnd@arndb.de>
 <CAKwvOdn7J6bvF=58UkeXA8LVAMt-g76EDFT+j5EWc0LdsyX_CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn7J6bvF=58UkeXA8LVAMt-g76EDFT+j5EWc0LdsyX_CQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 01-10-19 09:36:24, Nick Desaulniers wrote:
> On Tue, Oct 1, 2019 at 7:22 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Removing the mem_cgroup_id_get() stub function introduced a new warning
> > of the same kind when CONFIG_MMU is disabled:
> >
> > mm/memcontrol.c:4929:13: error: unused function 'mem_cgroup_id_get_many' [-Werror,-Wunused-function]
> >
> > Address this using a __maybe_unused annotation.
> >
> > Note: alternatively, this could be moved into an #ifdef block.  Marking it
> 
> Hi Arnd,
> Thank you for the patch!  I would prefer to move the definition to the
> correct set of #ifdef guards rather than __maybe_unused.  Maybe move
> the definition of mem_cgroup_id_get_many() to just before
> __mem_cgroup_clear_mc()?  I find __maybe_unused to be a code smell.

Agreed!
-- 
Michal Hocko
SUSE Labs
