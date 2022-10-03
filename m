Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042975F36E1
	for <lists+cgroups@lfdr.de>; Mon,  3 Oct 2022 22:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJCUP3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Oct 2022 16:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJCUP2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Oct 2022 16:15:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815E42A268;
        Mon,  3 Oct 2022 13:15:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c24so10655305plo.3;
        Mon, 03 Oct 2022 13:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=C3/N9hbhwupuGmO0AntkXcuTr5FrNGR8ZHngrdZEthU=;
        b=qRoStCLUpxzw2alYY4nRjwbDniVOp8r0swaVcfpwPdIZNnoFCQ4yfr/+ZSZ1CDeYOs
         z7pb17R3TjBSqJwf5r/yas2oc5Tg5YIcxLhgMAwL8Az8k0PEcg4mVmeiQR3jyRy/AwhO
         +YWF/uUicBgF61WQTFHS1YOx12fHVeKIowPbeQbx+MpvPCBiAd7NAmJcvPGKX+vzyvEP
         lWgbCkExvoG93U49AtvbMOPRVbxtS/ejd3i3tR9o+A3EQBbztZuuvQWE+mjLFEkO272e
         kMxiNlbpxEbPFy58aiweYJFXjJVHhv1oRFonnxwCQWQ5+4UX9EozgbNg3PmZUJENB6nM
         TukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=C3/N9hbhwupuGmO0AntkXcuTr5FrNGR8ZHngrdZEthU=;
        b=UD/G8Nlhb+PxdnTSTfrXDUQ1pmIfu3QdUQqbmEZ1iwshS+lxvKdm6K1Z6veMvvBjHc
         i4acfLEcADlHaLvhiLrAC73mDgw5Jz3NPLM7KKxgxLZ77rxh0mKKuskb0KQnwHcVnI4v
         +s5819KB6uZD6e/tqvtkxvoleJuCowFDTtPVV9VkvgHUKjvIMxF90ztWlZ6Ewd86InQN
         8FtP+4l+DCwkcjH/oIZgdDWQWH8ugfewCn3DPtci7/pRBbq6FEVYxX6w0vHxtBtUZFJV
         d+KdFEVN/Nx0TUPmmgFy83AGpKA/WCXr3jU5Hb8wzstcm4ifAunDlE9kFMmyWsktXXZ5
         8Rmw==
X-Gm-Message-State: ACrzQf3ADmsHquN3snY+NyFCkPYabuE4RPgMZ6r4C52trapcSBu3gcnE
        uvqmd9htjx9WyEHS1uuc3mt/qhzFhuOAIw==
X-Google-Smtp-Source: AMsMyM52XvJpXABGrNU34Tz1SGCYuNUqAG1pM7eFFxSnbt+hDbkTf/b8aWnc/cIS17tC9C+18TN7lw==
X-Received: by 2002:a17:90b:4d08:b0:20a:6861:352c with SMTP id mw8-20020a17090b4d0800b0020a6861352cmr13840900pjb.225.1664828126740;
        Mon, 03 Oct 2022 13:15:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:cb45])
        by smtp.gmail.com with ESMTPSA id v1-20020a626101000000b00543a098a6ffsm7708265pfb.212.2022.10.03.13.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 13:15:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 3 Oct 2022 10:15:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v7 1/3] llist: Add a lock-less list variant terminated by
 a sentinel node
Message-ID: <YztC3BVzOiwOKZij@slm.duckdns.org>
References: <20221003154459.207538-1-longman@redhat.com>
 <20221003154459.207538-2-longman@redhat.com>
 <YzsQZPONIJRgtf3o@slm.duckdns.org>
 <006ebc52-ab37-442a-9ba3-e7b8dff53fab@redhat.com>
 <YzsUgY4CC0SH8Sl2@slm.duckdns.org>
 <8008933b-4a28-19e5-02db-ef1d07eaf952@redhat.com>
 <YzsdsjlMMDFwLOzR@slm.duckdns.org>
 <87e7cd70-4ab6-f33b-ce26-afe2c7c04faa@redhat.com>
 <67f5d0af-dbfa-291a-a596-c90860b94455@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f5d0af-dbfa-291a-a596-c90860b94455@redhat.com>
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

On Mon, Oct 03, 2022 at 03:39:02PM -0400, Waiman Long wrote:
> There are 123 instances where llist_head is referenced in arch, driver,
> filesystem and kernel code. Going through all these to make sure that it
> will all work will be a major effort. I think it will be safer to allow both
> NULL and the sentinel node as the initializers and gradually convert them to
> use the proper llist APIs over time to complete the conversion. I am sorry
> that I can't spend that much time upfront for this conversion effort.

I see. Oh well, thanks for taking a look.

-- 
tejun
