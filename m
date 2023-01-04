Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8894F65DFE9
	for <lists+cgroups@lfdr.de>; Wed,  4 Jan 2023 23:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240652AbjADWWp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 17:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240697AbjADWWN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 17:22:13 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A842E3D9DF;
        Wed,  4 Jan 2023 14:21:56 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c2-20020a17090a020200b00226c762ed23so1497320pjc.5;
        Wed, 04 Jan 2023 14:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/3ppUmh4bmqybcFcsNaCu/D7XFzMdaZVgO4yNK9uS8=;
        b=m3Sl/7J9Eg2xJBzdmZbdAe60sOL/fthI5hRvSskmpX6OHx15gV3HeMT50kSGqypuOh
         FCbow/o8gEu5cXqV5g56v5bzEP2U6cGZuJNvfRWaO+dLFhB5eKEX571YWfow8VgC0Vfu
         hCngLTiyWszq+yaoa8COFsKDVGPnTZJnNFt3olQhC/dRejvoy6Qh5WUbe+qDJ0YQ/DzM
         8+p2WwcZXk2+nwhC3EcLF0Tw0EClGyI5FwPJSFUoiBXpN5qKRXPQry85sGYRy+4ez/j0
         M17e5MNoHlAmPyA/fHz4Gkh689AVXyJFuGxYRuSEfNg8daWv61TBk/mopeymvSnfm4AR
         pKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/3ppUmh4bmqybcFcsNaCu/D7XFzMdaZVgO4yNK9uS8=;
        b=NOGG/EGjRp/1FoGA7rZMdBnuYzKU7Z3IPq/rtjUlNJtr8frDUxRjqx/fz4FWZ81y0p
         lML3a3J55mHOm2eFuKKg1Unp+DVayGRr7NRR4IRDhAZ0QErIu6auvEq+1PbiYzyYngjT
         5t00suBPE+ihBP/rYX4gH7TW+j6ywubLxuMcgovi6omQKKhrcMXtU8/37GSJqjAQVW8o
         rGOmVGKsO/5UOpc/WSwbb/5TDJxO1dMKuxP+TxUlF1isomlbX0+DVdEtVvw+L9PB5W2d
         ieIqyfDA2VOlpto/JVBxqxWvD8rSafweTOAG85jDwT+300vUxgUNsG8cRueKymlbtiL2
         DKUw==
X-Gm-Message-State: AFqh2koN2xSS6R5LxEjc9cMILcb5Vfc1O00t5/p/pxmlWs8TarWpTvGa
        ofbPeZoJpYV/0DuV5RUAay8=
X-Google-Smtp-Source: AMrXdXvMb27b+iyK400wTRm1M/yoJxFBm8ykx/ofKk68b0QY7iRWL5gZADL4Q9I45XJj9PZMt4Y+ZQ==
X-Received: by 2002:a17:902:d4ca:b0:191:1f16:efa3 with SMTP id o10-20020a170902d4ca00b001911f16efa3mr54923459plg.65.1672870915949;
        Wed, 04 Jan 2023 14:21:55 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001894881842dsm4553569plr.151.2023.01.04.14.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:21:55 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Jan 2023 12:21:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Vacek <neelx@redhat.com>
Cc:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: no need to explicitly init a global
 static variable
Message-ID: <Y7X8Asv25sntht6t@slm.duckdns.org>
References: <20221220151415.856093-1-neelx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220151415.856093-1-neelx@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 20, 2022 at 04:14:15PM +0100, Daniel Vacek wrote:
> cpuset_rwsem is a static variable. It's initialized at build time and so
> there's no need for explicit runtime init leaking one percpu int.
> 
> Signed-off-by: Daniel Vacek <neelx@redhat.com>

Applied to cgroup/for-6.2-fixes with the following description:

    cgroup/cpuset: no need to explicitly init a global static variable
    
    cpuset_rwsem is a static variable defined with DEFINE_STATIC_PERCPU_RWSEM().
    It's initialized at build time and so there's no need for explicit runtime
    init leaking one percpu int.
    
    Signed-off-by: Daniel Vacek <neelx@redhat.com>
    Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
    Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>
    Signed-off-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
