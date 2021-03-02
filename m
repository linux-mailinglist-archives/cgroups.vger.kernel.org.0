Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9B232B1D5
	for <lists+cgroups@lfdr.de>; Wed,  3 Mar 2021 04:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhCCAst (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Mar 2021 19:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575087AbhCBDw4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Mar 2021 22:52:56 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A0DC061793
        for <cgroups@vger.kernel.org>; Mon,  1 Mar 2021 19:52:14 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id g4so13014748pgj.0
        for <cgroups@vger.kernel.org>; Mon, 01 Mar 2021 19:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57oy+i2wyCGM30/m8sTFwn3B8L9Scmi9y+74jBQL4vs=;
        b=eDNo6T5R9U/hOaETJQW7tHVGPRRrxSUybhcdsh8luN7bLlUhFb4Hoycj+OMDnhBnql
         65FHpbOfmlHmgyxtM3JVmc2mQcitwZGb8tPB8LJAR0V04VWVQ0yl2fA9n8X/H2RiZ5o8
         JGhQpb6kj7Bn2HCSfEfmHnkSuyEJgV8VA36qB/Ai+2icthxmSKekehKAFBdJyduJorSy
         JXHanj6IjXxeePGyeLl7WILWzYWblG6hddeH7BOK/Eb1M1g+BU3MDjIDdKBxOMGWBDr5
         bma2ZRCT0zWPmAzH8UPm3dquhCdPzxobKiz8h8rReCBscZrY7bHEITUNeFORv60B6zj0
         Zfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57oy+i2wyCGM30/m8sTFwn3B8L9Scmi9y+74jBQL4vs=;
        b=ZdQ0FQ8F41KBC92UklghwbZs+gNdsTK+yXz5HKlhgDYAbDJOV4dcKeuXps83khbGod
         z9LtKr0JqWBotmFq374PF8Rsz3bu0xrbsd1XFE6/ZOyWB5pzkHZDAUmPBYhwHvo9Onan
         FpT5r5Bpmz34WK43rzofsQvTDWYsUahMHc2ZFieckPA2DcOCA3yi5s9BUUilw6H14cFO
         o4wvVHgJdaJxgN5pnmxw4veDvPWWagfk0r1/95aRbtX6okbus6nZcdEfix7atms0BqaQ
         QEk/l8l4y3E1yNKHjSPu+ABDcOx6MS0A2o43tL1GnSS3Yei+pKCSP9DFJdKSz8P0X/ME
         hVDA==
X-Gm-Message-State: AOAM533KBxZLMv57hfXzQgrxDekz+4DP8nuEs9BlE+5l/AyxdHftZEbm
        jmueOHYGTYzdtKganvYO0prxTc2D42PdwRDLc2VQsg==
X-Google-Smtp-Source: ABdhPJzcaUfOFHNGcSwihHOwcKhocr1mJt3SRQ35DB3BbiQ0eJJN8kETf2XLREn+v+AQ4squnM1FDAmvmjrcrb0kGao=
X-Received: by 2002:aa7:9342:0:b029:1ee:8893:8554 with SMTP id
 2-20020aa793420000b02901ee88938554mr9846451pfn.2.1614657133983; Mon, 01 Mar
 2021 19:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20210301062227.59292-1-songmuchun@bytedance.com>
 <20210301062227.59292-3-songmuchun@bytedance.com> <CALvZod7sysj0+wrzLTXnwn7s_Gf-V2eFPJ6cLcoRmR0LdAFk0Q@mail.gmail.com>
 <CAMZfGtVhgPzGXrLp12Z=r_FYuyqOoza9tOkPZ0N1=cHR+ataQA@mail.gmail.com> <CALvZod6TmaG7QnxeM65sCzVJBTGfb34q50=0no391Ciww4ZzCQ@mail.gmail.com>
In-Reply-To: <CALvZod6TmaG7QnxeM65sCzVJBTGfb34q50=0no391Ciww4ZzCQ@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 2 Mar 2021 11:51:37 +0800
Message-ID: <CAMZfGtX=WqMuGw2DOZroF1oKTdfV0fRUc4cp6mMBH218vJDnkQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/5] mm: memcontrol: make page_memcg{_rcu}
 only applicable for non-kmem page
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>, kpsingh@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, bristot@redhat.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Wei Yang <richard.weiyang@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Oskolkov <posk@google.com>, Jann Horn <jannh@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Waiman Long <longman@redhat.com>,
        Michel Lespinasse <walken@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, krisman@collabora.com,
        esyr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 2, 2021 at 11:36 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Mon, Mar 1, 2021 at 7:03 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > On Tue, Mar 2, 2021 at 2:11 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Sun, Feb 28, 2021 at 10:25 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > > >
> > > > We want to reuse the obj_cgroup APIs to reparent the kmem pages when
> > > > the memcg offlined. If we do this, we should store an object cgroup
> > > > pointer to page->memcg_data for the kmem pages.
> > > >
> > > > Finally, page->memcg_data can have 3 different meanings.
> > > >
> > > >   1) For the slab pages, page->memcg_data points to an object cgroups
> > > >      vector.
> > > >
> > > >   2) For the kmem pages (exclude the slab pages), page->memcg_data
> > > >      points to an object cgroup.
> > > >
> > > >   3) For the user pages (e.g. the LRU pages), page->memcg_data points
> > > >      to a memory cgroup.
> > > >
> > > > Currently we always get the memcg associated with a page via page_memcg
> > > > or page_memcg_rcu. page_memcg_check is special, it has to be used in
> > > > cases when it's not known if a page has an associated memory cgroup
> > > > pointer or an object cgroups vector. Because the page->memcg_data of
> > > > the kmem page is not pointing to a memory cgroup in the later patch,
> > > > the page_memcg and page_memcg_rcu cannot be applicable for the kmem
> > > > pages. In this patch, we introduce page_memcg_kmem to get the memcg
> > > > associated with the kmem pages. And make page_memcg and page_memcg_rcu
> > > > no longer apply to the kmem pages.
> > > >
> > > > In the end, there are 4 helpers to get the memcg associated with a
> > > > page. The usage is as follows.
> > > >
> > > >   1) Get the memory cgroup associated with a non-kmem page (e.g. the LRU
> > > >      pages).
> > > >
> > > >      - page_memcg()
> > > >      - page_memcg_rcu()
> > >
> > > Can you rename these to page_memcg_lru[_rcu] to make them explicitly
> > > for LRU pages?
> >
> > Yes. Will do. Thanks.
> >
>
> Please follow Johannes' suggestion regarding page_memcg_kmem() and
> then no need to rename these.

OK.
