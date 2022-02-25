Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8384C3FD7
	for <lists+cgroups@lfdr.de>; Fri, 25 Feb 2022 09:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbiBYIOV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Feb 2022 03:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiBYIOV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Feb 2022 03:14:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48781D0340
        for <cgroups@vger.kernel.org>; Fri, 25 Feb 2022 00:13:48 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 742391F383;
        Fri, 25 Feb 2022 08:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645776827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a9XUtHgFIXz3Y7VU5CfuvkiImWSSj6M2SSPgIuQZxWw=;
        b=P51WeZJwQaSXAs3kehFkP5GgGwrp0kmlZJytxgvWQc9SXsNbzmcUW37g2LTuqRdG6+JVHX
        x49lzoHoYwtXjQ9ason8Vzr7s9hOBPm1En8NXOGujqR4T2RM+XUx4MdLOeKZL0Q7hYIfIQ
        AiUg+xtD4wBqtK75jF2ZvixJTvQ968A=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 472EEA3B81;
        Fri, 25 Feb 2022 08:13:47 +0000 (UTC)
Date:   Fri, 25 Feb 2022 09:13:46 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm/memcg: some cleanup for mem_cgroup_iter()
Message-ID: <YhiPuokZpIk1MYaB@dhcp22.suse.cz>
References: <20220225003437.12620-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225003437.12620-1-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 25-02-22 00:34:34, Wei Yang wrote:
> No functional change, try to make it more readable.
> 
> Wei Yang (3):
>   mm/memcg: set memcg after css verified and got reference
>   mm/memcg: set pos to prev unconditionally
>   mm/memcg: move generation assignment and comparison together
> 
>  mm/memcontrol.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)

I am sorry but I do not really see these changes to be simplifying 
the iterator code enough to be worth touching the code. The iterator
code is really subtle and we have experienced some subtle bugs there.
I would be really reluctant to touch it unless the result is a clear
simplification or a bug fix. Please keep in mind that the review
overhead is far from negligible here.

Unless Johannes sees that as a clear improvement then I would suggest
dropping these patches from the akpm's tree.
-- 
Michal Hocko
SUSE Labs
