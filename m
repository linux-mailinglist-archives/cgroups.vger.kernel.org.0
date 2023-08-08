Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC232773DBC
	for <lists+cgroups@lfdr.de>; Tue,  8 Aug 2023 18:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjHHQV4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Aug 2023 12:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjHHQT6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Aug 2023 12:19:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6129032;
        Tue,  8 Aug 2023 08:49:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 65DF020017;
        Tue,  8 Aug 2023 07:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691479795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lpA4KdrK70TL2Etj3PL1Cfra8aJL0LqY3fuNb0fiTvc=;
        b=mgZVAibaY3lnvIFmOTTHRMtxp3t7qQKh8BnOSevYzZfKQ9ODixCurYGn0FceCkXYyYsp0+
        RvsA+wkdqZohpaqPEn1MlNCQFu0gtGvRAx4qDNx3uVWO++I0kqwdfjEmJD+LpiPmQNnfxG
        pO3CeZANL2wZKxSHtzxRki9EQbPlmFg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37BD813451;
        Tue,  8 Aug 2023 07:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2xkkCvPu0WTBXwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 08 Aug 2023 07:29:55 +0000
Date:   Tue, 8 Aug 2023 09:29:54 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     xiongwei.song@windriver.com, hannes@cmpxchg.org,
        shakeelb@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: add tips for kmem.slabinfo
Message-ID: <ZNHu8m3h3ckn+HeI@dhcp22.suse.cz>
References: <20230808022229.1560559-1-xiongwei.song@windriver.com>
 <ZNG9vwg1K6fn1SvN@P9FQF9L96D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNG9vwg1K6fn1SvN@P9FQF9L96D>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 07-08-23 20:59:59, Roman Gushchin wrote:
> On Tue, Aug 08, 2023 at 10:22:29AM +0800, xiongwei.song@windriver.com wrote:
> > From: Xiongwei Song <xiongwei.song@windriver.com>
> > 
> > No any output from kmem.slabinfo, which is not friendly. Adding
> > tips for it.
> > 
> > Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> > ---
> >  mm/memcontrol.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e8ca4bdcb03c..58d3bd93890b 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5002,10 +5002,8 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
> >  #if defined(CONFIG_MEMCG_KMEM) && (defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG))
> >  static int mem_cgroup_slab_show(struct seq_file *m, void *p)
> >  {
> > -	/*
> > -	 * Deprecated.
> > -	 * Please, take a look at tools/cgroup/memcg_slabinfo.py .
> > -	 */
> > +	seq_puts(m, "This file is deprecated.\n"
> > +		"Please use tools/cgroup/memcg_slabinfo.py, which is in kernel source.\n");
> 
> It'll break the ABI.

Agreed

> The only possible option here is to use WARN_ON_ONCE(), which will print once to dmesg.
> But honestly I'm not sure we need it.

There are systems with panic_on_warn configured. I do not think we want
those to go down just becasue some random tool tries to read this file.
-- 
Michal Hocko
SUSE Labs
