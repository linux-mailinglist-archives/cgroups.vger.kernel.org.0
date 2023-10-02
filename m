Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7DB7B52CE
	for <lists+cgroups@lfdr.de>; Mon,  2 Oct 2023 14:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbjJBMSj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 08:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbjJBMSi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 08:18:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB369D;
        Mon,  2 Oct 2023 05:18:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 75102210E0;
        Mon,  2 Oct 2023 12:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696249112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tIkc8wpprjvNQ6XbejVFpwUcXLgpsEm5O3FIVv9vWWY=;
        b=rfXoQ7EGE9+npzmoeY7FfpoViXbIdglWC3ICWGVjx/3rw1XLefZngDRsNdIa+6Mj7wVuzz
        cVELoJKQ+CkG5mxIb8kxE3JJByLldqwmyXk84eqH7BMRB1EN/2+nob4t45C/5qEJbd8Fpa
        lzMwdkSfEqPsh48il+pJrqXEh/Fg4+8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A5F013434;
        Mon,  2 Oct 2023 12:18:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gak4Dxi1GmVrIQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 02 Oct 2023 12:18:32 +0000
Date:   Mon, 2 Oct 2023 14:18:31 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
        akpm@linux-foundation.org, riel@surriel.com,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
Message-ID: <ZRq1F4uKRSK2xLTY@dhcp22.suse.cz>
References: <20230928005723.1709119-1-nphamcs@gmail.com>
 <20230928005723.1709119-2-nphamcs@gmail.com>
 <CAJD7tkanr99d_Y=LefQTFsykyiO5oZpPUC=suD3P-L5eS=0SXA@mail.gmail.com>
 <CAKEwX=M=8KYqvBTz9z1csrsFUpGf2tgWj-oyu96dSpRjn3ZnUQ@mail.gmail.com>
 <CAKEwX=Npb4mwZ2ibJkmD5GyqXazr7PH8UGLu+YSDY8acf152Eg@mail.gmail.com>
 <CAJD7tkaeDBTHC3UM91O56yrp8oCU-UBO6i_5HJMjVBDQAw0ipQ@mail.gmail.com>
 <20230929150829.GA16353@cmpxchg.org>
 <CAJD7tkZ1NiMMvQhxGSGzsPqYfBpwzP6svPe17s2FTDoHY6jYWQ@mail.gmail.com>
 <20230929174221.GA19137@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230929174221.GA19137@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 29-09-23 13:42:21, Johannes Weiner wrote:
> On Fri, Sep 29, 2023 at 08:11:54AM -0700, Yosry Ahmed wrote:
> > On Fri, Sep 29, 2023 at 8:08 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Thu, Sep 28, 2023 at 06:18:19PM -0700, Yosry Ahmed wrote:
> > > > My concern is the scenario where the memory controller is mounted in
> > > > cgroup v1, and cgroup v2 is mounted with memory_hugetlb_accounting.
> > > >
> > > > In this case it seems like the current code will only check whether
> > > > memory_hugetlb_accounting was set on cgroup v2 or not, disregarding
> > > > the fact that cgroup v1 did not enable hugetlb accounting.
> > > >
> > > > I obviously prefer that any features are also added to cgroup v1,
> > > > because we still didn't make it to cgroup v2, especially when the
> > > > infrastructure is shared. On the other hand, I am pretty sure the
> > > > maintainers will not like what I am saying :)
> > >
> > > I have a weak preference.
> > >
> > > It's definitely a little weird that the v1 controller's behavior
> > > changes based on the v2 mount flag. And that if you want it as an
> > > otherwise exclusive v1 user, you'd have to mount a dummy v2.
> > >
> > > But I also don't see a scenario where it would hurt, or where there
> > > would be an unresolvable conflict between v1 and v2 in expressing
> > > desired behavior, since the memory controller is exclusive to one.
> > >
> > > While we could eliminate this quirk with a simple
> > > !cgroup_subsys_on_dfl(memory_cgrp_subsys) inside the charge function,
> > > it would seem almost punitive to add extra code just to take something
> > > away that isn't really a problem and could be useful to some people.
> > >
> > > If Tejun doesn't object, I'd say let's just keep implied v1 behavior.
> > 
> > I agree that adding extra code to take a feature away from v1 is
> > probably too much, but I also think relying on a v2 mount option is
> > weird. Would it be too much to just have a v1-specific flag as well
> > and use cgroup_subsys_on_dfl(memory_cgrp_subsys) to decide which flag
> > to read?
> 
> Yeah, let's not preemptively add explicit new features to cgroup1.
> 
> Since we agree the incidental support is weird, let's filter hugetlb
> charging on cgroup_subsys_on_dfl(memory_cgrp_subsys) after all.

Agreed. It would be a bad idea to have an implicit behavior change based
on v2 mounting options. And I really do not think we want to add this
feature to v1. I am not supper thrilled about enabling this for v2 to be
completely honest but I do see a demand so I will not object to that.
-- 
Michal Hocko
SUSE Labs
