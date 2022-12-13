Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3686964BD49
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 20:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbiLMT3s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 14:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbiLMT3g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 14:29:36 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11F0248F5;
        Tue, 13 Dec 2022 11:29:28 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 4so902563plj.3;
        Tue, 13 Dec 2022 11:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7iej3uCNn9r6CuK7MDwP9bcqGiFhUgLAt5WQq2ePLA=;
        b=k8gA9BVoaw8yYqfb3WcJbE9PU/wx0MjT4ZBH29rHEE3YZ3p83vX1GakjNnqCAcr3Oa
         w6DCBxMko8Pkra2ttxA70QRGC/qJ8u41XaQk/aQRUMqKMu+9EdRMvNNYiUYtXquHXbXW
         EQBcIUH+jFUoC1easz32DDyL/LrE0eqZAquVXbEF0JdQmPFImn+DaIcmGyYqrao9JnnG
         OqVnsgPQT6iPNsOraxbEg1fuzcRSct08BKWiI60WV2gSktSzVsDtIzV38eWQE8AeXzko
         Cbhu8ACMVwRUIkiXKZM9+47YNbVzzb9o1LPbCLTf34DBbTVzKUMCElxP8GsBdL+gZDZL
         cnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7iej3uCNn9r6CuK7MDwP9bcqGiFhUgLAt5WQq2ePLA=;
        b=uFpWPXzF3/lVyOHoS0sXiRkp8oXhpU0n1k0pxbR/I+FRCC/S0cVWqSdHq0aeSleve/
         fW0xJ9B6oSwGnV0MxMugqxUsFdlVB2sSIfIMVfndWUEtavTNxvErzMuSTTPx/eVAbTqg
         Fb9UWFv1E/RkQWScObh1APLkQ9vvUKSCnT9iXrecKuTdqcQM0qfHS2tkpy0mERjkaise
         rX3PtkP1ThSyHZsnUUT7M4BAgF7SCaVBgCwQI2L72+djxGT13kWLqchs+eb5McWcD/1h
         TNv2AYU5zXRBz84HWt0XBuikg3aIwB+YZQBMJvOBCRO60B0nUqE/+4XniekjIz4ymzRg
         X9mA==
X-Gm-Message-State: ANoB5pmlOQs7gkOcV0LYv26HBleiTdR1JN9zGxx+V7gkNx5kFHrCGFa9
        D0Uii5Hujy7XfMDFla1qkUk=
X-Google-Smtp-Source: AA0mqf6MdMEtUXS7LxRhF8TBNyTlFws6dl5XBJuxnFV3lLin82JfRprzqq7+XQGJPVPWfRJCnOOBeQ==
X-Received: by 2002:a05:6a20:9c8f:b0:a2:17a6:3e86 with SMTP id mj15-20020a056a209c8f00b000a217a63e86mr5501167pzb.55.1670959768196;
        Tue, 13 Dec 2022 11:29:28 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:c415])
        by smtp.gmail.com with ESMTPSA id c197-20020a624ece000000b005745788f44csm8017095pfb.124.2022.12.13.11.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:29:27 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 13 Dec 2022 09:29:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH-block v3 1/2] bdi, blk-cgroup: Fix potential UAF of blkcg
Message-ID: <Y5jSllwwBdmQ1jQz@slm.duckdns.org>
References: <20221213184446.50181-1-longman@redhat.com>
 <20221213184446.50181-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213184446.50181-2-longman@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 13, 2022 at 01:44:45PM -0500, Waiman Long wrote:
> Commit 59b57717fff8 ("blkcg: delay blkg destruction until after
> writeback has finished") delayed call to blkcg_destroy_blkgs() to
> cgwb_release_workfn(). However, it is done after a css_put() of blkcg
> which may be the final put that causes the blkcg to be freed as RCU
> read lock isn't held.
> 
> Another place where blkcg_destroy_blkgs() can be called indirectly via
> blkcg_unpin_online() is from the offline_css() function called from
> css_killed_work_fn(). Over there, the potentially final css_put() call
> is issued after offline_css().
> 
> By adding a css_tryget() into blkcg_destroy_blkgs() and warning its
> failure, the following stack trace was produced in a test system on
> bootup.

This doesn't agree with the code anymore. Otherwise

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
