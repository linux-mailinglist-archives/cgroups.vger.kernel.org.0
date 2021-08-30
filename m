Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD443FB740
	for <lists+cgroups@lfdr.de>; Mon, 30 Aug 2021 15:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhH3NuP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 Aug 2021 09:50:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47326 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhH3NuP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 Aug 2021 09:50:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BE0CC200AB;
        Mon, 30 Aug 2021 13:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630331360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cc2jyFkI4Y/eTP0fuxxH8ESHEZFe6V2z4lrRtmnXM6Q=;
        b=f9o3YxtNcrKp+PK+ZWm2qAcsw5SLHc0jhEZNVj2f5bET7VWTGz50zzq8TpyCC/RXE458Tf
        lSeFAgCdD9JtLnXb3jnosfjBDxBo6eXU50D46GUyB+DEzAz3eANVJR3QcOCnV1V7yPUKAJ
        xoHh8NZSrT3v+aSLPdXND61QpTGNN4g=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 94E53A3B9F;
        Mon, 30 Aug 2021 13:49:19 +0000 (UTC)
Date:   Mon, 30 Aug 2021 15:49:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     yong w <yongw.pur@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, alexs@kernel.org,
        Wei Yang <richard.weiyang@gmail.com>, Hui Su <sh_def@163.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        wang.yong12@zte.com.cn, Cgroups <cgroups@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn
Subject: Re: [PATCH v2] mm: Add configuration to control whether vmpressure
 notifier is enabled
Message-ID: <YSzh31BasoxUQXAu@dhcp22.suse.cz>
References: <1629417219-74853-1-git-send-email-wang.yong12@zte.com.cn>
 <YR+Rc9HC6OqlEq4I@dhcp22.suse.cz>
 <CAOH5QeCfwF0hX3XpoThEtwnddtOFEU9Jtp0Hoj+Q37D4Q6HC0Q@mail.gmail.com>
 <YR/NRJEhPKRQ1r22@dhcp22.suse.cz>
 <CAOH5QeDUUqrMnuws6cnBDU_oub4cK6KsHeX39p7Eikr4Bcjcnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOH5QeDUUqrMnuws6cnBDU_oub4cK6KsHeX39p7Eikr4Bcjcnw@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun 22-08-21 17:46:08, yong w wrote:
> > All those reasons should be a part of the changelog.
> >....
> > I am not sure these are sufficient justifications but that is something
> > to discuss. And hence it should be a part of the changelog.
> >
> OK, These reasons will be added to the patch notesin later versions.
> 
> > > 3. In the case where the user does not need vmpressure,  vmpressure
> > > calculation is additional overhead.
> >
> > You should quantify that and argue why that overhead cannot be further
> > reduced without config/boot time knobs.
> >
> The test results of the previously used PFT tool may not be obvious.
> Is there a better way to quantify it?

This is a question for you to answer I am afraid. You want to add a
configuration option and (as explained) that is not free of cost from
the maintenance POV. There must a very good reason to do that.

> > > In some special scenes with tight memory, vmpressure will be executed
> > > frequently.we use "likely" and "inline"
> > > to improve the performance of the kernel, why not reduce some
> > > unnecessary calculations?
> >
> > I am all for improving the code. Is it possible to do it by other means?
> > E.g. reduce a potential overhead when there no events registered?
> Yes, the method you mentioned may be feasible, but it does not conflict
> with this patch.

It is not in conflict but runtime overhead reduction without more burden
on the configurability is usually a preferred approach.
-- 
Michal Hocko
SUSE Labs
