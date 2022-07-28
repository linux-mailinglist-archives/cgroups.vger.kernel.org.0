Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944A758420E
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 16:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiG1Oob (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 10:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiG1Oob (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 10:44:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED5A6262;
        Thu, 28 Jul 2022 07:44:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2E4B534A17;
        Thu, 28 Jul 2022 14:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659019468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gpW4YToHW6w1TJ+JUui+ok8xn0F55KMcQkwdz3YZ6hI=;
        b=gr1imVX/+jT5GEcGtWZ8FbJVs2S+5goVZ3h54Klc/9rJIqVQc5zm9Io0oEppBZkpPdh/6p
        vBJUd2+893USnplUtxLe9m9SBOZYRw9hFoC11WwAfTE1LB4fL5sASnD2XsvlwN9GgP2Z6A
        0x0hKwuBnycqcXIaHuIFbuizv3oUn/I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C936C13A7E;
        Thu, 28 Jul 2022 14:44:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g4QoMMug4mILZwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 28 Jul 2022 14:44:27 +0000
Date:   Thu, 28 Jul 2022 16:44:26 +0200
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
Subject: Re: [PATCH 2/2] cgroup: Skip subtree root in
 cgroup_update_dfl_csses()
Message-ID: <20220728144426.GA26631@blackbody.suse.cz>
References: <20220728005815.1715522-1-longman@redhat.com>
 <20220728005815.1715522-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220728005815.1715522-2-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 27, 2022 at 08:58:15PM -0400, Waiman Long <longman@redhat.com> wrote:
> The cgroup_update_dfl_csses() function updates css associations when a
> cgroup's subtree_control file is modified. Any changes made to a cgroup's
> subtree_control file, however, will only affect its descendants but not
> the cgroup itself. 

I find this correct.

> So there is no point in migrating csses associated with that cgroup.
> We can skip them instead.

Alone it's not such a big win but it componds with the recent Tejun's
threadgroup_rwsem elision.

> ---
>  kernel/cgroup/cgroup.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Feel free to have
Reviewed-by: Michal Koutný <mkoutny@suse.com>
