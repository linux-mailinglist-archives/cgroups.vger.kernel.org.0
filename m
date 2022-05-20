Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5510252F070
	for <lists+cgroups@lfdr.de>; Fri, 20 May 2022 18:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242165AbiETQUl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 May 2022 12:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiETQUj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 May 2022 12:20:39 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055027CDFA;
        Fri, 20 May 2022 09:20:39 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id m1so7768578plx.3;
        Fri, 20 May 2022 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MtVzH3UoF12u8L33efNjqLpTUDtaXmlgKBbTF3gWD9k=;
        b=Dsgg7TZ96W0GRuErppdSf6T4FUWmmZNPMnNO7I+8rmFZ9Wab7KpPZAoYQSzGSPzlhT
         mb0X1UQ+25OgdIChFrz6rVnxb9d+U0p/aU6V3lmCC6hn6/QqDqNfx/FpekIj9bjlmOA9
         PFlhK+DZQ8ibN3OaS6/ADJbQOEZiqGuikFY6jTpZYOIj4L9I/e6OWdc0LKeqEgAhkzMe
         SMiDElqSqUx15bpFQWKQWFSqe+RLP/2OfKdcecnWuwQhOtE/eTNHqm8spfzC1msqPQrZ
         98s9aR05kcj3vJPjsNqGYraDEGpKWwTldO41pcmFmGFbDG+wsboA+O9roKh5t/tN4SY5
         K2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=MtVzH3UoF12u8L33efNjqLpTUDtaXmlgKBbTF3gWD9k=;
        b=ecHy213Fv9HkUWSE0jF3Ouwng68yG0bBjwKfnFCjbK5F8/KgfkPF24g95gyfxve20F
         J82Cr5gErAyJtkgCH1nX6koX7BK/v9fEjVLzAH7og46KjfW8Z/eaGcT3D1gko6nwt/+8
         VunVuq+r56JodQHf6bV5KBCo2rbIoJyy4hiNqWdRiNR4mXmK6WY4E1u1kfZ+Nlhv5eXw
         e+u8dNXNMH5/FwlLRLSECQ/xQrRnOOYTI9b137pRyWLHtqZrI5Anz3SV2CqOqzKyh9aZ
         J8qh7nTNN/UV1lV6kHzHUZBK/P1ieHd0dfROnJaCtC2Rs9jkfbhhopkkKUyd/JJ8sT3v
         McLg==
X-Gm-Message-State: AOAM5334X2tZj78FlyGklhn9cbMZa8HmkEa6a30S0ej9LTYfiDK9tquq
        l0DmiWRJp8kiu1C+1W9Ifh4=
X-Google-Smtp-Source: ABdhPJxYicDnUkYqugMyMSYpobkXd2eA8l55tKWUoCwezF8GqNS+WhSBNQr8HswLB3GaL+Pd+D/MCg==
X-Received: by 2002:a17:90b:4a0f:b0:1e0:edc:c1f with SMTP id kk15-20020a17090b4a0f00b001e00edc0c1fmr101197pjb.93.1653063638340;
        Fri, 20 May 2022 09:20:38 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:1761])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902db0300b0015e8d4eb23dsm5971304plx.135.2022.05.20.09.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 09:20:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 20 May 2022 06:20:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     "yukuai (C)" <yukuai3@huawei.com>, axboe@kernel.dk,
        ming.lei@redhat.com, geert@linux-m68k.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v3 2/2] blk-throttle: fix io hung due to
 configuration updates
Message-ID: <Yoe/1BRYzSRI0JBd@slm.duckdns.org>
References: <20220519085811.879097-1-yukuai3@huawei.com>
 <20220519085811.879097-3-yukuai3@huawei.com>
 <20220519095857.GE16096@blackbody.suse.cz>
 <a8953189-af42-0225-3031-daf61347524a@huawei.com>
 <20220519161026.GG16096@blackbody.suse.cz>
 <73464ca6-9412-cc55-d9c0-f2e8a10f0607@huawei.com>
 <fe3c03f7-9b52-7948-075d-cbdf431363e1@huawei.com>
 <20220520160305.GA17335@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220520160305.GA17335@blackbody.suse.cz>
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

On Fri, May 20, 2022 at 06:03:05PM +0200, Michal Koutný wrote:
> > Then io hung can be triggered by always submmiting new configuration
> > before the throttled bio is dispatched.
> 
> How big is this a problem actually? Is it only shooting oneself in the leg
> or can there be a user who's privileged enough to modify throttling
> configuration yet not privileged enough to justify the hung's
> consequences (like some global FS locks).

So, the problem in itself is of the self-inflicted type and I'd prefer to
ignore it. Unfortunately, the kernel doesn't have the kind of isolation
where stalling out some aribtrary tasks is generally safe, especially not
blk-throtl as it doesn't handle bio_issue_as_root() and thus can have a
pretty severe priority inversions where IOs which can block system-wide
operations (e.g. memory reclaim) get trapped in a random cgroup.

Even ignoring that, the kernel in general assumes some forward progress from
everybody and when a part stalls it's relatively easy to spread to the rest
of the system, sometimes gradually, sometimes suddenly - e.g. if the stalled
IO was being performed while holding the mmap_sem, which isn't rare, then
anything which tries to read its proc cmdline will hang behind it.

So, we wanna avoid a situation where a non-priviledged user can cause
indefinite UNINTERRUPTIBLE sleeps to prevent local DoS attacks. I mean,
preventing local attacks is almost never fool proof but we don't want to
make it too easy at least.

Thanks.

-- 
tejun
