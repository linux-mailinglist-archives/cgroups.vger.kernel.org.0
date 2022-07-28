Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35937584303
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiG1PYF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 11:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiG1PX7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 11:23:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FADB664C7;
        Thu, 28 Jul 2022 08:23:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7878A33F11;
        Thu, 28 Jul 2022 15:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659021837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SRF9MyYDxSMz1004MAxo6xxMYmTRoIn6prKJRfvdun8=;
        b=Q1KNd85cVzSSFmi42M5onWHVuxuR4JxQDTShGHvzT1UF7YE5YJzw5A621cajhDejtlunGg
        cF3/xOafEk+snEKjU50p1two9rp8NCu6vZNHWEk4ViJjp6+mM/vvZjVfLrpXYqEsSJgAXV
        9/tOOOmYkta+W2r/j5AnczQdehm85hc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D69913427;
        Thu, 28 Jul 2022 15:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ek4rCg2q4mLJdwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 28 Jul 2022 15:23:57 +0000
Date:   Thu, 28 Jul 2022 17:23:55 +0200
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
Message-ID: <20220728152355.GB25894@blackbody.suse.cz>
References: <20220728005815.1715522-1-longman@redhat.com>
 <20220728144420.GA27407@blackbody.suse.cz>
 <a58852b4-313a-9271-f31d-f79a91ec188b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a58852b4-313a-9271-f31d-f79a91ec188b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 28, 2022 at 10:59:01AM -0400, Waiman Long <longman@redhat.com> wrote:
> Cgroup v1 doesn't have this problem.

v1 analogy would be:

	echo 2-3 >$dst/cpuset.cpus
	# job runs in $dst
	# one task T in $dst sets affinity just to one cpu
	# I rethink my config, I want to allow $dst more space
	echo 2-5 >$dst/cpuset.cpus

Most tasks in $dst happily utilize the new cpus but it breaks affinity
for T -- this must have been broken since ever.

(Or I'd argue that per-thread affinities are just recommendations, if I
have a task for nohz CPU, I should enforce its placement with cpuset
from the beginning.)

Michal
