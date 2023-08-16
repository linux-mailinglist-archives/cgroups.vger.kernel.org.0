Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807F377EB23
	for <lists+cgroups@lfdr.de>; Wed, 16 Aug 2023 22:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjHPU5h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Aug 2023 16:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346324AbjHPU5T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Aug 2023 16:57:19 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9492724
        for <cgroups@vger.kernel.org>; Wed, 16 Aug 2023 13:57:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc6535027aso59195805ad.2
        for <cgroups@vger.kernel.org>; Wed, 16 Aug 2023 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692219437; x=1692824237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PTnRjDgF03Eifi7sf3kpv96X0kZ1CgBBnY922J5YppA=;
        b=YrnJuLkKAUI9GOoFGUyMxaW0N4JvwWCdrMEG+WXxw28UwGdvMagNkGayO+D+VNRv7W
         tdSXtKKS34K9MQ4zDTHtW6q2rQmnBOa1Cm/YWl1qMYvmdTxQHD3MejqhxJNse7BFpFZ4
         taJO9DBM9v9B7HzFifZ/3iQ27MxXyE1MvyhG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692219437; x=1692824237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTnRjDgF03Eifi7sf3kpv96X0kZ1CgBBnY922J5YppA=;
        b=F3I7IG472EwW5yNw2OSkKgmak2S/yJvinQfYzecOw4891Ylt0ZQdyRXXpnv3q6wKwn
         LDw/8VINqZpxLar85lMfRH6MfC1DsLecWN3W/zN+ZNVcPruJSeYXZOCr5a8H3o5yOO5n
         zSIp1etbsQYOZuCrykTyiwzS2Y1DRcH72qZMbChfCJmtr1MWbL4P9EEwpG8k7QOfiDDt
         tIi5rUXH/4T2EKWYOFLn26DUkmcplhAfnzvytnKF69IdOp8vmtWOEu8gFTTYHyr4bs5C
         MMs2HOixwhARUn2oGduXjz0BC7wr1BrNAVft+xIgxw+h9zL9IIBD/W0oqnObL3zhUctm
         UnLQ==
X-Gm-Message-State: AOJu0YzqrfQRd6dMyd0YU4GmnzLO10Y4K1TTrdcD4wwub7thWkA+i5rj
        1l2Ethk2Ikupz/t04O09QuHLpQ==
X-Google-Smtp-Source: AGHT+IG3SG9qeo0oZfUja9go8C9ZZOvux73Nr1ZbS1VQ53Pv2p6wh5BCDdxyWq4rcnvjgBR0dMyodw==
X-Received: by 2002:a17:90a:e38a:b0:268:e43a:dbfd with SMTP id b10-20020a17090ae38a00b00268e43adbfdmr2746938pjz.1.1692219436996;
        Wed, 16 Aug 2023 13:57:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id rj6-20020a17090b3e8600b002680f0f2886sm158262pjb.12.2023.08.16.13.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:57:16 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:57:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] cgroup: Avoid -Wstringop-overflow warnings
Message-ID: <202308161356.4AED47263E@keescook>
References: <ZN02iLcZYgxHFrEN@work>
 <ZN02wFqzvwP2JI-K@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN02wFqzvwP2JI-K@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 16, 2023 at 10:51:12AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Aug 16, 2023 at 02:50:16PM -0600, Gustavo A. R. Silva wrote:
> > Change the notation from pointer-to-array to pointer-to-pointer.
> > With this, we avoid the compiler complaining about trying
> > to access a region of size zero as an argument during function
> > calls.
> 
> Haha, I thought the functions were actually accessing the memory. This can't
> be an intended behavior on the compiler's side, right?

I think it's a result of inlining -- the compiler ends up with a case
where it looks like it might be possible to index a zero-sized array,
but it is "accidentally safe".

-- 
Kees Cook
