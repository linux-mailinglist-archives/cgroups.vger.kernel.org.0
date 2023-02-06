Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6591D68C85C
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 22:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjBFVOe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 16:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjBFVOe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 16:14:34 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632FD126F9;
        Mon,  6 Feb 2023 13:14:33 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 203so9358928pfx.6;
        Mon, 06 Feb 2023 13:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOmjkak4hSmRchvmEJgN6IqY5BTXXjlVuAkqhp03RaU=;
        b=Q5VBT+2LKQxS9wiyf3Xi/Hm7NsRvScNG1exKySJO4Dq2OSUmrEmfapxLhGvnAj+nzj
         lIs5CgcCVS5i90KKIQDoyqNgoIhyL/L16hvRw+RHgrv8d0OuvPx2RucHIaT6yM3eeI6c
         VodL4y1qwpNmToerzPOBpI9hUs9WPe9VxU0AY0n5FjEY5lqGxPNXDE8SVCw8TqAECtt0
         4Jwk2uo/SS/hCwspgO7ijlzCfuWtcM16cBVAqg8W72f7DguU3s5ZYlTBHALexjIcU+jV
         vHZv/KMeqeQiRVHoToYdVOBy2maKr2y4PsNiIcD8qcXTG1sC1F1l4/mm5VckTwB7eo9k
         dkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOmjkak4hSmRchvmEJgN6IqY5BTXXjlVuAkqhp03RaU=;
        b=VldUc2MnlinKJJqNsWB/m9Dy2cD9/V8oSdI3HIz07eSQTZ3irfmtT7i88c5Jy6cQUh
         3fSeooV4a1u/NDcINT7MBKxtMEtLwYNVZCjPOMgS1cIW3rvD935NhGe7yUDD+DX3lsiQ
         ByG3tSB+Yf5reNrJCC3fZdQJBlzk0pskRtPgD7M5XEsuUryLU8WyR7El/0OHZsH6W2Mm
         5/SrGEjB5BbybNib7f3t2nnQOHHqIJh6qGcVnoSpzblFRuk9mwYJ38zTEk+OZnidPXkK
         h/Yn5JM4eIwF80KVw9u6W+1zaYX7r3wioMPFImltIrplD9dagUrH9FVSS+IU86Q1KkSF
         H6qw==
X-Gm-Message-State: AO0yUKXQ9h2AzBjSJboxIX6CTqaOsT69E/0tg38t5XSkHeLYOaouURLx
        doQDQ8LCmQTNfxEwPyRZE3A=
X-Google-Smtp-Source: AK7set8HpHmnm5AI0DRSN+d/xw18SaK99JMMN2/w+YbIW1MBZ0n52zMJqXaqJL5jC5vyocknwWbdBQ==
X-Received: by 2002:a62:8412:0:b0:592:3eeb:51d9 with SMTP id k18-20020a628412000000b005923eeb51d9mr979165pfd.21.1675718072596;
        Mon, 06 Feb 2023 13:14:32 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d198-20020a621dcf000000b00593225b379dsm7613137pfd.106.2023.02.06.13.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:14:31 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 6 Feb 2023 11:14:30 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y+Fttp1ozejoSQzl@slm.duckdns.org>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 06, 2023 at 06:47:51PM +1100, Alistair Popple wrote:
> If too much memory in a system is pinned or locked it can lead to
> problems such as performance degradation or in the worst case
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

As I wrote before, I think this might fit better as a part of memcg than as
its own controller.

Thanks.

-- 
tejun
