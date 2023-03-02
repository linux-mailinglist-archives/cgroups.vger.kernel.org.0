Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298876A82F3
	for <lists+cgroups@lfdr.de>; Thu,  2 Mar 2023 13:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCBM6L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Mar 2023 07:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCBM6H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Mar 2023 07:58:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5504F4FA87
        for <cgroups@vger.kernel.org>; Thu,  2 Mar 2023 04:57:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 68AED21DA6;
        Thu,  2 Mar 2023 12:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677761799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9dfdj+0VRA1atO5irS3WM17Vy2/MRKhULv8ZRzYg1B8=;
        b=obAnjgZcykCoUbbN6rN8SKlIpKGzcD1NSN1YK83PLumRG5PgrbmA/U6H+4pybKywOWd8SP
        LX4PO09z8ZWzd2sP1/uFyLeuFRQHYQjWv60IPVPnMwmmbogjKc7QG4UBUhTDSQMxG3hBrn
        pzwiLv0H0AUaIdaOdUeGuJsuBL7XeOk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AD1F13349;
        Thu,  2 Mar 2023 12:56:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1BfYCwedAGTAMAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 02 Mar 2023 12:56:39 +0000
Date:   Thu, 2 Mar 2023 13:56:38 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v5 2/6] mm/memcg: Disable threshold event handlers on
 PREEMPT_RT
Message-ID: <ZACdBuVBHZ/AMAh/@dhcp22.suse.cz>
References: <20220226204144.1008339-1-bigeasy@linutronix.de>
 <20220226204144.1008339-3-bigeasy@linutronix.de>
 <xhsmh4jr4pbzc.mognet@vschneid.remote.csb>
 <ZABUMit05SZBDXRQ@dhcp22.suse.cz>
 <xhsmh1qm7pibs.mognet@vschneid.remote.csb>
 <ZACHa4wrtwpQbmP2@dhcp22.suse.cz>
 <xhsmhy1ofnxna.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhy1ofnxna.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 02-03-23 12:30:33, Valentin Schneider wrote:
> On 02/03/23 12:24, Michal Hocko wrote:
> > On Thu 02-03-23 10:18:31, Valentin Schneider wrote:
> >> On 02/03/23 08:45, Michal Hocko wrote:
> >> > On Wed 01-03-23 18:23:19, Valentin Schneider wrote:
> > [...]
> >> >> I want cgroupv1 to die as much as the next person, but in that specific
> >> >> situation I kinda need cgroupv1 to behave somewhat sanely on RT with
> >> >> threshold events :/
> >> >
> >> > Could you expand on the usecase?
> >> >
> >>
> >> In this case it's just some middleware leveraging memcontrol cgroups and
> >> setting up callbacks for in-cgroup OOM events. This is a supported feature
> >> in cgroupv2, so this isn't a problem of cgroupv1 vs cgroupv2 feature
> >> parity, but rather one of being in a transitional phase where the
> >> middleware itself hasn't fully migrated to using cgroupv2.
> >
> > How is this related to the RT kernel config? memcg OOM vs any RT
> > assumptions do not really get along well AFAICT.
> >
> 
> Yep. AIUI the tasks actually relying on RT guarantees DTRT (at least
> regarding memory allocations, or lack thereof), but other non-RT-reliant
> tasks on other CPUs come and go, hence the memcg involvement.

So are you suggesting that the RT kernel is used for mixed bag of
workloads with RT and non RT assumptions? Is this really a reasonable
and reliable setup?

What I am trying to evaluate here is whether it makes sense to support
and maintain a non-trivial code for something that might be working
sub-optimally or even not working properly in some corner cases. The
price for the maintenance is certainly not free.
-- 
Michal Hocko
SUSE Labs
