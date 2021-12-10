Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB72470B3C
	for <lists+cgroups@lfdr.de>; Fri, 10 Dec 2021 21:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbhLJUDq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Dec 2021 15:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240266AbhLJUDq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Dec 2021 15:03:46 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC30DC061746;
        Fri, 10 Dec 2021 12:00:10 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id m192so8812709qke.2;
        Fri, 10 Dec 2021 12:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yLZJvjoofMd+xeF11awcZvcV4Nn3U+z+fMY0sp4o/sA=;
        b=BjS8Vig6e8gQ4F0ZwsS3QThNYRE1ejxTIXemMKWA/aHL8GjyLyTAhPf/Yn4mdskwdf
         aGk3YFZk3sckvjvH/XRMg6GqWCMnutMR9SLLbsDTP1CWCGbMFyuGWDDSQPaHvMh5uDPY
         z3K0J/UJ88uHGHrSEaJG1bGYB13RPUe6ug+5eyDprQAY+8kISqRD/Kokt2j8/3EEjF+w
         Ij8EsV1Mq18LEA8wgQtDhSBN+KwwoFXMxKkv0Z2fiFWa5YOwIw2jy2ERGW9Ua+or7G2V
         K+1YH+vLDsvdwnJNUccX+KEsh3seflpRZHOnjBrh8z4QksUW5Fl5x9DJB9B0f+zojjUf
         OS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yLZJvjoofMd+xeF11awcZvcV4Nn3U+z+fMY0sp4o/sA=;
        b=Dx+NJm6x/C3CHoQepItXqF4lsIPRIZd/9oL3LugMo7WZOZSfFuw/BACPPfX8f+XAyY
         geiV4x4SfO7gr4BzOlaM2Tf0/A1vG5Ne6MwYwTAMDvGisQREwS9Ioh9BAh9GvmaYoZqM
         /gAnWWuL3KYipsaiV00SAGjxGhbEqGiHWilt1RyLMAB4OvHRkXAxoWXvyw+A2yS6eFjB
         WzfEQZgzA9GL3+LxKZSRutZeKRhgh/r+0xy/BJpxa7qzpBD+713s/MlWsBc0yAE9d98D
         /lraNNCdaV/Olb7b62mpigCnRq/l3qfrrZLfl0lOcjAH8ARCcHVrA5B06pBEDABYsBHA
         Vwbg==
X-Gm-Message-State: AOAM5304Lol54WaJk3+sSjzl32oTmfSur9NuPHCAML6d8aJhn2RZ6Fhb
        bl4moShumQ9aIKATIZSfH8I=
X-Google-Smtp-Source: ABdhPJxcyt16X640iWzcAvnwZWhPX3Xnns70Dp67SogNqM2UhY/oywrxq/hOGQnDCQLuwDoSew/1nA==
X-Received: by 2002:a37:e105:: with SMTP id c5mr22591377qkm.777.1639166409684;
        Fri, 10 Dec 2021 12:00:09 -0800 (PST)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:500::1:a9d6])
        by smtp.gmail.com with ESMTPSA id v4sm1734537qkp.118.2021.12.10.12.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 12:00:09 -0800 (PST)
Date:   Fri, 10 Dec 2021 15:00:06 -0500
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <YbOxxhuQ3a1Myd6v@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20211203162426.3375036-1-schatzberg.dan@gmail.com>
 <CALvZod6y+_O49jzuD9wLXncCEGCgun4f-uf_yBzYcsfEiH1WOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6y+_O49jzuD9wLXncCEGCgun4f-uf_yBzYcsfEiH1WOQ@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 03, 2021 at 04:45:54PM -0800, Shakeel Butt wrote:
> On Fri, Dec 3, 2021 at 8:24 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> >
> > Our container agent wants to know when a container exits if it was OOM
> > killed or not to report to the user. We use memory.oom.group = 1 to
> > ensure that OOM kills within the container's cgroup kill
> > everything. Existing memory.events are insufficient for knowing if
> > this triggered:
> >
> > 1) Our current approach reads memory.events oom_kill and reports the
> > container was killed if the value is non-zero. This is erroneous in
> > some cases where containers create their children cgroups with
> > memory.oom.group=1 as such OOM kills will get counted against the
> > container cgroup's oom_kill counter despite not actually OOM killing
> > the entire container.
> >
> > 2) Reading memory.events.local will fail to identify OOM kills in leaf
> > cgroups (that don't set memory.oom.group) within the container cgroup.
> >
> > This patch adds a new oom_group_kill event when memory.oom.group
> > triggers to allow userspace to cleanly identify when an entire cgroup
> > is oom killed.
> >
> > Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> 
> So, with this patch, will you be watching oom_group_kill from
> memory.events or memory.events.local file for your use-case?
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

We will watch from memory.events.local. If containers want to
construct their own child cgroups and allow for group oom to occur
inside, that's fine - a future container exit should not result in us
claiming the container was OOM killed. If the container exits and
memory.event.local shows oom_group_kill > 0 then we know the container
was OOM killed.
