Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32500523A6B
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 18:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbiEKQep (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 12:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245088AbiEKQem (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 12:34:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EC4239D8E;
        Wed, 11 May 2022 09:34:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8EA021D24;
        Wed, 11 May 2022 16:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652286880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2JoTxCuGT/XwmSwU+DDVolsXEflHmN6heyJDe9s6Lc8=;
        b=CUkd58Keel+pNaWn+KYfxSYFopIDQDKGU3PoRCjYzjYA13p/vREkGqB+N7B6dnrAbP0OUH
        UgN9xcN9ryoxwKytW0/dcicFGuLYVDNSMVS7cyFxSnp+8lCv7Nr/tgx3tn2JfRg3TITSdt
        xKGuvz/T96eKVUHLlFlJcs+fWsGNMCQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DE2613A76;
        Wed, 11 May 2022 16:34:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S8OOJaDle2JBUQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 11 May 2022 16:34:40 +0000
Date:   Wed, 11 May 2022 18:34:39 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Vasily Averin <vvs@openvz.org>, Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: kernfs memcg accounting
Message-ID: <20220511163439.GD24172@blackbody.suse.cz>
References: <7e867cb0-89d6-402c-33d2-9b9ba0ba1523@openvz.org>
 <20220427140153.GC9823@blackbody.suse.cz>
 <7509fa9f-9d15-2f29-cb2f-ac0e8d99a948@openvz.org>
 <YnBLge4ZQNbbxufc@blackbook>
 <52a9f35b-458b-44c4-7fc8-d05c8db0c73f@openvz.org>
 <YnsoMEuWjlpDcmt3@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnsoMEuWjlpDcmt3@carbon>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 10, 2022 at 08:06:24PM -0700, Roman Gushchin <roman.gushchin@linux.dev> wrote:
> My primary goal was to apply the memory pressure on memory cgroups with a lot
> of (dying) children cgroups. On a multi-cpu machine a memory cgroup structure
> is way larger than a page, so a cgroup which looks small can be really large
> if we calculate the amount of memory taken by all children memcg internals.
> 
> Applying this pressure to another cgroup (e.g. the one which contains systemd)
> doesn't help to reclaim any pages which are pinning the dying cgroups.

Just a note -- this another usecase of cgroups created from within the
subtree (e.g. a container). I agree that cgroup-manager/systemd case is
also valid (as dying memcgs may accumulate after a restart).

memcgs with their retained state with footprint are special.

> For other controllers (maybe blkcg aside, idk) it shouldn't matter, because
> there is no such problem there.
> 
> For consistency reasons I'd suggest to charge all *large* allocations
> (e.g. percpu) to the parent cgroup. Small allocations can be ignored.

Strictly speaking, this would mean that any controller would have on
implicit dependency on the memory controller (such as io controller
has).
In the extreme case even controller-less hierarchy would have such a
requirement (for precise kernfs_node accounting).
Such a dependency is not enforceable on v1 (with various topologies of
different hierarchies).
Although, I initially favored the consistency with memory controller too,
I think it's simpler to charge to the creator's memcg to achieve
consistency across v1 and v2 :-) 

Michal
