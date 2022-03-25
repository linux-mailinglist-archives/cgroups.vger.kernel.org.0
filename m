Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8AF4E7142
	for <lists+cgroups@lfdr.de>; Fri, 25 Mar 2022 11:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358901AbiCYKc4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Mar 2022 06:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358907AbiCYKcz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Mar 2022 06:32:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A22CA0D5;
        Fri, 25 Mar 2022 03:31:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 315BB210DD;
        Fri, 25 Mar 2022 10:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648204280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h6jomU3pNhNfJYGm9LatF9aqOCiUlgqkCJJ0ZhBuK44=;
        b=OsMPUua2iforFSm/UO/9WA9UJuZ+xXzZyx7U7SbDGrfPWJ19fd6uUDvHS5HlFiizH8bmb/
        p2dURGMdjGTgK315FM0aQYhh88yWszyYJUdLrvzWW2gJttjV5HsA9O+13YgiZIiNGIXf9t
        fn7HnjdhscuOqORQ1tnVhDPzk3vTItA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7E901332D;
        Fri, 25 Mar 2022 10:31:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /5V/K/eZPWLFHgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 25 Mar 2022 10:31:19 +0000
Date:   Fri, 25 Mar 2022 11:31:18 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>
Subject: Re: [RFC PATCH] mm: memcg: Do not count memory.low reclaim if it
 does not happen
Message-ID: <20220325103118.GC2828@blackbody.suse.cz>
References: <20220324095157.GA16685@blackbody.suse.cz>
 <5049EBC3-5BAE-4509-BA63-1F4A7D913517@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5049EBC3-5BAE-4509-BA63-1F4A7D913517@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 24, 2022 at 11:17:14AM -0700, Roman Gushchin <roman.gushchin@linux.dev> wrote:
> Ok, so it’s not really about the implementation details of the reclaim
> mechanism (I mean rounding up to the batch size etc),

Actually, that was what I deemed more serious first.
It's the point 2 of RFCness:

| 2) The observed behavior slightly impacts distribution of parent's memory.low.
|    Constructed example is a passive protected workload in s1 and active in s2
|    (active ~ counteracts the reclaim with allocations). It could strip
|    protection from s1 one by one (one:=SWAP_CLUSTER_MAX/2^sc.priority).
|    That may be considered both wrong (s1 should have been more protected) or
|    correct s2 deserves protection due to its activity.
|    I don't have (didn't collect) data for this, so I think just masking the
|    false events is sufficient (or independent).

> Idk, I don’t have a strong argument against this change (except that
> it changes the existing behavior), but I also don’t see why such
> events are harmful. Do you mind elaborating a bit more?

So I've collected some demo data now.

	systemd-run \
	        -u precious.service --slice=test-protected.slice \
	        -p MemoryLow=50M \
	        /root/memeater 50 # allocates 50M anon, doesn't use it
	
	systemd-run \
	        -u victim.service --slice=test-protected.slice \
	        -p MemoryLow=0M \
	        /root/memeater -m 50 50 # allocates 50M anon, uses it
	
	echo "Started workloads"
	
	systemctl set-property --runtime test.slice MemoryMax=200M
	systemctl set-property --runtime test-protected.slice MemoryLow=50M
	
	sleep 5
	
	systemd-run \
	        -u pressure.service --slice=test.slice \
	        -p MemorySwapMax=0M \ # to push test-protected.slice to swap
	        /root/memeater -m 170 170
	
	sleep 5
	systemd-cgtop -b -1 -m test.slice

Result with memory_recursiveprot

> Control Group                                                        Tasks   %CPU   Memory  Input/s Output/s
> test.slice                                                               3      -   199.9M        -        -
> test.slice/pressure.service                                              1      -   170.5M        -        -
> test.slice/test-protected.slice                                          2      -    29.4M        -        -
> test.slice/test-protected.slice/victim.service                           1      -    29.1M        -        -
> test.slice/test-protected.slice/precious.service                         1      -   292.0K        -        -

Result without memory_recursiveprot

> Control Group                                                        Tasks   %CPU   Memory  Input/s Output/s
> test.slice                                                               3      -   199.8M        -        -
> test.slice/pressure.service                                              1      -   170.5M        -        -
> test.slice/test-protected.slice                                          2      -    29.3M        -        -
> test.slice/test-protected.slice/precious.service                         1      -    28.7M        -        -
> test.slice/test-protected.slice/victim.service                           1      -   560.0K        -        -

(kernel 5.17.0, systemd 249.10)

So with this result, I'd say the event reporting is an independent change
(admiteddly, thanks to the current implementation (not the proposal of
mine) I noticed this issue).
/me scratches head, let me review my other approaches...


Michal
