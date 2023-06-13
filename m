Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5917D72E248
	for <lists+cgroups@lfdr.de>; Tue, 13 Jun 2023 13:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240821AbjFMLxK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Jun 2023 07:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240399AbjFMLxH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Jun 2023 07:53:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1C719A5;
        Tue, 13 Jun 2023 04:52:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 522D0224C5;
        Tue, 13 Jun 2023 11:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686657129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xGuAwbZ+ToWocWzlF7uUFTALD/7tV0uI1p0rTYe0rOw=;
        b=T0wn9mJWbyZjRwsgG82QNi/GH9v/gfKYllIRa19GYFZfIeFrZxnN05r2NBWG31Gv0BdOHE
        Xa99ZbS/k4wu7P+HIBADAToF6+U6kIrNU9rgZG7dNRKB3/b8irgVVlRdBEaXCAOQFx1HxL
        jWyJMAbrq2xqZg9KY/6T5D6RkZ9pPXg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3505513345;
        Tue, 13 Jun 2023 11:52:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Av0rDGlYiGTGIAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 13 Jun 2023 11:52:09 +0000
Date:   Tue, 13 Jun 2023 13:52:07 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] cgroup: rstat: Simplified
 cgroup_base_stat_flush() update last_bstat logic
Message-ID: <ssbelevnb6zpeeqwcdmbzepl6igw42azaxcfw3sn5zlubmjwl2@3ipsbldccyiy>
References: <20230518124142.57644-1-jiahao.os@bytedance.com>
 <f39b9229-e59c-2b1c-7f3f-1aeedfad44dc@bytedance.com>
 <5g73i4yvi4ub4dqrf4dnq5qghkyckoygmgd2st6be3gg7twww2@w6zim6nxpt3b>
 <4d49f7e7-2488-9690-258e-34e617cfef6f@bytedance.com>
 <remnwctqmxleig7ywt6puhxnpmzjo7xm6hlfhpnul46ulfnw7j@36sbuxhuatto>
 <d6d19a61-a584-1839-e6cc-ea63479ca800@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6d19a61-a584-1839-e6cc-ea63479ca800@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 12, 2023 at 11:13:41AM +0800, Hao Jia <jiahao.os@bytedance.com> wrote:
> Sorry for replying you so late. I am using RDTSC on my machine (an Intel
> Xeon(R) Platinum 8260 CPU@2.40GHz machine with 2 NUMA nodes each of which
> has 24 cores with SMT2 enabled, so 96 CPUs in total.) to compare the time
> consumption of arithmetics vs copying. There is almost no difference in the
> time consumption between arithmetics and copying.

Thanks for carrying out and sharing this despite not convincing towards
the change.

Michal
