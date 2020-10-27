Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF1929AD7E
	for <lists+cgroups@lfdr.de>; Tue, 27 Oct 2020 14:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbgJ0Ngx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Oct 2020 09:36:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:38734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752306AbgJ0Ngw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Oct 2020 09:36:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603805811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vVfsint97M+naTXXxHG4OXnQeWqqb/vQC4U46ftK8Ro=;
        b=ZOf89cP7tkb4NTIdZZR2NsUHBbPHti3VCEVDz7sHKYwFFlg+572/0TcwmJQL2wSN9l1bqg
        ry53bKL9p748UXGDWGHYu695j2Q393Aj863UtWvB99OIxR8DCXMcXG+WFsOET6susjdi7N
        FQtmPeB0VLsWf/hrCYgXnKHvYqSBwKQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09CF1AF2F;
        Tue, 27 Oct 2020 13:36:51 +0000 (UTC)
Date:   Tue, 27 Oct 2020 14:36:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        iamjoonsoo.kim@lge.com, laoar.shao@gmail.com, chris@chrisdown.name,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        mingo@kernel.org, keescook@chromium.org, tglx@linutronix.de,
        esyr@redhat.com, surenb@google.com, areber@redhat.com,
        elver@google.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/5] mm: memcontrol: Simplify the mem_cgroup_page_lruvec
Message-ID: <20201027133639.GT20500@dhcp22.suse.cz>
References: <20201027080256.76497-1-songmuchun@bytedance.com>
 <20201027080256.76497-6-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027080256.76497-6-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 27-10-20 16:02:56, Muchun Song wrote:
> We can reuse the code of mem_cgroup_lruvec() to simplify the code
> of the mem_cgroup_page_lruvec().

yes, removing the code duplication is reasonable. But ...

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/memcontrol.h | 44 +++++++++++++++++++++++++++-----------
>  mm/memcontrol.c            | 40 ----------------------------------
>  2 files changed, 32 insertions(+), 52 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 95807bf6be64..5e8480e54cd8 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -451,16 +451,9 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
>  	return memcg->nodeinfo[nid];
>  }
>  
> -/**
> - * mem_cgroup_lruvec - get the lru list vector for a memcg & node
> - * @memcg: memcg of the wanted lruvec
> - *
> - * Returns the lru list vector holding pages for a given @memcg &
> - * @node combination. This can be the node lruvec, if the memory
> - * controller is disabled.
> - */
> -static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
> -					       struct pglist_data *pgdat)
> +static inline struct lruvec *mem_cgroup_node_lruvec(struct mem_cgroup *memcg,
> +						    struct pglist_data *pgdat,
> +						    int nid)

This is just wrong interface. Either take nid or pgdat. You do not want
both because that just begs for wrong usage.
-- 
Michal Hocko
SUSE Labs
