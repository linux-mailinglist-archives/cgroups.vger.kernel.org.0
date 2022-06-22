Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629BB555297
	for <lists+cgroups@lfdr.de>; Wed, 22 Jun 2022 19:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376485AbiFVRje (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Jun 2022 13:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359087AbiFVRjd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Jun 2022 13:39:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF08F2CE1A;
        Wed, 22 Jun 2022 10:39:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7B1251F38A;
        Wed, 22 Jun 2022 17:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655919571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qjLsn3chRmVR7wBslFm7Nmwci+bvj1b1+qTpUK32rXQ=;
        b=iGD8LGlhBV+ijnTy+c24IKvp3gS6t3Xd7fZf0W5mhS4jcdaQdBdVobDGrLTSUQYAXoEATz
        JokCZyEMcnVxZEGqwjaMlMEyZdB0kDdegEDn9d5unKiSxSMx7nn9t4BUaYxsUPslHkd98r
        aF5iZpfXyd/FBxVY1CTQo6j408qFIqM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22E08134A9;
        Wed, 22 Jun 2022 17:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 571xB9NTs2JaLwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 22 Jun 2022 17:39:31 +0000
Date:   Wed, 22 Jun 2022 19:39:29 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     rdunlap@infradead.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: RT bandwidth interface for cgroup unified
 hierarchy
Message-ID: <20220622173929.GA669@blackbody.suse.cz>
References: <20220622015557.7497-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622015557.7497-1-zhouchengming@bytedance.com>
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

Hello Chengming.

On Wed, Jun 22, 2022 at 09:55:57AM +0800, Chengming Zhou <zhouchengming@bytedance.com> wrote:
> We need to run RT threads in cgroup unified hierarchy, but we can't
> since the default rt_bandwidth.rt_runtime of non-root task_group is 0
> and we haven't interface to update it.

Do you really want to make use of group RT schedulling
(CONFIG_RT_GROUP_SCHED) or just be able to run RT threads in the unified
hieararchy with cpu controller enabled?

Those are two different use cases, the former is more complex and it's a
reason why v2 doesn't expose the RT attributes (yet).
The latter is typically achieved by unsetting CONFIG_RT_GROUP_SCHED (and
relying on the global rt_runtime limit).

Thanks,
Michal
