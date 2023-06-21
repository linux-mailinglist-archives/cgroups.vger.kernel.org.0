Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F94C7390ED
	for <lists+cgroups@lfdr.de>; Wed, 21 Jun 2023 22:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjFUUmZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Jun 2023 16:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFUUmY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Jun 2023 16:42:24 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B377110EC;
        Wed, 21 Jun 2023 13:42:23 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-777a6ebb542so261013939f.0;
        Wed, 21 Jun 2023 13:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687380143; x=1689972143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efNPwXii9p40aEa8rDVFFS1wZk6ktbvmOO6XguzWEk8=;
        b=DeEC7sohDKZ9WK1hcV069v/RrKf2OYtk4yfm9LUKkOHgANu2oXKTruOpn63bjz7Q00
         Rk3blTvq+RMsoJPzTG4zlVbWhm+8YOxVCuhSrA5Or82BE5oVnjnmd1xZdJVHsa7GA8t7
         /pS6bsBroCBBVQW6m1q7B0ex5DB/6rg18UhAXCRVI+4GCe31PJD8GGSK9Cx2MHbqZK6U
         H6OSOvUB1kH3m1iZc0be1q2EO4rxGDGGydfX/1u+KOx+C2GQe0QRA+uJzAo67smH96kJ
         ZZGZ/shnstWohFx9RAOhKZDAsZY7mQGJJxHOqbKb/qyz0l4Uk5rIfbRqhHO4Zl4dNeIg
         2+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687380143; x=1689972143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efNPwXii9p40aEa8rDVFFS1wZk6ktbvmOO6XguzWEk8=;
        b=KBuI1IWdEcAzlPSGxkWvure1lE5iNa+r7hmrSBSVkZc0CkP3CbkTLafB/vAMhJ0n3r
         xB8LmvB3eO/cNlEX/EWkUg0LtgBAmNh9BtCx3knxqkS91YrwxZpORYClVz1IQ284qf8E
         tJgpqxfOhDO+aQmbbO9jJeE1YBoFWSxH/1EToC2GJPcZqTjh1aHM4GmRIP0QiKrR1Z54
         xCw//CxO++h3VkOj5gqyWAM7h/EZFFMGmDHu+mdVVJAmZHK9Bxxgd/sITt9Nigtcb/ST
         b3qI7y+seAJguHfi5k7851bNtphJSOCnTeph5WxI4FDe3qjyr1PyAhhBvCCziZyply/A
         10GQ==
X-Gm-Message-State: AC+VfDxOd1DCySm6/acwk8XIktITgSgON920VKgDvDORsMv1ie3wJ9J5
        rm2siQ7ZL+E1WFt2xM3B5+4=
X-Google-Smtp-Source: ACHHUZ5OvySq5xaRuaNJ+gh/NFTMJ6rkPySVRSoSp6LDuFfHmlPoSi0gM6hmHv82OQbBw9jqUrc6+Q==
X-Received: by 2002:a5e:8515:0:b0:77a:c54c:1e51 with SMTP id i21-20020a5e8515000000b0077ac54c1e51mr12842246ioj.9.1687380142832;
        Wed, 21 Jun 2023 13:42:22 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id ei22-20020a05663829b600b0040f94261ab1sm1584455jab.12.2023.06.21.13.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:42:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 21 Jun 2023 10:42:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] cgroup: Avoid -Wstringop-overflow warnings
Message-ID: <ZJNgrLEE7i9CfUnS@slm.duckdns.org>
References: <ZIpm3pcs3iCP9UaR@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIpm3pcs3iCP9UaR@work>
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

On Wed, Jun 14, 2023 at 07:18:22PM -0600, Gustavo A. R. Silva wrote:
> Address the following -Wstringop-overflow warnings seen when
> built with ARM architecture and aspeed_g4_defconfig configuration
> (notice that under this configuration CGROUP_SUBSYS_COUNT == 0):
> kernel/cgroup/cgroup.c:1208:16: warning: 'find_existing_css_set' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:1258:15: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:6089:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:6153:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> 
> These changes are based on commit d20d30ebb199 ("cgroup: Avoid compiler
> warnings with no subsystems").
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to cgroup/for-6.5.

Thanks.

-- 
tejun
