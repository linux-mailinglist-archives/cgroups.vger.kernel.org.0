Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66731169B9B
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2020 02:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgBXBLq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 23 Feb 2020 20:11:46 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35069 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbgBXBLq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 23 Feb 2020 20:11:46 -0500
Received: by mail-oi1-f194.google.com with SMTP id b18so7463455oie.2
        for <cgroups@vger.kernel.org>; Sun, 23 Feb 2020 17:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=HX1fJHLiNwnVKz7r+onFwX/niXbmKqUAA8UMhmaKQVk=;
        b=kvTvYofZbz9U3B5NUoEdMRddWJRK/T6OWfWosieMYrRCRmBG6eds6cFCmkYooinSxb
         8VPn/Y70cjNOolZdgXXxZbXrOgCEDWU+L7iglCMwW+DF/5BFvXKY0G0dPLuQ4lQmY5WP
         JNK5G2q80TrH67xVPlf3bovornkAJZFsIRARlH+qEnAVUsgB1s6isDKWXfcJA0FwjoBY
         nRdSBFeW6FTnlcgIbbxsM8b/CY2eBs+XAdfipDCubdL5u0kKxae5lEJ6Fy2NEr7PkG2O
         ATHNhSb++IjMLmUksnNBie+sd/AN3rJrbjO2Xqcd8JLvVZlsIYm7dt+uer/M20dGt1FP
         48pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=HX1fJHLiNwnVKz7r+onFwX/niXbmKqUAA8UMhmaKQVk=;
        b=HonpxWhRbz5y4gZ2CvgNW/xr9oXGwXsQzpvjgntzloxjMEGFAXWKH95epVQEr4lMq6
         QwGxMMuxOHQqJZzG2aduklGFdmxmTFeeLqGXUaLspNe411rUrlTDLvLxJCTlja2wVtZD
         3AGCQSowtKqZrNGBOKKdgwt+q3p0geh8f7dMY5xcnGaldA+oDkly7MsRYKw1gWmcivSu
         +86wCrsUZquoACGkZ+Jz3HYmnlYGFI8XiKDBfm6wkvP3i/3J78Px6t8ZHX/B5h9ktK+Y
         4TIjo358txMQb9hzjeL8pIdip/gSF4TXgN9QWP9LEHDyqSqiPf1y8eK8Xj/fYte4kGEK
         Y+/A==
X-Gm-Message-State: APjAAAU6Yj1wY6KPh3ta5kUV5IYcjxn86INH6V/rWuUHc06Em8hWAurx
        jgea07dn98gZzs8K1QZ9GdTh0Q==
X-Google-Smtp-Source: APXvYqxhhn1kZfC9aGeOzvgd6UOP1g9Z1kN2EROT2rl+Hr6et8C1VoRjmDndu2vyAIreE4N4uciOPg==
X-Received: by 2002:a05:6808:84:: with SMTP id s4mr10963771oic.147.1582506704543;
        Sun, 23 Feb 2020 17:11:44 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j5sm3881050otl.71.2020.02.23.17.11.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Feb 2020 17:11:43 -0800 (PST)
Date:   Sun, 23 Feb 2020 17:11:12 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
cc:     Hugh Dickins <hughd@google.com>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v3 2/3] mm: Charge active memcg when no mm is set
In-Reply-To: <alpine.LSU.2.11.2002231058520.5735@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2002231710420.7354@eggly.anvils>
References: <cover.1582216294.git.schatzberg.dan@gmail.com> <0a27b6fcbd1f7af104d7f4cf0adc6a31e0e7dd19.1582216294.git.schatzberg.dan@gmail.com> <alpine.LSU.2.11.2002231058520.5735@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, 23 Feb 2020, Hugh Dickins wrote:
> On Thu, 20 Feb 2020, Dan Schatzberg wrote:
> 
> > memalloc_use_memcg() worked for kernel allocations but was silently
> > ignored for user pages.
> > 
> > This patch establishes a precedence order for who gets charged:
> > 
> > 1. If there is a memcg associated with the page already, that memcg is
> >    charged. This happens during swapin.
> > 
> > 2. If an explicit mm is passed, mm->memcg is charged. This happens
> >    during page faults, which can be triggered in remote VMs (eg gup).
> > 
> > 3. Otherwise consult the current process context. If it has configured
> >    a current->active_memcg, use that. Otherwise, current->mm->memcg.
> > 
> > Previously, if a NULL mm was passed to mem_cgroup_try_charge (case 3) it
> > would always charge the root cgroup. Now it looks up the current
> > active_memcg first (falling back to charging the root cgroup if not
> > set).
> > 
> > Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Acked-by: Tejun Heo <tj@kernel.org>
> 
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> Yes, internally we have some further not-yet-upstreamed complications
> here (mainly, the "memcg=" mount option for all charges on a tmpfs to
> be charged to that memcg); but what you're doing here does not obstruct
> adding that later, they fit in well with the hierarchy that you (and
> Johannes) mapped out above, and it's really an improvement for shmem
> not to be referring to current there - thanks.

I acked slightly too soon. There are two other uses of "try_charge" in
mm/shmem.c: we can be confident that the userfaultfd one knows what mm
it's dealing with, but the shmem_swapin_page() instance has a similar
use of current->mm, that you also want to adjust to NULL, don't you?

Hugh
