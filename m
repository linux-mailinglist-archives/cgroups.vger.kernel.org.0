Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1F0698556
	for <lists+cgroups@lfdr.de>; Wed, 15 Feb 2023 21:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjBOUO5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Feb 2023 15:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBOUOt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Feb 2023 15:14:49 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3636E25E0A
        for <cgroups@vger.kernel.org>; Wed, 15 Feb 2023 12:14:48 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id fj20so25501056edb.1
        for <cgroups@vger.kernel.org>; Wed, 15 Feb 2023 12:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PGQ2Tjph2raaiJJrHEWHFU5AYzV1uv01WttFdbl8X1E=;
        b=V4bh0Fv36Oc96JTrtwDRSTpRRhi4LZ/kX4qEbvP6JqRfZk1/DM5jUVx5Kyj39yoIhi
         aq33fcQOTI5PPoku2ND7mukiujbjW4a1bQG4ZzuMpv6Onpj3W8XzL9y6VaGZ/XlDqAxd
         MWIEni88bTVGzfFSjBMo33x9Bj5G7hovJOQRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGQ2Tjph2raaiJJrHEWHFU5AYzV1uv01WttFdbl8X1E=;
        b=mtBjWKcia0gmfvjcOSouTRZ00Kl/YekJzKFDf1OJbuwcU51UxrWqjApH02gH/v2kH9
         AjVxBSd6pdZdbx0CpnuLrk1RiiKxXbzhzA1XceZKUaB7mRTAKhbgEFKs65fhPg0NWI69
         e6TnHkcGHJnQzywWNBU6NbMgfTKxvGWdT3fORAosrCD+E7BwqyEy/VoOFuF3Sw2bRGth
         /5IP23DtlTmq5pVUE8rwl0E0zIyStS00rc8jkgWvVEF4zA8Cr0O/I+X+Nhc7iiV6x/u4
         wgP03TJXOg2z1GRDIM3ghlFI4b9wW+9Mw0oSdMX6Z2GAjFtT1JJ0kezaxnQJK5mQ4zO4
         VPbQ==
X-Gm-Message-State: AO0yUKVaUHmPMEfxQuBjxvaXdJQW/GAM2OX7hyGmr8Z9FNeQAH8txB/X
        rCTmIYTE1FWhEKbjAY/lBY/rOoQP56ULYsBknAQ=
X-Google-Smtp-Source: AK7set+dSKoQSLjyBA5q4qLYQu1NbwuwjKzCG8xSJ7uhnxSRSdpxxexO8sVGwZJfj46gMiELemLlcA==
X-Received: by 2002:a17:907:1007:b0:888:a32d:b50 with SMTP id ox7-20020a170907100700b00888a32d0b50mr3185460ejb.40.1676492086456;
        Wed, 15 Feb 2023 12:14:46 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id q25-20020a170906941900b008b13a93ea5esm1746985ejx.215.2023.02.15.12.14.44
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:14:45 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id n20so10494200edy.0
        for <cgroups@vger.kernel.org>; Wed, 15 Feb 2023 12:14:44 -0800 (PST)
X-Received: by 2002:a50:bb2f:0:b0:4ac:c720:207c with SMTP id
 y44-20020a50bb2f000000b004acc720207cmr1826668ede.5.1676492084676; Wed, 15 Feb
 2023 12:14:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Feb 2023 12:14:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjG+MD3JBJ1qN8tD_di9K+kV0_PSe+DE9MRGd8Vco9CNA@mail.gmail.com>
Message-ID: <CAHk-=wjG+MD3JBJ1qN8tD_di9K+kV0_PSe+DE9MRGd8Vco9CNA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Change the return value for page isolation functions
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, sj@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
        mike.kravetz@oracle.com, willy@infradead.org,
        damon@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This v3 series looks like it's making things more readable, so ack as
far as I'm concerned.

But it looks like it's firmly in the "Andrew's mm tree" category, so
I'll leave it up to him to decide.

                   Linus
