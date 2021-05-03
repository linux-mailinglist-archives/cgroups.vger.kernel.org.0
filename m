Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8634C371933
	for <lists+cgroups@lfdr.de>; Mon,  3 May 2021 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhECQZe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 May 2021 12:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhECQZe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 May 2021 12:25:34 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C972C061761
        for <cgroups@vger.kernel.org>; Mon,  3 May 2021 09:24:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s25so7534331lji.0
        for <cgroups@vger.kernel.org>; Mon, 03 May 2021 09:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TcATYEvqWtFfx/44txhT0Spsn4kumnm2+a2rXW71+CM=;
        b=Eaj4rKKhZajb/S9uMXpRE9KCEfy5HuJE+EtOo+Se6CW6ZyQY6bjKa68nq45phIbM8c
         9TspWHri3VmH+anix1LFL9doASiwyNTqks3Vv/7hIOtmUu9iGOYIp1pDR+mJj140dErP
         2zdwQ4ZzQCYdtRvlXSW3nT+Oui+b+dcaeR9qAq78qteAVIv+oBCqxsjuJawt+JhI0XDR
         WSEvmIiMehxJm2M0t2lllY238waLTBfzWXMAcWNGZzTHFzl8495jjZshk4PXeB+VzL88
         D/Yv7r5Rda77+oUmHrJMYIxfK2ANAzAvW5iNyhVv2B933abB++3JB+BeSQFVVtKcg//l
         P0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcATYEvqWtFfx/44txhT0Spsn4kumnm2+a2rXW71+CM=;
        b=afXiT2haigsL4+uXv+lMnKw8Nea6Lpq3qj6aKpz5b7UU5bQyJBgiu0xRSULQvYItCQ
         JxExNk5qiNDhoGHTeAaSsdKpyjHublqwRw1vYfoBG/JOOxfKRVOnBa1gCeBCrC3wwqDK
         V8T00VzabTavg7HuCheNYxFoDLxxbN+eugpHQnTRCyNw90YOkwp4nVmSwODWAJr9vvlZ
         4fUtpsw13jFMldUQH4KaHzvtJkbjK4BKPsVaz7SYrj008KB47q8HuZWcLfaglpRKHKHY
         dMoUCkbRIUZ605FKiG+t9tha+nFh0H9b35MPym78uIPvb2wgr/2WrLAwPDb1ceDXhTA0
         tuSw==
X-Gm-Message-State: AOAM530fOGq7vdOugVcESvT2XX3Een4N7u4ke68iFveYIfg6wXSupLKQ
        faEc2IwYOsnKcWI9TCvmcS6reSDxtwT2QwJh3+wTDw==
X-Google-Smtp-Source: ABdhPJxwOZF5GNeOtag2xfRjfFSTBwoX7sJqPEbEXnr+f2iHHA67gp9bI5NGIDNieGQOC7JQarf3LW+/cizq2fFp46k=
X-Received: by 2002:a2e:94d:: with SMTP id 74mr13275855ljj.122.1620059079137;
 Mon, 03 May 2021 09:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210502180755.445-1-longman@redhat.com> <20210502180755.445-2-longman@redhat.com>
 <699e5ac8-9044-d664-f73f-778fe72fd09b@suse.cz> <4c90cf79-9c61-8964-a6fd-2da087893339@redhat.com>
 <d767ff72-711d-976c-d897-9cea0375c827@suse.cz>
In-Reply-To: <d767ff72-711d-976c-d897-9cea0375c827@suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 3 May 2021 09:24:28 -0700
Message-ID: <CALvZod4aW0P2a5ZG4JO4YH2oQ8a1kM9_Tsjz-tAGP_-9hLyOpw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: memcg/slab: Don't create unfreeable slab
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Waiman Long <llong@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 3, 2021 at 8:32 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 5/3/21 4:20 PM, Waiman Long wrote:
> > On 5/3/21 8:22 AM, Vlastimil Babka wrote:
> >> On 5/2/21 8:07 PM, Waiman Long wrote:
> >>> The obj_cgroup array (memcg_data) embedded in the page structure is
> >>> allocated at the first instance an accounted memory allocation happens.
> >>> With the right size object, it is possible that the allocated obj_cgroup
> >>> array comes from the same slab that requires memory accounting. If this
> >>> happens, the slab will never become empty again as there is at least one
> >>> object left (the obj_cgroup array) in the slab.
> >>>
> >>> With instructmentation code added to detect this situation, I got 76
> >>> hits on the kmalloc-192 slab when booting up a test kernel on a VM.
> >>> So this can really happen.
> >>>
> >>> To avoid the creation of these unfreeable slabs, a check is added to
> >>> memcg_alloc_page_obj_cgroups() to detect that and double the size
> >>> of the array in case it happens to make sure that it comes from a
> >>> different kmemcache.
> >>>
> >>> This change, however, does not completely eliminate the presence
> >>> of unfreeable slabs which can still happen if a circular obj_cgroup
> >>> array dependency is formed.
> >> Hm this looks like only a half fix then.
> >> I'm afraid the proper fix is for kmemcg to create own set of caches for the
> >> arrays. It would also solve the recursive kfree() issue.
> >
> > Right, this is a possible solution. However, the objcg pointers array should
> > need that much memory. Creating its own set of kmemcaches may seem like an
> > overkill.
>
> Well if we go that way, there might be additional benefits:
>
> depending of gfp flags, kmalloc() would allocate from:
>
> kmalloc-* caches that never have kmemcg objects, thus can be used for the objcg
> pointer arrays
> kmalloc-cg-* caches that have only kmemcg unreclaimable objects
> kmalloc-rcl-* and dma-kmalloc-* can stay with on-demand
> memcg_alloc_page_obj_cgroups()
>
> This way we fully solve the issues that this patchset solves. In addition we get
> better separation between kmemcg and !kmemcg thus save memory - no allocation of
> the array as soon as a single object appears in slab. For "kmalloc-8" we now
> have 8 bytes for the useful data and 8 bytes for the obj_cgroup  pointer.
>

Yes this seems like a better approach.
