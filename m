Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9958B4F9C0F
	for <lists+cgroups@lfdr.de>; Fri,  8 Apr 2022 19:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiDHR4f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Apr 2022 13:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238389AbiDHR4e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Apr 2022 13:56:34 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5729AF1E1;
        Fri,  8 Apr 2022 10:54:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e8-20020a17090a118800b001cb13402ea2so5916390pja.0;
        Fri, 08 Apr 2022 10:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Ro5wZmz5/qjQoMRhhyRUYMmqQbliREDVqsZ81z5Kko=;
        b=XtxAWitQSB4YBg/9d5jI5GEOZ55aoUF9Ezg/KdD/yMNC9r0yJU7zSrbgzPwx18YsZx
         O7EST5Hup1HYNHyOuU4Gn9xc8kgTc50AWCNDyWpH96BU/O0M7IZLyXntwdM83AvkGJx0
         9PBjLSKeeTk3O17dhV6Cbu6xFO80FcqAIZl0Bxf4Gb+VmR1lg8G6R2ByX7tqfRsZwi2X
         cz34XrBlVXwdt9kcfWX9nfoM9MHeJNJ2omo4yRRqk1a4fZVRvx+lsDRFjzMYYuIxYhB3
         vEP/YhRJE9996VGhwLWbVyM+6pqzFpowHBWHijc3tlSK37o4UU2aJAnzuMENi0Bp3wyd
         WH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4Ro5wZmz5/qjQoMRhhyRUYMmqQbliREDVqsZ81z5Kko=;
        b=XNsIxQag5iSsj/7+1FIh0mWJg4vGbk/wjdXWckm2mvLvx505KSQsXx90RiuurGgRRT
         FnFWY5ThzhCQkxLPXfQnO1oy7PYQVaZ61vEeUJT7Jpm88i0yLuhUOdazfcEVR9C5yuO7
         rZ2hKsrWxIvuj0+tT4etx3Xe2mDQWwMrJvPw8iKE4jVQfy0RxFDLw9n6dR4WQ503jiEz
         vvhd2ztsrl4rHlBhAYgNFRbngOseSyadhfwKk/eIt2iZFmaKn14EldAVyCBxM1B7BfUA
         OlS5QYhylTY+RbIfDBlBinsv0xO38UePSkND6dg7/fGzhnkwr6ufzZfP+wpt2+rjA9NF
         LE8Q==
X-Gm-Message-State: AOAM531QHKMuXkKB3QP6k2pHdiDsFqNfYtl9rBlaqkNQgJoLeCiG6DYt
        ErIFqX5eI1ROnb9TpCfCtTnal2xgq1Q0dw==
X-Google-Smtp-Source: ABdhPJzpOVsiqjyFzsypMF/T5dtprIvNQ1QMuoaYPyf6lVh5hncelAnwYlN6Sr471+vxfXLYhNOvsw==
X-Received: by 2002:a17:90a:cf94:b0:1ca:7ff9:73eb with SMTP id i20-20020a17090acf9400b001ca7ff973ebmr23206297pju.173.1649440469108;
        Fri, 08 Apr 2022 10:54:29 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:ab2a])
        by smtp.gmail.com with ESMTPSA id q203-20020a632ad4000000b003987c421eb2sm22884266pgq.34.2022.04.08.10.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 10:54:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 8 Apr 2022 07:54:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        ke.wang@unisoc.com
Subject: Re: [PATCH] cgroup: fix attach task fail when subtree_control
 configured
Message-ID: <YlB20sw1e998Dant@slm.duckdns.org>
References: <1649413394-17501-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649413394-17501-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 08, 2022 at 06:23:14PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> It is found that task attach to a vacant cgroup will fail when its
> subtree_control has been configured. Fix it by judging if there is no chrildren
> existed.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

If I'm not misunderstanding, that's the intended behavior. Can you please
take a look at Documentation/admin-guide/cgroup-v2.rst and confirm what
you're trying to do?

Thanks.

-- 
tejun
