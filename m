Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B3652AEF5
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 02:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiERAIW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 20:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiERAIW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 20:08:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EA717E19;
        Tue, 17 May 2022 17:08:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D01E6B81D97;
        Wed, 18 May 2022 00:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1F5C385B8;
        Wed, 18 May 2022 00:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652832498;
        bh=dGo2DK/jcDFeW9OzAZX7pYd8dKE594MPgxl0d5vf08o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PuAzQ1xUkMYyjYcicOstd9P9trgynYqqBU+B/c2c5XLaLyMpG8ZFb7oTGcEHuLm28
         PoiyLQqVLCv4fnNH7dDRn/aAktE47o9fUzo2OtiJyKNlMCgfG01RkCwloZu+jdbZ8T
         kAcGMpVpaQVVKEem6L1nUmerTDe80ZYkF+mRm8Rw=
Date:   Tue, 17 May 2022 17:08:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wang Cheng <wanngchenng@gmail.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+ad1b8c404f0959c4bfcc@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/mempolicy: fix uninit-value in mpol_rebind_policy()
Message-Id: <20220517170817.94ca21558bbe035ae06bf6fa@linux-foundation.org>
In-Reply-To: <20220516094726.b5rrsjg7rvei2od5@ppc.localdomain>
References: <20220512123428.fq3wofedp6oiotd4@ppc.localdomain>
        <20220516094726.b5rrsjg7rvei2od5@ppc.localdomain>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 16 May 2022 17:47:26 +0800 Wang Cheng <wanngchenng@gmail.com> wrote:

> 
> ...
>
> This patch seems to fix below bug too.
> KMSAN: uninit-value in mpol_rebind_mm (2)
> https://syzkaller.appspot.com/bug?id=f2fecd0d7013f54ec4162f60743a2b28df40926b
> 
> The uninit-value is pol->w.cpuset_mems_allowed in mpol_rebind_policy().
> When syzkaller reproducer runs to the beginning of mpol_new(),
> 
> 	    mpol_new() mm/mempolicy.c
> 	  do_mbind() mm/mempolicy.c
> 	kernel_mbind() mm/mempolicy.c
> 
> `mode` is 1(MPOL_PREFERRED), nodes_empty(*nodes) is `true` and `flags`
> is 0. Then
> 
> 	mode = MPOL_LOCAL;
> 	...
> 	policy->mode = mode;
> 	policy->flags = flags;
> 
> will be executed. So in mpol_set_nodemask(),
> 
> 	    mpol_set_nodemask() mm/mempolicy.c
> 	  do_mbind()
> 	kernel_mbind()
> 
> pol->mode is 4(MPOL_LOCAL), that `nodemask` in `pol` is not initialized,
> which will be accessed in mpol_rebind_policy().

Thanks, I added the above to the changelog and I plan to import the
result into mm-stable later this week.

> IIUC, "#syz fix: mm/mempolicy: fix uninit-value in mpol_rebind_policy()"
> could be sent to syzbot+ad1b8c404f0959c4bfcc@syzkaller.appspotmail.com
> to attach the fixing commit to the bug. WDYT?

Could be.  The "syz fix" isn't a thing I've paid much attention to. 
I'll start doing so ;)

