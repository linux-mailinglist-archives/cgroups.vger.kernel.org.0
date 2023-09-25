Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D907AD982
	for <lists+cgroups@lfdr.de>; Mon, 25 Sep 2023 15:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjIYNuh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Sep 2023 09:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjIYNug (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Sep 2023 09:50:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9BEB3;
        Mon, 25 Sep 2023 06:50:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2880021857;
        Mon, 25 Sep 2023 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695649829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jcHoHaiIokbvVhLAntZeHFBs/mSZ9sLRljn4JH46n+8=;
        b=Y+Ze5tZaa/vhJYJpUpwQ0pZmKaOFR5s0ikzu9g5De+vsjp3KrPoNIbfEpJEqnpebKz7H2H
        cXibuPUBw6pEV4FasYGv0okod+puihW3ODDK0rw/6LlqrOe6N0+uNiT2vmYKLuq3S8sK/b
        e+u3WHYLF6e4U7Ku6SU3U1Iwmz9SDMY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0246A1358F;
        Mon, 25 Sep 2023 13:50:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F8kFOSSQEWXiHQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 25 Sep 2023 13:50:28 +0000
Date:   Mon, 25 Sep 2023 15:50:26 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mm: memcg: fix tracking of pending stats updates
 values
Message-ID: <ZRGQIhWF02SRzN4D@dhcp22.suse.cz>
References: <20230922175741.635002-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175741.635002-1-yosryahmed@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 22-09-23 17:57:38, Yosry Ahmed wrote:
> While working on adjacent code [1], I realized that the values passed
> into memcg_rstat_updated() to keep track of the magnitude of pending
> updates is consistent. It is mostly in pages, but sometimes it can be in
> bytes or KBs. Fix that.

What kind of practical difference does this change make? Is it worth
additional code?
 
> Patch 1 reworks memcg_page_state_unit() so that we can reuse it in patch
> 2 to check and normalize the units of state updates.
> 
> [1]https://lore.kernel.org/lkml/20230921081057.3440885-1-yosryahmed@google.com/
> 
> v1 -> v2:
> - Rebased on top of mm-unstable.
> 
> Yosry Ahmed (2):
>   mm: memcg: refactor page state unit helpers
>   mm: memcg: normalize the value passed into memcg_rstat_updated()
> 
>  mm/memcontrol.c | 64 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 51 insertions(+), 13 deletions(-)
> 
> -- 
> 2.42.0.515.g380fc7ccd1-goog

-- 
Michal Hocko
SUSE Labs
