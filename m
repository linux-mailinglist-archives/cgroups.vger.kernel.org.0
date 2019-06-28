Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 437E05A55D
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2019 21:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfF1Ttm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jun 2019 15:49:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40666 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfF1Ttm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jun 2019 15:49:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so10005581wmj.5
        for <cgroups@vger.kernel.org>; Fri, 28 Jun 2019 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FrbVagGlg8oUssb+kQNdeSDxFyuguP7EOINDPPuAb+I=;
        b=sI2Qes/i2KTyBMY6GWvETa2Q/O4iYBd8jNgfNuZGEhkFzJRKnLSBQ4KGMvmHIqyAre
         MvY0ArWhc9cjWps6hougPyE+3rrT57O+QIRUX1mMPWUEot3dWE2SJc6U2UuwwbtGqQSE
         6VVBrIa64vbAtHS2nATlj5WCESfcHbhbmw2mTzvTcCz6kTVwSV2j/l43PpgmDvtCIcGQ
         HtuFrRo7kgNfb9cjY8jeT3cVRkqVyEWh2yhahD8j2TBjXKb/f7/EYKjflO/QEs0LBt/o
         U88Yhz90hGx+wpWdKHD5+l/mOtk9KnQfDrfv1Fd/d04TW0Q7xVfiLuNS9FsW2UDTpw1w
         Vbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FrbVagGlg8oUssb+kQNdeSDxFyuguP7EOINDPPuAb+I=;
        b=NOFUDGohzLfPPGWwXq8Jq4yk1sdmnVTpQ3J+khOgSsqrOk4M/XXj4KToSQd7pHzxYw
         T9Zje+9J5FpeIBzTf+Cbdt7ohbTMN70cGxwc8VjyEOTmt8U9dbKQITPqUQuYF8XVEEBA
         9pgTRsnAjs2eE5bC4NHrGAbkNmK59xWImPFrVa2GN8UmFM/cDnf9BVJXiCyK3W8hEyTf
         hTaDdqXBxhaorSWopHphFLAUhNtbY5vfZ1g7A1HIAG1S4EaZzAl0HRjb4ws1Orc4foTn
         SzNy3EJbLIPyfGbRiC1tKDLbCs7bk1US+AMdHndRUwPubqO2WVslT0Lq78LLb8Io4zTM
         t/Fw==
X-Gm-Message-State: APjAAAVK/xnp1TGJ+l/z7LwCKqC+XJKibZk3YcqzazgBRidKgi7Xo1nO
        Rj7DURMmfCb8LnMy/foTKvYwIhVdyaXC7RKUGFU=
X-Google-Smtp-Source: APXvYqyxRzzo6sBqiICI5blkxMaQl1iJgTMzM9bp7mrstrzmBN1suLiqih3vEqThbjkRkcsLx6n+38EOPWbwUG0wqyU=
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr8222737wme.29.1561751379642;
 Fri, 28 Jun 2019 12:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190626150522.11618-1-Kenny.Ho@amd.com> <20190626150522.11618-10-Kenny.Ho@amd.com>
 <20190626162554.GU12905@phenom.ffwll.local> <CAOWid-dO5QH4wLyN_ztMaoZtLM9yzw-FEMgk3ufbh1ahHJ2vVg@mail.gmail.com>
 <20190627061153.GD12905@phenom.ffwll.local>
In-Reply-To: <20190627061153.GD12905@phenom.ffwll.local>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Fri, 28 Jun 2019 15:49:28 -0400
Message-ID: <CAOWid-dCkevUiN27pkwfPketdqS8O+ZGYu8vRMPY2GhXGaVARA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/11] drm, cgroup: Add per cgroup bw measure and control
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 27, 2019 at 2:11 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> I feel like a better approach would by to add a cgroup for the various
> engines on the gpu, and then also account all the sdma (or whatever the
> name of the amd copy engines is again) usage by ttm_bo moves to the right
> cgroup.  I think that's a more meaningful limitation. For direct thrashing
> control I think there's both not enough information available in the
> kernel (you'd need some performance counters to watch how much bandwidth
> userspace batches/CS are wasting), and I don't think the ttm eviction
> logic is ready to step over all the priority inversion issues this will
> bring up. Managing sdma usage otoh will be a lot more straightforward (but
> still has all the priority inversion problems, but in the scheduler that
> might be easier to fix perhaps with the explicit dependency graph - in the
> i915 scheduler we already have priority boosting afaiui).
My concern with hooking into the engine/ lower level is that the
engine may not be process/cgroup aware.  So the bandwidth tracking is
per device.  I am also wondering if this is also potentially be a case
of perfect getting in the way of good.  While ttm_bo_handle_move_mem
may not track everything, it is still a key function for a lot of the
memory operation.  Also, if the programming model is designed to
bypass the kernel then I am not sure if there are anything the kernel
can do.  (Things like kernel-bypass network stack comes to mind.)  All
that said, I will certainly dig deeper into the topic.

Regards,
Kenny
