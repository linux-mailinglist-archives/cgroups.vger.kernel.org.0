Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33F80C48DA
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2019 09:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfJBHx3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Oct 2019 03:53:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:38016 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfJBHx3 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 2 Oct 2019 03:53:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45BBEAD73;
        Wed,  2 Oct 2019 07:53:27 +0000 (UTC)
Date:   Wed, 2 Oct 2019 09:53:26 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] mm/memcontrol.c: fix another unused function warning
Message-ID: <20191002075326.GF15624@dhcp22.suse.cz>
References: <20191001142227.1227176-1-arnd@arndb.de>
 <1569940805.5576.257.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569940805.5576.257.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 01-10-19 10:40:05, Qian Cai wrote:
> On Tue, 2019-10-01 at 16:22 +0200, Arnd Bergmann wrote:
> > Removing the mem_cgroup_id_get() stub function introduced a new warning
> > of the same kind when CONFIG_MMU is disabled:
> 
> Shouldn't CONFIG_MEMCG depends on CONFIG_MMU instead?

I wanted to do that in the past but there was a clear disagreement from
Johannes.
-- 
Michal Hocko
SUSE Labs
