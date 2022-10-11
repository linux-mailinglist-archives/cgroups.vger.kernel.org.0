Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120ED5FBAF1
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 21:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiJKTCI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 15:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiJKTB2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 15:01:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447DE8A1DE;
        Tue, 11 Oct 2022 12:01:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 828581F37C;
        Tue, 11 Oct 2022 19:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665514881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w1Wip/kR/nLx7NLOcIVQ++U0LbZfFaHpu0ZiHUekL6M=;
        b=r0pi3DBSDiAet5rHRn6FCp5z5UxtoxqnvqLG4J56c9yiBSUM+770wvzqJwNB5kNiRUa1IZ
        shbQchCLgt2qSnnrrkvPeyFYQoKrHIwkovCmtVRT2LFUY6Zyvf0AC2axO2N9Sf/+3Dimv2
        LBdTVAi9D5F06aQWnvV/8tU8HTcuo6M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5220E139ED;
        Tue, 11 Oct 2022 19:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9NrHEYG9RWN2PwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 11 Oct 2022 19:01:21 +0000
Date:   Tue, 11 Oct 2022 21:01:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH] mm/memcontrol: Don't increase effective low/min if no
 protection needed
Message-ID: <Y0W9gHblrima2tDd@dhcp22.suse.cz>
References: <20221011143015.1152968-1-longman@redhat.com>
 <Y0WOPZxWSnUjzZ8e@dhcp22.suse.cz>
 <defdb421-342e-ebcb-d7f0-005559dd1e0d@redhat.com>
 <Y0WiIDmPPXYZuHpX@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0WiIDmPPXYZuHpX@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 11-10-22 07:04:32, Tejun Heo wrote:
> On Tue, Oct 11, 2022 at 01:00:22PM -0400, Waiman Long wrote:
> > You are right about that. An alternative way to address this issue is to
> > disable memory low event when memory.low isn't set. An user who want to
> > track memory.low event has to set it to a non-zero value. Would that be
> > acceptable?
> 
> Wouldn't it make sense to fix the test? With recursive_prot on, the cgroup
> actually is under low protection and it seems like the correct behavior is
> to report the low events accordingly.

Agreed, the semantic makes sense and it seems to be just the test that
is not aware of it.
-- 
Michal Hocko
SUSE Labs
