Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB5616EE2D
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2020 19:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgBYSkT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Feb 2020 13:40:19 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42376 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731502AbgBYSkT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Feb 2020 13:40:19 -0500
Received: by mail-qv1-f68.google.com with SMTP id dc14so120494qvb.9
        for <cgroups@vger.kernel.org>; Tue, 25 Feb 2020 10:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=i2CV/HrBlB038Ie8Qimmh82koD0NdKzml2lxz77LIw8=;
        b=ERjzs/tXZewLwer9YDYr/IYsZ/pnkPxN3//YU6bP7CHHDRMWHkIbtg/nZJaTXwNmK7
         4Qs4eXYUyB3Ezg+amypKAA20yzqDlEMeDIBpWdXMJnLR0PY7mXMKbXfnv97c2RPJisPX
         mm5VxvL+kqkeqFK9E7EdHKna0JtlAdztQzV/q7yA8TjapZ/6iFqjVEf2XjpalFBXfJY5
         qX3jcf2q9XJ5LFRVJQgHZWN8TzNR4va/XA3U7FJ79+PGCItxdnPc4CUAhu+up/bX+Tfn
         Vfdfg2Pcea2m37AoNJ0Xto0D2JDL0rkW2eLIM8KMNVqsT+PYB2rqxqoqatC4WbAuFM49
         3yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=i2CV/HrBlB038Ie8Qimmh82koD0NdKzml2lxz77LIw8=;
        b=LSz4K+oR/ZquCpE521NCmymERUeXr3C7JoLTEFA7PwxSJ0jLPJc/m8gxrkQb73eOH8
         GJLQdKjlzP6i6oKNfftc2u0hHC8iqntd2kE65TCywR5ivL4bNRubBd3ZzL2vBnoaZU82
         /ZDQmIvSukaSCQeO9QcjKGEeCJOO0oS7mQ2rWZfj/nojuMKo+Ym0bgJ1BCxYc/mesXue
         lKI9A9pUaM3HbYBH9qFAoTaQDviUa4uVzSPpZZ+P64N9+PtYUuPzEGMI4NX47jKzt3oE
         D8YFldtiz+PHBmCa3ueXpjIDYn46xn1iofaqVoGy/TzaX4bQsUKeJTZA+6M9/mr8FFRK
         pU/A==
X-Gm-Message-State: APjAAAWLAJCjh+vVejQHuRfSchihsCGt8T6A9iLAuwL3iaCDAhQauju2
        ZT4HpK6HyA9+elI9iknO5643s9mlFbM=
X-Google-Smtp-Source: APXvYqykB1tvyK9fp2RnMOVCx8rSnGK9lnKsMu0SxzRDZPYVode1NoBodz4tt48PVsQOPvJqzVRHrQ==
X-Received: by 2002:a0c:da08:: with SMTP id x8mr313476qvj.166.1582656018181;
        Tue, 25 Feb 2020 10:40:18 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:4d9c])
        by smtp.gmail.com with ESMTPSA id u26sm6102857qkk.18.2020.02.25.10.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 10:40:17 -0800 (PST)
Date:   Tue, 25 Feb 2020 13:40:14 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 2/3] mm: memcontrol: clean up and document effective
 low/min calculations
Message-ID: <20200225184014.GC10257@cmpxchg.org>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-3-hannes@cmpxchg.org>
 <20200221171024.GA23476@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200221171024.GA23476@blackbody.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Michal,

On Fri, Feb 21, 2020 at 06:10:24PM +0100, Michal Koutný wrote:
> On Thu, Dec 19, 2019 at 03:07:17PM -0500, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > + *    Consider the following example tree:
> >   *
> > + *        A      A/memory.low = 2G, A/memory.current = 6G
> > + *       //\\
> > + *      BC  DE   B/memory.low = 3G  B/memory.current = 2G
> > + *               C/memory.low = 1G  C/memory.current = 2G
> > + *               D/memory.low = 0   D/memory.current = 2G
> > + *               E/memory.low = 10G E/memory.current = 0
> >   *
> > + *    and memory pressure is applied, the following memory
> > + *    distribution is expected (approximately*):
> >   *
> > + *      A/memory.current = 2G
> > + *      B/memory.current = 1.3G
> > + *      C/memory.current = 0.6G
> > + *      D/memory.current = 0
> > + *      E/memory.current = 0
> >   *
> > + *    *assuming equal allocation rate and reclaimability
> I think the assumptions for this example don't hold (anymore).
> Because reclaim rate depends on the usage above protection, the siblings
> won't be reclaimed equally and so the low_usage proportionality will
> change over time and the equilibrium distribution is IMO different (I'm
> attaching an Octave script to calculate it).

Hm, this example doesn't change with my patch because there is no
"floating" protection that gets distributed among the siblings.

In my testing with the above parameters, the equilibrium still comes
out to roughly this distribution.

> As it depends on the initial usage, I don't think there can be given
> such a general example (for overcommit).

It's just to illustrate the pressure weight, not to reflect each
factor that can influence the equilibrium.

I think it still has value to gain understanding of how it works, no?

> > @@ -6272,12 +6262,63 @@ struct cgroup_subsys memory_cgrp_subsys = {
> >   * for next usage. This part is intentionally racy, but it's ok,
> >   * as memory.low is a best-effort mechanism.
> Although it's a different issue but since this updates the docs I'm
> mentioning it -- we treat memory.min the same, i.e. it's subject to the
> same race, however, it's not meant to be best effort. I didn't look into
> outcomes of potential misaccounting but the comment seems to miss impact
> on memory.min protection.

Yeah I think we can delete that bit.

> > @@ -6292,52 +6333,29 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
> > [...]
> > +	if (parent == root) {
> > +		memcg->memory.emin = memcg->memory.min;
> > +		memcg->memory.elow = memcg->memory.low;
> > +		goto out;
> >  	}
> Shouldn't this condition be 'if (parent == root_mem_cgroup)'? (I.e. 1st
> level takes direct input, but 2nd and further levels redistribute only
> what they really got from parent.)

I believe we cleared this up in the parallel thread, but just in case:
reclaim can happen due to a memory.max set lower in the
tree. memory.low propagation is always relative from the reclaim
scope, not the system-wide root cgroup.
