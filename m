Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3D453A023
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 11:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348137AbiFAJPt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 05:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346234AbiFAJPr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 05:15:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0561403DA;
        Wed,  1 Jun 2022 02:15:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 53DBE1F93E;
        Wed,  1 Jun 2022 09:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654074945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yUzM6SCTjaU1mIdMVCprAWHtHI7nDAT4AcyKtphheFU=;
        b=sepJCSScSco/ygJugTWsZ6WDsOVoPXEAXUJWsBt1nE7P68p+7hhw14Ir0wKgMPbTy6rfz2
        uJoz2n6eIokFP4GbMKS4omn+EwCMNr51JNoG7uqDjtuvMQboSxieTjGqWXdvPY23kte/BX
        JNH8XgJ/JPc4f6ZESPn8deR8utON5ZI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B8F113A8F;
        Wed,  1 Jun 2022 09:15:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D/KqBUEul2JoagAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 01 Jun 2022 09:15:45 +0000
Date:   Wed, 1 Jun 2022 11:15:43 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH mm v3 0/9] memcg: accounting for objects allocated by
 mkdir cgroup
Message-ID: <20220601091543.GA21320@blackbody.suse.cz>
References: <06505918-3b8a-0ad5-5951-89ecb510138e@openvz.org>
 <3e1d6eab-57c7-ba3d-67e1-c45aa0dfa2ab@openvz.org>
 <YpSwvii5etfnOYC9@dhcp22.suse.cz>
 <ef9f7516-853d-ffe4-9a7a-5e87556bdbbe@openvz.org>
 <YpTTL3Ys35kgYyAW@dhcp22.suse.cz>
 <3a1d8554-755f-7976-1e00-a0e7fb62c86e@openvz.org>
 <YpXA35F33hvrxNLf@dhcp22.suse.cz>
 <118bcb39-1281-0d1d-b163-3f6bcc99c3e2@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <118bcb39-1281-0d1d-b163-3f6bcc99c3e2@openvz.org>
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

On Wed, Jun 01, 2022 at 06:43:27AM +0300, Vasily Averin <vvs@openvz.org> wrote:
> CT-901 /# cat /sys/fs/cgroup/memory/cgroup.subgroups_limit 
> 512
> CT-901 /# echo 3333 > /sys/fs/cgroup/memory/cgroup.subgroups_limit 
> -bash: echo: write error: Operation not permitted
> CT-901 /# echo 333 > /sys/fs/cgroup/memory/cgroup.subgroups_limit 
> -bash: echo: write error: Operation not permitted
> 
> I doubt this way can be accepted in upstream, however for OpenVz
> something like this it is mandatory because it much better
> than nothing.

Is this customization of yours something like cgroup.max.descendants on
the unified (v2) hierarchy? (Just curious.)

(It can be made inaccessible from within the subtree either with cgroup
ns or good old FS permissions.)

Michal
