Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A67580315
	for <lists+cgroups@lfdr.de>; Mon, 25 Jul 2022 18:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiGYQrv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Jul 2022 12:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiGYQru (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Jul 2022 12:47:50 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0ECBE27
        for <cgroups@vger.kernel.org>; Mon, 25 Jul 2022 09:47:47 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i13so8823451qvo.3
        for <cgroups@vger.kernel.org>; Mon, 25 Jul 2022 09:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ueOMTo6DsQCvnulLJ7Rsqpth0YKKV57efxM+awobwkc=;
        b=1SD4nF22NDrVthsvc/CcEaNX0GsOg8NrfWYQauQ6kZ74/Cf5YJX7Qk7C9QYuipn3dc
         /75txsFW7Y+hWMthAHT7xUpXGfNxA3+uwyKDdnPOvRjLAjoNosLPlXssiDxAdYS7n7Jg
         UwVDAE+eUF9u+ZhvysT3aXuegZZaQVBosX2fekmPN6pfxTmUviDaE/y1MZN7SG1p6PFN
         jrMEAAfWkhyrGkTrkhwlrN4NgjBSnR+iOqCXqUKe4nW4/ddOFDf7L7MeHWR36Gz2bm0w
         HWRIuOJKtD/Ge3FM/1ggPWvXsLLCav4plXeFanzurA9vEmbG5hSVzxuFIwafwUgVAol0
         YdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ueOMTo6DsQCvnulLJ7Rsqpth0YKKV57efxM+awobwkc=;
        b=dmGaKF1bOWk2dYkEysHA1/V8h5SXX/kjRxsp9Ua1REoa561vYpWPjo85WVzJ0Sayn9
         Uo+i6vJBw4Nuc4ZeMH2enJTY+0HhhZkbmjw2oFSfjHnmdFpD6Uz6A9d0HwjclURPQeBi
         xpAZVrLyWzAuRGG8MjUvE2anw/fX2kua4xss45Kg0QEKJRfFcyt5CELggON6KXg+awEn
         fOVKFnTVSeyELcGS525vGSZ3pPdDTjCl661isfSxGV6QQMDZJUxliqVyq5BLLVr5tnwF
         FfNGoj7wTky5dAiwJEh0bIAjzIEhQ95kFbUV+mQ5RNVVMl0c1x8xhvhFWxDJIDeaCjLH
         w7ew==
X-Gm-Message-State: AJIora8iREVj4oEwEp1GMOrZOdkencHJMgErhaj7NZJLrLUtw7XXCaDF
        rNq1Ecw4Isaj6FLZH61fLgWQVw==
X-Google-Smtp-Source: AGRyM1tsn0XMOPnrteAVb22JR6gvBwTiHBtpn90Nl3EtZupeVtIltfU2MMOYYeSMUPrNGhQqxw9BoQ==
X-Received: by 2002:a05:6214:d81:b0:45a:e07e:6bcb with SMTP id e1-20020a0562140d8100b0045ae07e6bcbmr10926274qve.29.1658767666878;
        Mon, 25 Jul 2022 09:47:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:994f])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a2a4600b006b633dc839esm6966288qkp.66.2022.07.25.09.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 09:47:46 -0700 (PDT)
Date:   Mon, 25 Jul 2022 12:47:45 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 6/9] sched/psi: save percpu memory when
 !psi_cgroups_enabled
Message-ID: <Yt7JMfKHYFLGUGBb@cmpxchg.org>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-7-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721040439.2651-7-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 21, 2022 at 12:04:36PM +0800, Chengming Zhou wrote:
> We won't use cgroup psi_group when !psi_cgroups_enabled, so don't
> bother to alloc percpu memory and init for it.
> 
> Also don't need to migrate task PSI stats between cgroups in
> cgroup_move_task().
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
