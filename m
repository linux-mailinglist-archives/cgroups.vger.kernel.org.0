Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A7360F864
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 15:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbiJ0NFi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 09:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbiJ0NF3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 09:05:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734B236864;
        Thu, 27 Oct 2022 06:05:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 25E1A1F8BD;
        Thu, 27 Oct 2022 13:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666875925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iLNO8fwHXhHPJ6MycKJ73w5HGMLMj9HlWspV0+LyiJY=;
        b=rDEM3ZnGroiojMFPrn3cjucEP3ymtmI5jrPZuAxvb5gEMPrn0HIj7PmXKMYgHo1+tO7yE2
        6urCMiTAG71A2qFslg+sHC6po5k0B6snagoA3ro5K29S4RuzkKtq0qdXHCrGD7CohRaAAK
        dRp+4plLctbuWS/EqHucGbLmAfiWebU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EFFFE134CA;
        Thu, 27 Oct 2022 13:05:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D90POBSCWmNLXgAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 27 Oct 2022 13:05:24 +0000
Date:   Thu, 27 Oct 2022 15:05:23 +0200
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
Message-ID: <Y1qCE8snHO2uKHKd@dhcp22.suse.cz>
References: <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
 <Y1jpDfwBQId3GkJC@feng-clx>
 <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
 <d17698d2-c1b5-9aa3-6271-838830d36cc5@linux.ibm.com>
 <Y1kTz1qjfsY1UBPf@dhcp22.suse.cz>
 <44e485d4-acf5-865d-17fe-13be1c1b430b@linux.ibm.com>
 <Y1kmOaXvzwRv/tza@dhcp22.suse.cz>
 <22590f74-ec91-e673-32df-8a04b4ab3931@linux.ibm.com>
 <Y1pJG+d+kXJgjNMc@dhcp22.suse.cz>
 <5a6c29f9-1154-03af-c22e-55108feb155f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a6c29f9-1154-03af-c22e-55108feb155f@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 27-10-22 15:46:07, Aneesh Kumar K V wrote:
> On 10/27/22 2:32 PM, Michal Hocko wrote:
> 
> >>
> >> Sorry, I meant MAP_ANONYMOUS | MAP_SHARED. 
> > 
> > I am still not sure where you are targeting to be honest. MAP_SHARED or
> > MAP_PRIVATE both can have page shared between several vmas.
> 
> 
> What I was checking was w.r.t demotion and shared pages do we need to
> cross-check all the related memory policies? On the page fault side, we don't do that.

Yes, because on the page fault we do have an originator and so we can
apply some reasonable semantic. For the memory reclaim there is no such
originator for a specific page. A completely unrelated context might be
reclaiming a page with some mempolicy constrain and you do not have any
records who has faulted it in. The fact that we have a memory policy
also at the task level makes a completely consistent semantic rather
hard if possible at all (e.g. what if different thread are simply bound
to a different node because shared memory is prefaulted and local thread
mappings will be always local).

I do not think shared mappings are very much special in that regards. It
is our mempolicy API that allows to specify a policy for vmas as well as
tasks and the later makes the semantic for reclaim really awkward.

-- 
Michal Hocko
SUSE Labs
