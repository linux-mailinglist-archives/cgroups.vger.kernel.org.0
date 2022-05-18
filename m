Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28CE52BF86
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 18:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239669AbiERPy6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 11:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239703AbiERPyu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 11:54:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00401CE62F;
        Wed, 18 May 2022 08:54:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 65F181F8D9;
        Wed, 18 May 2022 15:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652889286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fT6DJGA2cOSTPqSQ5kMo5BIA56bUH+3rlEL1RMSElmw=;
        b=aWoZP/8KOjx9GL8rIoYGs6MZgz48DGxy4SoNyCoki2pVbuV9gffBgLWkZpR5smgYoFlh0h
        hD3/PDiDEcNjj4m7KDuM6QwX/pIbSn0SH8uV6l7rVl8wbLYKF1Hl/E+/6/2W1k561Cwvqv
        fWdHnKJVpUyT5CPfddB82CRcJiWz+nA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CB6413A6D;
        Wed, 18 May 2022 15:54:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aZMWCsYWhWL9WAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 18 May 2022 15:54:46 +0000
Date:   Wed, 18 May 2022 17:54:44 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     void@manifault.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, shakeelb@google.com, tj@kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: Re: [PATCH 2/4] selftests: memcg: Expect no low events in
 unprotected sibling
Message-ID: <20220518155444.GB22503@blackbody.suse.cz>
References: <20220512174452.tr34tuh4k5jm6qjs@dev0025.ash9.facebook.com>
 <20220513171811.730-1-mkoutny@suse.com>
 <20220513171811.730-3-mkoutny@suse.com>
 <Yn6pWPodGPlz+D8G@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn6pWPodGPlz+D8G@carbon>
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

Hi.

On Fri, May 13, 2022 at 11:54:16AM -0700, Roman Gushchin <roman.gushchin@linux.dev> wrote:
> Hm, what are our plans here? Are we going to fix it soon-ish, or there
> is still no agreement on how to proceed?

Here are some of my ideas in random order so far and comments:

0) mask memory.events:low
-> not a real fix

1) don't do SWAP_CLUSTER_MAX roundup
-> won't solve sudden lift of protection

2) instead of SWAP_CLUSTER_MAX over-reclaim, do same under-reclaim
-> same problem as 1)

3) update children_low_usage transactionally (after reclaim round is done)
- ???

4) don't recursively distribute residual protection in the same reclaim round
- ???

5) iterate siblings from highest to lowest protection 
- not a solution

6) assign only >SWAP_CLUSTER_MAX of residuum
- need more info

I'm discouraged by possible complexity of 3) or 4), while 6) is what I'd
like to look more into.

HTH,
Michal

