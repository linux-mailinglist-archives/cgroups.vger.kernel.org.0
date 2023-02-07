Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD3468CBA3
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 02:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBGBDN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 20:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjBGBDM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 20:03:12 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB5134336;
        Mon,  6 Feb 2023 17:03:08 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v23so14086808plo.1;
        Mon, 06 Feb 2023 17:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imn/r+cGKKMSLDP+bAG1xH00VwxyZVzwdCmOeTkk6YA=;
        b=khb4QZQABICsRfT0uDHHbVzA3UBTkoSIM+PpBu5YmfkTOAxqLsLVa1aTVdtzG3Ky2k
         nKQgfiI1azs2+BcZYDC+Gycsy4iDLHVVr3TKWabwrX9b23qV7sMWIHQHdcyCgx/ADfik
         huGHRYbM6/KNcYgxL0UNluXr1VuYJVz18kghNCNtRIk/RdZbE9A1HDC5j6q3QgmiqVQW
         Pw3V4PGQFYzX7R4hgnpmLjZuY2cLjhNla7okQdtM3of0G5ogtwdosidAfWO6J9WKdhjj
         Dy7hGLwxzCA9CIjm+MbrBvfXHW1uugbEDNmXv67msNloH/WE9TsHIBKAy5ij6lVf9foa
         4unA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imn/r+cGKKMSLDP+bAG1xH00VwxyZVzwdCmOeTkk6YA=;
        b=y6gFonmCLyP8UcEs4S+Fvn5NhjQ7RkBr3nDKWuzUWygNv+TbfZJDmE91Dvu2g51Xsp
         ewzYfX5qLLyxZWdxqW8Od0r9x2fmmJN4oZ02iPSqJRRvQ0Ena8YnCmPicSSrKSuTFLAS
         rHP0iGVRXy3sANPoeX92OQPWnhLiF6OfXROZdaulxGzayw4nKn+D4a4VqqsneBhkkd0r
         8zGuqHQgMhxkWFnayItCS1TDZ2JeznTJDLIsfOHihy82/ppKSyASGtB+5CmrqJ5s1N+1
         zWIpGY0/NQBZYSJdHmqMsN421Xu/9PQfKIUV+hNLTSG8ochzDN4hTy+CUE7wcb7cHhNj
         sMFQ==
X-Gm-Message-State: AO0yUKVvvJo0SSp6pxsRQFRru2CJ+AQDrtjyOXE1uwJNEj6NFcG0NVjY
        SAKKx1EGF33NAZOg9jJCtfA=
X-Google-Smtp-Source: AK7set9wrKkTtBWE4UITecsjqSqCYhcbi/RFVpLCoulCEmgB7NT4ly4CEqgt6gzNFmmwg8yCTAceVw==
X-Received: by 2002:a17:902:e3c4:b0:199:1804:246e with SMTP id r4-20020a170902e3c400b001991804246emr686467ple.41.1675731787710;
        Mon, 06 Feb 2023 17:03:07 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-44e6-6a58-44be-40a6.res6.spectrum.com. [2603:800c:1a02:1bae:44e6:6a58:44be:40a6])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ab8900b00198e599f23bsm6727746plr.212.2023.02.06.17.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 17:03:06 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 6 Feb 2023 15:03:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@nvidia.com, jhubbard@nvidia.com, tjmercier@google.com,
        hannes@cmpxchg.org, surenb@google.com, mkoutny@suse.com,
        daniel@ffwll.ch, "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y+GjSTu9vE/A/EKG@mtj.duckdns.org>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
 <Y+Fttp1ozejoSQzl@slm.duckdns.org>
 <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
 <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org>
 <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
 <24668a43-fb00-5240-6072-230c5f5d0943@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24668a43-fb00-5240-6072-230c5f5d0943@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 06, 2023 at 08:00:54PM -0500, Waiman Long wrote:
> If it should not be part of the memcg, does it make sense to make it a
> resource in the existing misc controller? I believe we don't want a
> proliferation of new cgroup controllers.

Yeah, if it's gonna be an independent knob, I suppose so, but I really think
the locked accounting should be tied to the page, which mostly likely would
mean that it'd be tied to the page ownership too making its natural place
memcg.

Thanks.

-- 
tejun
