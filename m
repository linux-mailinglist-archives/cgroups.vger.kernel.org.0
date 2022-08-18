Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F5459913A
	for <lists+cgroups@lfdr.de>; Fri, 19 Aug 2022 01:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbiHRXgF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Aug 2022 19:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbiHRXgD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Aug 2022 19:36:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D08CDB049;
        Thu, 18 Aug 2022 16:36:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E9C2334639;
        Thu, 18 Aug 2022 23:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660865760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6/rgO9HvIpeNmrFhx/uSlbjwCoyaLrdacgDNOTFngc=;
        b=crwVJ8RpWCeHQxaFPbR63Suq6jo0KM/vc6yg567EIKjjInbysUmmLeMFIRidgKPPqHU4WZ
        UFGXIP+90Xi2cmKHe24plOJCTyRQyUCWcJI7h4tSC9Zae5AMpNX1TUA2VfcZgTl99Giiav
        C8ojR0N4WunTALT68TBda/cee4kyMmE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D0B5139B7;
        Thu, 18 Aug 2022 23:36:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1/RLHeDM/mIgPQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 18 Aug 2022 23:36:00 +0000
Date:   Fri, 19 Aug 2022 01:35:59 +0200
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
Subject: Re: [PATCH] sched, cpuset: Fix dl_cpu_busy() panic due to empty
 cs->cpus_allowed
Message-ID: <Yv7M3/L9SarNI56c@blackbook>
References: <20220803015451.2219567-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220803015451.2219567-1-longman@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 02, 2022 at 09:54:51PM -0400, Waiman Long <longman@redhat.com> wrote:
> Fixes: 7f51412a415d ("sched/deadline: Fix bandwidth check/update when migrating tasks between exclusive cpusets")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/sched.h  | 2 +-
>  kernel/cgroup/cpuset.c | 2 +-
>  kernel/sched/core.c    | 8 +++++---
>  3 files changed, 7 insertions(+), 5 deletions(-)

Good catch,
Reviewed-by: Michal Koutný <mkoutny@suse.com>
