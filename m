Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB2557F60
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 18:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiFWQIJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 12:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiFWQIA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 12:08:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C0A2ACC;
        Thu, 23 Jun 2022 09:07:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0A0131F747;
        Thu, 23 Jun 2022 16:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656000477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wMF9zQXoS7789benC3y1Mqff9+pXyWjyfnVX7+d4uIU=;
        b=mvvikz1x06mAR0j9AIIjqZez94lYbuacM/0nvGLHh9QkoXhZ0Bgz3bcqKQylfvDVab1ffl
        fs5NfryGLmDNt9mFXbPF8S/1L9pyATCAiB9FP7RkBv2Nhdqo1yCiRNngO6aqd++vLOKIUx
        RwGAngJGkZvbsOT99UE2700SeBZB+E4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 52EBA2C197;
        Thu, 23 Jun 2022 16:07:56 +0000 (UTC)
Date:   Thu, 23 Jun 2022 18:07:55 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     kernel@openvz.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH mm v5 0/9] memcg: accounting for objects allocated by
 mkdir, cgroup
Message-ID: <YrSP25ebDmXE+kPS@dhcp22.suse.cz>
References: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
 <0fe836b4-5c0f-0e32-d511-db816d359748@openvz.org>
 <c516033f-a9e4-3485-26d9-a68afa694c1d@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c516033f-a9e4-3485-26d9-a68afa694c1d@openvz.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 23-06-22 18:03:31, Vasily Averin wrote:
> Dear Michal,
> do you still have any concerns about this patch set?

Yes, I do not think we have concluded this to be really necessary. IIRC 
Roman would like to see lingering cgroups addressed in not-so-distant
future (http://lkml.kernel.org/r/Ypd2DW7id4M3KJJW@carbon) and we already
have a limit for the number of cgroups in the tree. So why should we
chase after allocations that correspond the cgroups and somehow try to
cap their number via the memory consumption. This looks like something
that will get out of sync eventually and it also doesn't seem like the
best control to me (comparing to an explicit limit to prevent runaways).
-- 
Michal Hocko
SUSE Labs
