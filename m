Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E080178E90F
	for <lists+cgroups@lfdr.de>; Thu, 31 Aug 2023 11:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjHaJFo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Aug 2023 05:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242756AbjHaJFo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Aug 2023 05:05:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13696CEA;
        Thu, 31 Aug 2023 02:05:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BDD2F21871;
        Thu, 31 Aug 2023 09:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693472737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DujY6dkqedsXFZeiaLXoDY/sYyiJ8dFrPRvd9QhXe4U=;
        b=TQbe7rXxOquuL1eiRja1QjBmuTWQRynSoCpR94kHmbf3Tw7pzzFmN0XBlcVvgYoueYiyQZ
        EAuxq5zsTcDlPZA2bzGEcVIGn3riohjif4a+PCyY7jvWVrgmvzDzsMsNttjkkgrEGpfBJH
        4CsiLRzknMGJH4L/emjN7lQ08pLIzkU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD66813583;
        Thu, 31 Aug 2023 09:05:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WcOdKeFX8GTpDAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 31 Aug 2023 09:05:37 +0000
Date:   Thu, 31 Aug 2023 11:05:37 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
Message-ID: <ZPBX4S6XKX+HsDdW@dhcp22.suse.cz>
References: <ZOcDLD/1WaOwWis9@dhcp22.suse.cz>
 <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz>
 <ZO48h7c9qwQxEPPA@slm.duckdns.org>
 <CAJD7tkaQ1hD9HHyYTK_vfCQ9PCVZag7qMBueKyB+sEn=swvNJA@mail.gmail.com>
 <ZO5IuULSCXMe9_pN@slm.duckdns.org>
 <CAJD7tkYtnhemCLBqFqOVurfWEaCjKtyEM745JYRxFS0r5cpZwQ@mail.gmail.com>
 <ZO5RROsZ1VESCsMG@slm.duckdns.org>
 <CAJD7tkZn_7ppFB1B1V8tBEw12LXCnEOue2Beq6e19PkUAVHUSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZn_7ppFB1B1V8tBEw12LXCnEOue2Beq6e19PkUAVHUSQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 29-08-23 13:20:34, Yosry Ahmed wrote:
[...]
> I will add a mutex on the userspace read side then and spin a v3.
> Hopefully this addresses Michal's concern as well. The lock dropping
> logic will still exist for the inner lock, but when one userspace
> reader drops the inner lock other readers won't be able to pick it up.

Yes, that would minimize the risk of the worst case pathological
behavior.

> > I don't have a strong preference. As long as we stay away from introducing a
> > new user interface construct and can address the noticed scalability issues,
> > it should be fine. Note that there are other ways to address priority
> > inversions and contentions too - e.g. we can always bounce flushing to a
> > [kthread_]kworker and rate limit (or rather latency limit) how often
> > different classes of users can trigger flushing. I don't think we have to go
> > there yet but if the simpler meaures don't work out, there are still many
> > ways to solve the problem within the kernel.
> 
> I whole-heartedly agree with the preference to fix the problem within
> the kernel with minimal/none user space involvement.

Let's see. While I would love to see a solution that works for everybody
without explicit interface we have hit problems with locks involved in
stat files in the past.
-- 
Michal Hocko
SUSE Labs
