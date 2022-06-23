Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012D25581DB
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 19:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiFWRHA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 13:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiFWRG3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 13:06:29 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E19551E5D
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 09:55:47 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g186so25666pgc.1
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 09:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxNuJF6Nbe8LLHbYqIbwZg9Zj1L4NANG6tNglCp+Qvc=;
        b=XHUVPgvbh1RbKwDTYzng/n5/obx4NKF4t5gJwAYybq7iw0yl1IDnJnj/UY6lbOdIcC
         JkaxYapcyaMhT7hyRjqzXPDIvNUgOB31tZlsO0LlgDI/TYnfopMr1Zeep1u7xtng6c7U
         Sm3VvZm1doZ/hhaqr8Q85AwjJvT8qWBqtgoRDufLJDPWRTqeYWW1HMtPPhtpNvrt51hn
         OzAAz9xbjUVszG9brdyyjkJOuSgnHuvZ6zm2eprL83/CPtn07FUuEfi6zGOrWwOkzBjA
         pYCc/T8UNb0tsN+TWWA7O5ktS1EBpp22pfEQuQWcMcqlVh/8XUXFTzRxBRfxmd9MTYgU
         9zuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxNuJF6Nbe8LLHbYqIbwZg9Zj1L4NANG6tNglCp+Qvc=;
        b=of5qikIUz3Gkk2o4cOeXcvjq2wqYKfC3NI4aHeH8eItbNciEcC5eki8Bxka+2O4QKp
         7qBQz6vEp4oXylKQt9PC+6Y6q2DNif8ce7nK772IXMeFzKMpSvftN7xrzsv+AVdy/s3i
         3s4YGVW4WI1JxDqN594M/BnAHrkHKrT2Lrow5jn2tgz9WH9/ERXyzrzuRdkK/HOEl4Bc
         Jo7SUfXLf3HYiU7vr4+taZTwT+xqbZ2p82J/t0v7I6HE6YP3HnQsE2n32++3EtGGOk9K
         D0DggDzjEA2H35H5zPjmiXlsBs5pNUHaYxtZ8UHx1UZSvanfbt00m4rEnwxaLN5Voog7
         vTOw==
X-Gm-Message-State: AJIora++yr+A3ih6ikM8LWcU9g7EENeBxyWVFAVJBXlilIkehxzaWM4+
        TpFmTQJxwTOLpw75lT/DbeRMrxCftkF47RD88Z2FOg==
X-Google-Smtp-Source: AGRyM1tEW//oYgmqBPHq48elIVVWT5t+ubvinbX4G1Hc6hZJrESk88dK9Jd6fyiayXLcRsWyQhixpLKJ/IPg7eKqTKc=
X-Received: by 2002:a05:6a00:2393:b0:524:eeb2:5547 with SMTP id
 f19-20020a056a00239300b00524eeb25547mr30203002pfc.8.1656003344568; Thu, 23
 Jun 2022 09:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
 <0fe836b4-5c0f-0e32-d511-db816d359748@openvz.org> <c516033f-a9e4-3485-26d9-a68afa694c1d@openvz.org>
 <YrSP25ebDmXE+kPS@dhcp22.suse.cz>
In-Reply-To: <YrSP25ebDmXE+kPS@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 23 Jun 2022 09:55:33 -0700
Message-ID: <CALvZod4WsmrpfZtfnP4AmvtnkvBRngXXGyhM6+aQzkdfjsinAQ@mail.gmail.com>
Subject: Re: [PATCH mm v5 0/9] memcg: accounting for objects allocated by
 mkdir, cgroup
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vasily Averin <vvs@openvz.org>, kernel@openvz.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 23, 2022 at 9:07 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 23-06-22 18:03:31, Vasily Averin wrote:
> > Dear Michal,
> > do you still have any concerns about this patch set?
>
> Yes, I do not think we have concluded this to be really necessary. IIRC
> Roman would like to see lingering cgroups addressed in not-so-distant
> future (http://lkml.kernel.org/r/Ypd2DW7id4M3KJJW@carbon) and we already
> have a limit for the number of cgroups in the tree. So why should we
> chase after allocations that correspond the cgroups and somehow try to
> cap their number via the memory consumption. This looks like something
> that will get out of sync eventually and it also doesn't seem like the
> best control to me (comparing to an explicit limit to prevent runaways).
> --

Let me give a counter argument to that. On a system running multiple
workloads, how can the admin come up with a sensible limit for the
number of cgroups? There will definitely be jobs that require much
more number of sub-cgroups. Asking the admins to dynamically tune
another tuneable is just asking for more complications. At the end all
the users would just set it to max.

I would recommend to see the commit ac7b79fd190b ("inotify, memcg:
account inotify instances to kmemcg") where there is already a sysctl
(inotify/max_user_instances) to limit the number of instances but
there was no sensible way to set that limit on a multi-tenant system.
