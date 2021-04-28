Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407CD36D23A
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 08:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhD1GeZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 02:34:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:51226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhD1GeY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Apr 2021 02:34:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619591619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ZhVc13i/loE89OYYNbTCn+LJbpHgfesQUl3vFUzU4w=;
        b=hcsbUVWZOVa/VD7u1r+GmF/lDktHCL3s1g+57QapM1T1z/kS/fIVhq2dmbzUoQQ1SkD5P8
        jq0XFt5nGtr5WpT2823UcVhheb//TC4a0GNGLkTr+bmBbrLPca+VmxIZWE+D68CsXk/Ul8
        PtTpuvnPR6+vo9WXfNBwN9/fguwpXfs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 803C9B05C;
        Wed, 28 Apr 2021 06:33:39 +0000 (UTC)
Date:   Wed, 28 Apr 2021 08:33:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH 2/2] ipc: use kmalloc for msg_queue and shmid_kernel
Message-ID: <YIkBwgrDXF2x0Dt+@dhcp22.suse.cz>
References: <e67f2a95-4b01-9db2-fe47-0b2210f0b138@virtuozzo.com>
 <b0845b85-f4fe-601d-3328-d707d7db27f5@virtuozzo.com>
 <YIaVKi+0VMrz5LGD@dhcp22.suse.cz>
 <70805e05-5e56-2ab9-2654-3d48e9fe5a0a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70805e05-5e56-2ab9-2654-3d48e9fe5a0a@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 28-04-21 08:15:10, Vasily Averin wrote:
> On 4/26/21 1:25 PM, Michal Hocko wrote:
> > Using kvmalloc for sub page size objects is suboptimal because kmalloc
> > can easily fallback into vmalloc under memory pressure and smaller
> > objects would fragment memory. Therefore replace kvmalloc by a simple
> > kmalloc.
> 
> I think you're wrong here:
> kvmalloc can failback to vmalloc for size > PAGE_SIZE only

You are right. My bad. My memory failed on me. Sorry about the
confusion.
-- 
Michal Hocko
SUSE Labs
