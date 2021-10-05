Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0653422D98
	for <lists+cgroups@lfdr.de>; Tue,  5 Oct 2021 18:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbhJEQQT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Oct 2021 12:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbhJEQQQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Oct 2021 12:16:16 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F22C061749
        for <cgroups@vger.kernel.org>; Tue,  5 Oct 2021 09:14:25 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id m21so20182532pgu.13
        for <cgroups@vger.kernel.org>; Tue, 05 Oct 2021 09:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sWV3eCSW91vjz0ZnFEdePdyFv0khCWAXj63KXD3BxX4=;
        b=m9fVw7Q4ARqPYCSirL0dcKTTY9WiiGEUQx/SHaP6js1Ej2mc3rFteVrje7naDzeB6w
         k2u+A+0jUEbEI6P3EcTkTW93cOpQAQdP5Dic8C2Gyw2W1jNspuMSujON6JiDhr+w7i22
         xflC2ZH1aT+3JYPgtUjbxZ8ASpXrFp9G7PEfBfw/QPAOuzWepkByV8l6h3WOT0xWW6CW
         /CGh1qZtmK36Fjgg8juAgUp48tMVF5076wGTM9yG4oXs24AL/uhbtz37bTq0as3WIgS7
         eb7EvA6L5SdU7YE/i+1PXymvJ252kYhyy/n8iUblDtBwlkbXz2xF5WZYDwOJsr/rKUc2
         q+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sWV3eCSW91vjz0ZnFEdePdyFv0khCWAXj63KXD3BxX4=;
        b=6IHmHUDlig5U1rBkp/UuGDPM/ET0Z++iD6CzS5m9tCxGWRsRhP4fBkZvHtSa1mFGf0
         SuBhS6NSmd4gY4hio2EMwGLGYnGXXjUZZY+q5FCn6EiMs549TIF9aTzBkuPdutSoqpV9
         k5qW0OclBYNU7bdIqqPdmcNsED6T0fIQggeZnxOFwWOfWaOWky3P4iCvEPRQSrn+qzfU
         K9vQs46hGjD0vjiWwCd1kBHNw7jwFosdRDkPCUbgjFZgg3XSforSlmEQQuD60HpY//pC
         +waeBaKmf0RsqhrYPz2l7FOsFsNfBE+NoNtDnX+00xEmqmY48jVRdKselQVywjcGZIky
         8gUg==
X-Gm-Message-State: AOAM531hFUym3UhpvIKKFC9uRZ8gsFgLxnp5VAyKTbH82h5aszwjsObV
        FyOCNSVxCxvxrj/KNHs6X8g=
X-Google-Smtp-Source: ABdhPJzZw/EkntCRu3SQDw6ex3wB+0LAeXeP06pKMIGvF7b33dG+H+SmN8Z83MgSiLqTaiOp3Rch3g==
X-Received: by 2002:a62:8f87:0:b0:44c:620b:df63 with SMTP id n129-20020a628f87000000b0044c620bdf63mr11449343pfd.61.1633450464856;
        Tue, 05 Oct 2021 09:14:24 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id u12sm17648714pgi.21.2021.10.05.09.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 09:14:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 5 Oct 2021 06:14:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Vishal Verma <vverma@digitalocean.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup: cgroup-v1: do not exclude cgrp_dfl_root
Message-ID: <YVx5342KvJ1RFoL+@slm.duckdns.org>
References: <20211004201948.20293-1-vverma@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004201948.20293-1-vverma@digitalocean.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 04, 2021 at 08:19:48PM +0000, Vishal Verma wrote:
> Found an issue within cgroup_attach_task_all() fn which seem
> to exclude cgrp_dfl_root (cgroupv2) while attaching tasks to
> the given cgroup. This was noticed when the system was running
> qemu/kvm with kernel vhost helper threads. It appears that the
> vhost layer which uses cgroup_attach_task_all() fn to assign the
> vhost kthread to the right qemu cgroup works fine with cgroupv1
> based configuration but not in cgroupv2. With cgroupv2, the vhost
> helper thread ends up just belonging to the root cgroup as is
> shown below:
...
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Vishal Verma <vverma@digitalocean.com>

Applied to cgroup/for-5.16.

Thanks.

-- 
tejun
