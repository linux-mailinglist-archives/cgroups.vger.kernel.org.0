Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB353624485
	for <lists+cgroups@lfdr.de>; Thu, 10 Nov 2022 15:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiKJOmt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Nov 2022 09:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiKJOms (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Nov 2022 09:42:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60C019288;
        Thu, 10 Nov 2022 06:42:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 83F191FB05;
        Thu, 10 Nov 2022 14:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668091365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QggOl6oet9gjyrUMq6KLf3FzSdMoYy/LwzCTm6J8+gA=;
        b=ZMS072hGRT7Bf0y9PM16lWz0Q8PM65nd78eBvUC9sFc0C1kpezgASqxeIDMK8aTmA7+k+1
        iYFDCN1izrUXQKtA2wb/YLjQSxzOThg5HHql5Iz3xnt8FvW44zm+MpzNTXDLKfVn/MuY7n
        c7Q7OCw4Yfo5nWtlAIE6hJ8bG400Igk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 365111332F;
        Thu, 10 Nov 2022 14:42:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zyNJDOUNbWMnLAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 10 Nov 2022 14:42:45 +0000
Date:   Thu, 10 Nov 2022 15:42:43 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/memcontrol.c: drains percpu charge caches in
 memory.reclaim
Message-ID: <20221110144243.GA10562@blackbody.suse.cz>
References: <20221110065316.67204-1-lujialin4@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20221110065316.67204-1-lujialin4@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jialin.

On Thu, Nov 10, 2022 at 02:53:16PM +0800, Lu Jialin <lujialin4@huawei.com> wrote:
> When user use memory.reclaim to reclaim memory, after drain percpu lru
> caches, drain percpu charge caches for given memcg stock in the hope
> of introducing more evictable pages.

Do you have any data on materialization of this hope?

IIUC, the stock is useful for batched accounting to page_counter but it
doesn't represent real pages. I.e. your change may reduce the
page_counter value but it would not release any pages. Or have I missed
a way how it helps with the reclaim?

Thanks,
Michal

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY20N4QAKCRAkDQmsBEOq
ubBKAQDp1xBK5/DkToOkWZCbNxS9WdDxDYDsi9+ZeCKLncwpHQD9HaNqQZdrxab3
/hyNSLGsED0LyA/3PnNvyOufETMiWQ4=
=jyz6
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
