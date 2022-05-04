Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69FF51A1E4
	for <lists+cgroups@lfdr.de>; Wed,  4 May 2022 16:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351218AbiEDOOC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 May 2022 10:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351207AbiEDONn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 May 2022 10:13:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CABE43AD4;
        Wed,  4 May 2022 07:10:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA529210DB;
        Wed,  4 May 2022 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651673402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8N/2j1iMVEWPhLHwXlf1lbWHCy97qgMOd6RtCKAAHI=;
        b=YUvahhi8lIQnKT+/35TWCpA0GcF25PHrlG0nI6I37i/XqOeTn+w+dV7CC77XJJbhzSF9d6
        hg6QJYGL24C0qMCZELbiXO5XFTcgbVtkpXWBBhhbCSTgPBQPb3AtS78QY6poz0CYHIWK+m
        IWbijGNan7qNqCzpWSk4Oe9ejmyXlUI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70740131BD;
        Wed,  4 May 2022 14:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hitmGjqJcmLpDQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 04 May 2022 14:10:02 +0000
Date:   Wed, 4 May 2022 16:10:01 +0200
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
Message-ID: <20220504141001.GA10890@blackbody.suse.cz>
References: <7e867cb0-89d6-402c-33d2-9b9ba0ba1523@openvz.org>
 <20220427140153.GC9823@blackbody.suse.cz>
 <7509fa9f-9d15-2f29-cb2f-ac0e8d99a948@openvz.org>
 <YnBLge4ZQNbbxufc@blackbook>
 <52a9f35b-458b-44c4-7fc8-d05c8db0c73f@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a9f35b-458b-44c4-7fc8-d05c8db0c73f@openvz.org>
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

On Wed, May 04, 2022 at 12:00:18PM +0300, Vasily Averin <vvs@openvz.org> wrote:
> My patches protect the host mostly from misuse, when someone creates
> a huge number of nedevices inside a container.

Understood.

> Frankly speaking I do not see a big difference between memcg of current process,
> memcg of newly created child and memcg of its parent.

I agree that's not substantial difference. It's relevant for outer
entities "injecting" something into a subtree.
As I wrote previously, charging to the creator in the generic case is
sensible.

> As far as I understand, Roman chose the parent memcg because it was a special
> case of creating a new memory group. He temporally changed active memcg
> in mem_cgroup_css_alloc() and properly accounted all required memcg-specific
> allocations.

> However, he ignored accounting for a rather large struct mem_cgroup
> therefore I think we can do not worry about 128 bytes of kernfs node.

Are you referring to the current code (>= v5.18-rc2)? All big structs
related to mem_cgroup should be accounted. What is ignored?

> Primary I mean here struct mem_cgroup allocation in mem_cgroup_alloc().

Just note that memory controller may not be always enabled so
cgroup_mkdir != mem_cgroup_alloc().

> However, I think we need to take into account any other distributions called
> inside cgroup_mkdir: struct cgroup and kernefs node in common part and 
> any other cgroup-cpecific allocations in other .css_alloc functions.
> They all can be called from inside container, allocates non-accountable
> memory and by this way theoretically can be misused.

Also note that (if you're purely on unified hierachy) you can protect
against that with cgroup.max.descendants and cgroup.max.depth.

Thanks,
Michal
