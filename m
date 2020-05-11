Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0213A1CD626
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2020 12:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgEKKN2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 May 2020 06:13:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55019 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgEKKN1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 May 2020 06:13:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id h4so17424143wmb.4;
        Mon, 11 May 2020 03:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uOhWjc2sd24xbu0R8XTgR/bnPdX/gR8GhK7Om+UST/I=;
        b=ezyocZerD4gU4npRNtCYjOYn0Exnl9L0VxO9/kMy3ngXYqEIjtK4o51pSM+UeI7c9R
         Kl4171hv14/HbBbzww+rD+xoEHwNbsUi6nuN2LY7q5l/N5Gf8KVml31ljQyPyu1EKdQi
         F6+xthoNCMoFUSbxKSIwWSqg8l0HIBzi2iNfxVa8KMcTL5UbzU836cKNO57GUULZiIQC
         rUwmuig5wx3a4pXjPqR/xC3Y3Ww8odGq8jgOKj4HJLhQ+V79A8QU1wCrVEXsYHrlsh6c
         vyshvteGOBOJZ+Gq8J/+Tlxne4o2Nk6k8o7uoS/Ky8ZouCOcAMn40x5jt8RDWWGeURDB
         SPaw==
X-Gm-Message-State: AGi0Pubu7b+b4MUs8QD9NJE4ss5wZZnIXZtJpsMllRfTtv9vX1bn8Ykp
        POQa+X3XKysi+6tnTKJkPYw=
X-Google-Smtp-Source: APiQypKiG/83MSsUYm/CowCYDjDJkgwYsim/g2CFoTBskQl373KykPNmSMHAUUrWn+GsH703Ktj+SQ==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr30199972wmc.142.1589192005108;
        Mon, 11 May 2020 03:13:25 -0700 (PDT)
Received: from localhost (ip-37-188-228-19.eurotel.cz. [37.188.228.19])
        by smtp.gmail.com with ESMTPSA id n24sm9865895wmi.40.2020.05.11.03.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 03:13:24 -0700 (PDT)
Date:   Mon, 11 May 2020 12:13:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH] doc: cgroup: update note about conditions when oom
 killer is invoked
Message-ID: <20200511101322.GE29153@dhcp22.suse.cz>
References: <158894738928.208854.5244393925922074518.stgit@buzz>
 <20200511083904.GB29153@dhcp22.suse.cz>
 <0ddb8e58-5bfd-7754-6979-4276acf5b4c8@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ddb8e58-5bfd-7754-6979-4276acf5b4c8@yandex-team.ru>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 11-05-20 12:34:00, Konstantin Khlebnikov wrote:
> 
> 
> On 11/05/2020 11.39, Michal Hocko wrote:
> > On Fri 08-05-20 17:16:29, Konstantin Khlebnikov wrote:
> > > Starting from v4.19 commit 29ef680ae7c2 ("memcg, oom: move out_of_memory
> > > back to the charge path") cgroup oom killer is no longer invoked only from
> > > page faults. Now it implements the same semantics as global OOM killer:
> > > allocation context invokes OOM killer and keeps retrying until success.
> > > 
> > > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > > ---
> > >   Documentation/admin-guide/cgroup-v2.rst |   17 ++++++++---------
> > >   1 file changed, 8 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > index bcc80269bb6a..1bb9a8f6ebe1 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -1172,6 +1172,13 @@ PAGE_SIZE multiple when read back.
> > >   	Under certain circumstances, the usage may go over the limit
> > >   	temporarily.
> > > +	In default configuration regular 0-order allocation always
> > > +	succeed unless OOM killer choose current task as a victim.
> > > +
> > > +	Some kinds of allocations don't invoke the OOM killer.
> > > +	Caller could retry them differently, return into userspace
> > > +	as -ENOMEM or silently ignore in cases like disk readahead.
> > 
> > I would probably add -EFAULT but the less error codes we document the
> > better.
> 
> Yeah, EFAULT was a most obscure result of memory shortage.
> Fortunately with new behaviour this shouldn't happens a lot.

Yes, it shouldn't really happen very often. gup was the most prominent
example but this one should be taken care of by triggering the OOM
killer. But I wouldn't bet my hat there are no potential cases anymore.

> Actually where it is still possible? THP always fallback to 0-order.
> I mean EFAULT could appear inside kernel only if task is killed so
> nobody would see it.

Yes fatal_signal_pending paths are ok. And no I do not have any specific
examples. But as you've said EFAULT was a real surprise so I thought it
would be nice to still keep a reference for it around. Even when it is
unlikely.

-- 
Michal Hocko
SUSE Labs
