Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CE93653B4
	for <lists+cgroups@lfdr.de>; Tue, 20 Apr 2021 10:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhDTIG2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Apr 2021 04:06:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:55558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhDTIG2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 20 Apr 2021 04:06:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618905956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QI+jU+hQq4MG4fnEZIyp1J+yoW7z3R2nnTri1hPIMb0=;
        b=LDwx87FWadOHK1RH2RC0IFbccjafULornqRJg3LIpFf66O+6qZ/1S6Teqsh1nd5G8PYKYe
        SX0GjTu6vo5dK98WipgCgvNj2KpHbjFV+9pgpliHBfHGvIuGWDbsJtuWuQ1Ok7NtjAxamm
        IPOMk7r5giucoElK3B7f8YLpbFMIyko=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 19398B23F;
        Tue, 20 Apr 2021 08:05:56 +0000 (UTC)
Date:   Tue, 20 Apr 2021 10:05:55 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Waiman Long <llong@redhat.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 1/5] mm/memcg: Move mod_objcg_state() to memcontrol.c
Message-ID: <YH6LY/N/fqqnv2QT@dhcp22.suse.cz>
References: <20210419000032.5432-1-longman@redhat.com>
 <20210419000032.5432-2-longman@redhat.com>
 <YH2eT+JCII48hX80@cmpxchg.org>
 <ffb5705e-8629-808d-9d09-0c9c7f509326@redhat.com>
 <140444ea-14e7-b305-910f-f23fafe45488@redhat.com>
 <YH26RrMBOxLaMg4l@cmpxchg.org>
 <b7c8e209-3311-609b-9b61-5602a89a8313@redhat.com>
 <d1c36f26-b958-49e0-ae44-1cf6334fa4c5@redhat.com>
 <YH3yCZn9EeSPKKGY@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH3yCZn9EeSPKKGY@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 19-04-21 17:11:37, Johannes Weiner wrote:
> On Mon, Apr 19, 2021 at 01:26:29PM -0400, Waiman Long wrote:
[...]
> - the soft limit tree and soft limit reclaim
> 
> - the threshold and oom event notification stuff
> 
> - the charge moving code
> 
> - remaining v1 interface files, as well as their helper functions
> 
> From a quick scan, this adds up to ~2,500 lines of old code with no
> actual dependencies from the common code or from v2, and which could
> be moved out of the way without disrupting ongoing development much.

Moving those into its own file makes sense to me as well. If the code is
not conditional (e.g. like swap accounting and some others) then moving
it would make memecontrol.c easier to navigate through.
-- 
Michal Hocko
SUSE Labs
