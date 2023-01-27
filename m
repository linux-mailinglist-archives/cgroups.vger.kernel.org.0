Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31E67F099
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 22:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjA0Vo4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 16:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjA0Vox (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 16:44:53 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B3B80014;
        Fri, 27 Jan 2023 13:44:34 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k13so6360821plg.0;
        Fri, 27 Jan 2023 13:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGyEe5r+NojLRSHukODHgweo3795xTuuhhKFb1p2rKo=;
        b=VVClLmEPsUs9mjKaayyyC5mh2eOFGjtp5LxcHfc7P9UlzPULKquyQZuXhdzBYjWskB
         cY+T8fXqgz2lgHkfuFYTZGXNLG8iTep3xXcGfGIQWrWDHFeT1iGMNzYJ79a7sLcFfgBj
         PHB9PbYr2Yi05ss+681fc7wf/O4e6J3vd4JedzmNXg00rXoD7/BGx25KLKKfzZb+35lR
         naDMMn14bOioHB5fz0Oic1JdIiO8eo99pOipmiC3OwSEhuAl8GzaAUemQpMQovnJ7YQ8
         S9hYzb1loWgT/dkcLt79/yjOfmkoPN42XN21dnWzctMUvZbbN9jpn95JVynnO1jQmvM6
         pT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGyEe5r+NojLRSHukODHgweo3795xTuuhhKFb1p2rKo=;
        b=3fFNpONNJBeaHYGntdJexoyYhv/1t7q3d/CTMWNqjfEWAs1BJONwwa1Rwt3+KmETdP
         gVQwsVikO54fB9JwieLvKzHlmqxqQLptaHZUr7OeMxaD4ma9++dj+mKKNfQFJt1wQml4
         13NQziYOakGZ4MNnD5pSRJSRsK9i8EFIAulP1DObL9em1W6YgiM+mImp9csDlPJ5nXlk
         +IO+tNi0wfSFMQ2J0dqH3KeDRIiHAqxS17U1tJG/dxSEhvpf3Dqfce8SOO2tIkMvYYRT
         TVtcaz3uAGzTTLSSve0RAQwQNEAEVearYLaIIHcq1dCzwLabSwRIeYI/oyDcSovO8kDT
         RxRg==
X-Gm-Message-State: AFqh2kr8B1/Z8vRbFWHrXXb38SnnsBOPCdi0Q0qNtjEfxafYO0C4Xhbx
        T2mt8etwQmacN1ipWo4nFGQ=
X-Google-Smtp-Source: AMrXdXvg9xeWLi95LLoBVMsG4rR/NetrqF9W6r+y4Yq1/r2ua4S9qisTOZupoPVmcgv2pKv8gBCSnA==
X-Received: by 2002:a17:902:bd07:b0:192:8d17:78e0 with SMTP id p7-20020a170902bd0700b001928d1778e0mr39591462pls.42.1674855861379;
        Fri, 27 Jan 2023 13:44:21 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902c74500b00183c67844aesm3334819plq.22.2023.01.27.13.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 13:44:20 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 27 Jan 2023 11:44:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y9RFs+90TyzVMs83@slm.duckdns.org>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <183372b80aac73e640d9f5ac3c742d505fc6c1f2.1674538665.git-series.apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <183372b80aac73e640d9f5ac3c742d505fc6c1f2.1674538665.git-series.apopple@nvidia.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 24, 2023 at 04:42:43PM +1100, Alistair Popple wrote:
> If too much memory in a system is pinned or locked it can lead to
> problems such as performance degredation or in the worst case
> out-of-memory errors as such memory cannot be moved or paged out.
> 
> In order to prevent users without CAP_IPC_LOCK from causing these
> issues the amount of memory that can be pinned is typically limited by
> RLIMIT_MEMLOCK. However this is inflexible as limits can't be shared
> between tasks and the enforcement of these limits is inconsistent
> between in-kernel users of pinned memory such as mlock() and device
> drivers which may also pin pages with pin_user_pages().
> 
> To allow for a single limit to be set introduce a cgroup controller
> which can be used to limit the number of pages being pinned by all
> tasks in the cgroup.

The use case makes some sense to me but I wonder whether this'd fit a lot
better in memcg rather than being its own controller.

Thanks.

-- 
tejun
