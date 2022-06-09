Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3983C54482B
	for <lists+cgroups@lfdr.de>; Thu,  9 Jun 2022 12:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiFIKAg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Jun 2022 06:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiFIKAe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Jun 2022 06:00:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B728A32B;
        Thu,  9 Jun 2022 03:00:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C915D1FDBF;
        Thu,  9 Jun 2022 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654768832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HgC272Pd9ho/7vBO6onIjh94FgZzaAHnEz7I9LIsXfA=;
        b=W00ihDeCz4lidD0CWe7uib7kxBcABEnZJ7TMl+N/nj4GBzuibU5MkYyhvZhPlPNKM95hx1
        /NZh0KtdasghNU7Mv7z1SnqWbsxmKoOg5qcBsP9yH0woTmWIFq9CbFjV9bS7iCG8+eZELH
        WBoipRD1p2w3+TId+bJDZ9f4qnHfjbY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90CC313A8C;
        Thu,  9 Jun 2022 10:00:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kW8BIsDEoWIqdwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 09 Jun 2022 10:00:32 +0000
Date:   Thu, 9 Jun 2022 12:00:31 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     =?utf-8?B?5Y+y5oCd6L+c?= <shisiyuan19870131@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, shisiyuan <shisiyuan@xiaomi.com>
Subject: Re: [PATCH] cgroup: handle cset multiidentity issue when migration
Message-ID: <20220609100031.GA11537@blackbody.suse.cz>
References: <1654187688-27411-1-git-send-email-shisiyuan@xiaomi.com>
 <20220608135110.GA19399@blackbody.suse.cz>
 <CAC=y0uc7OERw7uaCtwkhv=OktxRhEifBvk0W-G40osn7AnCgWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC=y0uc7OERw7uaCtwkhv=OktxRhEifBvk0W-G40osn7AnCgWg@mail.gmail.com>
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

Hello.

On Thu, Jun 09, 2022 at 11:49:38AM +0800, 史思远 <shisiyuan19870131@gmail.com> wrote:
> The process is like above photo, thread 2 exits
> between cgroup_migrate_prepare_dst() and cgroup_migrate_execute().
> Then the refcount of csetX turns to be 0 here, and UAF appears when thread1
> migrating.
> Thread2 exits asynchronously, can rwsem prevent it?

See the bailout in cgroup_migrate_add_task():

	if (task->flags & PF_EXITING)
	        return;

And cgroup_threadgroup_change_begin(tsk) in exit_signals().

> The purpose of my patch is to keep csetX's refcount still 1 after thread2
> exits, and make sure thread1 migrating successfully.

Why is not src_cset==dst_cset in cgroup_migrate_prepare_dst() not
sufficient?

Still, can this be reproduced in real world or is your reasoning based
on theory only?

Thanks,
Michal
