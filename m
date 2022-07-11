Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B9D57083B
	for <lists+cgroups@lfdr.de>; Mon, 11 Jul 2022 18:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiGKQYk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Jul 2022 12:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGKQYj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Jul 2022 12:24:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA15B21835;
        Mon, 11 Jul 2022 09:24:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6D6542298F;
        Mon, 11 Jul 2022 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657556676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M+ZIKuMBKYf6iILzZp439lcSa19VN5bgrLR+ASf2Bx0=;
        b=TnIjaLMox+kOMiA7MSs9PGijGwpUTPR1Gp3apVzCIokhbYQ/jpXYrxi56aGQM93pgcazcV
        /fXxuL0Y8zRKuKpKzJVNuCn2/hUNZ3eSeR1pVnORgSH48LLn8wR6r1zBEi2S8rOeQAe8yr
        +9TNNW9znECSwf3bVawntAU3+i4U8l0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DE6482C141;
        Mon, 11 Jul 2022 16:24:35 +0000 (UTC)
Date:   Mon, 11 Jul 2022 18:24:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH mm v5 0/9] memcg: accounting for objects allocated by
 mkdir, cgroup
Message-ID: <YsxOwEI7HOqdkRpz@dhcp22.suse.cz>
References: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
 <0fe836b4-5c0f-0e32-d511-db816d359748@openvz.org>
 <c516033f-a9e4-3485-26d9-a68afa694c1d@openvz.org>
 <YrSP25ebDmXE+kPS@dhcp22.suse.cz>
 <CALvZod4WsmrpfZtfnP4AmvtnkvBRngXXGyhM6+aQzkdfjsinAQ@mail.gmail.com>
 <YrXDV7uPpmDigh3G@dhcp22.suse.cz>
 <CALvZod6U8DvMUcuUNfpQRwfkevQB7=nP4ZLA2gWGNf_JGdyARQ@mail.gmail.com>
 <Yr7Ukyy0vhBjebo4@dhcp22.suse.cz>
 <1a64fc6a-a33d-03f4-ec12-980e42148061@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a64fc6a-a33d-03f4-ec12-980e42148061@openvz.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun 10-07-22 21:53:34, Vasily Averin wrote:
> On 7/1/22 14:03, Michal Hocko wrote:
> > On Mon 27-06-22 09:37:14, Shakeel Butt wrote:
> >> On Fri, Jun 24, 2022 at 6:59 AM Michal Hocko <mhocko@suse.com> wrote:
> > [...]
> >>> Is it even possible to prevent from id
> >>> depletion by the memory consumption? Any medium sized memcg can easily
> >>> consume all the ids AFAICS.
> >>
> >> Though the patch series is pitched as protection against OOMs, I think
> >> it is beneficial irrespective. Protection against an adversarial actor
> >> should not be the aim here. IMO this patch series improves the memory
> >> association to the actual user which is better than unattributed
> >> memory treated as system overhead.
> > 
> > Considering the amount of memory and "normal" cgroup usage (I guess we
> > can agree that delegated subtrees do not count their cgroups in
> > thousands) is this really something that is worth bothering with?
> > 
> > I mean, these patches are really small and not really disruptive so I do
> > not really see any problem with them. Except that they clearly add a
> > maintenance overhead. Not directly with the memory they track but any
> > future cgroup/memcg metadata related objects would need to be tracked as
> > well and I am worried this will get quickly out of sync. So we will have
> > a half assed solution in place that doesn't really help any containment
> > nor it provides a good and robust consumption tracking.
> > 
> > All that being said I find these changes rather without a great value or
> > use.
> 
> Dear Michal,
> I sill have 2 questions:
> 1) if you do not want to account any memory allocated for cgroup objects,
> should you perhaps revert commit 3e38e0aaca9e "mm: memcg: charge memcg percpu
> memory to the parent cgroup". Is it an exception perhaps?
> (in fact I hope you will not revert this patch, I just would like to know 
> your explanations about this accounting)

Well, I have to say I was not a great fan of this patch when it was
proposed but I didn't really have strong arguments against it to nack
it. It was simple enough, rather self contained in few places. Just to
give you an insight into my thinking here. Your patchseries is also not
something I would nack (nor I have done that). I am not super fan of it
either. I voiced against it because it just hit my internal thrashold of
how many different places are patched without any systemic approach. If
we consider that it doesn't really help with the initial intention to
protect against adversaries then what is the point of all the churn?

Others might think differently and if you can get acks by other
maintainers then I won't stand in the way. I have voiced my concerns and
I hope my thinking is clear now.

> 2) my patch set includes kernfs accounting required for proper netdevices accounting
> 
> Allocs  Alloc   Allocation
> number  size
> --------------------------------------------
> 1   +  128      (__kernfs_new_node+0x4d)	kernfs node
> 1   +   88      (__kernfs_iattrs+0x57)		kernfs iattrs
> 1   +   96      (simple_xattr_alloc+0x28)	simple_xattr, can grow over 4Kb
> 1       32      (simple_xattr_set+0x59)
> 1       8       (__kernfs_new_node+0x30)
> 
>  2/9] memcg: enable accounting for kernfs nodes
>  3/9] memcg: enable accounting for kernfs iattrs
>  4/9] memcg: enable accounting for struct simple_xattr
> 
> What do you think about them? Should I resend them as a new separate patch set?

kernfs is not really my area so I cannot really comment on those.

-- 
Michal Hocko
SUSE Labs
