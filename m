Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F141783510
	for <lists+cgroups@lfdr.de>; Mon, 21 Aug 2023 23:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjHUV67 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Aug 2023 17:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjHUV67 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Aug 2023 17:58:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A027B129
        for <cgroups@vger.kernel.org>; Mon, 21 Aug 2023 14:58:56 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fee7b7689dso21360425e9.0
        for <cgroups@vger.kernel.org>; Mon, 21 Aug 2023 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692655135; x=1693259935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZx0If7VnJ4j8LySOPTnKHBC3HYJ+LY29Fzf9AdSRdo=;
        b=wwE+i55gac9vrq6+Vw6RsJhUsFXlx1hfF862zikhtnEQO122lP7ycLTxuaXnV6FdBc
         6hLlGZ9VL9ImHF1uHd83GrfUrCnfGjaDG1dHm/NepAvZFiJCzRhc3QqWvKzbMvwDm3mJ
         UxPNbwVVuDzYmMex5oDV8RGD4Cz9iKYvUTr5dC8PT327GIb3uBu43Igh8AHPNf4nyf1D
         xofx1990g1JHr6+6wzB10SGBnVxfIRsEUslUxt9hDo9UOuyrSKsTVefZVMfM6bpwRd4T
         uJ6brI4WIcPlE+iv+NFeQlTc/iQ4iPwrW69GMkcVmplNNRz6XWo3maGaKuSSaiAqdl4g
         KKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692655135; x=1693259935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZx0If7VnJ4j8LySOPTnKHBC3HYJ+LY29Fzf9AdSRdo=;
        b=A75zPeXRWtZLllR/PPeDFwR2tl8hnRjyqYuUnIiLutXr/rS46Cb8wdlao9f8uUdBOv
         9URveivzDttmTrNNhvr/U2TSBHGoVgGzt6SxVQI1NemOQeptBxKV7yIg6kpweknX89bA
         LfVl0Np5gw1jy4xa08L0T8k4KkpoazVHMEW8oyDVD/3cZczVuFnTMQrwG+USjmHflbA7
         eWgA666+X/wYnERQ1GyCPgwT4yvx/dJaT3wqyZdXM+gCdprhCKblZiCgjzXrtXpR36U/
         se7mvArZK5xYkgkp2Pc6qFM+2/rD+AqdsgZ89+CxLXnGGB6qVcs2ZXCdQmcykngZna5G
         UMYg==
X-Gm-Message-State: AOJu0Yx/KsyTNBUoIZ3FsOLVaEOM2fQyd/wap+0k893s5MtrYGpFDJqx
        eQYExnza+sPZm+M5PyV2oRs10A==
X-Google-Smtp-Source: AGHT+IGqaJ0z3qsZS7fHqemlFDnbowpWoGIAo1Ej0l0pZFtCvg4vwqJnBNbf6iQM4cfHiGp9kjfspg==
X-Received: by 2002:a05:600c:3b16:b0:3fe:5802:676a with SMTP id m22-20020a05600c3b1600b003fe5802676amr6048491wms.4.1692655135016;
        Mon, 21 Aug 2023 14:58:55 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id z9-20020adfe549000000b0031762e89f94sm13694168wrm.117.2023.08.21.14.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:58:54 -0700 (PDT)
Date:   Mon, 21 Aug 2023 22:58:52 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Backport rework of deadline bandwidth restoration
 for 6.1.y
Message-ID: <20230821215852.qc5e6cqjbkgob6nf@airbuntu>
References: <20230820152417.518806-1-qyousef@layalina.io>
 <2023082140-dreaded-hemstitch-84b9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023082140-dreaded-hemstitch-84b9@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 08/21/23 15:26, Greg KH wrote:
> On Sun, Aug 20, 2023 at 04:24:11PM +0100, Qais Yousef wrote:
> > This is a backport of the series that fixes the way deadline bandwidth
> > restoration is done which is causing noticeable delay on resume path. It also
> > converts the cpuset lock back into a mutex which some users on Android too.
> > I lack the details but AFAIU the read/write semaphore was slower on high
> > contention.
> > 
> > Compile tested against some randconfig for different archs and tested against
> > android14-6.1 GKI kernel.
> > 
> > My testing is limited to resume path only; and general phone usage to make sure
> > nothing falls apart. Would be good to have some deadline specific testing done
> > too.
> > 
> > Based on v6.1.46
> 
> I can't take these for only some branches, as you know.  Any reason why
> you didn't also do 6.4.y?

Beside being tunneled visioned towards LTS only, nope.

They apply cleanly on 6.4.y and preparing the patches now. I'm not sure I can
run any tests on 6.4.y though except maybe boot test on qemu.

Waiting for compile tests to finish and will post shortly.


Thanks!

--
Qais Yousef
