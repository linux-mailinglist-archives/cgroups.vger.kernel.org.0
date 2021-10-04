Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAFA421450
	for <lists+cgroups@lfdr.de>; Mon,  4 Oct 2021 18:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbhJDQnb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Oct 2021 12:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237288AbhJDQna (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Oct 2021 12:43:30 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D466CC061746;
        Mon,  4 Oct 2021 09:41:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b22so305603pls.1;
        Mon, 04 Oct 2021 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DaLvQvhsWsf+s4lKV5/UMhvRlT3UszqwQeMdAkp1K3Y=;
        b=quXUJID1FdabBGz7mwElEsxPvEcN27h5uU84QFos6CG76Q06RyCwmCRrgwdJ/NtBSe
         eI4YUiwaxF8nBTgUyf0Eapc+zxNNJHBe1gG+O0Kr+uf1lk4zedFsGmcJp8foUlAnk9qF
         ZaKp6+1M+vsx1Vykw52NXb3FwgFrlIfaERdI+0fCUn2Dt8HTz0rp1OxrcLDBbCTkQtcH
         Zw/QwqmiIcpMerEn2QnER5fJkHTlgAQeBEHR3rzdbS8TMMmMzP13C33iHchRML/2fJPj
         d7qvROcOuYc8A14dJR3AIYR7r5o3jQRTeRo9bsfCA0gmgpIZPs22J6pCCFqhdJgpDbp/
         q9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DaLvQvhsWsf+s4lKV5/UMhvRlT3UszqwQeMdAkp1K3Y=;
        b=vR3Dx6eIcNwdsnogfwA38Q45w86Hgyg5r4h7yrUfx1wjLFv2jZnWpZDiwwV1hB5+F1
         NaVS7nkYAR5UNs9Jccu+k2/oPyBm41aJ5KhYFiZVI+MTCYhevvcTlvwJw2eTQZ8f+no6
         mSAZ2pNOqxo7BB4gsGDj0EojmfT+VPdw0w4ztQ7MiLAPdqavFLN+kF87JtkIlD88qhef
         YeCGBu+zbEwhz0hA43GXJhVG8VN7NnzY3K9rlUT89ZxU1tn2gGnOf8vFSrhTuRXY+zgd
         IXHKgJtKgrWYcquv1iqHVcPUT+P8077GX/aqb+JfiYFXi8kuDW5TThVr0IGLNiKw5Z/c
         AV7Q==
X-Gm-Message-State: AOAM533GXnsWtiQU/OYyDsTAzkJgLRQBMaRje10B0Eqh7sr56kz6zZ8X
        5qUYOGaQVzUaJoUeWdWK40A=
X-Google-Smtp-Source: ABdhPJziQ7qIPqhOqCNQxobX3HiRWlGbAVTG4Ptfmt3FZB8v97Nv21tHKuAmJRbQzy2BjS3gECSUiQ==
X-Received: by 2002:a17:903:31cd:b0:134:5b6f:2ff8 with SMTP id v13-20020a17090331cd00b001345b6f2ff8mr619707ple.46.1633365701300;
        Mon, 04 Oct 2021 09:41:41 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id o3sm7214892pfu.126.2021.10.04.09.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:41:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 4 Oct 2021 06:41:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>
Subject: Re: [PATCH 1/1] cgroup-v1: Grant CAP_SYS_NICE holders permission to
 move tasks between cgroups
Message-ID: <YVsuw+UBZDY6Rkzd@slm.duckdns.org>
References: <20210617090941.340135-1-lee.jones@linaro.org>
 <YMs08Ij8PZ/gemLL@slm.duckdns.org>
 <YMs5ssb50B208Aad@dell>
 <CAJuCfpHvRuapSMa2KMdF4_-8fKdqtx_gYVKyw5dYT6XjfRrDfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHvRuapSMa2KMdF4_-8fKdqtx_gYVKyw5dYT6XjfRrDfg@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 30, 2021 at 02:20:53PM -0700, Suren Baghdasaryan wrote:
> Some of the controllers are moving to cgroup v2 but not all of them
> are there yet. For example, there are still some issues with moving
> the cpu controller to v2 which I believe were discussed during Android
> Microconference at LPC 2021.

Care to provide a summary?

Thanks.

-- 
tejun
