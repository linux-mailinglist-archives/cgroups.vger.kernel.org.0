Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E6152BF28
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 18:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbiERPpB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 11:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239549AbiERPo4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 11:44:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B85104C83;
        Wed, 18 May 2022 08:44:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E8DD1F8C9;
        Wed, 18 May 2022 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652888694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Li9ptdI+7pbwM42wCuvaB+5mMwjEshptpUoGbDfSMkY=;
        b=fiVX2lKRrKorbVXuGy5EOhLKEcCdgm6LoS8Q1eP9hMLFZ2O3zUvKl1DntQYEBgb0s1ipqE
        H/kIM/mlE/wx9ugHkH4GOKa9eNdWhazdoVMHSX0xucMBrzjBMuZ1NrZX8D8sL7eoM3dPpJ
        2579nbRfMXXYzKEL+5hpZWLzllAZ1FU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D92013A6D;
        Wed, 18 May 2022 15:44:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PAUBEnYUhWJEVAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 18 May 2022 15:44:54 +0000
Date:   Wed, 18 May 2022 17:44:52 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, void@manifault.com,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, shakeelb@google.com, tj@kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: Re: [PATCH 4/4] selftests: memcg: Remove protection from top level
 memcg
Message-ID: <20220518154452.GA22503@blackbody.suse.cz>
References: <20220512174452.tr34tuh4k5jm6qjs@dev0025.ash9.facebook.com>
 <20220513171811.730-1-mkoutny@suse.com>
 <20220513171811.730-5-mkoutny@suse.com>
 <Yn6qrHHS935ppX98@carbon>
 <20220517172443.3e524a8319c693ab24c5f22e@linux-foundation.org>
 <YoRDSfv6xK/R+n+R@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoRDSfv6xK/R+n+R@carbon>
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

On Tue, May 17, 2022 at 05:52:25PM -0700, Roman Gushchin <roman.gushchin@linux.dev> wrote:
> Please, go ahead with it. If anything comes up, it can be addressed later.

I hope I can still post v2 of the tests cleanups (applying feedback from
here), it's in [1] with more info there. (I sent it to a new thread
based on get_maintainers.pl).

Thanks,
Michal

[1] https://lore.kernel.org/r/20220518154037.18819-1-mkoutny@suse.com
