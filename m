Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BFD6892ED
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 10:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBCI7C (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 03:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjBCI7A (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 03:59:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B398DAE0;
        Fri,  3 Feb 2023 00:58:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ECD0E20F67;
        Fri,  3 Feb 2023 08:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675414736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v8S6zraZDmm8NfG5YlmoDj55zR5f/MJguLBUkCuqdFU=;
        b=nMUifxEzJUnVuWEuDfCB40VhS3vpxS+f9DwWxSfS6K37MuTVadnC6RU2yr0fLSldcoR7e1
        I4kGUT2Yfchr4CA4oDRoV83lCZ2soHeDICcCHoYEzAVx2iDl4VPPfborkCE9UjZprEOlFJ
        18ULHKXGs/z2b8zS8YhQ9mzDg6KNaXA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB29A1346D;
        Fri,  3 Feb 2023 08:58:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nv57L9DM3GOfCgAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 03 Feb 2023 08:58:56 +0000
Date:   Fri, 3 Feb 2023 09:58:56 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: introduce entrance for root_mem_cgroup's current
Message-ID: <Y9zM0GbmfKdvy3bL@dhcp22.suse.cz>
References: <1675312377-4782-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y9tz+0J9fw+Z+O+O@dhcp22.suse.cz>
 <CALvZod5E0s9Vu3wq-Fuvs9z=ViMADn3aNL0f56ELGmFzxKCtkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5E0s9Vu3wq-Fuvs9z=ViMADn3aNL0f56ELGmFzxKCtkg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 02-02-23 10:24:08, Shakeel Butt wrote:
> On Thu, Feb 2, 2023 at 12:27 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 02-02-23 12:32:57, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Introducing memory.root_current for the memory charges on root_mem_cgroup.
> >
> > Charges are not currently accounted for the root memcg universally. See
> > try_charge which is used for all user space and skmem charges. I am not
> > 100% sure about objcg based accounting because there is no explicit
> > check for the root memcg but this might be hidden somewhere as well.
> 
> Yes in __get_obj_cgroup_from_memcg(). However the reason to use
> try_charge_memcg() to bypass root check was to avoid the race with
> reparenting. More details in c5c8b16b596e ("mm: memcontrol: fix
> root_mem_cgroup charging").

Thanks for the pointer!

> > That means that the patch as is doesn't really provide and usable value.
> > The root exemption has been removed in the past but that has been
> > reverted due to a regression. See ce00a967377b ("mm: memcontrol: revert
> > use of root_mem_cgroup res_counter") for more.
> >
> 
> One advantage I can see is if someone is looking for usage for all top
> containers (alive or zombie) but I wanted to know if that was the real
> motivation behind the patch.

Isn't that just a global stats that we already display via /proc files?

-- 
Michal Hocko
SUSE Labs
