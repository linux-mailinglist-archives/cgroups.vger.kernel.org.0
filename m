Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98015A5CA1
	for <lists+cgroups@lfdr.de>; Tue, 30 Aug 2022 09:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiH3HMx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Aug 2022 03:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiH3HMw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Aug 2022 03:12:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5FEAE208;
        Tue, 30 Aug 2022 00:12:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8A9EA21D09;
        Tue, 30 Aug 2022 07:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661843569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eNLXbzHMzQQl1S+F8MG5tq68Rc2DBXxOVacQ+xIc0Yc=;
        b=Y/SIOnqS5qw04flbBT0UNoziQh4DL76iydFlVllZY+A0CuuiymDctwvPAVb0iymIopbpe6
        KWyit2vQ1FPjzGG9nhgthU0208gtfTPsZ9XcW/V8t71kobfUGPIF+eiPIJinYYrhCvFyX5
        qDDPWjg5H/fGrgXOVU/fO5Q+N/WngCo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B9D413ACF;
        Tue, 30 Aug 2022 07:12:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8VW6F3G4DWNXLwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 30 Aug 2022 07:12:49 +0000
Date:   Tue, 30 Aug 2022 09:12:48 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kairui Song <ryncsn@gmail.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: memcontrol: remove mem_cgroup_kmem_disabled
Message-ID: <Yw24cFGTtOZF7Cgw@dhcp22.suse.cz>
References: <20220830055949.12640-1-ryncsn@gmail.com>
 <20220830055949.12640-2-ryncsn@gmail.com>
 <Yw2x6T3xchjpzX7j@dhcp22.suse.cz>
 <CAMgjq7A+Ju247rC7+fo9jcZpK8rkd0Ou6e=7qzgL4rV3JWBX5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7A+Ju247rC7+fo9jcZpK8rkd0Ou6e=7qzgL4rV3JWBX5w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 30-08-22 15:06:57, Kairui Song wrote:
> Michal Hocko <mhocko@suse.com> 于2022年8月30日周二 14:45写道：
> >
> > On Tue 30-08-22 13:59:48, Kairui Song wrote:
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > There are currently two helpers for checking if cgroup kmem
> > > accounting is enabled:
> > >
> > > - mem_cgroup_kmem_disabled
> > > - memcg_kmem_enabled
> >
> > Yes, this is a bit confusing indeed!
> >
> > > mem_cgroup_kmem_disabled is a simple helper that returns true if
> > > cgroup.memory=nokmem is specified, otherwise returns false.
> > >
> > > memcg_kmem_enabled is a bit different, it returns true if
> > > cgroup.memory=nokmem is not specified and there is at least one
> > > non-root cgroup ever created. And once there is any non-root memcg
> > > created, it won't go back to return false again.
> > >
> > > This may help improve performance for some corner use cases where
> > > the user enables memory cgroup and kmem accounting globally but never
> > > create any cgroup.
> > >
> > > Considering that corner case is rare, especially nowadays cgroup is
> > > widely used as a standard way to organize services.
> >
> > Is it really that rare? Most configurations would use a default setup, so
> > both MEMCG enabled and without nokmem on cmd line yet the memory
> > controller is not enabled in their setups.
> 
> Actually I don't have too much confidence saying that as well... but
> AFAIK, almost all distros will create a few sub cgroup on boot by the
> init (eg. openrc, finit, systemd).

Yeah, but do they enable the memory controller as well? Unless I am
missing something this will require at least one memcg enabled cgroup to
be created.

-- 
Michal Hocko
SUSE Labs
