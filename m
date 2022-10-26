Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3197C60E085
	for <lists+cgroups@lfdr.de>; Wed, 26 Oct 2022 14:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiJZMVS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Oct 2022 08:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiJZMVS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Oct 2022 08:21:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E6B85597;
        Wed, 26 Oct 2022 05:21:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 579231F8BE;
        Wed, 26 Oct 2022 12:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666786874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=stwyNrefmhSrw8ppEzQNvMc29Kx0uiDfudCufTdmCGM=;
        b=h4NGPvxQAvmYcOQAcqLhGHjHFLpeODtWyPXeWpOJ/M8Xb1AVRvurQrYS76hwRzaDG4wibb
        rPherkc7CwQHQIMqW6AirPDBmhmF0N3JvYLy/JT1aQjl5blqf1AjnHUVZ0007JwCHx4XGx
        oD0pqddYyE7kqh6rV9Xy+Yv4aejT4HA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38F3413A77;
        Wed, 26 Oct 2022 12:21:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UMwBCzomWWOmPgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 26 Oct 2022 12:21:14 +0000
Date:   Wed, 26 Oct 2022 14:21:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
Message-ID: <Y1kmOaXvzwRv/tza@dhcp22.suse.cz>
References: <20221026074343.6517-1-feng.tang@intel.com>
 <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
 <Y1jpDfwBQId3GkJC@feng-clx>
 <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
 <d17698d2-c1b5-9aa3-6271-838830d36cc5@linux.ibm.com>
 <Y1kTz1qjfsY1UBPf@dhcp22.suse.cz>
 <44e485d4-acf5-865d-17fe-13be1c1b430b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e485d4-acf5-865d-17fe-13be1c1b430b@linux.ibm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 26-10-22 17:38:06, Aneesh Kumar K V wrote:
> On 10/26/22 4:32 PM, Michal Hocko wrote:
> > On Wed 26-10-22 16:12:25, Aneesh Kumar K V wrote:
> >> On 10/26/22 2:49 PM, Michal Hocko wrote:
> >>> On Wed 26-10-22 16:00:13, Feng Tang wrote:
> >>>> On Wed, Oct 26, 2022 at 03:49:48PM +0800, Aneesh Kumar K V wrote:
> >>>>> On 10/26/22 1:13 PM, Feng Tang wrote:
> >>>>>> In page reclaim path, memory could be demoted from faster memory tier
> >>>>>> to slower memory tier. Currently, there is no check about cpuset's
> >>>>>> memory policy, that even if the target demotion node is not allowd
> >>>>>> by cpuset, the demotion will still happen, which breaks the cpuset
> >>>>>> semantics.
> >>>>>>
> >>>>>> So add cpuset policy check in the demotion path and skip demotion
> >>>>>> if the demotion targets are not allowed by cpuset.
> >>>>>>
> >>>>>
> >>>>> What about the vma policy or the task memory policy? Shouldn't we respect
> >>>>> those memory policy restrictions while demoting the page? 
> >>>>  
> >>>> Good question! We have some basic patches to consider memory policy
> >>>> in demotion path too, which are still under test, and will be posted
> >>>> soon. And the basic idea is similar to this patch.
> >>>
> >>> For that you need to consult each vma and it's owning task(s) and that
> >>> to me sounds like something to be done in folio_check_references.
> >>> Relying on memcg to get a cpuset cgroup is really ugly and not really
> >>> 100% correct. Memory controller might be disabled and then you do not
> >>> have your association anymore.
> >>>
> >>
> >> I was looking at this recently and I am wondering whether we should worry about VM_SHARE
> >> vmas. 
> >>
> >> ie, page_to_policy() can just reverse lookup just one VMA and fetch the policy right?
> > 
> > How would that help for private mappings shared between parent/child?
> 
> 
> this is MAP_PRIVATE | MAP_SHARED?

This is not a valid combination IIRC. What I meant is a simple
MAP_PRIVATE|MAP_ANON that is CoW shared between parent and child.

[...]
-- 
Michal Hocko
SUSE Labs
