Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C79523BDE
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 19:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbiEKRt7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 13:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbiEKRt6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 13:49:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDAA235163
        for <cgroups@vger.kernel.org>; Wed, 11 May 2022 10:49:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 79D5E21D24;
        Wed, 11 May 2022 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652291395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hybTl5KXVmOatuBKIZ1j2DSZPawKaxXgyyz91XdUDuE=;
        b=G2bilHY0B/+vLx83jRgBB8ceum/Xr8F2UCoGFzvV/mo+XEiTGAAMpYAd2AhTxSY08pdrPp
        U4m58yO/rWjGFseMxnSsTzChDwtKo1EgEw2EgP72eymTewrYpBFvVPE7f1l89TA5jchVXT
        1HvBpkMoA9W/gjRqjz5I3aT3F035XDE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 522EB139F9;
        Wed, 11 May 2022 17:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hj0JE0P3e2LtawAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 11 May 2022 17:49:55 +0000
Date:   Wed, 11 May 2022 19:49:54 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Ganesan Rajagopal <rganesan@arista.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/memcontrol: Export memcg->watermark via sysfs for
 v2 memcg
Message-ID: <20220511174953.GC31592@blackbody.suse.cz>
References: <20220507050916.GA13577@us192.sjc.aristanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220507050916.GA13577@us192.sjc.aristanetworks.com>
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

Hi.

On Fri, May 06, 2022 at 10:09:16PM -0700, Ganesan Rajagopal <rganesan@arista.com> wrote:
> We run a lot of automated tests when building our software and run into
> OOM scenarios when the tests run unbounded. v1 memcg exports
> memcg->watermark as "memory.max_usage_in_bytes" in sysfs. We use this
> metric to heuristically limit the number of tests that can run in
> parallel based on per test historical data.
> 
> This metric is currently not exported for v2 memcg and there is no
> other easy way of getting this information. getrusage() syscall returns
> "ru_maxrss" which can be used as an approximation but that's the max
> RSS of a single child process across all children instead of the
> aggregated max for all child processes. The only work around is to
> periodically poll "memory.current" but that's not practical for
> short-lived one-off cgroups.
> 
> Hence, expose memcg->watermark as "memory.peak" for v2 memcg.

It'll save some future indirections if the commit messages includes the
argument about multiple readers and purposeful irresetability.

> 
> Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
>  mm/memcontrol.c                         | 13 +++++++++++++
>  2 files changed, 20 insertions(+)

Besides that it looks useful and correct, feel free to add
Reviewed-by: Michal Koutný <mkoutny@suse.com>
