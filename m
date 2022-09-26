Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68215EB0FC
	for <lists+cgroups@lfdr.de>; Mon, 26 Sep 2022 21:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiIZTMN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Sep 2022 15:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIZTMM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Sep 2022 15:12:12 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9673A88DCB;
        Mon, 26 Sep 2022 12:12:11 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c7so7390458pgt.11;
        Mon, 26 Sep 2022 12:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=Dyqc18f7tvm496eP3xU3ct8tqy6/7/TepuJUSfhcP1Y=;
        b=pMeDGfIZ6SzFPBlN73M0ajQB/RGF4w2o+TyqK7pty1VyKbu13iZcGmLUl9Bi8c2hPZ
         eKhAKnp3n2f08OHQVHBk0cq8xo4bA/d/+AWNzbMxyzInJS+HoYC1k7Akvf8aYWF6y/LW
         wi5drJ1GstBDZBqr7IBiPDOXPWIee6npCJJtfvXUM1tAnalK/5YXC3k/HJB20y8gAufg
         gOXNdlPoOhFdxQ42BdVqVm8eYolU6FyOpYZN/YR3iqp5eEfmcYK6nWnTM6xergGyXbOQ
         +yOOkfw952go/oFjAV9ndq0eQKqhzSt7kVN5eWnT2Lv0KNiACRPbhJoopFAZY8RnRRAn
         0gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Dyqc18f7tvm496eP3xU3ct8tqy6/7/TepuJUSfhcP1Y=;
        b=1xNzjPEOGKWclsN6NnNfd514BKC4hMkr/E3CHKEchUqkLQICWU3i8M3K5bQf6XuLDR
         Rp9ZfFfmbnsPeS/BUKU+Ii6NZvnbLATksxbU2nZODZSaB+XgHqeVgeDEKq3YL1/61HVi
         Pt9P76JZWlKGLR+dBiaVyTfG3atwv0HWTfoX85AdY4Yo7xhWvpbP5KVwnRGcC8i2duvQ
         0aOl6/dZMj/4eYr7lM4Dl6cXooPkLQ4ijvejUWr9nyD5JtmP95hXwW7EdoQ29Ro0GXrS
         g3OS92fXMa7OsXmrHatw1vJ1R61wMxdYDek0S/0j4lJvbk31Z4bSA/4XsZCyRbNc/1ut
         4Dpw==
X-Gm-Message-State: ACrzQf2QqbgdH1fbzADCiuqi7SX7UJuMI7Yxhou/UQ5VR/CIbhQvP7Or
        QZjIa5+ETVL9MOBNKoga6vs=
X-Google-Smtp-Source: AMsMyM6OoV1vjbpH9Fpg55ZVS2AbhR/iGQF6HZ6Sn1AcxtetxlTu2PFlMqy9JBQn5OW/bdcQwGWkig==
X-Received: by 2002:a63:85c3:0:b0:43a:4c05:c313 with SMTP id u186-20020a6385c3000000b0043a4c05c313mr21577436pgd.418.1664219530946;
        Mon, 26 Sep 2022 12:12:10 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902714d00b00178aaf6247bsm11647718plm.21.2022.09.26.12.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 12:12:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Sep 2022 09:12:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "lujialin (A)" <lujialin4@huawei.com>
Cc:     peterz@infradead.org, Zefan Li <lizefan.x@bytedance.com>,
        cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [question] Is it possible for userspace program to control cpu
 usage time of RT process through cgroup2 now?
Message-ID: <YzH5iM0hy58f0tjd@slm.duckdns.org>
References: <0a83dcd5-b7fd-811c-b8d2-062115fa8c94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a83dcd5-b7fd-811c-b8d2-062115fa8c94@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Sat, Sep 24, 2022 at 05:26:20PM +0800, lujialin (A) wrote:
> Cgroup2 dose not support controling real-time processes and the cpu
> controller can only be enabled when all RT processes are in the root cgroup.
> 
> RT stuff was being overhauled when cpu controller interface for cgroup
> unified hierarchy was being implemented in 2017. It was decided that we
> would like to wait till the RT side settles down and proceed with an
> interface that better matches RT.
> 
> Is it possible for userspace program to control cpu usage time of RT process
> through cgroup2 now? If not, how is the current state looking and is there
> any proposed solution?

Not right now. The hard allocation model is pretty challenging to work with
on cgroup1 - they get enabled when cpu controller gets enabled and being
hard allocations, not allocating any prevents the cgroups from using RT at
all while allocating by default takes away from what others can use whether
that allocation is used or not, so some distros turned them off last I
checked. Overall, I'm not sure hard allocations done this way is all that
useful to manage hierarchically given that the resource has to be hard
partitioned anyway.

Can you describe your usecase?

Thanks.

-- 
tejun
