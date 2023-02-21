Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FFA69E454
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 17:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjBUQQ7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 11:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjBUQQ7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 11:16:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7BC2BEC3;
        Tue, 21 Feb 2023 08:16:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 654FD34B9B;
        Tue, 21 Feb 2023 16:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676996216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VIg5pY0sBhoDHUCkynozPJyyyBzhn0SD+XqJCl/DX2E=;
        b=ur51GYTE2PM2xTY09JS0cAxfrrMgcksi2E8L5UaVsGStsT6bwlH326WLSm6l65zQtfEdqw
        Z4arZMuoF0l5KIbPLj1yCjM6zsKeo1KHpZgW4KMeov7zRMniNkkJ4UQHM1oXVcjpqRGzbA
        UBvQod4cxxgaQzlYpt3NWSL7267moYU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4716713481;
        Tue, 21 Feb 2023 16:16:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kpteDnju9GOZEQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 21 Feb 2023 16:16:56 +0000
Date:   Tue, 21 Feb 2023 17:16:55 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Christopher Wong <Christopher.Wong@axis.com>
Cc:     Matthew Chae <Matthew.Chae@axis.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel <kernel@axis.com>, Muchun Song <muchun.song@linux.dev>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Sv: [PATCH] mm/memcontrol: add memory.peak in cgroup root
Message-ID: <Y/TudzUxEDwn6MHX@dhcp22.suse.cz>
References: <20230221143421.10385-1-matthew.chae@axis.com>
 <Y/TeKkhQtV7Bck8P@dhcp22.suse.cz>
 <DB4PR02MB93344BAA949FA7E25E298C90FEA59@DB4PR02MB9334.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB4PR02MB93344BAA949FA7E25E298C90FEA59@DB4PR02MB9334.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 21-02-23 16:13:14, Christopher Wong wrote:
> Hi Michal,
> 
> Thanks for the quick response! I think we are just trying to
> get the same value that was available for us in cgroup v1
> memory.max_usage_in_bytes. I guess this value also is incomplete for
> representing the system memory usage.

Correct.

> Is it due the incompleteness that the memory.peak has been left out in
> the root of cgroup v2?

I think so but I do not remember 100%. You might want to look into email
archives.
-- 
Michal Hocko
SUSE Labs
