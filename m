Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DD0666F97
	for <lists+cgroups@lfdr.de>; Thu, 12 Jan 2023 11:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjALK3L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Jan 2023 05:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237417AbjALK2B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Jan 2023 05:28:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9DF2019;
        Thu, 12 Jan 2023 02:25:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 900FC3FB4E;
        Thu, 12 Jan 2023 10:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673519138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RFRkZ+Fj3t8T5BZaiHz5NCYqROwzY9AM/nVOyatEKtk=;
        b=kXlRU9udXbFgZotDjntGowEBuvchX+T2tPOQt4l2B/QItP41pyuGf09UekzD58fu0LIxRc
        w76yu+pkH0Ua7YBS6uJ2rwWDxCoFeyaVSAeCGGeNdqLbR3tAQh+xq9uDiO7GTSj2Wj7bNn
        HineNr8vyQXh2nAR99gNAKtfqxMYBuI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6650E13585;
        Thu, 12 Jan 2023 10:25:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9ozhGCLgv2PZJgAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 12 Jan 2023 10:25:38 +0000
Date:   Thu, 12 Jan 2023 11:25:37 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, android-mm@google.com,
        jstultz@google.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 0/4] Track exported dma-buffers with memcg
Message-ID: <Y7/gIRv9aJfPK7/f@dhcp22.suse.cz>
References: <20230109213809.418135-1-tjmercier@google.com>
 <CALvZod4ru7F38tAO-gM9ZFKaEhS0w3KqFbPwhwcTvgJs4xMUow@mail.gmail.com>
 <Y78+rfzXPq5XGs9O@phenom.ffwll.local>
 <20230112075631.wc6fd54ci55drhkp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112075631.wc6fd54ci55drhkp@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 12-01-23 07:56:31, Shakeel Butt wrote:
> On Wed, Jan 11, 2023 at 11:56:45PM +0100, Daniel Vetter wrote:
> > 
> [...]
> > I think eventually, at least for other "account gpu stuff in cgroups" use
> > case we do want to actually charge the memory.
> > 
> > The problem is a bit that with gpu allocations reclaim is essentially "we
> > pass the error to userspace and they get to sort the mess out". There are
> > some exceptions (some gpu drivers to have shrinkers) would we need to make
> > sure these shrinkers are tied into the cgroup stuff before we could enable
> > charging for them?
> > 
> 
> No, there is no requirement to have shrinkers or making such memory
> reclaimable before charging it. Though existing shrinkers and the
> possible future shrinkers would need to be converted into memcg aware
> shrinkers.
> 
> Though there will be a need to update user expectations that if they 
> use memcgs with hard limits, they may start seeing memcg OOMs after the
> charging of dmabuf.

Agreed. This wouldn't be the first in kernel memory charged memory that
is not directly reclaimable. With a dedicated counter an excessive
dmabuf usage would be visible in the oom report because we do print
memcg stats.

It is definitely preferable to have a shrinker mechanism but if that is
to be done in a follow up step then this is acceptable. But leaving out
charging from early on sounds like a bad choice to me.
-- 
Michal Hocko
SUSE Labs
