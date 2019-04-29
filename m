Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E999E065
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2019 12:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfD2KRh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Apr 2019 06:17:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:33222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbfD2KRh (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 29 Apr 2019 06:17:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8327AD22;
        Mon, 29 Apr 2019 10:17:35 +0000 (UTC)
Date:   Mon, 29 Apr 2019 12:17:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, mm <linux-mm@kvack.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: memcg causes crashes in list_lru_add
Message-ID: <20190429101732.GB21837@dhcp22.suse.cz>
References: <f0cfcfa7-74d0-8738-1061-05d778155462@suse.cz>
 <2cbfb8dc-31f0-7b95-8a93-954edb859cd8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cbfb8dc-31f0-7b95-8a93-954edb859cd8@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 29-04-19 11:25:48, Jiri Slaby wrote:
> On 29. 04. 19, 10:16, Jiri Slaby wrote:
[...]
> > Any idea how to fix this mess?
> 
> memcg_update_all_list_lrus should take care about resizing the array. So
> it looks like list_lru_from_memcg_idx returns a stale pointer to
> list_lru_from_kmem and then to list_lru_add. Still investigating.

I am traveling and on a conference this week. Please open a bug and if
this affects upstream kernel then report upstream as well. Cc linux-mm
and memcg maintainers. This doesn't ring bells immediately. I do not
remember any large changes recently.
-- 
Michal Hocko
SUSE Labs
