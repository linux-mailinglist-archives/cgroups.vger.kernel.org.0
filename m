Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA0A9166664
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 19:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgBTSfz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 13:35:55 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:35187 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTSfz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 13:35:55 -0500
Received: by mail-qv1-f65.google.com with SMTP id u10so2360716qvi.2
        for <cgroups@vger.kernel.org>; Thu, 20 Feb 2020 10:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ui1GYJ+3TKdhDhER6hX80GC8ogMrESlUENKJdsvmiJw=;
        b=fmztncXTcGHJiFgzRFjgjLEip0FvqqT27efzmzqFHV75pB/K83qJ3D1hNW4E70dXeZ
         CJFi4rvcQHriQibThmglNljM7AMJM2WmKPyRjHJZtP1+ft4kHUBatB/TJEuTN6xxhTiN
         E6+kHjefonE2x7TQtlE6uRTgWbAoPRwp5TtqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ui1GYJ+3TKdhDhER6hX80GC8ogMrESlUENKJdsvmiJw=;
        b=Iq1gTc87CZvggZ7VNRoWJuk7+Y+7vq8ya7N8gNWBq6iPkbP/SfozRC8Otnf3RqQa5J
         1JNpkB8AE1ok+vI3zQjHfo+QsGFs1giOMa2/j4bYGPVqK1GnAwM8dY44RUaQ2kqbbc/q
         BQ/nuscXzOUaHgQ7+yr/DVupneu3NmnNtwnhsI8bvX5wSLHBttZ/Qny0QiRyscRVcwhG
         Cq2hXQZNCyLt3BCmY93xq1O72xuF4l1iyebPrIntbDIx3PLGqyMwZHuMUkr2LHV3m3l1
         1wb9gWo7eoD5vrh+EFa/bV2LzRETbfyhwi72SSApuqHgNJfYkX+uuuHBJ97HXvDmUaWk
         19Gw==
X-Gm-Message-State: APjAAAWyOp4z5xav35xB5rqM/OTVltdthaqjSPGTWTTc8t3n0L4/4ZQ8
        1um3zSQGEgn7B/OH8aUjbujS9Q==
X-Google-Smtp-Source: APXvYqxmnMhAcMk3lY0AI5vqnwgSVzy5Kgiji+XEXQ3tkC5VUl2qSX0E++tOv9JyuEOMeCuZhNP74Q==
X-Received: by 2002:ad4:478b:: with SMTP id z11mr27009509qvy.185.1582223754273;
        Thu, 20 Feb 2020 10:35:54 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:a76b])
        by smtp.gmail.com with ESMTPSA id g9sm226424qkl.11.2020.02.20.10.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 10:35:53 -0800 (PST)
Date:   Thu, 20 Feb 2020 13:35:52 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v3 2/3] mm: Charge active memcg when no mm is set
Message-ID: <20200220183552.GA2181061@chrisdown.name>
References: <cover.1582216294.git.schatzberg.dan@gmail.com>
 <0a27b6fcbd1f7af104d7f4cf0adc6a31e0e7dd19.1582216294.git.schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0a27b6fcbd1f7af104d7f4cf0adc6a31e0e7dd19.1582216294.git.schatzberg.dan@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dan Schatzberg writes:
>memalloc_use_memcg() worked for kernel allocations but was silently
>ignored for user pages.
>
>This patch establishes a precedence order for who gets charged:
>
>1. If there is a memcg associated with the page already, that memcg is
>   charged. This happens during swapin.
>
>2. If an explicit mm is passed, mm->memcg is charged. This happens
>   during page faults, which can be triggered in remote VMs (eg gup).
>
>3. Otherwise consult the current process context. If it has configured
>   a current->active_memcg, use that. Otherwise, current->mm->memcg.
>
>Previously, if a NULL mm was passed to mem_cgroup_try_charge (case 3) it
>would always charge the root cgroup. Now it looks up the current
>active_memcg first (falling back to charging the root cgroup if not
>set).
>
>Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
>Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>Acked-by: Tejun Heo <tj@kernel.org>

Acked-by: Chris Down <chris@chrisdown.name>

Thanks! The clarification the v2 thread for this made things clear to me.
