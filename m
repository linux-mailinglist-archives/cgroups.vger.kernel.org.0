Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FA579CF1F
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 13:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjILLD3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Sep 2023 07:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjILLD1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Sep 2023 07:03:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F2F9F;
        Tue, 12 Sep 2023 04:03:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4CB7F212AE;
        Tue, 12 Sep 2023 11:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694516601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PlNpuPSqWIqOE0DwsvfoNnsmeYOzW02ShwOmRdVvGGY=;
        b=MhPUvXVFP4OmyPGqhryRQRDMUAdVx6IyQ77oN9SuE0NTFREpi/Hr63l8a46k1tz1U6gLxS
        spIv8n4MmEY/r1mNnpLOYB6XQ9CYXFhXwTf5u7t1Eg6gr5jSeOSbdW+0fZMDkMZuCfz0OC
        TIHai/JH/h+g3ExVXULDJaSjK/ypAhI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B49A13A39;
        Tue, 12 Sep 2023 11:03:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ks1SDXlFAGUfaAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 12 Sep 2023 11:03:21 +0000
Date:   Tue, 12 Sep 2023 13:03:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] mm: memcg: let non-unified root stats flushes
 help unified flushes
Message-ID: <ZQBFeHxzO49gv987@dhcp22.suse.cz>
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-4-yosryahmed@google.com>
 <ZPXupwjewuLgksAI@dhcp22.suse.cz>
 <6tne52ip62ucev7nmnim3m7fhcydnwcytyxynrlxxgaf4cbqea@r4hec425izap>
 <ZPX6luPGqypp68+L@dhcp22.suse.cz>
 <hrpw2bjsrs3pzxympb7cz4nohyeztnxkmdtzbzlfdba6ugkken@dhcdbbbrv4fn>
 <CAJD7tkaHVtMiMYFocNiABuyhPcqt77gei0UeaDq4J7V-=tMFYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaHVtMiMYFocNiABuyhPcqt77gei0UeaDq4J7V-=tMFYA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 05-09-23 08:54:46, Yosry Ahmed wrote:
> On Tue, Sep 5, 2023 at 7:10 AM Michal Koutný <mkoutny@suse.com> wrote:
> >
> > On Mon, Sep 04, 2023 at 05:41:10PM +0200, Michal Hocko <mhocko@suse.com> wrote:
> > > So it also creates an undocumented but userspace visible behavior.
> > > Something that userspace might start depending on, right?
> >
> > Yes but -
> > - depending on undocumented behavior is a mistake,
> > - breaking the dependency would manifest (in the case I imagine) as a
> >   performance regression (and if there are some users, the future can
> >   allow them configuring periodic kernel flush to compensate for that).
> 
> I think I am missing something. This change basically makes userspace
> readers (for the root memcg) help out unified flushers, which are
> in-kernel readers (e.g. reclaim) -- not the other way around.
> 
> How would that create a userspace visible behavior that a dependency
> can be formed on? Users expecting reclaim to be faster right after
> reading root stats? I would guess that would be too flaky to cause a
> behavior that people can depend on tbh.

Flaky or not, it might cause behavior difference and a subtle one. I can
imagine nohz and similar workloads wanting to (ab)use this to reduce
kernel footprint. If we really need this then make it obvious in the
changelog at least.

-- 
Michal Hocko
SUSE Labs
