Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996B758420B
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 16:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiG1OoY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 10:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiG1OoY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 10:44:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB8AF5;
        Thu, 28 Jul 2022 07:44:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C8E9F20A80;
        Thu, 28 Jul 2022 14:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659019461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DUx+MWMoJx3rj7YLGpNF515BhD3DfyJeCTB/nJKgRCk=;
        b=MHJHRYEZfylLqaLT6NoEWTI/QBRAymRiDK0CUqh5mdBBeYtTx6qCLSiiiJlKDbXH2CtuML
        ELg0DUMKWzPeLpTK+ErUV7mFx6fxMZpMc7rnXtt9XGWtBGIt5ltP3AO/QF24jIC/h4u+UH
        iAHGylfhM2L1Jq106PrL+B58hQ2xPus=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77DB513A7E;
        Thu, 28 Jul 2022 14:44:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3t49HMWg4mL+ZgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 28 Jul 2022 14:44:21 +0000
Date:   Thu, 28 Jul 2022 16:44:20 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup/cpuset: Keep current cpus list if cpus
 affinity was explicitly set
Message-ID: <20220728144420.GA27407@blackbody.suse.cz>
References: <20220728005815.1715522-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728005815.1715522-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello.

On Wed, Jul 27, 2022 at 08:58:14PM -0400, Waiman Long <longman@redhat.com> wrote:
> It was found that any change to the current cpuset hierarchy may reset
> the cpus_allowed list of the tasks in the affected cpusets to the
> default cpuset value even if those tasks have cpus affinity explicitly
> set by the users before.

I'm surprised this went so long unnoticed / unreported.

Could it be users relied on that implicit affinity reset?

> That is especially easy to trigger under a cgroup v2 environment where
> writing "+cpuset" to the root cgroup's cgroup.subtree_control file
> will reset the cpus affinity of all the processes in the system.

This should apply only to tasks that were extracted out of the root
cgroup, no? (OK, those are all processes practically.)

(Even without your second patch, the scope should be limited because of
src_cset==dst_cset check in cgroup_migrate_prepare_dst().)

> That is especially problematic in a nohz_full environment where the
> tasks running in the nohz_full CPUs usually have their cpus affinity
> explicitly set and will behave incorrectly if cpus affinity changes.

One could also argue that for such processes, cgroup hierarchy should be
first configured and only then they start and set own affinity.

> Fix this problem by adding a flag in the task structure to indicate that
> a task has their cpus affinity explicitly set before and make cpuset
> code not to change their cpus_allowed list unless the user chosen cpu
> list is no longer a subset of the cpus_allowed list of the cpuset itself.

I'm uneasy with the occasional revert of this flag, i.e. the task who
set their affinity would sometimes have it overwritten and sometimes
not (which might have been relied on, especially with writes into
cpuset.cpus).
(But I have no better answer than the counter-argument above since
there's no easier way to detect the implicit migrations.)

Also, is there similar effect with memory binding?

Thanks,
Michal
