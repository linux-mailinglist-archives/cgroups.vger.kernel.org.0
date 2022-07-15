Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F176576207
	for <lists+cgroups@lfdr.de>; Fri, 15 Jul 2022 14:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiGOMpn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jul 2022 08:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGOMpm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jul 2022 08:45:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6046C129
        for <cgroups@vger.kernel.org>; Fri, 15 Jul 2022 05:45:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA45B34D8F;
        Fri, 15 Jul 2022 12:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657889139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZa4+jMpT3rkbUbFtzmtQFirgHMD5Uw1UtC1qekP12c=;
        b=H/DS2GYvkohsGsKHCbE2JLE/fFca54l4n/YuYnlwfn7LbkXkOfRLUSOVMtiWaF2+M2ap9p
        PGgCQW4eGeRbY0Rr2U62vWbmYtwaXYpW2IqdNxA55FmUBpznKKthHc0YqBcd3QNHaOs/e/
        wZgU2xHoStzDXp+AVK8+/kgt3ZgDup4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7F8113AC3;
        Fri, 15 Jul 2022 12:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JS/eK3Nh0WK9FgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 15 Jul 2022 12:45:39 +0000
Date:   Fri, 15 Jul 2022 14:45:38 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "taoyi.ty" <escape@linux.alibaba.com>
Cc:     lizefan.x@bytedance.com, Tejun Heo <tj@kernel.org>,
        hannes@cmpxchg.org, cgroups@vger.kernel.org
Subject: Re: Question about disallowing rename(2) in cgroup v2
Message-ID: <20220715124538.GB8646@blackbody.suse.cz>
References: <1c9d5118-25fa-e791-8aed-b1430cf23d36@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c9d5118-25fa-e791-8aed-b1430cf23d36@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Escape.

On Tue, Jun 28, 2022 at 09:09:48PM +0800, "taoyi.ty" <escape@linux.alibaba.com> wrote:
> I found that rename(2) can be used in cgroup v1 but is disallowed in cgroup
> v2, what's the reason for this design?

There's some info in the commit 6db8e85c5c1f89cd0183b76dab027c81009f129f.

> rename(2) is critical when managing a cgroup pool in userspace, which uses
> rename to reuse cgroup rather than mkdir to create a new one，

Strictly speaking, it's not critical if you decouple your job and cgroup
naming scheme (i.e. use the cgroup with the old name).

> this can improve the performance of container concurrent startup,
> because renaming cgroup is much more lightweight compared with
> creating cgroup.

Do you have some numbers for this?
You can save work with not rmdir/mkdir'ing but you mention
concurrent startup specifically. And you still need to (re)setup
the cgroups after reuse and that also isn't parallelizable (at least you
need to (re)populate each reused cgroup, which is mostly under one
lock). (Even cgroup1_rename() has an exclusive section under
cgroup_mutex but it looks relatively simply.)


Michal
