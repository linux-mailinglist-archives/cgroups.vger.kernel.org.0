Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA39D4D7A16
	for <lists+cgroups@lfdr.de>; Mon, 14 Mar 2022 06:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbiCNFVm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Mar 2022 01:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiCNFVl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Mar 2022 01:21:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F761FCF5;
        Sun, 13 Mar 2022 22:20:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mv5-20020a17090b198500b001bf2a039831so16288828pjb.5;
        Sun, 13 Mar 2022 22:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ziHLpQ3BSJG9uN5+hBB/K6gEy6fyUA7DHi/ja3cIYfM=;
        b=q00xIdHjpKrgKFRyR7NWEIHcwWV9iQlp7ojYRaJVhqNPsW8IakgsMbDhLXKoO2fyMm
         L40MTzx1rNEjjJ+CzfnU3WMxC5v7DI8cQtMqPxxvQZFC9+5LKhGXRghAOSvSUC1jqjdK
         4aa6E9xjaNtqVpZmwcBYJwXWsxu5e9Cn8zLt9bieBt4Kawq1UgTrW0MjTNLKZxeMNO99
         /vdOQN2yQS+f+1MgrodpMUb4Zjj8qVz7yVFH/40/9ocAejfaX0SbcFtwsmfmC3j7HhKM
         AteOHOZv8LgeY609Eka+n4NfJOwKapW1PWiYuHvofNlQQG5jcPkCnD5RFFgaO773uoFp
         Kinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ziHLpQ3BSJG9uN5+hBB/K6gEy6fyUA7DHi/ja3cIYfM=;
        b=W3PU1crilLEKcQp4jfb9K9ATrP1Y8Ov/ZDrq3knAq/7/wlQKV9OG5tPXC446uwXGxw
         ayoK8ZUSoN2i8Q3VAz7ntfK05vO67u3DKNl0BnlSSB/iziavFM9kmnEDdkfkVpzBJAOh
         kIMm6jl0xNZOzaozUlItRP5DlYG7NQc/gsOKHcVwraPGoZvS2xJaAurgrynFHe8aRTka
         28R2m5OY9Yz1vkFvhbxFKNlc46V7uKj2RoWk/kf28HFkkitvsaisBb/gy/VuNlwpEey7
         K8CpvITr9nTJP+6WfUMUO0+uhBNZJiswIUA8bT6E0AEgNAIL9S0LI3Y4JFbllBmAId7i
         cuMA==
X-Gm-Message-State: AOAM531mtXPn3v7Jrlj+7iOszZ59PBCsR5DRYY/Pr9WXxoEgMsg+Vsgu
        gD1JjohbdJHMpKDbLoIYAehEXDKa7dtPZg==
X-Google-Smtp-Source: ABdhPJy2N10/kuyRtzhGAI7OGBTz7x2djL200AEXIwbnCDRPmnlC1B6fOp6bJcJIAV4rclTMXLhI2A==
X-Received: by 2002:a17:903:11c7:b0:151:7290:ccc with SMTP id q7-20020a17090311c700b0015172900cccmr22215622plh.95.1647235230980;
        Sun, 13 Mar 2022 22:20:30 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id mt15-20020a17090b230f00b001bf191e6f08sm15960332pjb.9.2022.03.13.22.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 22:20:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 13 Mar 2022 19:20:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     trix@redhat.com
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: cleanup comments
Message-ID: <Yi7QnANYByb+8aSS@slm.duckdns.org>
References: <20220305204657.707070-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305204657.707070-1-trix@redhat.com>
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

On Sat, Mar 05, 2022 at 12:46:57PM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> for spdx, add a space before //
> 
> replacements
> judgement to judgment
> transofrmed to transformed
> partitition to partition
> histrical to historical
> migratecd to migrated
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied to cgroup/for-5.18.

Thanks.

-- 
tejun
