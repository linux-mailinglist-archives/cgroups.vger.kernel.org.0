Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C65C5AF258
	for <lists+cgroups@lfdr.de>; Tue,  6 Sep 2022 19:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiIFRYF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Sep 2022 13:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239768AbiIFRXv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Sep 2022 13:23:51 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975DD8B995;
        Tue,  6 Sep 2022 10:13:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so15644844pjq.3;
        Tue, 06 Sep 2022 10:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date;
        bh=42bQWA0qZBsxm3OOPTZKyEAb0lweU3co0C6JWYj3U0Y=;
        b=CAF0j+NHyujvUVorHf1g2IPoP/FNkjlA1Dm3pUNb/eAjF/7d+k+3EkfRyFx4M0jM4e
         gtoiQMCyWlfphdr+MYytsA+fF8SAg3rYUlI7O9gKyIE7MDTZcCnQV1fxz6b2C0xaPHIY
         XK4hwFkPK/pFcCD9quOMLZl8hoBj4PGHlPbR/yKJIaSJuA1Fw6TU/Fmjl+TnKU9liVyG
         TqCj1HUz36yHyLJ5Gb+XzxttyngfyKAt8GR8e9+IdqJ/8sWtGhY+Zb/crFxPScTEYsPT
         GX5sgkeoOKOexkBQ3AHKHi0LHCZqCyEduyZeal9e+DTZ+LziuzpkUZVJcTZ97dVb9WwU
         aG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=42bQWA0qZBsxm3OOPTZKyEAb0lweU3co0C6JWYj3U0Y=;
        b=vaHG+7Y8UCuEkscRABJ2tsAbXq6QlVRsIxpcUMXNwFLZaLPLiu4AVPFET9FHHPNS/i
         El46kjgVW1maZgpcAEpPJPxMcR9wBrcZMq2Xd3RWVvk97G3t1YmiV9IsnvVasXdEOMDh
         +2QKM2yVp2pGMWeGRAkpNFyrbyiXjG/VL2HJZWMS4OqSL4uelTJa++fmC7ooTd/c0J1c
         breaNzI7FR2eapDoYTgBA4bj1LLJPrfNNue59DwqnWL9Az2FaQ7cz3zcftosaZTlfDMq
         iSPfUYpUf2JInBXDGCuviKRuhYbZhtY+0G42Br8r0qV6UyS/zGcl4obM/zmKbEvJ7rfy
         TyAA==
X-Gm-Message-State: ACgBeo3fC6NX6IGKagNzlKDDEuHqLeIWDoh1Okm8hlEAuzo7tpRdq4jt
        M91busRLGp94/aYVSvj7YJs=
X-Google-Smtp-Source: AA6agR7mkh5p4S5cPy0Zlo5cUhrdX8v/IxiU7K5waCfIyvFuWmkgO5elRjw+b0gdnLwU68NjsIh8ZQ==
X-Received: by 2002:a17:90b:388e:b0:1fb:62c1:9cb7 with SMTP id mu14-20020a17090b388e00b001fb62c19cb7mr25098791pjb.207.1662484403359;
        Tue, 06 Sep 2022 10:13:23 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q61-20020a17090a4fc300b001fa9e7b0c3esm9024505pjh.41.2022.09.06.10.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 10:13:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Sep 2022 07:13:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] cgroup: Reorganize css_set_lock and kernfs path
 processing
Message-ID: <Yxd/sUQ/NB3NlC6f@slm.duckdns.org>
References: <20220905170944.23071-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220905170944.23071-1-mkoutny@suse.com>
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

Hello, Michal.

On Mon, Sep 05, 2022 at 07:09:44PM +0200, Michal Koutný wrote:
> I considered adding get_cgroup() into current_cgns_cgroup_from_root to
> avoid reliance on the transitive pinning via css_set. 
> After reasoning about no asynchronous NS switch and v1 hiearchies kill_sb it
> didn't seem to bring that much benefit (it didn't compose well with
> BUG_ON(!cgrp) neither).

I still think this is too subtle and incidental. If we go this way, we'd
need to add comments explaining why this obviously confusing pattern (lock,
find obj, unlock, use obj) is being used which goes into how the object is
directly pinned through the css_set which happens to be pinned also
because... and so on. Even if the code looks a bit uglier, I'd much prefer
straight-forward pinning.

Thanks.

-- 
tejun
