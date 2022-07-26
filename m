Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD1A58186A
	for <lists+cgroups@lfdr.de>; Tue, 26 Jul 2022 19:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiGZRd0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jul 2022 13:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiGZRd0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Jul 2022 13:33:26 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A11F1C908;
        Tue, 26 Jul 2022 10:33:25 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z3so13977488plb.1;
        Tue, 26 Jul 2022 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=csi8DKhXQqGuLjHDX+zKw1RSlMGZo6HFF9ZyuowCuq4=;
        b=U/SdxptusQuSzFDIruTYLSWMcIba2U5OWiLGu6pkSYGjb1Nx+wNeOoSNQjBOMkxTKz
         zXq9A7gaHKIYjoND1POiRg2zHsufOsMWHHkUyfhwXmVE2gDM5PI+lb8bJX77ZshlVSQ3
         BD/GGKqArAy8NjtbJgFpXv+4ypVe67LSLaNtXmXAf4e07P01qocpHVaitOV1Dt74CRmh
         5iHsteyTsCkZfWuARYvMkM5T0Z9VWKmGwohbrXhhqpaBWb035bzWnKwrHMieeFGdVRWn
         nRQLftN8+acOuqZpW5qWFezxRsXd+GHg9ojbmsZZUUqBS684vqgS93NXMfDN0V3j1rTM
         O2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=csi8DKhXQqGuLjHDX+zKw1RSlMGZo6HFF9ZyuowCuq4=;
        b=O80qXCDgoBJqMNPN67Tv8Cy1oDgVkIVXOdNxt1XiW7Qi1JBxP5Dg4cooKX81hz0sfD
         8+iZIPdYbY19giGHAf1LEHhEW46RsQ/j1oTRP1I1F+atJdNHML87zgVvCkD+JkE1jZRf
         RS3MIH6CdJNaNTQeQQ4og+0p6ZJXrdHhoOyngzaSingrQyodg54VkC3OfxDto4BvkbUb
         OX1/wncw0KcH2bdQMmgW1xFgx+Ppjunpv1O7vFJG4/5gcHCg/E9ep8NLo0oyMQFGafhS
         38D2Qez90totwuBi9GSEtlaUayd1otWsNQk4DvoneMf9k+MDvxBA87kJgO5RlJGeg4US
         pATA==
X-Gm-Message-State: AJIora+lnFzNOgHg1DsGpU/xCVGPYD1zAllLMIr1mo4iGhgcTZ3lFXWQ
        iY093F19lSUcVi++b1+r7cU=
X-Google-Smtp-Source: AGRyM1uBgdQVJl4Bm9xjEtUHzKDAipN4RiFvTrxaA0S/9BoPlUNNz51qEWuZ2WacBAWmp1oZESUjyQ==
X-Received: by 2002:a17:902:b612:b0:16c:d98d:638 with SMTP id b18-20020a170902b61200b0016cd98d0638mr17312229pls.38.1658856804727;
        Tue, 26 Jul 2022 10:33:24 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:370d])
        by smtp.gmail.com with ESMTPSA id qe9-20020a17090b4f8900b001f2ef3c7956sm1904021pjb.25.2022.07.26.10.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:33:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 26 Jul 2022 07:33:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH RESEND 3/3 cgroup/for-5.20] cgroup: Make !percpu
 threadgroup_rwsem operations optional
Message-ID: <YuAlYlPTMbuDjINF@slm.duckdns.org>
References: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
 <YtDvU4jRPSsarcNp@slm.duckdns.org>
 <YtDvl7Qjc5zI3e/b@slm.duckdns.org>
 <YtwFjPnCtw8ySnuv@slm.duckdns.org>
 <20220726143257.GA23882@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220726143257.GA23882@blackbody.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Jul 26, 2022 at 04:32:57PM +0200, Michal Koutný wrote:
> On Sat, Jul 23, 2022 at 04:28:28AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > This makes the hotter paths - fork and exit - slower as they're always
> > forced into the slow path. There is no reason to force this on everyone
> > especially given that more common static usage pattern can now completely
> > avoid write-locking the rwsem. Write-locking is elided when turning on and
> > off controllers on empty sub-trees and CLONE_INTO_CGROUP enables seeding a
> > cgroup without grabbing the rwsem.
> 
> Just a practical note that CLONE_INTO_CGROUP may not be so widespread
> yet [1][2].
> But generally, the change makes sense to me.

Yeah, I was disappoinetd that it wasn't being used by systemd already. It'd
be great if the glibc situation can be rectified soon because this is a much
better interface.

> > +	CGRP_ROOT_FAVOR_DYNMODS = (1 << 4),
> > +
> > +	/*
> >  	 * Enable cpuset controller in v1 cgroup to use v2 behavior.
> >  	 */
> > -	CGRP_ROOT_CPUSET_V2_MODE = (1 << 4),
> > +	CGRP_ROOT_CPUSET_V2_MODE = (1 << 16),
> >  
> >  	/*
> >  	 * Enable legacy local memory.events.
> >  	 */
> > -	CGRP_ROOT_MEMORY_LOCAL_EVENTS = (1 << 5),
> > +	CGRP_ROOT_MEMORY_LOCAL_EVENTS = (1 << 17),
> >  
> >  	/*
> >  	 * Enable recursive subtree protection
> >  	 */
> > -	CGRP_ROOT_MEMORY_RECURSIVE_PROT = (1 << 6),
> > +	CGRP_ROOT_MEMORY_RECURSIVE_PROT = (1 << 18),
> 
> Why this new gap in flag bits?

To distinguish core and per-controller flags.

Thanks.

-- 
tejun
