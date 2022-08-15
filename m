Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FE65948E1
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 02:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346370AbiHOXme (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 19:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354329AbiHOXlx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 19:41:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9CE2C66F;
        Mon, 15 Aug 2022 13:12:46 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id f28so7517886pfk.1;
        Mon, 15 Aug 2022 13:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=4ge96+G7p+gdjTYmHEuqmuSxfOOy8/jVGuHx76Z8uTY=;
        b=pLp2CiRi+Q0codn/rk0EUtKXWKYbBTq4iQ1i0IS8oj2p881Cp5/783eDfJBXDkuqIU
         jjJs9qY3y/DHGcUDIdRbaCh9dkPrWj84/Rf0ZzDNoWCj5sxoRKDDNuhsaFm17B4b9Hx1
         k5KRl39FLK4MkAbHYeLrBvTexfeNTeu5cWnaKgf+BzKHrGhDfTH8hbj0MNMbBvTs/kJR
         JU+Lrnbjt1EkY2ulXYMkOIvCmOR82l6Y0YYJxkjR4IWoHNW0+9Xc5kyrR50WROX/+ti+
         HBGuR+L4Qx0G3vttyZ4FBcnOUp87yMYKnWnvuNZOe2ozDCx+kp3Qra4iWOZHUpnVyQE5
         frUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=4ge96+G7p+gdjTYmHEuqmuSxfOOy8/jVGuHx76Z8uTY=;
        b=r317OAC0h36DYF9qZ3IRAqC/aUntS3lW6pb4Tvz3WqflMdCjn088GhyA5JdKPQTsLO
         aFCYWd20KBtNMtQEcq+TPISb1bS+cNb/8AWLoIe1xUDgVM7k6KUhxRFxkCYAhd5DC5Y5
         05dAh/VrGw7OzHNFrhTNGWwOEq/VH7WwCMFwsJNDULOmFKIgDGDHc+S1Tw/WfWFl01/R
         nx/vWKUGskQhqWvyK+GUy2mHnEGuudgw2co78AG5wviYfYTOH7WtpegiizyqXUY1TTmg
         z9x3rJ9A+Oj61GxeyXkNtox5PoYcBuFQQWPF3lnXp17lypAAZ7Sq2xPVTWP3dosn3Zrx
         TUAQ==
X-Gm-Message-State: ACgBeo3/pOD1/7sF+OW1nCK3u/CFUPnckAKDimA5+KeflnIoUzjqwJA8
        ir85kvuTco8l1v3dZ+/8iBA=
X-Google-Smtp-Source: AA6agR5sTy8gJWEQW/VbC65qEQq6LDfwouCpv9FRONRd3eINTHpJls4f7qaUYSGKduWFCqZn2f6waA==
X-Received: by 2002:a65:6bc4:0:b0:3c2:2f7c:cc74 with SMTP id e4-20020a656bc4000000b003c22f7ccc74mr14854282pgw.307.1660594366059;
        Mon, 15 Aug 2022 13:12:46 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:3a69])
        by smtp.gmail.com with ESMTPSA id w9-20020a627b09000000b0052ddccd7b64sm6877339pfc.205.2022.08.15.13.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 13:12:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 15 Aug 2022 10:12:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH] cgroup: use root_mem_cgroup as css when current is
 not enabled
Message-ID: <YvqovLtVv8C3Zifj@slm.duckdns.org>
References: <1660298966-11493-1-git-send-email-zhaoyang.huang@unisoc.com>
 <YvakpukeF9d35Bc8@slm.duckdns.org>
 <CAGWkznG6n=+v7hUKR8Rmg8VEF=BTDegk8bh6aHfvOU5TbmeXDw@mail.gmail.com>
 <CAGWkznHa9WTV2oK=HB1OVEdKeMZ1V2omDDiNrRdyBdyYd=q5Fg@mail.gmail.com>
 <CAGWkznEQ_njmNt8usr-DyaiYDAHJE-niC2QxoXPQkDqY7v_Mqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznEQ_njmNt8usr-DyaiYDAHJE-niC2QxoXPQkDqY7v_Mqg@mail.gmail.com>
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

On Mon, Aug 15, 2022 at 05:17:03PM +0800, Zhaoyang Huang wrote:
> > > IMHO, I would like to say if it makes more sense as "A given cgroup
> > > always encompasses all the resources consumed in its ENABLED
> > > self-including subtree." Otherwise, how should I couple with the
> > > scenarios I raised in the commit message which I prefer parts of the
> > > subtrees compete for "memory" while others are free for it. The free
> > > here is not only without "min/low/high watermarks" but also not
> > > charged to their own LRU.
> > I would like to state more why these make sense. Memory cgroup is a
> > little bit different to other cgroups, that is, memcg will have real
> > physical resources attached, say pages. From perspective of memory
> > reclaiming, it is odd to find that pages under free memcgs are charged
> > to separate LRUs but without any management(no watermark control) and
> > perhaps affect workingset mechanism by LRU reason. Furthermore, v2
> > should grant the groups with the right to reject the subsys which
> > introduced by sibling enable, which could be deemed as v2's
> > inconvenient. The memcg could also apply subtree_control to enroll all
> > memory back whenever it want.
> As suggested by zefan, raise the practical scenario here to make more
> sense. The issue is observed in android system where per-app cgroup is
> demanded by freezer subsys and part of them require memory control.
> Under this scenario, less efficient memory reclaim is observed when
> comparing with no memory control. It is believed that multi LRU
> scanning introduces some of the overhead. Furthermore, page thrashing
> is also heavier than global LRU which could be the consequences of
> partial failure of WORKINGSET mechanism as LRU is too short to protect
> the active pages.

The basic architecture isn't gonna change and there are fundamental reasons
why things are the way they are. The resources, especially the main ones,
are entangled with each other - e.g. memory, io and cpu are entangled with
each other through reclaim. While we aren't capturing the cpu part yet but
we now do a largely acceptable job of controlling memory and io together.

This is reduction of flexibility compared to cgroup1 and can cause some
inconvenience when transitioning from cgroup1 but the experience has been
that the pros clearly outweigh the cons. Even here, none of the problems
you're listing are architectural. If there are memcg behavior problems, we
should fix them in memcg, not work around by twisting the basic
architecture. Are the problematic memcg behaviors reproducible in upstream?
If so, can you please make a detailed report on those?

Thanks.

-- 
tejun
