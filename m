Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335D069DBDC
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 09:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjBUI0L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 03:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjBUI0K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 03:26:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE8322DCB;
        Tue, 21 Feb 2023 00:26:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 64C7D34636;
        Tue, 21 Feb 2023 08:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676967966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=64nOhdqsrfC+GQvY/2yDtSkhDgrub/IRKe6PuUtaoTA=;
        b=gL/+k88YS+b45aJgVurrBUpl0g1ZFiyovTv6aHjfZ9jSBCOegm2/HVLZmSevsnN8c27HXc
        qiKMeeqh92MmoN1xTCabTZIByhEkYtbvvgvTGShcDF2NbBr69DSWBVaLW+5RnkbEYyf7y/
        zzDrC4knnc0O1PBH8hBci/5ov6RFTh0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4802213223;
        Tue, 21 Feb 2023 08:26:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DqbQDh6A9GNCCAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 21 Feb 2023 08:26:06 +0000
Date:   Tue, 21 Feb 2023 09:26:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Yue Zhao <findns94@gmail.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
Message-ID: <Y/SAHfHsljuIRBJm@dhcp22.suse.cz>
References: <20230220151638.1371-1-findns94@gmail.com>
 <Y/PhmEPc/qYeZ52T@P9FQF9L96D>
 <20230220230624.lkobqeagycx7bi7p@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220230624.lkobqeagycx7bi7p@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 20-02-23 23:06:24, Shakeel Butt wrote:
> On Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gushchin wrote:
> > On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
> > > The knob for cgroup v2 memory controller: memory.oom.group
> > > will be read and written simultaneously by user space
> > > programs, thus we'd better change memcg->oom_group access
> > > with atomic operations to avoid concurrency problems.
> > > 
> > > Signed-off-by: Yue Zhao <findns94@gmail.com>
> > 
> > Hi Yue!
> > 
> > I'm curious, have any seen any real issues which your patch is solving?
> > Can you, please, provide a bit more details.
> > 
> 
> IMHO such details are not needed. oom_group is being accessed
> concurrently and one of them can be a write access. At least
> READ_ONCE/WRITE_ONCE is needed here. Most probably syzbot didn't
> catch this race because it does not know about the memory.oom.group
> interface.

I do agree with Roman here. It is _always_ good to mention whether this
is a tool/review or actual bug triggered fix. Also {READ,WRITE}_ONCE doesn't
guarantee atomicity so it would be good to rephrase the changelog.
Something like:
The knob for cgroup v2 memory controller: memory.oom.group
is not protected by any locking so it can be modified while it is used.
This is not an actual problem because races are unlikely (the knob is
usually configured long before any workloads hits actual memcg oom)
but it is better to use READ_ONCE/WRITE_ONCE to prevent compiler from
doing anything funky.

This patch is not fixing any actual user visible bug but it is in line
of a standard practice.
-- 
Michal Hocko
SUSE Labs
