Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFFF31411D
	for <lists+cgroups@lfdr.de>; Mon,  8 Feb 2021 22:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhBHVAG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Feb 2021 16:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhBHU65 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Feb 2021 15:58:57 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1A3C061786;
        Mon,  8 Feb 2021 12:58:15 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id n28so4407390qtv.12;
        Mon, 08 Feb 2021 12:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tqRaxICy5YHBMmHcX2M4Wd1YNoE/TgL6qyHQaFgZCcY=;
        b=Kbipus5vPp2mNkhFtKdD511qL2yTMBCGkJZfr16sI2xPQnoo74CcVb7BKoEvNsK0Ka
         uhkpzga2kyNnhAT8doX26kRfoHUMEh4usIoPhV1QXcI2l7N6BuHrhC5pj7g0nRcThPfM
         Im3oy3HkeuZHZPj26peXKX7xI4Q9Gw27KDbhyW4CvpnP7D+0Qm76ctrraFJM+mjD5jSG
         7huMyxqW0/n0d3Rm74L0WMPLdSydyk2YfXTZXTtJzY4NGFMUamuDbbqU5exQeM4Lk9US
         mHcN3S9Rqqm7mORgR40fI2W97hMnvhan02fsuGrxKZW1wV1MMqdvgxNdhbrDp6nPQRrs
         sI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tqRaxICy5YHBMmHcX2M4Wd1YNoE/TgL6qyHQaFgZCcY=;
        b=h5+jeRpsrPbwxXpWBKPtLLzO4fY/NJRwl3dAFfYi/ral3sfEcKB2pbQy73JMdrcfff
         UNPabLYyGDzlxcHNpgOc0Qt9TBbbKkZrZGTzby7S6FDVIQVaJduFOZrd/eDrrJAfnniO
         GMTIZ/+TMhVH3v7YWdUyYa/iRssjLfn1UclxXwUtfbltD10qfI5Q8jWfwxPrsL3WtPGm
         syy7+8txi1tc+wIFRcVE1ArF7HH/XcXC2paFNT4qe+VDg8eIFt9Wio7bRpoipCOq2VV3
         qQvu1rQwGNuthvfLUMOTpbmXif7+0+M8MXFDOKqA5V0w1DAwG5M2osyD9BF/tzP2chOq
         fVfg==
X-Gm-Message-State: AOAM533DMQcsnKDOS7NquBaJkLuxCD9VMwHcUdX7Gnms7aNe8SaLU5nQ
        +1I0Erc9ej2Zczo2DIPoTpA=
X-Google-Smtp-Source: ABdhPJz1H9hgXr0QIuDRCjaDc/VNli6qF6kkuPHto504MFo2+7jHJi+4ymrEjDcL6YxhKJImjUH4lA==
X-Received: by 2002:ac8:5c0a:: with SMTP id i10mr16404804qti.239.1612817894151;
        Mon, 08 Feb 2021 12:58:14 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id n4sm2933535qtp.72.2021.02.08.12.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 12:58:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 8 Feb 2021 10:58:11 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 5/8] cgroup: rstat: punt root-level optimization to
 individual controllers
Message-ID: <YCFfkxytFaYooidE@slm.duckdns.org>
References: <20210205182806.17220-1-hannes@cmpxchg.org>
 <20210205182806.17220-6-hannes@cmpxchg.org>
 <YB4OT61owRaze5/M@mtj.duckdns.org>
 <YCGfIYTLzcTO+ng8@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCGfIYTLzcTO+ng8@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Feb 08, 2021 at 03:29:21PM -0500, Johannes Weiner wrote:
> > > @@ -789,6 +793,7 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
> > >  		u64_stats_update_end(&blkg->iostat.sync);
> > >  
> > >  		/* propagate global delta to parent */
> > > +		/* XXX: could skip this if parent is root */
> > >  		if (parent) {
> > >  			u64_stats_update_begin(&parent->iostat.sync);
> > >  			blkg_iostat_set(&delta, &blkg->iostat.cur);
> > 
> > Might as well update this similar to cgroup_base_stat_flush()?
> 
> I meant to revisit that, but I'm never 100% confident when it comes to
> the interaction and lifetime of css, blkcg and blkg_gq.

Yeah, it does get hairy.

> IIUC, the blkg_gq->parent linkage always matches the css parent
> linkage; it just exists as an optimization for ancestor walks, which
> would otherwise have to do radix lookups when going through the css.

But yes, at least this part is straight-forward.

> So with the cgroup_parent() check at the beginning of the function
> making sure we're looking at a non-root group, blkg_gq->parent should
> also never be NULL and I can do if (paren->parent) directly, right?

I think so.

> > >  static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
> > >  {
> > > -	struct cgroup *parent = cgroup_parent(cgrp);
> > >  	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
> > > +	struct cgroup *parent = cgroup_parent(cgrp);
> > 
> > Is this chunk intentional?
> 
> Yeah, it puts the local variable declarations into reverse christmas
> tree ordering to make them a bit easier to read. It's a while-at-it
> cleanup, mostly a force of habit. I can drop it if it bothers you.

I don't mind either way. Was just wondering whether it was accidental.

Thanks.

-- 
tejun
