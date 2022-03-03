Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E844CC90B
	for <lists+cgroups@lfdr.de>; Thu,  3 Mar 2022 23:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbiCCWdf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Mar 2022 17:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbiCCWda (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Mar 2022 17:33:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFA44DF6D
        for <cgroups@vger.kernel.org>; Thu,  3 Mar 2022 14:32:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4B22E218B8;
        Thu,  3 Mar 2022 22:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646346754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zAFiVjWnJwrSeWw65bTJP2sI95/1TY2jdAcpRUDQbtM=;
        b=VXV9PxiWVt8ldki0V+S8Sfj7c687p9Om5DqH1miJtWATf4hOxUPcw4msG056PF7h12uXyy
        GWj1nCH353Ix4TRBSPj5zbqaiNNKWcpteUC6PB+wNzUtAyrK9wDUgyAz+Iitv1dv9f5T6o
        RcbOrMACuKsRmhFFczzmGXgR6mCyiAw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 094D013A9C;
        Thu,  3 Mar 2022 22:32:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rIbpAAJCIWJVOAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 03 Mar 2022 22:32:34 +0000
Date:   Thu, 3 Mar 2022 23:32:32 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-mm@kvack.org, Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/memcontrol: return 1 from cgroup.memory __setup()
 handler
Message-ID: <YiFCAFZwG//aeQP2@blackbook>
References: <20220222005811.10672-1-rdunlap@infradead.org>
 <20220302185300.GA19699@blackbody.suse.cz>
 <9f8d4ddb-81ce-738a-d1f7-346ff9bf8ebd@infradead.org>
 <20220303101406.GE10867@blackbody.suse.cz>
 <5130da56-0f22-8212-0ea3-6ddb8a8f5455@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5130da56-0f22-8212-0ea3-6ddb8a8f5455@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 03, 2022 at 01:53:03PM -0800, Randy Dunlap <rdunlap@infradead.org> wrote:
> > Isn't mere presence of the handler sufficient to filter those out? [1]
> 
> What is [1] here?

Please ignore, too much editing on my side.

> I don't know of any case where "foo=2" should be passed to init if
> there is a setup function for "foo=" defined.

Good. I was asking because of the following semantics:
- absent handler -- pass to init,
- returns 0 -- filter out,
- returns negative -- filter out, print message.

> > (Richer reporting or -EINVAL is by my understanding now a different
> > problem.)

Regards,
Michal
