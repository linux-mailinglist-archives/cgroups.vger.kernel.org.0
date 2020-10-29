Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E6229E6F5
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 10:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgJ2JI6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 05:08:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:46456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgJ2JIJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Oct 2020 05:08:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603962487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pRfvIcEC60eWRFi87by9E7+LFhlD5mHOp4kKoOmBQUI=;
        b=jhHChYEGIqkgyrVF2bZZDAP9fShBJKnw5Z76v7XG/lfKacRenW4EL4SRGC/eZd1qasjwS2
        cXgAP3eIkMrcSCfouk1jFCJmAe+jJ4WKqCfQbzrt+J4qDoDjNaVak+cdilW0CbujdHb2DS
        S50daeUjnIvhpfapMjy5qa/SKRtIe58=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A0EDAB2CF;
        Thu, 29 Oct 2020 09:08:07 +0000 (UTC)
Date:   Thu, 29 Oct 2020 10:08:06 +0100
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
Subject: Re: [PATCH v2] mm: memcontrol: Simplify the mem_cgroup_page_lruvec
Message-ID: <20201029090806.GD17500@dhcp22.suse.cz>
References: <20201028035013.99711-1-songmuchun@bytedance.com>
 <20201028035013.99711-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028035013.99711-4-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 28-10-20 11:50:13, Muchun Song wrote:
[...]
> -struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgdat)
> +static struct lruvec *
> +__mem_cgroup_node_lruvec(struct mem_cgroup *memcg, struct pglist_data *pgdat,
> +			 int nid)

I thought I have made it clear that this is not a good approach. Please
do not repost new version without that being addressed. If there are any
questions then feel free to ask for details.
-- 
Michal Hocko
SUSE Labs
