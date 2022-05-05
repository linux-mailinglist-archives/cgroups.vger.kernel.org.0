Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CB951BC68
	for <lists+cgroups@lfdr.de>; Thu,  5 May 2022 11:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352192AbiEEJur (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 May 2022 05:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346565AbiEEJup (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 May 2022 05:50:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB9631531;
        Thu,  5 May 2022 02:47:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BD91E1F37E;
        Thu,  5 May 2022 09:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651744025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9UR1yAl5TuOKPXs8xewFpELkQ8J8mZZySCuXUINaiZ8=;
        b=ohURCbNOo2RJ/iazwraZdarADgzIdXUJbgxG/iAU7mBk1yalYm6Z3rluGWxuPENvMTsqsE
        fHfJZm+HCTsJND5hEJKSEt6nrFOm3ZeJaME2+RjY7Q2tcYOXOVnIC/3RYVTEweETeKq1UT
        aC9V3D1cYBJ8i9avDe84kHWVKwG58Pk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8316113A65;
        Thu,  5 May 2022 09:47:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aRcFHxmdc2J9MwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 05 May 2022 09:47:05 +0000
Date:   Thu, 5 May 2022 11:47:04 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: kernfs memcg accounting
Message-ID: <20220505094704.GB10890@blackbody.suse.cz>
References: <7e867cb0-89d6-402c-33d2-9b9ba0ba1523@openvz.org>
 <20220427140153.GC9823@blackbody.suse.cz>
 <7509fa9f-9d15-2f29-cb2f-ac0e8d99a948@openvz.org>
 <YnBLge4ZQNbbxufc@blackbook>
 <52a9f35b-458b-44c4-7fc8-d05c8db0c73f@openvz.org>
 <20220504141001.GA10890@blackbody.suse.cz>
 <65244222-02c5-6e8d-7f4b-83651f378ce2@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65244222-02c5-6e8d-7f4b-83651f378ce2@openvz.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 05, 2022 at 12:16:12AM +0300, Vasily Averin <vvs@openvz.org> wrote:
> I think it should allocate at least 2 pages.

After decoding kmalloc_type(), I agree this falls into a global
(unaccouted) kmalloc_cache.

> However if cgroup_mkdir() calls mem_cgroup_alloc() it correctly account huge percpu
> allocations but ignores neighbour multipage allocation.

So, the spillover is bound and proportional to memcg limit (same ration
like these two sizes).
But it may be better to account it properly, especially if it's
contribution form an offlined mem_cgroup.

Thanks,
Michal
