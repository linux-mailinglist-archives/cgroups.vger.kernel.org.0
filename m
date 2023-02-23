Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09BF6A048C
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 10:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjBWJNU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Feb 2023 04:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjBWJNT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Feb 2023 04:13:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1BA35A5
        for <cgroups@vger.kernel.org>; Thu, 23 Feb 2023 01:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677143552;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=uwZaYUWCxFZTg3f1dH6MjHYdgF0IHgLHUPN7A+BCwIc=;
        b=RVgx7kppoQw7kqwC9fpDWLYFerIVfpdGesscA/7+1q+mMCx3lNCEM+VrryJCRgTXu9qEmA
        AdLzcw5t9zSQy/9Mz3U2c6to8ma7cscFl2FBwxNwoNFTL+uzPO268Evx0xHE9W3V8y832g
        TZLNvvjxRmWxVQCEDsaldSPbaA3pDAU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-ldKDf7H7OXWL4bvkUNpuzA-1; Thu, 23 Feb 2023 04:12:25 -0500
X-MC-Unique: ldKDf7H7OXWL4bvkUNpuzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2C8E800050;
        Thu, 23 Feb 2023 09:12:24 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.113])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF0F31121314;
        Thu, 23 Feb 2023 09:12:21 +0000 (UTC)
Date:   Thu, 23 Feb 2023 09:12:19 +0000
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alistair Popple <apopple@nvidia.com>, Tejun Heo <tj@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y/ct88JBeQuSmCuj@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <Y/T/bkcYc9Krw4rE@slm.duckdns.org>
 <Y/UEkNn0O65Pfi4e@nvidia.com>
 <Y/UIURDjR9pv+gzx@slm.duckdns.org>
 <Y/Ua6VcNe/DFh7X4@nvidia.com>
 <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
 <Y/UiQmuVwh2eqrfA@nvidia.com>
 <87o7pmnd0p.fsf@nvidia.com>
 <Y/YRJNwwvqp7nKKt@nvidia.com>
 <87k009nvnr.fsf@nvidia.com>
 <Y/bHNO7A8T3QQ5T+@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/bHNO7A8T3QQ5T+@nvidia.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 22, 2023 at 09:53:56PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 23, 2023 at 09:59:35AM +1100, Alistair Popple wrote:
> > 
> > Jason Gunthorpe <jgg@nvidia.com> writes:
> > 
> > > On Wed, Feb 22, 2023 at 10:38:25PM +1100, Alistair Popple wrote:
> > >> When a driver unpins a page we scan the pinners list and assign
> > >> ownership to the next driver pinning the page by updating memcg_data and
> > >> removing the vm_account from the list.
> > >
> > > I don't see how this works with just the data structure you outlined??
> > > Every unique page needs its own list_head in the vm_account, it is
> > > doable just incredibly costly.
> > 
> > The idea was every driver already needs to allocate a pages array to
> > pass to pin_user_pages(), and by necessity drivers have to keep a
> > reference to the contents of that in one form or another. So
> > conceptually the equivalent of:
> > 
> > struct vm_account {
> >        struct list_head possible_pinners;
> >        struct mem_cgroup *memcg;
> >        struct pages **pages;
> >        [...]
> > };
> > 
> > Unpinnig involves finding a new owner by traversing the list of
> > page->memcg_data->possible_pinners and iterating over *pages[] to figure
> > out if that vm_account actually has this page pinned or not and could
> > own it.
> 
> Oh, you are focusing on Tejun's DOS scenario. 
> 
> The DOS problem is to prevent a pin users in cgroup A from keeping
> memory charged to cgroup B that it isn't using any more.
> 
> cgroup B doesn't need to be pinning the memory, it could just be
> normal VMAs and "isn't using anymore" means it has unmapped all the
> VMAs.
> 
> Solving that problem means figuring out when every cgroup stops using
> the memory - pinning or not. That seems to be very costly.
> 
> AFAIK this problem also already exists today as the memcg of a page
> doesn't change while it is pinned. So maybe we don't need to address
> it.
> 
> Arguably the pins are not the problem. If we want to treat the pin
> like allocation then we simply charge the non-owning memcg's for the
> pin as though it was an allocation. Eg go over every page and if the
> owning memcg is not the current memcg then charge the current memcg
> for an allocation of the MAP_SHARED memory. Undoing this is trivial
> enoug.
> 
> This doesn't fix the DOS problem but it does sort of harmonize the pin
> accounting with the memcg by multi-accounting every pin of a
> MAP_SHARED page.
> 
> The other drawback is that this isn't the same thing as the current
> rlimit. The rlimit is largely restricting the creation of unmovable
> memory.
> 
> Though, AFAICT memcg seems to bundle unmovable memory (eg GFP_KERNEL)
> along with movable user pages so it would be self-consistent.
> 
> I'm unclear if this is OK for libvirt..

I'm not sure what exact scenario you're thinking of when talking
about two distinct cgroups and its impact on libvirt. None the less
here's a rough summary of libvirt's approach to cgroups and memory

On the libvirt side, we create 1 single cgroup per VM, in which lives
at least the QEMU process, but possibly some additional per-VM helper
processes (swtpm for TPM, sometimes slirp/passt for NIC, etc).

Potentially there are externally managed processes that are handling
some resources on behalf of the VM. These might be a single centralized
daemon handling work for many VMs, or might be per VM services. Either
way, since they are externally managed, their setup and usage of cgroups
is completely opaque to libvirt.

Libvirt is only concerned with the 1 cgroup per VM that it creates and
manages. Its goal is to protect the host OS from a misbehaving guest
OS/compromised QEMU.

The memory limits we can set on VMs are somewhat limited. In general
we prefer to avoid setting any hard per-VM memory cap by default.
QEMU's worst case memory usage is incredibly hard to predict, because
of an incredibly broad range of possible configurations and opaque
behaviour/usage from ELF libraries it uses. Every time anyone has
tried hard memory caps, we've ended up with VMs being incorrectly
killed because they genuinely wanted more memory than anticipated
by the algorithm.

To protect the host OS, I tend to suggest mgmt apps/admins set a
hard memory limit acrosss all VMs in aggregate eg at /machine.slice,
instead of per-VM. This aims to makes it possible to ensure that
the host OS always has some memory reserved for its own system
services, while allowing the individual VMs to battle it out
between themselves.

We do still have to apply some tuning for VFIO, around what amount
of memory it is allowed to lock, but that is not so bad as we just
need to allow it to lock guest RAM which is known + an finite extra
amount, so don't need to take account of all of QEMU's memory
allocations in general. This is all still just in context of 1
cgroup though, as least as far as libvirt is aware. Any other
cgroups involved are opaque to libvirt, and not our concern as long
as QEMU's cgroup is preventing QEMU's misbehaviour as configured.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

