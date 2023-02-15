Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E567F698405
	for <lists+cgroups@lfdr.de>; Wed, 15 Feb 2023 20:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjBOTA0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Feb 2023 14:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBOTAZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Feb 2023 14:00:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B9710D1;
        Wed, 15 Feb 2023 11:00:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E2D3339F6;
        Wed, 15 Feb 2023 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676487623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q9MXy991oBVRpb6GnqmhHyO0/qmV1r3htDajWMoxvQ8=;
        b=N4xQTAbnLwRgwCQBjoPceaeSqtRnnWbW+5RsHtICTCIb1hI+QHki5lvmgTmg7pCPj9dIQR
        iaSN8ZLQoHVJe4/wyfQ08g9RxB6WNH5UbkgmeTpMVKfK+xzG0RJivvxNMqOLX4xQp40mg6
        UrDutjEC4USYLM7FKMmUs5cGyW1fPbs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5ABF013483;
        Wed, 15 Feb 2023 19:00:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hwvgE8cr7WPffQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 15 Feb 2023 19:00:23 +0000
Date:   Wed, 15 Feb 2023 20:00:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y+0rxoM4w9nilUMZ@dhcp22.suse.cz>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
 <Y+Fttp1ozejoSQzl@slm.duckdns.org>
 <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
 <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org>
 <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
 <Y+GMbWWP/YhtJQqe@slm.duckdns.org>
 <Y+GQB9I6MFN6BOFw@nvidia.com>
 <Y+GcJQRhvjqFaaSp@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+GcJQRhvjqFaaSp@mtj.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 06-02-23 14:32:37, Tejun Heo wrote:
> Hello,
> 
> On Mon, Feb 06, 2023 at 07:40:55PM -0400, Jason Gunthorpe wrote:
> > (a) kind of destroys the point of this as a sandboxing tool
> > 
> > It is not so harmful to use memory that someone else has been charged
> > with allocating.
> > 
> > But it is harmful to pin memory if someone else is charged for the
> > pin. It means it is unpredictable how much memory a sandbox can
> > actually lock down.
> > 
> > Plus we have the double accounting problem, if 1000 processes in
> > different cgroups open the tmpfs and all pin the memory then cgroup A
> > will be charged 1000x for the memory and hit its limit, possibly
> > creating a DOS from less priv to more priv
> 
> Let's hear what memcg people think about it. I'm not a fan of disassociating
> the ownership and locker of the same page but it is true that actively
> increasing locked consumption on a remote cgroup is awkward too.

One thing that is not really clear to me is whether those pins do
actually have any "ownership". The interface itself doesn't talk about
anything like that and so it seems perfectly fine to unpin from a
completely different context then pinning. If there is no enforcement
then Tejun is right and relying on memcg ownership is likely the only
reliable way to use for tracking. The downside is sharing obviously but
this is the same problem we already do deal with with shared pages.

Another thing that is not really clear to me is how the limit is
actually going to be used in practice. As there is no concept of a
reclaim for pins then I can imagine that it would be quite easy to
reach the hard limit and essentially DoS any further use of pins. Cross
cgroup pinning would make it even worse because it could become a DoS
vector very easily. Practically speaking what tends to be a corner case
in the memcg limit world would be norm for pin based limit.

Or am I misunderstanding something here?
-- 
Michal Hocko
SUSE Labs
