Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5F25C050B
	for <lists+cgroups@lfdr.de>; Wed, 21 Sep 2022 19:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIURDZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Sep 2022 13:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiIURDE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Sep 2022 13:03:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B718284D;
        Wed, 21 Sep 2022 10:03:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3007C1F8CA;
        Wed, 21 Sep 2022 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663779781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CSBNW4JvmKppsNMMHKaTcBQ/8SMBBa+a7IGCYeQgCtE=;
        b=HMTzIHmeWUNV9l2wsxzfUSlYDCzoRFpj2D0Jd4idAYXKkplJwnqSsc7We8fOPTXX3mCCbs
        lq+ffxVoyltT0YQUQDkoVgNfX/WJnYakasL+RuA16GPfGeekVHOakGz3EjnLAMxmiR9e9E
        N5K9L8Lt4ptHe5BvEeMqjedNyt/Gd68=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1B9513A89;
        Wed, 21 Sep 2022 17:03:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WqE7MsRDK2ORFwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 21 Sep 2022 17:03:00 +0000
Date:   Wed, 21 Sep 2022 19:02:59 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Vasily Averin <vvs@openvz.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, cgroups@vger.kernel.org,
        Sparc kernel list <sparclinux@vger.kernel.org>
Subject: Re: [sparc64] fails to boot, (was: Re: [PATCH memcg v6] net: set
 proper memcg for net_init hooks allocations)
Message-ID: <20220921170259.GI8331@blackbody.suse.cz>
References: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
 <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org>
 <20220918092849.GA10314@u164.east.ru>
 <CADxRZqyyHAtzaaPjcKi8AichGew2yi-_vQcKoLoxPanLvXZL0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqyyHAtzaaPjcKi8AichGew2yi-_vQcKoLoxPanLvXZL0g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello.

Thanks for the report.

On Wed, Sep 21, 2022 at 05:44:56PM +0300, Anatoly Pugachev <matorola@gmail.com> wrote:
> On Sun, Sep 18, 2022 at 12:39 PM Anatoly Pugachev <matorola@gmail.com> wrote:
> >
> >
> > I'm unable to boot my sparc64 VM anymore (5.19 still boots, 6.0-rc1 does not),
> > bisected up to this patch,
> >
> > mator@ttip:~/linux-2.6$ git bisect bad
> > 1d0403d20f6c281cb3d14c5f1db5317caeec48e9 is the first bad commit
> > commit 1d0403d20f6c281cb3d14c5f1db5317caeec48e9
> 
> reverting this patch makes my sparc64 box boot successfully.

The failed address falls into vmmemmap region (per your boot log
output). It looks like the respective page/folio (of init_net struct) is
unbacked there (and likely folio_test_slab fails dereferencing ->flags). 

Would you mind sharing your kernel's config?
(I'm most curious about CONFIG_SPARSMEM_VMEMMAP, I'm not familiar with
your arch at all though.)

Thanks,
Michal
