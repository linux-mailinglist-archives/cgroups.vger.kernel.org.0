Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A04613262
	for <lists+cgroups@lfdr.de>; Mon, 31 Oct 2022 10:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJaJS6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Oct 2022 05:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaJS4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Oct 2022 05:18:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864B1BE15;
        Mon, 31 Oct 2022 02:18:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FAA41F91D;
        Mon, 31 Oct 2022 09:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667207934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5f+L4lFYRpVQJbtga4qXT/E9MSZAjXCdeB1iVrLLAwE=;
        b=nuddbqq6TZ5pf7kcq2IG5RchiKUxQQg5buEf9Z/wa2aKMhbg7b3HUcgyRFp3A6JPC0e4Qc
        7IwSXh9euPvo2ECab2gA2wkXzqpsEoE/cAkSKxkTiovPpHcG+WOi708agMeYmFKIJzN6EH
        P5RsnzkHClZu3MXCxPxAvl0nryGA4GE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F31D213AAD;
        Mon, 31 Oct 2022 09:18:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gYQdOf2SX2OMVwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 31 Oct 2022 09:18:53 +0000
Date:   Mon, 31 Oct 2022 10:18:53 +0100
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
Message-ID: <Y1+S/UkS1DNIwlp7@dhcp22.suse.cz>
References: <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
 <87wn8lkbk5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1ou5DGHrEsKnhri@dhcp22.suse.cz>
 <87o7txk963.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1o63SWD2KmQkT3v@dhcp22.suse.cz>
 <87fsf9k3yg.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1p5vaN1AWhpNWZx@dhcp22.suse.cz>
 <87bkpwkg24.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1+J7+1V1nJXF+3b@dhcp22.suse.cz>
 <87wn8gcr5s.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn8gcr5s.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 31-10-22 16:51:11, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Fri 28-10-22 07:22:27, Huang, Ying wrote:
> >> Michal Hocko <mhocko@suse.com> writes:
> >> 
> >> > On Thu 27-10-22 17:31:35, Huang, Ying wrote:
> > [...]
> >> >> I think that it's possible for different processes have different
> >> >> requirements.
> >> >> 
> >> >> - Some processes don't care about where the memory is placed, prefer
> >> >>   local, then fall back to remote if no free space.
> >> >> 
> >> >> - Some processes want to avoid cross-socket traffic, bind to nodes of
> >> >>   local socket.
> >> >> 
> >> >> - Some processes want to avoid to use slow memory, bind to fast memory
> >> >>   node only.
> >> >
> >> > Yes, I do understand that. Do you have any specific examples in mind?
> >> > [...]
> >> 
> >> Sorry, I don't have specific examples.
> >
> > OK, then let's stop any complicated solution right here then. Let's
> > start simple with a per-mm flag to disable demotion of an address
> > space.
> 
> I'm not a big fan of per-mm flag.  Because we don't have users for that
> too and it needs to add ABI too.

OK, if there are no users for opt-out then let's jus document the
current limitations and be done with it.

> > Should there ever be a real demand for a more fine grained solution
> > let's go further but I do not think we want a half baked solution
> > without real usecases.
> 
> I'm OK to ignore per-task (and missing per-process) memory policy
> support for now.

I am against such a half baked solution.
-- 
Michal Hocko
SUSE Labs
