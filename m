Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315BC2FCC55
	for <lists+cgroups@lfdr.de>; Wed, 20 Jan 2021 09:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbhATIGl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Jan 2021 03:06:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:59832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730071AbhATIEV (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 20 Jan 2021 03:04:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611128997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QeFIPCKf1lzYZ5NNZ/UyihM0FPQ4ig48O6bHj3KSVc0=;
        b=pjKh/cmX3L7lWbEKaS4FMhCZzGKLMOMKo9InQl9tWIyGjOGZkXfH3nRZUV7+XPf5Fka8W1
        7ADICESjNintsIualGfn3VWpnmRIbn34rk7Jd14bymn6XA42bxGdXyDDCwgjLrm0qKf4pG
        8jKoVVesER20mZI+dx71Qxm8MDXlZ4U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49F69AAAE;
        Wed, 20 Jan 2021 07:49:57 +0000 (UTC)
Date:   Wed, 20 Jan 2021 08:49:56 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Muchun Song <songmuchun@bytedance.com>, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: skip propagate percpu vmstat values to
 current memcg
Message-ID: <20210120074956.GB9371@dhcp22.suse.cz>
References: <20210119052744.96765-1-songmuchun@bytedance.com>
 <YAcPwhl//jF/WpHu@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAcPwhl//jF/WpHu@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 19-01-21 11:58:42, Johannes Weiner wrote:
> On Tue, Jan 19, 2021 at 01:27:44PM +0800, Muchun Song wrote:
> > The current memcg will be freed soon, so updating it's vmstat and
> > vmevent values is pointless. Just skip updating it.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> Oof, that's pretty subtle! Somebody trying to refactor that code for
> other purposes may not immediately notice that optimization and add
> potentially tedious bugs.

Absolutely agreed!

> How much does this save? Cgroup creation and deletion isn't really
> considered a hot path. It takes global locks and such...

This is not the first time when an (micro)optimization is posted without
any data showing benefit or otherwise appealing justification. Sigh.

-- 
Michal Hocko
SUSE Labs
