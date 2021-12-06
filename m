Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACCB469E57
	for <lists+cgroups@lfdr.de>; Mon,  6 Dec 2021 16:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377937AbhLFPiM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Dec 2021 10:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388233AbhLFPc3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Dec 2021 10:32:29 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4302AC09B060
        for <cgroups@vger.kernel.org>; Mon,  6 Dec 2021 07:19:31 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id l8so11099672qtk.6
        for <cgroups@vger.kernel.org>; Mon, 06 Dec 2021 07:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nefXY9GnrKTvs8NuB1vTMpAOilGrkfP6qgHIvnqCGyA=;
        b=HzYh2WxY8Q+EgOkB2smBNZ25CT3P5TCbZA91IuxwSLyZw7X7AbSYLmJEljM3LlDwFx
         lY8VvbF9xOM4Psmx2Kh9WX8lRdwFEMYfS6mr3MXhAhkjeVWwSXTdCzxNGP0M8Eqaa7dN
         D+lH/ekiFAwEukjTTKRP3Q43Qqa54gnyAeHmk61hhdv8zarhymwU5U6GvAoB4ZZ+K3ZH
         bQKCen1R+8SJvC0WKy2eNUOCPB9kXlRoY1KVCNh7vY0q+agMYnkTfCD5Ao7FANJOiaWD
         HzvM+F48qhwpHiZkY/rH7viLoFAKAMa+9dHA6Pkfvuzu/pW7n45fUfXm6CSS0BFdRnbs
         B7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nefXY9GnrKTvs8NuB1vTMpAOilGrkfP6qgHIvnqCGyA=;
        b=t8vol4ufN3apg5bffbbBO7vgHdmk8FHiOMiwz+KFkvV9kD2Ibrv3I8Sg1Oux86PMbs
         p/d7QQ2CzjzLupg+84UF9jnQapqySiUT8mQsXFFjzWDsip7UnZP9zY1emPnihadw8uqS
         oXpqfZzr7WE2kdz7zkh4HqOT+/rXOhZolgjIid7gKFbWD7rpEKLG47FZqCuy+fHeGcGe
         yhLFN+A8zi3WevQIc/uJS/4egfRPoK6A27KkxjnQt3ZLAgCQhpSg4CKON12/2GnV59/Q
         RQ4u/4qKATsD5ksJ2wBXzBAGwXeQG3LI35Hg6Ear7eqN+FPqGs5Ww7h6x3K5XUuVxLWY
         cRJw==
X-Gm-Message-State: AOAM533aWM/sTg5y4jdYDV466/0CPrv8lOmfAV12ZvOwvw9yKb09KMhH
        +uPfXvR8ZH4c6+G7VGIbe5ZbVg==
X-Google-Smtp-Source: ABdhPJxSYyh4j4Ckh7jks6r8W3wi3f74t9J4HYT3qkHXAcm2NbLDr0ElmK/TnADyXfHBrmWGl7cp9w==
X-Received: by 2002:ac8:7d84:: with SMTP id c4mr40411114qtd.94.1638803970478;
        Mon, 06 Dec 2021 07:19:30 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id b6sm7721017qtk.91.2021.12.06.07.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:19:29 -0800 (PST)
Date:   Mon, 6 Dec 2021 10:19:29 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: add group_oom_kill memory event
Message-ID: <Ya4qAWzz6Ozq07Sl@cmpxchg.org>
References: <20211203162426.3375036-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203162426.3375036-1-schatzberg.dan@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This makes perfect sense, just one minor point:

On Fri, Dec 03, 2021 at 08:24:23AM -0800, Dan Schatzberg wrote:
> @@ -4390,6 +4390,9 @@ static int mem_cgroup_oom_control_read(struct seq_file *sf, void *v)
>  	seq_printf(sf, "under_oom %d\n", (bool)memcg->under_oom);
>  	seq_printf(sf, "oom_kill %lu\n",
>  		   atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]));
> +	seq_printf(sf, "oom_group_kill %lu\n",
> +		   atomic_long_read(
> +			&memcg->memory_events[MEMCG_OOM_GROUP_KILL]));
>  	return 0;
>  }

oom_control is a cgroup1 file, but group-oom is a cgroup2-only
feature. Best to drop this hunk.

With that, please add:
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
