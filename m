Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF0D50C998
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 13:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiDWLgj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 07:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiDWLgi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 07:36:38 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2451223B99F;
        Sat, 23 Apr 2022 04:33:42 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id f14so7240249qtq.1;
        Sat, 23 Apr 2022 04:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xhkxBApasO2KYhvHt3jPbkNJA2T8yl9BqHMlLP4VXpA=;
        b=CFpSRiEO5mKHqp+4C7L/51Gw+TWgdVU8xWHIR7s8HlpOIAhNZU6i2MYlZ3rVp/2Vuh
         9KT8wL/j+uGHKeU09zszbomsQPn5qIXhvf14bmRHiysFgMvW6IU7LbpvaR35Dr0ek98Y
         E3D4MYmaamjoRvQ7N6B7RLqhmP8Ur/MIv3vh2vXjJ8nG3rxiKlF3WUMfe9ygqLlQahyo
         kn82ScpaoALRrcJ17gfoyXDOI5PN+NfBXJZRXVL8mtbzW3dIJX+Y+yGblG1V1PafLzWO
         L22ilr8u0Aa00GcGlYQ/Q6GF8scghtVdylnEwlXPJsoudb3FbMRvLXoyLOSrOBRToZha
         kNrQ==
X-Gm-Message-State: AOAM532WgYRThyRyH5qENgSIMc2IwgetEpHAxb3rO72GPjW6d/gDy7Kt
        4Uw++n1YM1HK6nYkCcPWOIE=
X-Google-Smtp-Source: ABdhPJyTDRaw9GNoMENM7hOpIRsOmrMFpvF7BqSNK1AB6k5OCH3BUx2HEWRwgYXzOpTwZ6Z9u0rn+g==
X-Received: by 2002:ac8:5f06:0:b0:2f1:f657:eb3a with SMTP id x6-20020ac85f06000000b002f1f657eb3amr6143327qta.151.1650713621146;
        Sat, 23 Apr 2022 04:33:41 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-000.fbsv.net. [2a03:2880:20ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87d04000000b002e06b4674a1sm2998837qtb.61.2022.04.23.04.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 04:33:40 -0700 (PDT)
Date:   Sat, 23 Apr 2022 04:33:38 -0700
From:   David Vernet <void@manifault.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com
Subject: Re: [PATCH 2/5] cgroup: Account for memory_recursiveprot in
 test_memcg_low()
Message-ID: <20220423113338.yu6inrn2w5zmm3j6@dev0025.ash9.facebook.com>
References: <20220422155728.3055914-1-void@manifault.com>
 <20220422155728.3055914-3-void@manifault.com>
 <YmM0+/P0ro9pPzMf@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmM0+/P0ro9pPzMf@carbon>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 22, 2022 at 04:06:35PM -0700, Roman Gushchin wrote:
> Hopefully no one has a mountpoint with the memory_recursiveprot name :)

Heh, good point. I considered adding another root-level cgroup.features
file to match the features specified in /sys/kernel/cgroup/features, but
ultimately decided it wasn't warranted given that it just duplicates the
information in /proc/mounts.
