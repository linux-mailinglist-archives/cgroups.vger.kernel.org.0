Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B940476EF2F
	for <lists+cgroups@lfdr.de>; Thu,  3 Aug 2023 18:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbjHCQOY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Aug 2023 12:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbjHCQOX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Aug 2023 12:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B24C198A
        for <cgroups@vger.kernel.org>; Thu,  3 Aug 2023 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691079217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NBGgPFoZzZurgnvdLr2MN4Fp3sMcoIPkqmKxp6vR8Tk=;
        b=RcpU2nRN2gRZzadkoFUjYSwNr1jbOKzOqLbHZtJoBn6/ucq4XaHn7AdcnJRLHn9H0Zt8fV
        e3Y3HAmNM/yU7Gd1f82q2jo1i+B5+WLglsFrHIQM+z9gYmp5iWEQixHuTvVRqqWnGhPD7L
        gdh6vIQuO/lvz9BAIsNZZOncRglxC2o=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-0uu9M-mNMGSHCPZ-JNSPDA-1; Thu, 03 Aug 2023 12:13:36 -0400
X-MC-Unique: 0uu9M-mNMGSHCPZ-JNSPDA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-40a91222d8fso13145431cf.1
        for <cgroups@vger.kernel.org>; Thu, 03 Aug 2023 09:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691079216; x=1691684016;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBGgPFoZzZurgnvdLr2MN4Fp3sMcoIPkqmKxp6vR8Tk=;
        b=XtFV6kiCW+Bw29KOb17d7iBEF5gSFf6lE2EqMGyIRut4C6K3zK6Y6Vfrc/OIYEQdlX
         ZmRUvUvcfVsOebd492arhN5pvpGN2s9hmk+BnwSv354+HS7nkEJZiCwGOnOmIYvH/se5
         nV5LVZWd+Neu2HJblmaGf7ywrelDyTGwEgYLkiFYIIzWXPEyjeLlUeX1X1xOIYBPSgPv
         waNEWOwnT/Osu6Cgll65DGr7ljSCMsVK4MzNbtvRtk3Jmny5AbxqCqhqlR3DkFuuBm+Z
         /2bBr1U3OdeI2sUiYDYPeYiCfMHw/xIF5yk60vmIJvksQLwGpFBQS0T5DbbOp3340tfy
         O3rw==
X-Gm-Message-State: ABy/qLZWwbBF0t9d13JzmLmU4WgZagny93khN479xwOovhV/e9vsxbqx
        E0didntjNXQ3olRAy0NZDHlrxs1FYA6z6ziGoUqio/0nZI9T4fYct5jYr7F5IjuwNfr7w51tI5V
        kJG49gXFmOB3v/HcpBA==
X-Received: by 2002:ac8:5fca:0:b0:403:3583:68eb with SMTP id k10-20020ac85fca000000b00403358368ebmr24199816qta.19.1691079216163;
        Thu, 03 Aug 2023 09:13:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG3VdgGbifhJIhxq1FGS+26MJbVd4+Viv/OOetM8WvY43XGRx4v0KOquoaKU5NzhJrJGpt3Vg==
X-Received: by 2002:ac8:5fca:0:b0:403:3583:68eb with SMTP id k10-20020ac85fca000000b00403358368ebmr24199801qta.19.1691079215899;
        Thu, 03 Aug 2023 09:13:35 -0700 (PDT)
Received: from fedora ([174.89.37.244])
        by smtp.gmail.com with ESMTPSA id h9-20020ac87769000000b004035843ec96sm29261qtu.89.2023.08.03.09.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:13:35 -0700 (PDT)
Date:   Thu, 3 Aug 2023 12:13:26 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: cgroup: fix test_kmem_basic false positives
Message-ID: <tqt5od6fuwid5qf2vjhkxef2swlccpki5oikx4pdoabyycrdpe@kzx2rpscvwgs>
References: <20230801135632.1768830-1-hannes@cmpxchg.org>
 <c40ca485-f52e-411a-9f33-3adabc53c0fc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c40ca485-f52e-411a-9f33-3adabc53c0fc@paulmck-laptop>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 01, 2023 at 09:39:28AM -0700, Paul E. McKenney wrote:
> On Tue, Aug 01, 2023 at 09:56:32AM -0400, Johannes Weiner wrote:
> > This test fails routinely in our prod testing environment, and I can
> > reproduce it locally as well.
> > 
> > The test allocates dcache inside a cgroup, then drops the memory limit
> > and checks that usage drops correspondingly. The reason it fails is
> > because dentries are freed with an RCU delay - a debugging sleep shows
> > that usage drops as expected shortly after.
> > 
> > Insert a 1s sleep after dropping the limit. This should be good
> > enough, assuming that machines running those tests are otherwise not
> > very busy.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> I am putting together something more formal, but this will certainly
> improve things, as Johannes says, assuming the system goes mostly
> idle during that one-second wait.  So:
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Yes, there are corner cases, such as the system having millions of
> RCU callbacks queued and being unable to invoke them all during that
> one-second interval.  But that is a corner case, and that is exactly
> why I will be putting together something more formal.  ;-)
> 
> 							Thanx, Paul
> 
> > ---
> >  tools/testing/selftests/cgroup/test_kmem.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> > index 258ddc565deb..1b2cec9d18a4 100644
> > --- a/tools/testing/selftests/cgroup/test_kmem.c
> > +++ b/tools/testing/selftests/cgroup/test_kmem.c
> > @@ -70,6 +70,10 @@ static int test_kmem_basic(const char *root)
> >  		goto cleanup;
> >  
> >  	cg_write(cg, "memory.high", "1M");
> > +
> > +	/* wait for RCU freeing */
> > +	sleep(1);
> > +
> >  	slab1 = cg_read_key_long(cg, "memory.stat", "slab ");
> >  	if (slab1 <= 0)
> >  		goto cleanup;
> > -- 
> > 2.41.0
> >

The same issue exists in the test case test_kmem_memcg_deletion. I
wouldn't mind posting the patch, but it seems you want to propose
something more formal. Let me know your opinion.

Thanks,
Lucas

