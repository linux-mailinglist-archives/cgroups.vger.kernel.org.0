Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204F4694728
	for <lists+cgroups@lfdr.de>; Mon, 13 Feb 2023 14:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBMNgq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Feb 2023 08:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjBMNgp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Feb 2023 08:36:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2531903C;
        Mon, 13 Feb 2023 05:36:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8A6F41F37E;
        Mon, 13 Feb 2023 13:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676295400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WBsHPFyQ/3u7/lh/7uLULXSnFfjfKpl/+ZQxS+UDoN8=;
        b=ACRFerY9QTr65z3Df8Q5sEawTKjoV04EOvZc+1ThKd2y5Gh1wCZZeMHcPkLA5kuH+0GSm4
        1bw19SNVRXLu8QM2qNVitO+V0dCusj4E6XNs9FABjLO7sJqaEDaI02e6239GbixcpWrLRY
        l3LNC5WFqGUnt+GT3sYThyEqgJn+NqA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BB181391B;
        Mon, 13 Feb 2023 13:36:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QkxxF+g86mNQZQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 13 Feb 2023 13:36:40 +0000
Date:   Mon, 13 Feb 2023 14:36:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y+o855yLUXa2dWgC@dhcp22.suse.cz>
References: <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
 <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
 <Y9MI42NSLooyVZNu@P9FQF9L96D.corp.robot.car>
 <Y9N5CI8PpsfiaY9c@dhcp22.suse.cz>
 <Y9PYe1X7dRQOcahg@dhcp22.suse.cz>
 <Y9QVWwAreTlDVdZ0@P9FQF9L96D.corp.robot.car>
 <Y90mZQhW89HtYfT9@dhcp22.suse.cz>
 <Y91fnF5uEcSA0/99@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y91fnF5uEcSA0/99@P9FQF9L96D.corp.robot.car>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 03-02-23 11:25:16, Roman Gushchin wrote:
> On Fri, Feb 03, 2023 at 04:21:09PM +0100, Michal Hocko wrote:
> > OK, so this is a speculative patch. cpu_is_isolated doesn't exist yet. I
> > have talked to Frederic off-list and he is working on an implementation.
> > I will be offline next whole week (will be back Feb 13th) so I am
> > sending this early but this patch cannot be merged without his one of
> > course.
> > 
> > I have tried to summarize the reasoning behind both approach should we
> > ever need to revisit this approach. For now I strongly believe a simpler
> > solution should be preferred.
> > 
> > Roman, I have added your ack as you indicated but if you disagree with
> > the reasoning please let me know.
> 
> Great, thank you for preparing it up! Really nice summary.
> My ack definitely applies.
> 
> If you want, feel free to add a
> "Suggested-by: Roman Gushchin <roman.gushchin@linux.dev>"
> tag to blame me later :)

Sure, I have updated the changelog. I will repost after the patchset by
Frederic[1] is merged.

[1] http://lkml.kernel.org/r/20230203232409.163847-1-frederic@kernel.org
-- 
Michal Hocko
SUSE Labs
