Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A6759F487
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 09:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiHXHuu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 03:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbiHXHut (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 03:50:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2BF71725;
        Wed, 24 Aug 2022 00:50:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D03F22A95;
        Wed, 24 Aug 2022 07:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661327447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2rJGzyr6oBy1qZU+/Zk1WI1GzB9DJpRteFyAPs6b7+4=;
        b=aMpZJpSL0j6SHbTDLQ9uRdArJgkx43RjfuH7hwtRw5n6vNQ3s8Ksrlvx5uuKQVPSC1A6Ib
        aF/ioA5POXxE1vBpJgNBih8LLL1jAxoYIyGYPDkBWO6+ygJk+ZxL+91eD9+SH8iYwkOjf3
        tKWHh1l4GA4mkpVbkI0P6UC/O0Q9nzM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D19913AC0;
        Wed, 24 Aug 2022 07:50:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 60D7D1fYBWOIVQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 24 Aug 2022 07:50:47 +0000
Date:   Wed, 24 Aug 2022 09:50:46 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [RFC PATCH] memcg: use root_mem_cgroup when css is inherited
Message-ID: <YwXYVjRpXQjQMsxr@dhcp22.suse.cz>
References: <CALvZod7QdLSMdBoD2WztL72qS8kJe7F79JuCH6t19rRcw6Pn1w@mail.gmail.com>
 <Yv/EArPDTcCrGqJh@slm.duckdns.org>
 <YwNpI1ydy0yDnBH0@dhcp22.suse.cz>
 <CAGWkznEB+R0YBaBFBL7dPqs8R=qKC6+ixTWEGCYy2PaczXkaPA@mail.gmail.com>
 <YwRjyx6wFLk8WTDe@dhcp22.suse.cz>
 <CAGWkznGaYTv4u4kOo-rupfyWzDNJXNKTchwP6dbUK-=UXWm47w@mail.gmail.com>
 <YwSQ4APOu/H7lYGL@dhcp22.suse.cz>
 <CAGWkznGd6mgareABseMKY5p0f1=5dkfVkj=NS7_B6OkXBYSwyw@mail.gmail.com>
 <YwS/S9Sd1OWnT81Q@dhcp22.suse.cz>
 <CAGWkznGYLyF+njUB0gFF3JVdThnK9JaNsqxXYFhbdSwEQpCxvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznGYLyF+njUB0gFF3JVdThnK9JaNsqxXYFhbdSwEQpCxvA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 24-08-22 10:23:14, Zhaoyang Huang wrote:
> On Tue, Aug 23, 2022 at 7:51 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > One way to achieve that would be shaping the hierarchy the following way
> >             root
> >         /         \
> > no_memcg[1]      memcg[2]
> > ||||||||         |||||
> > app_cgroups     app_cgroups
> >
> > with
> > no_memcg.subtree_control = ""
> > memcg.subtree_control = memory
> >
> > no?
> According to my understanding, No as there will be no no_memcg. All
> children groups under root would have its cgroup.controllers = memory
> as long as root has memory enabled.

Correct

> Under this circumstance, all
> descendants group under 'no_memcg' will charge memory to its parent
> group.

Correct. And why is that a problem? I thought you main concern was a per
application LRUs. With the above configuration all app_cgroups which do
not require an explicit memory control will share the same (no_memcg)
LRU and they will be aged together.
-- 
Michal Hocko
SUSE Labs
