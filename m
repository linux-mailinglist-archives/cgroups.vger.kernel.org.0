Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B24B4A840C
	for <lists+cgroups@lfdr.de>; Thu,  3 Feb 2022 13:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350612AbiBCMqe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Feb 2022 07:46:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53134 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiBCMqd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Feb 2022 07:46:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9E94E1F399;
        Thu,  3 Feb 2022 12:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643892392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WD0KsuFGAKxwPJ8TEDz3MZAplll7b1MiXcSJo4CExx4=;
        b=CQmLudPTvW4RaIzlWaw2EchZq5DbsHcpikxLxdiNyQzFdoT3+nVxC9O6xi3q9rw27Ye6Lp
        7ygFDsjVCbZNeC2UEUGl9dY/9Gcry845qVzIqZPWuHDHO0NJgA4S862fpTyluqIeFsoRn4
        p7lD24R7/HNiHwa1VlivOZxKVRNMnAQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2F23CA3B92;
        Thu,  3 Feb 2022 12:46:32 +0000 (UTC)
Date:   Thu, 3 Feb 2022 13:46:31 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>, Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v4 3/4] mm/page_owner: Print memcg information
Message-ID: <YfvOp5VXrxy9IW1w@dhcp22.suse.cz>
References: <20220131192308.608837-5-longman@redhat.com>
 <20220202203036.744010-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202203036.744010-4-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 02-02-22 15:30:35, Waiman Long wrote:
[...]
> +#ifdef CONFIG_MEMCG
> +	unsigned long memcg_data;
> +	struct mem_cgroup *memcg;
> +	bool online;
> +	char name[80];
> +
> +	rcu_read_lock();
> +	memcg_data = READ_ONCE(page->memcg_data);
> +	if (!memcg_data)
> +		goto out_unlock;
> +
> +	if (memcg_data & MEMCG_DATA_OBJCGS)
> +		ret += scnprintf(kbuf + ret, count - ret,
> +				"Slab cache page\n");
> +
> +	memcg = page_memcg_check(page);
> +	if (!memcg)
> +		goto out_unlock;
> +
> +	online = (memcg->css.flags & CSS_ONLINE);
> +	cgroup_name(memcg->css.cgroup, name, sizeof(name));

Is there any specific reason to use another buffer allocated on the
stack? Also 80B seems too short to cover NAME_MAX.

Nothing else jumped at me.
-- 
Michal Hocko
SUSE Labs
