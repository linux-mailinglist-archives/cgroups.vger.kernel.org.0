Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB887820AD
	for <lists+cgroups@lfdr.de>; Mon, 21 Aug 2023 01:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjHTXDE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Aug 2023 19:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjHTXDE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Aug 2023 19:03:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1445BA4
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 16:03:01 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso27049645e9.3
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 16:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692572579; x=1693177379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zASfMBgzYAjTR9c8GY5qaV+9MUOdSaUxlBCpiQVP8k0=;
        b=t/M436gLUC3+++Lm6yg65sJ9KSAuXIfPhOB12Lo8i7//DnPoosE1I3P39EuLVL4PNO
         zRxoSgoVSQgGE3VjMiyyof23ui1TFdgoOKaNFJqRby3F43/I7OR79Cz5BLE5wPYPtI5T
         VBr3r68voLEMZTuMRzdBo/IZTrf/8IHoS1DY3JjHEIyBznscOY5H2pCCx6BI5FHNijtM
         PPDqEKa5XS8oOtFuuVIwZel0iFIUHGm+0+a427vbiMxzGMDaz4p0GD7I/pHZfv3K5R9g
         SxKsr4mnY/efclf92+bb94JKR4Cr2yuLCpMgCL6hEieNYhRuwNR6i4S5WrF4+WvvQekE
         eH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692572579; x=1693177379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zASfMBgzYAjTR9c8GY5qaV+9MUOdSaUxlBCpiQVP8k0=;
        b=SyNFMrwSbaCMFeJQMe5QNwOHjXHR6+E9P0Tm9nI9k0h49N1kvvI33gqojZuKaShmyZ
         cPjyjjx/HRi8xfJCJItjSih9WOyw+COO+TEmKYYrjcgvif+5h46/py4aTcwheFoV4V3a
         CuqagUzgkqxO3epwU1YOJrW0FVggpChv03pNWccp6p2YpgCWYEQkfvZeVoGR6jNhu+Ul
         EBb68ERvXNH49XF0rtiG3TSQ5C8NhHfuF+65T+eCzHQOaumaB6+0siJ6CdTuDgi1Z/FY
         L/nuRQ5Frl3ZBlZvh/C2nqSlwzwmsC8nbO5t2EMlf9kLIPX5wktWnpqWCcvjNvcsq/zD
         qbgw==
X-Gm-Message-State: AOJu0YxNGycy3NQdU0EpDVvhfFCjcfiJE0Wh9GUkZldBpSfzwMwtfDlR
        DHv1SK5KUNDbeweXtSNFfwKWug==
X-Google-Smtp-Source: AGHT+IEDDxn1gA7l6hN0vwECDX74/sJ63XoHP2U9mIBarT4gPy/ZBfwz83YYHMQoWg88ioS6EzG+NQ==
X-Received: by 2002:a7b:c8d8:0:b0:3fe:195c:eca3 with SMTP id f24-20020a7bc8d8000000b003fe195ceca3mr3694180wml.9.1692572579582;
        Sun, 20 Aug 2023 16:02:59 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id l22-20020a7bc456000000b003fe1afb99a9sm10596979wmi.11.2023.08.20.16.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 16:02:59 -0700 (PDT)
Date:   Mon, 21 Aug 2023 00:02:57 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Waiman Long <longman@redhat.com>
Cc:     stable@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Backport rework of deadline bandwidth restoration
 for 5.10.y
Message-ID: <20230820230257.gmcmjuuirzq6xs52@airbuntu>
References: <20230820152144.517461-1-qyousef@layalina.io>
 <883a5a4f-b34e-689c-2fbd-7bf03db532eb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <883a5a4f-b34e-689c-2fbd-7bf03db532eb@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 08/20/23 12:24, Waiman Long wrote:
> 
> On 8/20/23 11:21, Qais Yousef wrote:
> > This is a backport of the series that fixes the way deadline bandwidth
> > restoration is done which is causing noticeable delay on resume path. It also
> > converts the cpuset lock back into a mutex which some users on Android too.
> > I lack the details but AFAIU the read/write semaphore was slower on high
> > contention.
> 
> Note that it was a percpu rwsem before this patch series. It was not a
> regular rwsem. Percpu rwsem isn't designed to handle high write lock
> contention. A regular rwsem should be similar to mutex in performance when
> handling high write lock contention.

Thanks a lot for the clarification Waiman! Much appreciated.


Cheers

--
Qais Yousef
