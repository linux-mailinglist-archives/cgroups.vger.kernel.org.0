Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AEC55CEA2
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 15:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344060AbiF1JIY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jun 2022 05:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbiF1JIW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jun 2022 05:08:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1660B766F;
        Tue, 28 Jun 2022 02:08:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C89A51F9D9;
        Tue, 28 Jun 2022 09:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656407300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z/CFWoysazPYOJ+RT+MoOQfwRcysVEsHRQF675n1OGQ=;
        b=JANHdKn0mmgpP88tAVTqM1LNjgntd0zv2uCWTJynSPXs4KRj2VMbaxE1WDbZpQZfBDRBC7
        /GxsxqrefLx2qwvL6P8kRKQJWWWolvM97j34XoT+6tfkvvfSzrs8eHKiO+zd0BJYf5cxEi
        LyXDetrh6tArsfPoS7eKN7rW3YmjliA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D158139E9;
        Tue, 28 Jun 2022 09:08:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wxFzIQTFumKKQAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 28 Jun 2022 09:08:20 +0000
Date:   Tue, 28 Jun 2022 11:08:19 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Vasily Averin <vvs@openvz.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH mm v2] memcg: notify about global mem_cgroup_id space
 depletion
Message-ID: <20220628090819.GB30543@blackbody.suse.cz>
References: <Yre8tNUY8vBrO0yl@castle>
 <97bed1fd-f230-c2ea-1cb6-8230825a9a64@openvz.org>
 <CAMZfGtWQEFmyuDngPfg59D-+b9sf58m9qhGoVPSQ_jAGmgT+sg@mail.gmail.com>
 <f3e4059c-69ea-eccd-a22f-9f6c6780f33a@openvz.org>
 <YrpVP6rpYGFsl3jj@castle>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrpVP6rpYGFsl3jj@castle>
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

On Mon, Jun 27, 2022 at 06:11:27PM -0700, Roman Gushchin <roman.gushchin@linux.dev> wrote:
> I think a better approach will be to add a cgroup event (displayed via
> cgroup.events) about reaching the maximum limit of cgroups. E.g.
> cgroups.events::max_nr_reached.

This sounds like a good generalization.

> Then you can set cgroup.max.descendants to some value below memcg_id
> space size. It's more work, but IMO it's a better way to communicate
> this event. As a bonus, you can easily get an idea which cgroup
> depletes the limit.

Just mind there's a difference between events: what cgroup's limit was
hit and what cgroup was affected by the limit [1] (the former is more
useful for the calibration if I understand the situation).

Michal

[1] https://lore.kernel.org/all/20200205134426.10570-2-mkoutny@suse.com/
