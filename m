Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D7D4D42F7
	for <lists+cgroups@lfdr.de>; Thu, 10 Mar 2022 09:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbiCJJAf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Mar 2022 04:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240557AbiCJJAd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Mar 2022 04:00:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C94FF65F0
        for <cgroups@vger.kernel.org>; Thu, 10 Mar 2022 00:59:32 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 21E841F381;
        Thu, 10 Mar 2022 08:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646902771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A2tx04p/KSEJFzMMLCMxNtcpoNboTHg9YDAAKmm2DYA=;
        b=VXIAcD8dd86ZuUY5S18Rif2jBHHChRst37CsbQWmebMzB8YUvjurTIktrQhDc3P0Sxt+t1
        IjWfmL1RSs37CJgYqBM+kctOhUC17Ds3eoPlCFKxMUtucTi04tYGW0hD/KJooRW7k/MZfn
        lxqWyCqFgd+Cop+/Ma29drhBxZ0FJCs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E4570A3B87;
        Thu, 10 Mar 2022 08:59:30 +0000 (UTC)
Date:   Thu, 10 Mar 2022 09:59:30 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 3/3] mm/memcg: add next_mz back if not reclaimed yet
Message-ID: <Yim98uGgFjTu2HeK@dhcp22.suse.cz>
References: <20220308012047.26638-1-richard.weiyang@gmail.com>
 <20220308012047.26638-3-richard.weiyang@gmail.com>
 <YicRNofU+L1cKIQp@dhcp22.suse.cz>
 <20220309004620.fgotfh4wsquscbfn@master>
 <YiiwPaCESiTuH22a@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiiwPaCESiTuH22a@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 09-03-22 14:48:46, Michal Hocko wrote:
> [Cc Tim - the patch is http://lkml.kernel.org/r/20220308012047.26638-3-richard.weiyang@gmail.com]
> 
> On Wed 09-03-22 00:46:20, Wei Yang wrote:
> > On Tue, Mar 08, 2022 at 09:17:58AM +0100, Michal Hocko wrote:
> > >On Tue 08-03-22 01:20:47, Wei Yang wrote:
> > >> next_mz is removed from rb_tree, let's add it back if no reclaim has
> > >> been tried.
> > >
> > >Could you elaborate more why we need/want this?
> > >
> > 
> > Per my understanding, we add back the right most node even reclaim makes no
> > progress, so it is reasonable to add back a node if we didn't get a chance to
> > do reclaim on it.
> 
> Your patch sounded familiar and I can remember now. The same fix has
> been posted by Tim last year
> https://lore.kernel.org/linux-mm/8d35206601ccf0e1fe021d24405b2a0c2f4e052f.1613584277.git.tim.c.chen@linux.intel.com/

Btw. I forgot to mention yesterday. Whatever was the reason this has
slipped through cracks it would great if you could reuse the changelog
of the original patch which was more verbose and explicit about the
underlying problem. The only remaining part I would add is a description
of how serious the problem is. The removed memcg would be out of the
excess tree until further memory charges would get it back. But that can
take arbitrary amount of time. Whether that is a real problem would
depend on the workload of course but considering how coarse of a tool
the soft limit is it is possible that this is not something most users
would even notice.
-- 
Michal Hocko
SUSE Labs
