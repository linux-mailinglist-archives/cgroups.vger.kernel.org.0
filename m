Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CB4333901
	for <lists+cgroups@lfdr.de>; Wed, 10 Mar 2021 10:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCJJnB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Mar 2021 04:43:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:50342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhCJJmb (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 10 Mar 2021 04:42:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615369350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qLZFJropWuTtqmng7j/uyvEO07U2wdIf80qxM4muyg=;
        b=lSDSOY1L1zj619JWFQuby2KTVCU26IkluUftoipiD8kBZ1LPFlwt1muJ5NEedjn9QC6ilf
        rWkTetl8hkNmE3ozGWCjgdUIlKwqEPldWEixmPPq2A/sY+d96fK2bhje1TWQD+3g5v7th+
        c/t0DM9sMHrxxJW3Ni07ZgbOalDRRtA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD183AE42;
        Wed, 10 Mar 2021 09:42:29 +0000 (UTC)
Date:   Wed, 10 Mar 2021 10:42:29 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 1/9] memcg: accounting for allocations called with
 disabled BH
Message-ID: <YEiUhWjsC6HbYFpT@dhcp22.suse.cz>
References: <18a0ae77-89ff-2679-ab19-378e38ce2be2@virtuozzo.com>
 <CALvZod4QiAhjgQOGO4KYCs4-GjUmqb6th+4tr8nQ+bPumGFzNg@mail.gmail.com>
 <YEfYFIlRH0+0XWwT@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEfYFIlRH0+0XWwT@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 09-03-21 12:18:28, Roman Gushchin wrote:
> On Tue, Mar 09, 2021 at 11:39:41AM -0800, Shakeel Butt wrote:
> > On Tue, Mar 9, 2021 at 12:04 AM Vasily Averin <vvs@virtuozzo.com> wrote:
> > >
> > > in_interrupt() check in memcg_kmem_bypass() is incorrect because
> > > it does not allow to account memory allocation called from task context
> > > with disabled BH, i.e. inside spin_lock_bh()/spin_unlock_bh() sections
> > >
> > > Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> > 
> > In that file in_interrupt() is used at other places too. Should we
> > change those too?
> 
> Yes, it seems so. Let me prepare a fix (it seems like most of them were
> introduced by me).

Does this affect any existing in-tree users?
-- 
Michal Hocko
SUSE Labs
