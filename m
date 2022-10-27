Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452E760F0ED
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 09:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiJ0HKz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 03:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiJ0HKx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 03:10:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC93635C2;
        Thu, 27 Oct 2022 00:10:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B54DA22131;
        Thu, 27 Oct 2022 07:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666854629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QCPTXBtSuvGJ41I50Ajt8waPylXnOrME9Qo8riEvBNs=;
        b=XV2ShTSF4yMp1EabKplEgz+GtFZweYHSKQhHbBajveqkzRHYsGy8eq+D0MRC6mXFe20ADN
        TtCHe5UXI87D9NRXQWAii9m1kRipuCxXtgYrSAL8Egtf/cHPgQjj5R2D5kZwrQ/tlwGxBk
        hRiLB37+QpZjrTyXUkMZD7LMu/NYpAg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9765F13357;
        Thu, 27 Oct 2022 07:10:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zaWXGOUuWmOLHQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 27 Oct 2022 07:10:29 +0000
Date:   Thu, 27 Oct 2022 09:10:28 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
Message-ID: <Y1ou5DGHrEsKnhri@dhcp22.suse.cz>
References: <20221026074343.6517-1-feng.tang@intel.com>
 <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
 <Y1jpDfwBQId3GkJC@feng-clx>
 <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
 <Y1kl8VbPE0RYdyEB@feng-clx>
 <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
 <87wn8lkbk5.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn8lkbk5.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 27-10-22 14:47:22, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
[...]
> > I can imagine workloads which wouldn't like to get their memory demoted
> > for some reason but wouldn't it be more practical to tell that
> > explicitly (e.g. via prctl) rather than configuring cpusets/memory
> > policies explicitly?
> 
> If my understanding were correct, prctl() configures the process or
> thread.

Not necessarily. There are properties which are per adddress space like
PR_[GS]ET_THP_DISABLE. This could be very similar.

> How can we get process/thread configuration at demotion time?

As already pointed out in previous emails. You could hook into
folio_check_references path, more specifically folio_referenced_one
where you have all that you need already - all vmas mapping the page and
then it is trivial to get the corresponding vm_mm. If at least one of
them has the flag set then the demotion is not allowed (essentially the
same model as VM_LOCKED).
-- 
Michal Hocko
SUSE Labs
