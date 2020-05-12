Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC9C1D0349
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2020 01:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbgELX6S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 May 2020 19:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELX6R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 May 2020 19:58:17 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E1FC061A0E
        for <cgroups@vger.kernel.org>; Tue, 12 May 2020 16:58:17 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id a4so4125293qvj.3
        for <cgroups@vger.kernel.org>; Tue, 12 May 2020 16:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yD3a12+euav5lEzQ2eD5g0W71Fdr+4HWLSF5wAq+Di4=;
        b=NCtjCiXdpUxrD3bLzlXKjxlXGtB+pIewyDmhQ6NgTrKvEBiiAO3l064DUq0chV8UqU
         3wB2OBgRQ9Iht75ymMDaei3StnLtfND5OXchaakbk/r7q/N8ILNzEior35O7K8va4vj+
         BMOiB9k3rO9/RspupD8JjBww3kCaa3IQrVCaRw2F0BIkSgdnctCS9PhcekAiHzOzBLkr
         nEry2gYpIjfwV5M6ajTLYZLme6Jsn+kCR4KMcN0MXVdjQ+LvwvTXQ0r55weM0847xzkz
         Mheh2jC4iUU31tpYcrbMBSe8SsSJO3QT5fBSmT+HjN6JfSS/rHlRsDS7n8JNyjTZLX8L
         ZRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yD3a12+euav5lEzQ2eD5g0W71Fdr+4HWLSF5wAq+Di4=;
        b=Pl0/gzhGhf/rfTtOqDELjefY2PVu/3betlwHQENC4GhU6zXjk+Rd3gLOUPdXEU3KXz
         l7Jl51aSgcMvo3mIENEETYM7HfJy6Y7T9i7xPNcoJlTkjVJdD98rtBuFhqGypc8Fnl8v
         vmhVjor/15ZhWfLu580QiLFpPS28wIZx0VJWu+iSZEgeEJPB+adsi3Q8iAwONAHh2d+2
         uaMFuBxZ9ffnSTSOk15/INKdj7iGAYI7QWhqFun1aLHX4aEhjpIhDBF4oO1+h7wtms8R
         RiAHAdbrI6hfqkaQKxL3PnPqBUp7KN2bQpCqaGTG4doPiONh74U7uNOI2hAqIoRwdMWd
         bpsw==
X-Gm-Message-State: AGi0PuafoG5f4ycOzfsf/uIXCg70nxLkQDNhfK7vAjE6h6wg+y6bVHCK
        ga0qVvUN41/F+5VGYISB4oSkow==
X-Google-Smtp-Source: APiQypLQc2IzguaIlxfjV2xEQaPP5JANj3ncXax4B/oEnympCQO03p058pVnDRHNNYvdeA4bh4hL0w==
X-Received: by 2002:ad4:42b1:: with SMTP id e17mr23319979qvr.149.1589327896644;
        Tue, 12 May 2020 16:58:16 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j11sm11834028qkk.33.2020.05.12.16.58.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 16:58:15 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 12/19] mm: memcontrol: convert anon and file-thp to new
 mem_cgroup_charge() API
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200512215813.GA487759@cmpxchg.org>
Date:   Tue, 12 May 2020 19:58:14 -0400
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, Linux-MM <linux-mm@kvack.org>,
        cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <25270BAD-CB7E-4E92-96BA-740690744DBA@lca.pw>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
 <20200508183105.225460-13-hannes@cmpxchg.org>
 <45AA36A9-0C4D-49C2-BA3C-08753BBC30FB@lca.pw>
 <20200512215813.GA487759@cmpxchg.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On May 12, 2020, at 5:58 PM, Johannes Weiner <hannes@cmpxchg.org> =
wrote:
>=20
> On Tue, May 12, 2020 at 10:38:54AM -0400, Qian Cai wrote:
>>> On May 8, 2020, at 2:30 PM, Johannes Weiner <hannes@cmpxchg.org> =
wrote:
>>>=20
>>> With the page->mapping requirement gone from memcg, we can charge =
anon
>>> and file-thp pages in one single step, right after they're =
allocated.
>>>=20
>>> This removes two out of three API calls - especially the tricky =
commit
>>> step that needed to happen at just the right time between when the
>>> page is "set up" and when it's "published" - somewhat vague and =
fluid
>>> concepts that varied by page type. All we need is a freshly =
allocated
>>> page and a memcg context to charge.
>>>=20
>>> v2: prevent double charges on pre-allocated hugepages in khugepaged
>>>=20
>>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>>> Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>>> ---
>>> include/linux/mm.h      |  4 +---
>>> kernel/events/uprobes.c | 11 +++--------
>>> mm/filemap.c            |  2 +-
>>> mm/huge_memory.c        |  9 +++------
>>> mm/khugepaged.c         | 35 ++++++++++-------------------------
>>> mm/memory.c             | 36 ++++++++++--------------------------
>>> mm/migrate.c            |  5 +----
>>> mm/swapfile.c           |  6 +-----
>>> mm/userfaultfd.c        |  5 +----
>>> 9 files changed, 31 insertions(+), 82 deletions(-)
>> []
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>=20
>>> @@ -1198,10 +1193,11 @@ static void collapse_huge_page(struct =
mm_struct *mm,
>>> out_up_write:
>>> 	up_write(&mm->mmap_sem);
>>> out_nolock:
>>> +	if (*hpage)
>>> +		mem_cgroup_uncharge(*hpage);
>>> 	trace_mm_collapse_huge_page(mm, isolated, result);
>>> 	return;
>>> out:
>>> -	mem_cgroup_cancel_charge(new_page, memcg);
>>> 	goto out_up_write;
>>> }
>> []
>>=20
>> Some memory pressure will crash this new code. It looks like somewhat =
racy.
>>=20
>> if (!page->mem_cgroup)
>>=20
>> where page =3D=3D NULL in mem_cgroup_uncharge().
>=20
> Thanks for the report, sorry about the inconvenience.
>=20
> Hm, the page is exclusive at this point, nobody else should be
> touching it. After all, khugepaged might reuse the preallocated page
> for another pmd if this one fails to collapse.
>=20
> Looking at the code, I think it's page itself that's garbage, not
> page->mem_cgroup changing. If you have CONFIG_NUMA and the allocation
> fails, *hpage could contain an ERR_PTR instead of being NULL.
>=20
> I think we need the following fixlet:

Yes, I have NUMA here.

Stephen, can you pick this up for first before Andrew has a chance to =
push out the next mmotm hopefully contain this fix?

https://lore.kernel.org/lkml/20200512215813.GA487759@cmpxchg.org/

>=20
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index f2e0a5e5cfbb..f6161e17da26 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1193,7 +1193,7 @@ static void collapse_huge_page(struct mm_struct =
*mm,
> out_up_write:
> 	up_write(&mm->mmap_sem);
> out_nolock:
> -	if (*hpage)
> +	if (!IS_ERR_OR_NULL(*hpage))
> 		mem_cgroup_uncharge(*hpage);
> 	trace_mm_collapse_huge_page(mm, isolated, result);
> 	return;
> @@ -1928,7 +1928,7 @@ static void collapse_file(struct mm_struct *mm,
> 	unlock_page(new_page);
> out:
> 	VM_BUG_ON(!list_empty(&pagelist));
> -	if (*hpage)
> +	if (!IS_ERR_OR_NULL(*hpage))
> 		mem_cgroup_uncharge(*hpage);
> 	/* TODO: tracepoints */
> }

