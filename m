Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B063D33C0A9
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 16:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhCOP66 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 11:58:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:50832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231875AbhCOP6f (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Mar 2021 11:58:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615823914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S1QyVKaSB8Yw5ODdqZSJJFR0A2j33an6mNYtE7mQyMI=;
        b=DzMFy86fpC0NliOMOn+TLBRnx2vAXvuYsfAytAevIQcYeOJThvqXU/EWqRTQijA2PbPf5u
        Sfej+/GbLTBq7vbacY/++OH3rcXiiXi6UHEeQIb8LVTDFWexz7tRhkJKu/sk+RhAPHU8/R
        RgwVgISDX5ikFoETUaJNN+j2EU8Dvg4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EE765AC75;
        Mon, 15 Mar 2021 15:58:33 +0000 (UTC)
Date:   Mon, 15 Mar 2021 16:58:32 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, Vasily Averin <vvs@virtuozzo.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Subject: Re: [PATCH v2 8/8] memcg: accounting for ldt_struct objects
Message-ID: <YE+EKC2yiyzjsEkq@dhcp22.suse.cz>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
 <360b4c94-8713-f621-1049-6bc0865c1867@virtuozzo.com>
 <20210315132740.GB20497@zn.tnic>
 <CALvZod7aT7t_Yp67CaECbCSzk8CuqBRMUBccthLCpz4osqDLKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7aT7t_Yp67CaECbCSzk8CuqBRMUBccthLCpz4osqDLKw@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 15-03-21 08:48:26, Shakeel Butt wrote:
> On Mon, Mar 15, 2021 at 6:27 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Mon, Mar 15, 2021 at 03:24:01PM +0300, Vasily Averin wrote:
> > > Unprivileged user inside memcg-limited container can create
> > > non-accounted multi-page per-thread kernel objects for LDT
> >
> > I have hard time parsing this commit message.
> >
> > And I'm CCed only on patch 8 of what looks like a patchset.
> >
> > And that patchset is not on lkml so I can't find the rest to read about
> > it, perhaps linux-mm.
> >
> > /me goes and finds it on lore
> >
> > I can see some bits and pieces, this, for example:
> >
> > https://lore.kernel.org/linux-mm/05c448c7-d992-8d80-b423-b80bf5446d7c@virtuozzo.com/
> >
> >  ( Btw, that version has your SOB and this patch doesn't even have a
> >    Signed-off-by. Next time, run your whole set through checkpatch please
> >    before sending. )
> >
> > Now, this URL above talks about OOM, ok, that gets me close to the "why"
> > this patch.
> >
> > From a quick look at the ldt.c code, we allow a single LDT struct per
> > mm. Manpage says so too:
> >
> > DESCRIPTION
> >        modify_ldt()  reads  or  writes  the local descriptor table (LDT) for a process.
> >        The LDT is an array of segment descriptors that can be referenced by user  code.
> >        Linux  allows  processes  to configure a per-process (actually per-mm) LDT.
> >
> > We allow
> >
> > /* Maximum number of LDT entries supported. */
> > #define LDT_ENTRIES     8192
> >
> > so there's an upper limit per mm.
> >
> > Now, please explain what is this accounting for?
> >
> 
> Let me try to provide the reasoning at least from my perspective.
> There are legitimate workloads with hundreds of processes and there
> can be hundreds of workloads running on large machines. The
> unaccounted memory can cause isolation issues between the workloads
> particularly on highly utilized machines.

It would be better to be explicit

8192 * 8 = 64kB * number_of_tasks

so realistically this is in range of lower megabytes. Is this worth the
memcg accounting overhead? Maybe yes but what kind of workloads really
care?

-- 
Michal Hocko
SUSE Labs
