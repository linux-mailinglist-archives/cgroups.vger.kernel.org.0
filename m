Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224A4763FEF
	for <lists+cgroups@lfdr.de>; Wed, 26 Jul 2023 21:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjGZTuD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jul 2023 15:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGZTuC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jul 2023 15:50:02 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC44212B;
        Wed, 26 Jul 2023 12:50:00 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bba04b9df3so1470515ad.0;
        Wed, 26 Jul 2023 12:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690401000; x=1691005800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0fC+88gZBz8jtA7XWzXX83zAKhjWaVQ+UtgjI6/8g4=;
        b=oukBQFR9IQO7+GHjeNafPLNndng0nKABjpaczwth9BgzQpiqLcIQmG3R0hQGndcxJm
         cYdWVh5nwhTZeVggUqY+dTHuIGwyN30/6fp2sp0wyfL72IGfNgg/LyhmK/aOsL0qe9rh
         hdl08+mPzCse2OTUc3DCOSQQdlnPnOVKbMtUM7PQdS9pjxjPVU1Ss81NUNDkqum4hDE7
         kbOOH4W3oJ+SWJh62vMxckP4920VO+vrtvTrkBs9b9GwH/Y8ktjUNvzdGAnSNbKu64a/
         V4UOi3avOQ9xPragbr0BWF/d/6EXsVAYc16BmiSMrYcqsAW0FvN+x0wHlEhYvWG6eIOr
         cRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690401000; x=1691005800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0fC+88gZBz8jtA7XWzXX83zAKhjWaVQ+UtgjI6/8g4=;
        b=abi/rdoXNLzBc9TMGXunPsBtSJk61llCeXQjtVnl6vg3u/H1S0CUZ9mZ5X4iuzsg/f
         CIAAvfh/WfemX/Jal+WRnUNbN1aZ5+gStCIQHltmo8U2Ml7kym9vHavgLGiqjKvNcO+L
         /8kqwTwgMlafrduFI9W4pWRXUkHlrW9uN2VKVjKFHt4Thnolbxu+3ga3hsAcOeR0JBQt
         OPh12QtiUPRr8dqTuDzrlaBhS8EpOxsJKIskRUIEFDk09ECv3/GZssjTzLgIZp6svh2n
         J2NRSUinvGyZLDEcY7VhjR/B9N+65ZEgnDmUfSiFtV2u5IZbu+9oKS3UZiIzUdHJb07w
         /dXQ==
X-Gm-Message-State: ABy/qLYRdb+JfmGxQTKEHIw+kd0nvaV8VRymMLgaMs0/qAPw0hMipPEj
        7RMTZhoqTSFZr4nIidtjHHM=
X-Google-Smtp-Source: APBJJlH9zA2mvZYIt6QxxOCW9WRumbHaz6Bvl8nhJS60Ba3BomJSyn3mO77wiPDJYkyr1sgu1cfIgw==
X-Received: by 2002:a17:903:2286:b0:1b8:66f6:87a3 with SMTP id b6-20020a170903228600b001b866f687a3mr3538222plh.52.1690400999964;
        Wed, 26 Jul 2023 12:49:59 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:18d])
        by smtp.gmail.com with ESMTPSA id iy12-20020a170903130c00b001bbb25dd3a7sm5477801plb.187.2023.07.26.12.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 12:49:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 26 Jul 2023 09:49:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
Subject: Re: [PATCH 16/17] cgroup/drm: Expose memory stats
Message-ID: <ZMF45fhrZhiNdn53@slm.duckdns.org>
References: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
 <20230712114605.519432-17-tvrtko.ursulin@linux.intel.com>
 <ZLsFBHqCQdPHoZVw@slm.duckdns.org>
 <8959f665-4353-3630-a6c7-5dca60959faa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8959f665-4353-3630-a6c7-5dca60959faa@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Jul 26, 2023 at 05:44:28PM +0100, Tvrtko Ursulin wrote:
...
> > So, yeah, if you want to add memory controls, we better think through how
> > the fd ownership migration should work.
> 
> It would be quite easy to make the implicit migration fail - just the matter
> of failing the first ioctl, which is what triggers the migration, after the
> file descriptor access from a new owner.

So, it'd be best if there's no migration involved at all as per the
discussion with Maarten.

> But I don't think I can really add that in the RFC given I have no hard
> controls or anything like that.
> 
> With GPU usage throttling it doesn't really apply, at least I don't think it
> does, since even when migrated to a lower budget group it would just get
> immediately de-prioritized.
> 
> I don't think hard GPU time limits are feasible in general, and while soft
> might be, again I don't see that any limiting would necessarily have to run
> immediately on implicit migration.

Yeah, I wouldn't worry about hard allocation of GPU time. CPU RT control
does that but it's barely used.

> Second part of the story are hypothetical/future memory controls.
> 
> I think first thing to say is that implicit migration is important, but it
> is not really established to use the file descriptor from two places or to
> migrate more than once. It is simply fresh fd which gets sent to clients
> from Xorg, which is one of the legacy ways of doing things.
> 
> So we probably can just ignore that given no significant amount of memory
> ownership would be getting migrated.

So, if this is the case, it'd be better to clarify this. ie. if the summary is:

fd gets assigned to the user with a certain action at which point the fd
doesn't have significant resources attached to it and the fd can't be moved
to some other cgroup afterwards.

then, everything is pretty simple. No need to worry about migration at all.
fd just gets assigned once at the beginning and everything gets accounted
towards that afterwards.

> And for drm.memory.stat I think what I have is good enough - both private
> and shared data get accounted, for any clients that have handles to
> particular buffers.
> 
> Maarten was working on memory controls so maybe he would have more thoughts
> on memory ownership and implicit migration.
> 
> But I don't think there is anything incompatible with that and
> drm.memory.stats as proposed here, given how the categories reported are the
> established ones from the DRM fdinfo spec, and it is fact of the matter that
> we can have multiple memory regions per driver.
> 
> The main thing that would change between this RFC and future memory controls
> in the area of drm.memory.stat is the implementation - it would have to get
> changed under the hood from "collect on query" to "account at
> allocation/free/etc". But that is just implementation details.

I'd much prefer to straighten out this before adding a prelimiary stat only
thing. If the previously described ownership model is sufficient, none of
this is complicated, right? We can just add counters to track the resources
and print them out.

Thanks.

-- 
tejun
