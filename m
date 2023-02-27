Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215AB6A476C
	for <lists+cgroups@lfdr.de>; Mon, 27 Feb 2023 18:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjB0RAI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Feb 2023 12:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjB0RAF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Feb 2023 12:00:05 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3B11CF40
        for <cgroups@vger.kernel.org>; Mon, 27 Feb 2023 09:00:04 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id m6-20020a17090a668600b002375cbab773so5435134pjj.9
        for <cgroups@vger.kernel.org>; Mon, 27 Feb 2023 09:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=75A0gEwys1mFY3sJ5wHScJ9ljDVthV3+ryRrHEENcQo=;
        b=cLtWhUG9qsA4Sg24ae9fYUU4+Jizp49jqXT9Sfy+9fByadRsDkot02jjzzg5b2L5Xs
         4p31MmnUIDIGwI0i/YSZGLRpX+ovsl39jJqI4PvJvxCbjeEQ+Qgawa2WEoiPTofV4BDa
         RlEha9mid0gYgb6ZrswEsykY7taZ9zgYENPxcCJgUDJ5aCXp4DYkULEQrtgAF7HwaDWD
         47tC1GMc9jX+XOMQrLfWidvs+Ppgw0lAJ2qMjRHZWhSqHcDOV9Sp1X96Cqel9TG8FKCt
         XUDU2HOvl03Pnq2Ioq1hngvzmArdOS/tf8YuPsxB5FNETBKRe5UoIcOan7vC6M/xITna
         zm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75A0gEwys1mFY3sJ5wHScJ9ljDVthV3+ryRrHEENcQo=;
        b=V485KQRo3X/plQWPP9nvajd1DU4qzDDI6XgNSRiKe5pQQjPe937VqXbUst0hgQ5aUL
         on5V91FuqzS+TpDLLcnKzBDPSbURzLch0jy7PGi51nBNzVRK8e05wWLv2xpRRaqkRF9j
         DD2BaECVRvPWbTjDzUsaAJxP7gn11XoLef1ff3/tiCh6gY/B9EV4mTcdk8PBVXfa8jYR
         RwsbSxLtiLVTaRSZp1k4WiXso55kJ6gLj2PMChVPOax1+BIiYED0bsjnDV8EBzYotEUU
         jqOseellyJrFPqNow0jkc8xKceLhu7jcWLIL+IvXmlAQC2WcnT3FrrPFo5lwD6w08R10
         mnVQ==
X-Gm-Message-State: AO0yUKUreQepRqksRpzjpcOD9QCmJ+F7jWJ9+FEtn3S4Uw+B/MxWsvoC
        SSePhxytfRx98VsJx8sVqoLs5s/FFavX/Q==
X-Google-Smtp-Source: AK7set8zQAXFt4iHWata/ORsoMm97Yi3POewWVMQEsZw5ZAOjhhfqfG2Q9XR/zpLBeiPml9TRrLMz6WNMVoAkQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:8a0f:b0:236:67f4:e575 with SMTP
 id w15-20020a17090a8a0f00b0023667f4e575mr4352155pjn.3.1677517203795; Mon, 27
 Feb 2023 09:00:03 -0800 (PST)
Date:   Mon, 27 Feb 2023 17:00:01 +0000
In-Reply-To: <20230226131634.34366-1-ivan.orlov0322@gmail.com>
Mime-Version: 1.0
References: <20230226131634.34366-1-ivan.orlov0322@gmail.com>
Message-ID: <20230227170001.ka5eyfscvdypc2oc@google.com>
Subject: Re: [PATCH] selftests: cgroup: Add 'malloc' failures checks in test_memcontrol
From:   Shakeel Butt <shakeelb@google.com>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Feb 26, 2023 at 04:16:33PM +0300, Ivan Orlov wrote:
> There are several 'malloc' calls in test_memcontrol, which can be
> unsuccessful. This patch will add 'malloc' failures checking to
> give more details about test's fail reasons and avoid possible
> undefined behavior during the future null dereference (like the
> one in alloc_anon_50M_check_swap function).
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
