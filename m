Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C0C523AC4
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 18:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345099AbiEKQt6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 12:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345060AbiEKQtt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 12:49:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6215295DDF;
        Wed, 11 May 2022 09:49:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 19E6E21D3A;
        Wed, 11 May 2022 16:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652287787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BT7PhFjb0yfnX8Jyg1myJFbP9avxJpO8kwYrkhn3Qao=;
        b=Rqw7tlXYAK6aOCv5cU2S5SjeLkNYuQNaHQjxOxoinQtMjkhzD4QD7va4YazZecdAXkcqd0
        hI8qsZ9LllH1OeY0mt/7zDJAI90AYjelKRQkzXYfT5rpLBqATrF3Uwbsysu1bjmOWYfnWM
        dAojk1ZewHtUCFuM7IjkVl+KdZmRADY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD78513A76;
        Wed, 11 May 2022 16:49:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aDCVMCrpe2JmVgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 11 May 2022 16:49:46 +0000
Date:   Wed, 11 May 2022 18:49:45 +0200
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
Message-ID: <20220511164945.GA31592@blackbody.suse.cz>
References: <7e867cb0-89d6-402c-33d2-9b9ba0ba1523@openvz.org>
 <20220427140153.GC9823@blackbody.suse.cz>
 <7509fa9f-9d15-2f29-cb2f-ac0e8d99a948@openvz.org>
 <YnBLge4ZQNbbxufc@blackbook>
 <52a9f35b-458b-44c4-7fc8-d05c8db0c73f@openvz.org>
 <YnsoMEuWjlpDcmt3@carbon>
 <0eec6575-548e-23e0-0d99-4e079a33d338@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eec6575-548e-23e0-0d99-4e079a33d338@openvz.org>
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

On Wed, May 11, 2022 at 09:01:40AM +0300, Vasily Averin <vvs@openvz.org> wrote:
> number	bytes	$1*$2	sum	note	call_site
> of	alloc
> allocs
> ------------------------------------------------------------
> 1       14448   14448   14448   =       percpu_alloc_percpu:
> 1       8192    8192    22640   ++      (mem_cgroup_css_alloc+0x54)

This requires just adding GFP_KERNEL_ACCOUNT (no new active memcg
switch).

> 49      128     6272    28912   ++      (__kernfs_new_node+0x4e)
> 49      96      4704    33616   ?       (simple_xattr_alloc+0x2c)
> 49      88      4312    37928   ++      (__kernfs_iattrs+0x56)
> 1       4096    4096    42024   ++      (cgroup_mkdir+0xc7)
> 1       3840    3840    45864   =       percpu_alloc_percpu:
> 4       512     2048    47912   +       (alloc_fair_sched_group+0x166)
> 4       512     2048    49960   +       (alloc_fair_sched_group+0x139)
> 1       2048    2048    52008   ++      (mem_cgroup_css_alloc+0x109)
> "
> [1] https://lore.kernel.org/all/1aa4cd22-fcb6-0e8d-a1c6-23661d618864@openvz.org/
> =	already accounted
> ++	to be accounted first
> +	to be accounted a bit later
> 
> There is no problems with objects allocated in mem_cgroup_alloc(),
> they will be accounted to parent's memcg.
> However I do not understand how to handle other large objects?
> 
> We could move set_active_memcg(parent) call from mem_cgroup_css_alloc() 
> to cgroup_apply_control_enable() and handle allocation in all .css_alloc()
> 
> However I need to handle allocations called from cgroup_mkdir() too and
> badly understand how to do it properly.

If we consent to charge to the creator, the change would be just passing
GFP_ACCOUNT at fewer (right) places, wouldn't it?

Also, my undertanding of memcgs is that they're not hermetically tight,
so I think charging just kernfs_nodes (for dirs and files) provides
sufficient bound.

Except for, the xattrs, my older notes say: "make kernfs simple_xattr kernel
accounted, up to KERNFS_USER_XATTR_SIZE_LIMIT*KERNFS_MAX_USER_XATTRS =
128k * 128 = 16M / inode".

HTH,
Michal
