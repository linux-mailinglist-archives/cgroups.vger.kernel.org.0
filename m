Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C6B4D96C7
	for <lists+cgroups@lfdr.de>; Tue, 15 Mar 2022 09:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245406AbiCOIyM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Mar 2022 04:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243805AbiCOIyL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Mar 2022 04:54:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C5C26F8
        for <cgroups@vger.kernel.org>; Tue, 15 Mar 2022 01:52:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 96EDF1F37E;
        Tue, 15 Mar 2022 08:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647334378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Wb88545i+4GjfuUzkTW0/rBBA3pVcbxmgsSI00NEnI=;
        b=DTOMEkvVV36MyxPlreZceP6EZiM5h4C63EtctwZ4uxDogkFL8tBVACTedPBu/dClCDmcIZ
        hCSKjspYoyWJDZSlu2YAP6haQbp8EaN73pjliwk5JJXNJ9Oa8EUfwuY2OT8CVvjmjPhczi
        pl9mPWWpMH0w+tdop26PYTgxzZIg4m4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 63097A3B87;
        Tue, 15 Mar 2022 08:52:58 +0000 (UTC)
Date:   Tue, 15 Mar 2022 09:52:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [Patch v2 2/3] mm/memcg: __mem_cgroup_remove_exceeded could
 handle a !on-tree mz properly
Message-ID: <YjBT6emPlZD1lg5z@dhcp22.suse.cz>
References: <20220312071623.19050-1-richard.weiyang@gmail.com>
 <20220312071623.19050-2-richard.weiyang@gmail.com>
 <Yi8Qu/1V4H1M9qZV@dhcp22.suse.cz>
 <20220314225150.fhwny4yhxgjevwxx@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314225150.fhwny4yhxgjevwxx@master>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 14-03-22 22:51:50, Wei Yang wrote:
> On Mon, Mar 14, 2022 at 10:54:03AM +0100, Michal Hocko wrote:
> >On Sat 12-03-22 07:16:22, Wei Yang wrote:
> >> There is no tree operation if mz is not on-tree.
> >
> >This doesn't explain problem you are trying to solve nor does it make
> >much sense to me TBH.
> >
> 
> This just tries to make the code looks consistent.

I guess this is rather subjective. One could argue that the check is
more descriptive because it obviously removes the node from the tree
when it is on the tree.
-- 
Michal Hocko
SUSE Labs
