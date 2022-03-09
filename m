Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F5C4D3089
	for <lists+cgroups@lfdr.de>; Wed,  9 Mar 2022 14:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiCINtw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Mar 2022 08:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiCINtr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Mar 2022 08:49:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC30E149B93
        for <cgroups@vger.kernel.org>; Wed,  9 Mar 2022 05:48:47 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7667E1F381;
        Wed,  9 Mar 2022 13:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646833726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NmqS7ZxhbO47ovim+J2EyZsGVX8eOAA0CiaG2u3dAcc=;
        b=BSZiI8/V+gSeLNp9LUeQx5MnXFEY6ewbJlggU5HYnG40WdE7XcXePudKhmbmRTbtygeJC9
        iOBVRhuFi5Q4rgyxUSkYX8rD8+bYWIZ9UC3MahrzjLke+daGGuNFP5y9OnIUEbvN83izCC
        i+LQ38tRFvPwAYrdkfijL5a9j/s3VPU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D7ACAA3B91;
        Wed,  9 Mar 2022 13:48:40 +0000 (UTC)
Date:   Wed, 9 Mar 2022 14:48:45 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 3/3] mm/memcg: add next_mz back if not reclaimed yet
Message-ID: <YiiwPaCESiTuH22a@dhcp22.suse.cz>
References: <20220308012047.26638-1-richard.weiyang@gmail.com>
 <20220308012047.26638-3-richard.weiyang@gmail.com>
 <YicRNofU+L1cKIQp@dhcp22.suse.cz>
 <20220309004620.fgotfh4wsquscbfn@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309004620.fgotfh4wsquscbfn@master>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[Cc Tim - the patch is http://lkml.kernel.org/r/20220308012047.26638-3-richard.weiyang@gmail.com]

On Wed 09-03-22 00:46:20, Wei Yang wrote:
> On Tue, Mar 08, 2022 at 09:17:58AM +0100, Michal Hocko wrote:
> >On Tue 08-03-22 01:20:47, Wei Yang wrote:
> >> next_mz is removed from rb_tree, let's add it back if no reclaim has
> >> been tried.
> >
> >Could you elaborate more why we need/want this?
> >
> 
> Per my understanding, we add back the right most node even reclaim makes no
> progress, so it is reasonable to add back a node if we didn't get a chance to
> do reclaim on it.

Your patch sounded familiar and I can remember now. The same fix has
been posted by Tim last year
https://lore.kernel.org/linux-mm/8d35206601ccf0e1fe021d24405b2a0c2f4e052f.1613584277.git.tim.c.chen@linux.intel.com/
It was posted with other changes to the soft limit code which I didn't
like but I have acked this particular one. Not sure what has happened
with it afterwards.
-- 
Michal Hocko
SUSE Labs
