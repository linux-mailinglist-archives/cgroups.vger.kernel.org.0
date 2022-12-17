Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98C764F88F
	for <lists+cgroups@lfdr.de>; Sat, 17 Dec 2022 10:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiLQJ5L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 17 Dec 2022 04:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLQJ5K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 17 Dec 2022 04:57:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBB21D6;
        Sat, 17 Dec 2022 01:57:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CEDBC608B2;
        Sat, 17 Dec 2022 09:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671271027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SoLRNQRrRqUNC0cGrLyDcGJ7nXiwl9BQ5rqnla0AEQg=;
        b=LzEcwgGhGGz8nj03JB5W4TiSbEKztKdG7hrQa5MIO0bwc5t2NC30MAA0U3vd2UhSj4T2Pz
        Tx7x3OMd+ZGReDRDIwwbXqxis7W8upuGmgfxuw87vV+OuG3oq1SRHDCSet4bS0DJKP0ag6
        XpG0vDOWegM0J6b+oztGV495X5UdU2I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A96941326D;
        Sat, 17 Dec 2022 09:57:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id St90JnOSnWOFNQAAMHmgww
        (envelope-from <mhocko@suse.com>); Sat, 17 Dec 2022 09:57:07 +0000
Date:   Sat, 17 Dec 2022 10:57:06 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mina Almasry <almasrymina@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] Revert "mm: add nodes= arg to memory.reclaim"
Message-ID: <Y52Scge3ynvn/mB4@dhcp22.suse.cz>
References: <20221202223533.1785418-1-almasrymina@google.com>
 <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz>
 <Y5xASNe1x8cusiTx@dhcp22.suse.cz>
 <20221216101820.3f4a370af2c93d3c2e78ed8a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216101820.3f4a370af2c93d3c2e78ed8a@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 16-12-22 10:18:20, Andrew Morton wrote:
> On Fri, 16 Dec 2022 10:54:16 +0100 Michal Hocko <mhocko@suse.com> wrote:
> 
> > I have noticed that the patch made it into Linus tree already. Can we
> > please revert it because the semantic is not really clear and we should
> > really not create yet another user API maintenance problem.
> 
> Well dang.  I was waiting for the discussion to converge, blissfully
> unaware that the thing was sitting in mm-stable :(  I guess the
> 
> 	Acked-by: Michal Hocko <mhocko@suse.com>
> 	Acked-by: Shakeel Butt <shakeelb@google.com>
> 	Acked-by: Muchun Song <songmuchun@bytedance.com>
> 
> fooled me.

Hmm, as pointed out in http://lkml.kernel.org/r/Y5bsmpCyeryu3Zz1@dhcp22.suse.cz
I've failed to see through all the consequences of the implementation.
SO my bad here to add my ack before fully understanding all the
implications.

> I think it's a bit premature to revert at this stage.  Possibly we can
> get to the desired end state by modifying the existing code.  Possibly
> we can get to the desired end state by reverting this and by adding
> something new.

Sure if we can converge to a proper implementation during the rc phase
then it would be ok. I cannot speak for others but at least for me
upcoming 2 weeks would be mostly offline so I cannot really contribute
much. A revert would be much more easier from the coordination POV IMHO.

Also I do not think there is any strong reason to rush this in. I do not
really see any major problems to have this extension in 6.2

-- 
Michal Hocko
SUSE Labs
