Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D8E534E03
	for <lists+cgroups@lfdr.de>; Thu, 26 May 2022 13:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbiEZLXP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 May 2022 07:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347252AbiEZLW6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 May 2022 07:22:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FC7273C;
        Thu, 26 May 2022 04:22:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 796581F88B;
        Thu, 26 May 2022 11:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653564149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hv0r7+P52bHUfxGCUQuHehbuy065ANoliNcm3V+0PFI=;
        b=utAQl6liQ+JUOSurMy22DRK/WHQEwUNAJPY0hO3x8ST/3ghDSYABv66ADrFm/rLcXGZbwL
        id0nrWLqSv+f/Re52lXyOhtxCSs1Tk51+U/rLpTMsbvmdpGjUFczTfQusPkTjTLUvbjwp2
        1JUNuLjIcjQLoyETNXg5L8Htt00NnlQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58D9513AE3;
        Thu, 26 May 2022 11:22:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NlXVFPVij2LnOgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 26 May 2022 11:22:29 +0000
Date:   Thu, 26 May 2022 13:22:28 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     =?utf-8?B?5Y+y5oCd6L+c?= <shisiyuan19870131@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Return if dst_cgrp equals to src_cgrp
Message-ID: <20220526112228.GG11007@blackbody.suse.cz>
References: <1653066120-21262-1-git-send-email-shisiyuan@xiaomi.com>
 <Yo6zAi+Y/uXLYUI7@blackbook>
 <CAC=y0ud7oPtFqj=dqBSicoWwoN0knAwA6svidiYjbFn9BJMR3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC=y0ud7oPtFqj=dqBSicoWwoN0knAwA6svidiYjbFn9BJMR3w@mail.gmail.com>
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

On Thu, May 26, 2022 at 12:40:17PM +0800, 史思远 <shisiyuan19870131@gmail.com> wrote:
> echo 1413 >  /dev/cpuset/foreground/cgroup.procs
> echo 1413 >  /dev/cpuset/foreground/cgroup.procs
> echo 1413 >  /dev/cpuset/foreground/cgroup.procs

Thank you.

> In this situation, since the second echo, dst_cgrp equals to src_cgrp(both
> cgroups are the 'foreground' cpuset).
> cgroup1_procs_write（）-> __cgroup1_procs_write()
> -> cgrp = cgroup_kn_lock_live()
> -> task = cgroup_procs_write_start(buf...)
> -> cgroup_attach_task(cgrp, task, threadgroup);
>   -> 1) cgroup_migrate_add_src(task_css_set(task), dst_cgrp, &mgctx);  //
> detect the (src_cgrp == dst_cgrp), don't need to continue the following
> migration flow.
>   -> 2) cgroup_migrate_prepare_dst(&mgctx)

Here, I'd like to let you know about [1]

>   -> 3) cgroup_migrate(leader, threadgroup, &mgctx)
>   -> 4) cgroup_migrate_finish(&mgctx) // cleanup
> -> cgroup_procs_write_finish();  // cleanup


> >> The main purpose for this patch is to handle the situation above, and
> just noticed that cgroup_update_dfl_csses() also
> calls cgroup_migrate_add_src(). So I assume it's a similar situation. We
> can discuss more about it.

So I think the patch doesn't save that much and identical css_set is
better condition to check on (covers cgroup_update_dfl_csses too).

Michal

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/cgroup/cgroup.c?h=v5.18#n2710
