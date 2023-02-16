Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AF9698E3E
	for <lists+cgroups@lfdr.de>; Thu, 16 Feb 2023 09:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBPIEI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Feb 2023 03:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBPIEH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Feb 2023 03:04:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1C71DB90;
        Thu, 16 Feb 2023 00:04:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 650EF21D48;
        Thu, 16 Feb 2023 08:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676534644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wWVDnYphOY4/7fmH3HtlQ3zoNYKaqCMgj+iYz5wiHqU=;
        b=TOnrT1930l8Lkgcu/NBbAhRjWZKg7qA7CFIiJ9f3jgXUEgDo5jvDmei89J+mww7boTXZ30
        7QV8xIJb/uirR4slpBrNXVEEZU8UdA0D1kKGj/L4LbcKjRzRhgLsw9eU+Pj6PDqovzgV1d
        1u/+saHPl+mKURI1P8vdfypAvyKOduw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41D18139B5;
        Thu, 16 Feb 2023 08:04:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o2zbDXTj7WNXAwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 16 Feb 2023 08:04:04 +0000
Date:   Thu, 16 Feb 2023 09:04:03 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Tejun Heo <tj@kernel.org>, Yosry Ahmed <yosryahmed@google.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y+3jcw9vo4ml5p0M@dhcp22.suse.cz>
References: <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
 <Y+Fttp1ozejoSQzl@slm.duckdns.org>
 <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
 <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org>
 <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
 <Y+GMbWWP/YhtJQqe@slm.duckdns.org>
 <Y+GQB9I6MFN6BOFw@nvidia.com>
 <Y+GcJQRhvjqFaaSp@mtj.duckdns.org>
 <Y+0rxoM4w9nilUMZ@dhcp22.suse.cz>
 <Y+0tWZxMUx/NZ3Ne@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+0tWZxMUx/NZ3Ne@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 15-02-23 15:07:05, Jason Gunthorpe wrote:
> On Wed, Feb 15, 2023 at 08:00:22PM +0100, Michal Hocko wrote:
> > On Mon 06-02-23 14:32:37, Tejun Heo wrote:
> > > Hello,
> > > 
> > > On Mon, Feb 06, 2023 at 07:40:55PM -0400, Jason Gunthorpe wrote:
> > > > (a) kind of destroys the point of this as a sandboxing tool
> > > > 
> > > > It is not so harmful to use memory that someone else has been charged
> > > > with allocating.
> > > > 
> > > > But it is harmful to pin memory if someone else is charged for the
> > > > pin. It means it is unpredictable how much memory a sandbox can
> > > > actually lock down.
> > > > 
> > > > Plus we have the double accounting problem, if 1000 processes in
> > > > different cgroups open the tmpfs and all pin the memory then cgroup A
> > > > will be charged 1000x for the memory and hit its limit, possibly
> > > > creating a DOS from less priv to more priv
> > > 
> > > Let's hear what memcg people think about it. I'm not a fan of disassociating
> > > the ownership and locker of the same page but it is true that actively
> > > increasing locked consumption on a remote cgroup is awkward too.
> > 
> > One thing that is not really clear to me is whether those pins do
> > actually have any "ownership".
> 
> In most cases the ownship traces back to a file descriptor. When the
> file is closed the pin goes away.

This assumes a specific use of {un}pin_user_page*, right? IIUC the
cgroup charging is meant to be used from vm_account but that doesn't
really tell anything about the lifetime nor the ownership. Maybe this is
just a matter of documentation update...

> > The interface itself doesn't talk about
> > anything like that and so it seems perfectly fine to unpin from a
> > completely different context then pinning. 
> 
> Yes, concievably the close of the FD can be in a totally different
> process with a different cgroup.

Wouldn't you get an unbalanced charges then? How can admin recover that
situation?

> > If there is no enforcement then Tejun is right and relying on memcg
> > ownership is likely the only reliable way to use for tracking. The
> > downside is sharing obviously but this is the same problem we
> > already do deal with with shared pages.
> 
> I think this does not work well because the owner in a memcg sense is
> unrelated to the file descriptor which is the true owner.
> 
> So we can get cases where the pin is charged to the wrong cgroup which
> is effectively fatal for sandboxing, IMHO.

OK, I see. This makes it really much more complicated then.
 
> > Another thing that is not really clear to me is how the limit is
> > actually going to be used in practice. As there is no concept of a
> > reclaim for pins then I can imagine that it would be quite easy to
> > reach the hard limit and essentially DoS any further use of pins. 
> 
> Yes, that is the purpose. It is to sandbox pin users to put some limit
> on the effect they have on the full machine.
> 
> It replaces the rlimit mess that was doing the same thing.

arguably rlimit has a concept of the owner at least AFAICS. I do realize
this is not really great wrt a high level resource control though.

> > Cross cgroup pinning would make it even worse because it could
> > become a DoS vector very easily. Practically speaking what tends to
> > be a corner case in the memcg limit world would be norm for pin
> > based limit.
> 
> This is why the cgroup charged for the pin must be tightly linked to
> some cgroup that is obviously connected to the creator of the FD
> owning the pin.

The problem I can see is that the fd is just too fluid for tracking. You
can pass fd over to a different cgroup context and then all the tracking
just loses any trail to an owner.

I can see how the underlying memcg tracking information is not really
feasible for your usecases but I am really worried that it is just too
easy to misaccount without any other proper ownership tracking.
-- 
Michal Hocko
SUSE Labs
