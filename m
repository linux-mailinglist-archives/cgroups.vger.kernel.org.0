Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D66F514560
	for <lists+cgroups@lfdr.de>; Fri, 29 Apr 2022 11:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347530AbiD2J3l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Apr 2022 05:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiD2J3k (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Apr 2022 05:29:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247AA35DE7;
        Fri, 29 Apr 2022 02:26:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B4C9921870;
        Fri, 29 Apr 2022 09:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651224381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U29ZMPPzFK4uUEyUYePHiz2qlt3Ri7SCZ7aNiH026UY=;
        b=IGPyVwbIILUdzwZFwC6tg5ufsIZXP5ClacMvrcvkQiCZaeUgVRAYMM/AoNO9PpHjD/AEcL
        fOWpgPD83vJ1gjAAlqWmAdKmqOLaAsi5QlzP+Y1N3FfIUGIGGIZFJNt++GwMtNRmpzL3Rs
        N46aQwwVuCxWp71FRvxzu2n0+VXMq3Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D51713446;
        Fri, 29 Apr 2022 09:26:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 903IHT2va2LwAgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 29 Apr 2022 09:26:21 +0000
Date:   Fri, 29 Apr 2022 11:26:20 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     David Vernet <void@manifault.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com,
        Richard Palethorpe <rpalethorpe@suse.com>
Subject: Re: [PATCH v2 2/5] cgroup: Account for memory_recursiveprot in
 test_memcg_low()
Message-ID: <20220429092620.GA23621@blackbody.suse.cz>
References: <20220423155619.3669555-1-void@manifault.com>
 <20220423155619.3669555-3-void@manifault.com>
 <20220427140928.GD9823@blackbody.suse.cz>
 <20220429010333.5rt2jwpiumnbuapf@dev0025.ash9.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429010333.5rt2jwpiumnbuapf@dev0025.ash9.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 28, 2022 at 06:03:33PM -0700, David Vernet <void@manifault.com> wrote:
> but my interpretation of the rest of that discussion with Roman is
> that we haven't yet decided whether we don't want to propagate
> memory.low events from children cgroups with memory.low == 0. Or at
> the very least, some more justification was requested on why not
> counting such events was prudent.

I'm not a fan of that original proposal of mine anymore (to be more
precise, of _only_ that patch, there's still the RFCness reason 1) to
consider).
As I shared with the last reply there, there's a problem in the behavior
which shouldn't be masked by filtering some events.

> Would you be ok with merging this patch so that the cgroup selftests can
> pass again based on the current behavior of the kernel, and we can then
> revert the changes to test_memcg_low() later on if and when we decide that
> we don't want to propagate memory.low events for memory.low == 0 children?

I still think that the behavior when there's no protection left for the
memory.low == 0 child, there should be no memory.low events (not just
uncounted but not happening) and test should not accept this (even
though it's the current behavior).

What might improve the test space would be to have two configs like

Original one (simplified here)
	parent		memory.low=50M	memory.current=100M
	` child1	memory.low=50M	memory.current=50M
	` child2	memory.low=0M	memory.current=50M

New one (checks events due to recursive protection)
	parent		memory.low=50M	memory.current=100M
	` child1	memory.low=40M	memory.current=50M
	` child2	memory.low=0M	memory.current=50M

The second config assigns recursive protection to child2 and should
therefore cause memory.low events in child2 (with memory_recursiveprot
enabled of course).

Or alternative new one (checks events due to recursive protection)
	parent		memory.low=50M	memory.current=100M
	` child1	memory.low=0M	memory.current=50M
	` child2	memory.low=0M	memory.current=50M

HTH,
Michal
