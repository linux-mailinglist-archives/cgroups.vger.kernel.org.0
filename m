Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB998601C92
	for <lists+cgroups@lfdr.de>; Tue, 18 Oct 2022 00:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJQWq3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Oct 2022 18:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiJQWq2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Oct 2022 18:46:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8597E820;
        Mon, 17 Oct 2022 15:46:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 231D71F8D1;
        Mon, 17 Oct 2022 22:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666046786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KPXn8oCISsFaCnRNyRjpdaEv1QQo5ZLAKB/NsLXVGBs=;
        b=NfKOqe4gHCl9/Htq5BcTbwrgFymKb4wGV1EoSbTVL1zMWiFBS0wESzuZBCcXi55G/gR0tQ
        dqkWXoDM2yaNsea3ydA79oc54ZMQO9pSGOy34tkFfc3j8hI+NmtNtlNXbV82hU2h+0y5E3
        y7ohEeM0pH8mJna2Hkfzj+XLk/7aVQo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D387413ABE;
        Mon, 17 Oct 2022 22:46:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7rDvMUHbTWN0YwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 17 Oct 2022 22:46:25 +0000
Date:   Tue, 18 Oct 2022 00:46:24 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH] mm/memcontrol: Don't increase effective low/min if no
 protection needed
Message-ID: <Y03bQJcK4o4Po1v2@blackbook>
References: <20221011143015.1152968-1-longman@redhat.com>
 <Y0WOPZxWSnUjzZ8e@dhcp22.suse.cz>
 <defdb421-342e-ebcb-d7f0-005559dd1e0d@redhat.com>
 <Y0WiIDmPPXYZuHpX@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0WiIDmPPXYZuHpX@slm.duckdns.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 11, 2022 at 07:04:32AM -1000, Tejun Heo <tj@kernel.org> wrote:
> Wouldn't it make sense to fix the test? With recursive_prot on, the cgroup
> actually is under low protection and it seems like the correct behavior is
> to report the low events accordingly.

It depends whether the there is a residual protection that the
memory.low=0 sibling can use (with memory_recursiveprot).

In the discussed LTP test, there should be no residual protection that
would justify the apparently misreported memory.low events. I.e. the
test is correct, the failure points to a subtle issue with distributing
residual protection among siblings.

Been there, (haven't) done that:
1) https://bugzilla.suse.com/show_bug.cgi?id=1196298
2) https://lore.kernel.org/r/20220325103118.GC2828@blackbody.suse.cz/

HTH,
Michal
