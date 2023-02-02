Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D78688944
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 22:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjBBVwu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 16:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjBBVwt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 16:52:49 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FAB10C6;
        Thu,  2 Feb 2023 13:52:48 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so2523934pjp.0;
        Thu, 02 Feb 2023 13:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPbQKX8+ZHiavjG0GpX1JkPzLwnGdWH//FsOE0v5fqg=;
        b=bTh7QzdUcluIUmAbaGdliBuyZhCIto2AflV+SltaNWnV46dCPIwNeCePIU/9c2iMdE
         c6MwnYIygtVy7olhrptGdPXQjAa9Q6ihDAnkj8cr8R7i20RxQB61n1B4xgkDK0EKyPJU
         H30Ap1rasAQ6UMfg6pTjk6LImI1CDQLtjwa+xH9vtnoJmdbFWtWeI/tom+KRXoLqylLU
         K91crbJ7H5Ct1sRQgomr/sJnDoxBRZnJznWLinf7LvUE3Dnn/1YtM/mbcr0aDOpL8L7+
         teP4fSUkgNPFgT6zZnAvhFu3OaiORiA1SV60V25P7R1rM7RwiBQUTpg9H6jfAVzQD8py
         J+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPbQKX8+ZHiavjG0GpX1JkPzLwnGdWH//FsOE0v5fqg=;
        b=NbrlI6lB4nUPzP4OnJ5Lm6O+/rqnWkGdvEe0TAgsKZCQ9T+MXLP+XkA88mwEdRsTpJ
         lUUHPG0KZXSuYHGY/PEbCvP6LIGshNyWz2R+dsDaqv6nTVP4u0rFXh6wDM4z9loQteFg
         aTWDgDpUUX5FhS2fMg0a3YltaiFIjg373BYcWXgkOGQ8C4l7jASvYO8wnDgNGLg+dHIb
         V8YcmcBE2tozlqXy5/7D9dZejD68wNyczqmxPU73trZGRcTqoaEEzgJXtVBj5bymEfPQ
         o9Xf+aTkYQkuhzdE115qfQItmuNk/uUUdZUR+PPwtH93wrAySDXajqKj9ECkH3VaVDFB
         iKQA==
X-Gm-Message-State: AO0yUKVIGwPQ8fBDw9r2cXaIpS+wJsV5Qs3FIID04eRK4I2wJbWa6PJr
        kccMbB1HyPza73nxvrTzCY0=
X-Google-Smtp-Source: AK7set/cFRC9oQfo/WrRpF8x7EIGkEob+dHPXPcHchy0CCWH9P1qkMtdKzh8ypSv+CCOGvktv5YI8Q==
X-Received: by 2002:a17:90b:3908:b0:22c:838:c27d with SMTP id ob8-20020a17090b390800b0022c0838c27dmr3065234pjb.6.1675374768174;
        Thu, 02 Feb 2023 13:52:48 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:48a9])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090a1d4c00b0022c90b7e3efsm3601494pju.50.2023.02.02.13.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 13:52:47 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Feb 2023 11:52:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 0/2] cgroup/cpuset: Make hotplug code more efficient
Message-ID: <Y9wwrvRDCspI6fhT@slm.duckdns.org>
References: <20230202143200.128753-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202143200.128753-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 02, 2023 at 09:31:58AM -0500, Waiman Long wrote:
>  v2:
>   - It turns out it works around the v1 cpuset missing offline cpu
>     problem better than I originally thought. So the patch description
>     is updated accordingly.
> 
> This small patch series makes the cpuset hotplug a bit more efficient
> by eliminating unnecessary task iteration and cpu/node masks update
> when a cpu hotplug event (online/offline) happens.
> 
> It can also largely work around the known problem of missing previously
> offlined cpus in v1 cpuset with some exceptions.

Imma hold on these patches for now. Let's see how the regression fix goes
and revisit after the merge window.

Thanks.

-- 
tejun
