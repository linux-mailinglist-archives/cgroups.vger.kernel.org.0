Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3434C56321E
	for <lists+cgroups@lfdr.de>; Fri,  1 Jul 2022 13:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiGALDy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Jul 2022 07:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGALDx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Jul 2022 07:03:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D7238BF5;
        Fri,  1 Jul 2022 04:03:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1D068220B1;
        Fri,  1 Jul 2022 11:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656673431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EQQ0uDHhygYXehLqsJhyCr+6to0zpT4yOYb+B/7ePOc=;
        b=WWJPQ2EXAZR1zW9+IVv5suuOU1NIHYrBg7iDSfv1oLM8W8yVOIyB5PnitFb/O8WjrQ65cw
        Rz3zvj+Qg7utK8xqKR8INSt6F2FnWqIzRi9ByD9vyq9spx9KQ6lUiOWwAHhO7EBzxT6J0J
        rcITBGmSTcrqyllxoSdrgRADn4cis5g=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9BFAC2C141;
        Fri,  1 Jul 2022 11:03:50 +0000 (UTC)
Date:   Fri, 1 Jul 2022 13:03:47 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Vasily Averin <vvs@openvz.org>, kernel@openvz.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH mm v5 0/9] memcg: accounting for objects allocated by
 mkdir, cgroup
Message-ID: <Yr7Ukyy0vhBjebo4@dhcp22.suse.cz>
References: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
 <0fe836b4-5c0f-0e32-d511-db816d359748@openvz.org>
 <c516033f-a9e4-3485-26d9-a68afa694c1d@openvz.org>
 <YrSP25ebDmXE+kPS@dhcp22.suse.cz>
 <CALvZod4WsmrpfZtfnP4AmvtnkvBRngXXGyhM6+aQzkdfjsinAQ@mail.gmail.com>
 <YrXDV7uPpmDigh3G@dhcp22.suse.cz>
 <CALvZod6U8DvMUcuUNfpQRwfkevQB7=nP4ZLA2gWGNf_JGdyARQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6U8DvMUcuUNfpQRwfkevQB7=nP4ZLA2gWGNf_JGdyARQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 27-06-22 09:37:14, Shakeel Butt wrote:
> On Fri, Jun 24, 2022 at 6:59 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > Is it even possible to prevent from id
> > depletion by the memory consumption? Any medium sized memcg can easily
> > consume all the ids AFAICS.
> 
> Though the patch series is pitched as protection against OOMs, I think
> it is beneficial irrespective. Protection against an adversarial actor
> should not be the aim here. IMO this patch series improves the memory
> association to the actual user which is better than unattributed
> memory treated as system overhead.

Considering the amount of memory and "normal" cgroup usage (I guess we
can agree that delegated subtrees do not count their cgroups in
thousands) is this really something that is worth bothering with?

I mean, these patches are really small and not really disruptive so I do
not really see any problem with them. Except that they clearly add a
maintenance overhead. Not directly with the memory they track but any
future cgroup/memcg metadata related objects would need to be tracked as
well and I am worried this will get quickly out of sync. So we will have
a half assed solution in place that doesn't really help any containment
nor it provides a good and robust consumption tracking.

All that being said I find these changes rather without a great value or
use.

-- 
Michal Hocko
SUSE Labs
