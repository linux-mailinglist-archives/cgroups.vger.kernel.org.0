Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7981D1150
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2020 13:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgEML3J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 May 2020 07:29:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38187 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgEML3J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 May 2020 07:29:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id e1so6501743wrt.5
        for <cgroups@vger.kernel.org>; Wed, 13 May 2020 04:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3llE+hJQ+seqQFgq9zbLo0/0zK+SZ7WYVbm/5bG7H5M=;
        b=uXlXhF9ym+yZE2DUzQ7OdxF5ITSccryfN+EKYYouP3RxwlIRHkG/gA9aQnkW1wmqLc
         +kP87br/Xy8kqB5Q9B5aqSm8eHEx7Ly7uR+ta70nGCe+iKAMNvWGiaqQdxutxm95otYW
         pVPwf0tq3Y7mOOwLCyrS739Knj5YfUe539HF2FrartnoV7QkB/jES5iTpv7oV77OnD3b
         7k+0Fk9RvQrSOL6ejvBofuqHkVY7+8mV9At9gRRf+/Glnul8FWEhHn3SLnDRwJmFckIM
         QI+c+UTvw6Wr0sGWIUnwRLCN4jg6/mv8h07yYUSBlZg+0LUGF9kPhsMKeK6EapgpyExW
         CjgQ==
X-Gm-Message-State: AGi0Puawke3tzrrLoitFcIP3h7u+vgAKeta17yOrEIrSkHCH2brrPjVT
        kwpyiGdPBVq2XnTWb/uZAZxdH6oI
X-Google-Smtp-Source: APiQypIiTrg/yulPCYukZyBiZi2cwVpwClkPUU7J/CdQK1ygG8GD0tqOE20B9KXNTAgAcRSED3sVgA==
X-Received: by 2002:adf:a704:: with SMTP id c4mr29943798wrd.303.1589369347321;
        Wed, 13 May 2020 04:29:07 -0700 (PDT)
Received: from localhost (ip-37-188-249-36.eurotel.cz. [37.188.249.36])
        by smtp.gmail.com with ESMTPSA id s15sm1341951wro.80.2020.05.13.04.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 04:29:06 -0700 (PDT)
Date:   Wed, 13 May 2020 13:29:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Zefan Li <lizefan@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] memcg: Fix memcg_kmem_bypass() for remote memcg charging
Message-ID: <20200513112905.GX29153@dhcp22.suse.cz>
References: <e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com>
 <20200513090502.GV29153@dhcp22.suse.cz>
 <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[Cc Roman - initial email is http://lkml.kernel.org/r/e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com]

On Wed 13-05-20 19:19:56, Li Zefan wrote:
> On 2020/5/13 17:05, Michal Hocko wrote:
> > On Wed 13-05-20 15:28:28, Li Zefan wrote:
> >> While trying to use remote memcg charging in an out-of-tree kernel module
> >> I found it's not working, because the current thread is a workqueue thread.
> >>
> >> Signed-off-by: Zefan Li <lizefan@huawei.com>
> >> ---
> >>
> >> No need to queue this for v5.7 as currently no upstream users of this memcg
> >> feature suffer from this bug.
> >>
> >> ---
> >>  mm/memcontrol.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index a3b97f1..db836fc 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -2802,6 +2802,8 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
> >>  
> >>  static inline bool memcg_kmem_bypass(void)
> >>  {
> >> +	if (unlikely(current->active_memcg))
> >> +		return false;
> > 
> > I am confused. Why the check below is insufficient? It checks for both mm
> > and PF_KTHREAD?
> > 
> 
> memalloc_use_memcg(memcg);
> alloc_page(GFP_KERNEL_ACCOUNT);
> memalloc_unuse_memcg();
> 
> If we run above code in a workqueue thread the memory won't be charged to the specific
> memcg, because memcg_kmem_bypass() returns true in this case.

Ohh, right I have misread your patch. Sorry about that. A comment for
the above branch would make it more clear. Something like
	/* Allow memalloc_use_memcg usage from kthread contexts */

On the other hand adding a code for an out of tree code is usually not
welcome. But in this particular case the branch is correct for the
existing code already so I am OK with it. Roman is de-facto kmem
implementation maintainer so I will defer to him.

> >>  	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
> >>  		return true;
> >>  	return false;

-- 
Michal Hocko
SUSE Labs
