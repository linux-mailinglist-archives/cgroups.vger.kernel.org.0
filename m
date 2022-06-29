Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4337560A43
	for <lists+cgroups@lfdr.de>; Wed, 29 Jun 2022 21:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiF2T0D (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Jun 2022 15:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiF2T0B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Jun 2022 15:26:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CC9393F4;
        Wed, 29 Jun 2022 12:26:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id n12so16074538pfq.0;
        Wed, 29 Jun 2022 12:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FOvU7kkY3061/Y6ML2riqvq9E9PyjzheNXe1X2hbYKw=;
        b=V9dUu8WtJeBE8oGYB7nq+4RFkzp3O7qiE28jpnaaEt3/FzsvCqubr9YdtYM6mODSY8
         dIUJluVOX75DHnavuyZ+/jgaLm4g8f4cYXnC8EMbWW/f54M1wsTwqtBLsQZzSnDQjQhu
         4fCs36fLopglf6HJXBUSbNnZPK18HlPzMa/J/sN4owOeqydod23RerxcOZIP5cpVTjWP
         77ukE+oErNdhKUIj9uRPop6ewX/GaseO3pgjt7dRfQIhgFu9YBcvdOrA0AW4z9yXjnTl
         +bpTkGSPWzroB99J7apjT2zvpSRe4o81bpRqoo1JMcNLcnp8Ou1XO/++4YqaIB3s0AfA
         DJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FOvU7kkY3061/Y6ML2riqvq9E9PyjzheNXe1X2hbYKw=;
        b=deyC3/FXV0DNoltGsny951WiukZAWXp7PPW1pCGyWqowkJINc7+UjuLrtqmoq5UF+s
         e8fQq1YMnvOJFzAKX/nV2pFdbLxXjS9WRJF1qZuvC/a2r22+GFZreYvyBCBpTEHxdZTy
         yArS3CkBDZQ+H1HV7r8fvGFXss3km4P5/rvMhHmhZxGwPTwnyNG6Jkep8VFNjVzYV6sL
         sXnJ6gWYv9B9+DfYEs3aLSU0zZ9bteblLIf+vpOzucA0y0XCA4b3UWayFxAoiCEDZM8d
         yawZbhZKGgtLr35g2dLrNvL0168IOOA2coA/PQOq5TQzVbC2z4/+5z5dJIVEq5duVuP7
         SXIA==
X-Gm-Message-State: AJIora/qRhD5UyPOCaySVfWvKb0/h5kBs7vtr37gWnPGSWT8QvFlHB4C
        ii4vQOIi3kfS28EqvE/r5SM=
X-Google-Smtp-Source: AGRyM1s9PWFUePsrgxouv4bRlaFMJX43z4TgMgAlzze33zra36HsiJNiy8+Ij5rCI2jNQP8TjRo+fA==
X-Received: by 2002:a63:5203:0:b0:40d:bf0c:d123 with SMTP id g3-20020a635203000000b0040dbf0cd123mr4133227pgb.287.1656530760072;
        Wed, 29 Jun 2022 12:26:00 -0700 (PDT)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a0a8900b001eee5416138sm2566952pjw.52.2022.06.29.12.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:25:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 30 Jun 2022 04:25:57 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH cgroup] cgroup: set the correct return code if hierarchy
 limits are reached
Message-ID: <YrynRcW4/B2nl/kK@mtj.duckdns.org>
References: <186d5b5b-a082-3814-9963-bf57dfe08511@openvz.org>
 <d8a9e9c6-856e-1502-95ac-abf9700ff568@openvz.org>
 <YrpO9CUDt8hpUprr@castle>
 <17916824-ba97-68ba-8166-9402d5f4440c@openvz.org>
 <20220628091648.GA12249@blackbody.suse.cz>
 <YrrIWe/nn5hoVyu9@mtj.duckdns.org>
 <525a3eea-8431-64ad-e464-5503f3297722@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <525a3eea-8431-64ad-e464-5503f3297722@openvz.org>
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

On Wed, Jun 29, 2022 at 09:13:02AM +0300, Vasily Averin wrote:
> I experimented on fedora36 node with LXC and centos stream 9 container.
> and I did not noticed any critical systemd troubles with original -EAGAIN.
> When cgroup's limit is reached systemd cannot start new services, 
> for example lxc-attach generates following output:
> 
> [root@fc34-vvs ~]# lxc-attach c9s
> lxc-attach: c9s: cgroups/cgfsng.c: cgroup_attach_leaf: 2084 Resource temporarily unavailable - Failed to create leaf cgroup ".lxc"
> lxc-attach: c9s: cgroups/cgfsng.c: __cgroup_attach_many: 3517 Resource temporarily unavailable - Failed to attach to cgroup fd 11
> lxc-attach: c9s: attach.c: lxc_attach: 1679 Resource temporarily unavailable - Failed to attach cgroup
> lxc-attach: c9s: attach.c: do_attach: 1237 No data available - Failed to receive lsm label fd
> lxc-attach: c9s: attach.c: do_attach: 1375 Failed to attach to container
> 
> I did not found any loop in userspace caused by EAGAIN.
> Messages looks unclear, however situation with the patched kernel is not much better:
> 
> [root@fc34-vvs ~]# lxc-attach c9s
> lxc-attach: c9s: cgroups/cgfsng.c: cgroup_attach_leaf: 2084 No space left on device - Failed to create leaf cgroup ".lxc"
> lxc-attach: c9s: cgroups/cgfsng.c: __cgroup_attach_many: 3517 No space left on device - Failed to attach to cgroup fd 11
> lxc-attach: c9s: attach.c: lxc_attach: 1679 No space left on device - Failed to attach cgroup
> lxc-attach: c9s: attach.c: do_attach: 1237 No data available - Failed to receive lsm label fd
> lxc-attach: c9s: attach.c: do_attach: 1375 Failed to attach to container

I'd say "resource temporarily unavailable" is better fitting than "no
space left on device" and the syscall restart thing isn't handled by
-EAGAIN return value. Grep restart_block for that.

Thanks.

-- 
tejun
