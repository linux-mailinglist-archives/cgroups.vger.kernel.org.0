Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED3E686618
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 13:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjBAMlU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 07:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAMlU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 07:41:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC8FCC;
        Wed,  1 Feb 2023 04:41:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E81B33D30;
        Wed,  1 Feb 2023 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675255277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pgarzvo5Cio7GL8GEMMFzzwnzoa+QoIct7DEsSsHtqA=;
        b=MWzo9/68aPfyUUKt0sBZONEVCQnB5Rnc7js3asZl1hGklDyD/kUD3l3yb52I05gyiwCGwJ
        FkltqazCB0qBi1IKYo4fWm7hphLeefGDPXjfrTgp8Qe/444/6AfB68SNhBTUfZhen1TiXu
        2Go0U87UliFst4DLvBn7AcwTkPETxhg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CAF51348C;
        Wed,  1 Feb 2023 12:41:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T9EqHO1d2mMjQQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 01 Feb 2023 12:41:17 +0000
Date:   Wed, 1 Feb 2023 13:41:16 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9pd7AxAILUSHrpe@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9IvoDJbLbFcitTc@dhcp22.suse.cz>
 <Y9LDAZmApLeffrT8@tpad>
 <Y9LQ615H13RmG7wL@dhcp22.suse.cz>
 <0122005439ffb7895efda7a1a67992cbe41392fe.camel@redhat.com>
 <Y9j9BnMwfm4TJks7@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9j9BnMwfm4TJks7@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 31-01-23 08:35:34, Marcelo Tosatti wrote:
[...]
> So it would be good to point out a specific problematic 
> testcase/scenario with using the spinlock in this particular case?

Please think about it some more. The sole purpose of the pcp charge
caching is to avoid atomics because the normal fast path (i.e. no limit
hit) is a page counter which is an atomic counter. If you go with a spin
lock for the pcp cache you are just losing some of the advantage of the
caching. Sure that would be a smaller atomics use than a deeper memcg
hierarchy but still.

Not to mention a potential contention which is hard to predict and it
will depend on the specific runtime very much. So not something that
would be easy to test for other than artificial testcases. Full cpu
pcp draining is not a very common operation and one could argue that
the problem will be limited but so far I haven't really heard any strong
arguments against the proposal to avoid scheduling the work on isolated
cpus which is a much more simpler solution and achieves the same
effect.
-- 
Michal Hocko
SUSE Labs
