Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E084D09D
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2019 16:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFTOoj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jun 2019 10:44:39 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45988 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfFTOoj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jun 2019 10:44:39 -0400
Received: by mail-yw1-f68.google.com with SMTP id m16so1262168ywh.12
        for <cgroups@vger.kernel.org>; Thu, 20 Jun 2019 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hkFAHTitPkfoSMrSNRMsrnAtfZq9o+iv5woQgM2GCxU=;
        b=thXTMTeTx0xXiZ9u/a78f4w6z2h57qLbhWVkhGpc5uU4+H4pPEGPk9N0YCZIJUb/U4
         TnuCUQ66JQqC0RvWoZCgR5L5jwqo76zVzKpMp8pXzP0t0CQ13sojAuWtJV7WnzKSCT2L
         TWtmySeyPfLwUziR7l0nrBHtk8fljJ+2ySjxfL+NG8AENzVWfMDj+iozng9mw4Awlsxa
         skqETBHwe+amhnj7vzDXN7JX46bW7xj9yy4+eq7BrRCQxowABoE0AiBdKbjHH05Jx41W
         5BmmPDMNbpX33eiLB6cDqnj9kFawoUkLCrF0p8UIYzkm0l8IfyFnL90oSO42R54TvW4k
         dHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkFAHTitPkfoSMrSNRMsrnAtfZq9o+iv5woQgM2GCxU=;
        b=VaqKKZ4xHf+G8cYaP0cUH+wxIc4bpd/VTYNie67ail9usbkvO1EA75TTSbye0E8LoR
         HwmYuxR5r1tLT8+C3gyFE5aOVC7qNLk/Vq3n7u2wYWdxcOVxe6jtIs57Wz614eHA5RjE
         H8xjVN4GdkUYypp7XEESUBwH19uspwFUAvZwF4ArKi4qkKzB1VC3hsH94nuFvcbDDVRt
         ECpM2u/B+wKGgPVkyb8iAXY8G+oTNbsSB3Yxu6mB+wF+hNep8vZTiY8RJA/iMRmHtdmo
         FavvFxH90oOwWIQcYYiodIp/4orcDZyLRW2nhJXomnk4xx2i7vhRnWXzJ+z632JQ1cZ1
         OsFw==
X-Gm-Message-State: APjAAAW3dSqUqbIqo9rCoyuaQ1g5TBRS+12deIv36Bhznw4blsyW8vMV
        Nh7lJ4QpkHMBKnDdpZG8fMx4FMBit30ukFNOvpgnjA==
X-Google-Smtp-Source: APXvYqx6zBr4fQkuPVHdnX/C78xgvMrTTDAZuq5i6MOjKE9DTzL7jnNL4Y6jb/qP1KrId0xDX5nVw5xKzMf3llYMevw=
X-Received: by 2002:a81:ae0e:: with SMTP id m14mr55624057ywh.308.1561041878378;
 Thu, 20 Jun 2019 07:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190619232514.58994-1-shakeelb@google.com> <20190620055028.GA12083@dhcp22.suse.cz>
In-Reply-To: <20190620055028.GA12083@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Jun 2019 07:44:27 -0700
Message-ID: <CALvZod4Fd5X91CzDLaVAvspQL-zoD7+9OGTiOro-hiMda=DqBA@mail.gmail.com>
Subject: Re: [PATCH] slub: Don't panic for memcg kmem cache creation failure
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 19, 2019 at 10:50 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 19-06-19 16:25:14, Shakeel Butt wrote:
> > Currently for CONFIG_SLUB, if a memcg kmem cache creation is failed and
> > the corresponding root kmem cache has SLAB_PANIC flag, the kernel will
> > be crashed. This is unnecessary as the kernel can handle the creation
> > failures of memcg kmem caches.
>
> AFAICS it will handle those by simply not accounting those objects
> right?
>

The memcg kmem cache creation is async. The allocation has already
been decided not to be accounted on creation trigger. If memcg kmem
cache creation is failed, it will fail silently and the next
allocation will trigger the creation process again.

> > Additionally CONFIG_SLAB does not
> > implement this behavior. So, to keep the behavior consistent between
> > SLAB and SLUB, removing the panic for memcg kmem cache creation
> > failures. The root kmem cache creation failure for SLAB_PANIC correctly
> > panics for both SLAB and SLUB.
>
> I do agree that panicing is really dubious especially because it opens
> doors to shut the system down from a restricted environment. So the
> patch makes sesne to me.
>
> I am wondering whether SLAB_PANIC makes sense in general though. Why is
> it any different from any other essential early allocations? We tend to
> not care about allocation failures for those on bases that the system
> must be in a broken state to fail that early already. Do you think it is
> time to remove SLAB_PANIC altogether?
>

That would need some investigation into the history of SLAB_PANIC. I
will look into it.

> > Reported-by: Dave Hansen <dave.hansen@intel.com>
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.
