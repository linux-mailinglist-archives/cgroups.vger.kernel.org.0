Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4AE779E37
	for <lists+cgroups@lfdr.de>; Sat, 12 Aug 2023 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjHLIfz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Aug 2023 04:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLIfy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Aug 2023 04:35:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC3A2684;
        Sat, 12 Aug 2023 01:35:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BCC70218BB;
        Sat, 12 Aug 2023 08:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691829356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJlNOetLP1c9ycAs8A2815lzssMFUEbIER+s4cVzY7E=;
        b=Q1+SdD1ePlUyb5K2u8qRDaFYuWyq/npUtKZ0updc2Xp53oigEoqFdP8xFNrUnUqJzJ99d1
        0bPDafZq9D7cNg35IFIT7/x7xYHr66y8z9sErgoHA+2MUz+aJHu19MOl99fZq+uGhCbQFj
        nekk1FHEBzMfi59qcazL2CbPzmKrQY0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9678213357;
        Sat, 12 Aug 2023 08:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZBf0IWxE12TmGwAAMHmgww
        (envelope-from <mhocko@suse.com>); Sat, 12 Aug 2023 08:35:56 +0000
Date:   Sat, 12 Aug 2023 10:35:55 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
Message-ID: <ZNdEaw2nktq1NfmH@dhcp22.suse.cz>
References: <CAJD7tkZFxbjas=VfhYSGU84Y5vyjuqHqGsRjiDEOSDWh2BxNAg@mail.gmail.com>
 <ZNYnx9NqwSsXKhX3@dhcp22.suse.cz>
 <CAJD7tkbJ1fnMDudtsS2xubKn0RTWz7t0Hem=PSRQQp3sGf-iOw@mail.gmail.com>
 <ZNaLGVUtPu7Ua/jL@dhcp22.suse.cz>
 <CAJD7tkbF1tNi8v0W4Mnqs0rzpRBshOFepxFTa1SiSvmBEBUEvw@mail.gmail.com>
 <CALvZod55S3XeK-MquTq0mDuipq8j0vFymQeX_XnPb_HuPK+oGQ@mail.gmail.com>
 <CAJD7tkYZxjAHrodVDK=wmz-sULJrq2VhC_5ecRP7T-KiaOcTuw@mail.gmail.com>
 <CALvZod46Cz_=5UgiyAKM+VgKyk=KJCqDqXu91=9uHy7-2wk53g@mail.gmail.com>
 <CAJD7tkY-ezyYebvcs=8Z_zrw2UVW8jf2WvP1G8tu2rT=2sMnAA@mail.gmail.com>
 <CALvZod5fH9xu_+6x85K38f63GfKGWD1LqtD2R4d09xmDtLB7ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvZod5fH9xu_+6x85K38f63GfKGWD1LqtD2R4d09xmDtLB7ew@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 11-08-23 19:48:14, Shakeel Butt wrote:
> On Fri, Aug 11, 2023 at 7:36 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Fri, Aug 11, 2023 at 7:29 PM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Fri, Aug 11, 2023 at 7:12 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > [...]
> > > >
> > > > I am worried that writing to a stat for flushing then reading will
> > > > increase the staleness window which we are trying to reduce here.
> > > > Would it be acceptable to add a separate interface to explicitly read
> > > > flushed stats without having to write first? If the distinction
> > > > disappears in the future we can just short-circuit both interfaces.
> > >
> > > What is the acceptable staleness time window for your case? It is hard
> > > to imagine that a write+read will always be worse than just a read.
> > > Even the proposed patch can have an unintended and larger than
> > > expected staleness window due to some processing on
> > > return-to-userspace or some scheduling delay.
> >
> > Maybe I am worrying too much, we can just go for writing to
> > memory.stat for explicit stats refresh.
> >
> > Do we still want to go with the mutex approach Michal suggested for
> > do_flush_stats() to support either waiting for ongoing flushes
> > (mutex_lock) or skipping (mutex_trylock)?
> 
> I would say keep that as a separate patch.

Separate patches would be better but please make the mutex conversion
first. We really do not want to have any busy waiting depending on a
sleep exported to the userspace. That is just no-go.

Thanks!
-- 
Michal Hocko
SUSE Labs
