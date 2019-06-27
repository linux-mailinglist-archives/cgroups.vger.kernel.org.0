Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8550B58B72
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 22:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfF0URW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jun 2019 16:17:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41770 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF0URW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jun 2019 16:17:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so3904425wrm.8
        for <cgroups@vger.kernel.org>; Thu, 27 Jun 2019 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXzBT3SunxKtxtFb1Dg3VQpAWP4tlhEFZulyYdsn0Sg=;
        b=i7QK1Cxd0JSWlH18qyEN9Mv/lp44691Nj55zulskqgrX72OQvk7YFR1nDIgca+HNg7
         NG6nnIPqVZCmtp5Wfo3wiqzeOUrM2UUWfCtqaIqilBHRcOrIldAHXNsSUtSBROmNLMnd
         zN+ST3EHPUgawYpptlnNCLsnh/go12WUYbNKB/I6V4lIJNd2+2QIQoSNnj88I8TR6Qnq
         lDVGSY3SU5JA5i38w2SPlw2drQVCxCzbTlFVe7yut5F0GKs7xpcxP0iP7Bs6gzR0vGfv
         hZQrisQSdXWzIaUvsElpsF6vyFoEiVYVy7ZjObZM9bxeLhfhSMegUwwPlmsiD59IO5YB
         LiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXzBT3SunxKtxtFb1Dg3VQpAWP4tlhEFZulyYdsn0Sg=;
        b=TqdBMwkl18Dk+V7TkBqCcLc47AEyEQx4nBduqS94edpFSjZfPi1PN5COH1CNUpxCfH
         BXWbZ/vRMqAGA7SzNMhOocQ81oBd7HaqnT83bLziRYr40WW6cdKChAtST6bkMOuM78+r
         lflanX7CIFn/ck9EXf527WL6lQoKj2tl3cCpYsn9WDOElkNNDhpDYCUCKcLL3BuryEIi
         Qy3dSLTyAXjyR6AaNSFb0RKH1KB9Nv+GABKRQ/0H0go2sG6SL/RbFwnLQjTTf5mYpvTL
         yMEE/06qiu8dVyYkOcox+Se7BV8GD3pbcmC5WQU52i+WNvow+IdhpzY1mvE2KMp1ro91
         BnIg==
X-Gm-Message-State: APjAAAW3/ah0L8SKWflF5zAjVLCeIquKWvHi8UgUEL2it41PZRKAm9fk
        nTWgTQ/WEW3S26fZnECxJu/1lVHMWjkNfKb5lYM=
X-Google-Smtp-Source: APXvYqy2ZhVkbooaFovwSFxpbAMvY1dZgmrog/A6N3mMxS5Gr/v9nVs6Mlatx89uIZNMImhvcttLFIOmwtnKbdxnMx4=
X-Received: by 2002:a5d:4810:: with SMTP id l16mr4334706wrq.48.1561666640514;
 Thu, 27 Jun 2019 13:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190626150522.11618-1-Kenny.Ho@amd.com> <20190626150522.11618-8-Kenny.Ho@amd.com>
 <20190626161254.GS12905@phenom.ffwll.local> <CAOWid-f3kKnM=4oC5Bba5WW5WNV2MH5PvVamrhO6LBr5ydPJQg@mail.gmail.com>
 <20190627060113.GC12905@phenom.ffwll.local>
In-Reply-To: <20190627060113.GC12905@phenom.ffwll.local>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Thu, 27 Jun 2019 16:17:09 -0400
Message-ID: <CAOWid-e=M4Rf30s8ZoK5n2fOYNHhvpun0H=7URsKmsGc3Z0FDQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 07/11] drm, cgroup: Add TTM buffer allocation stats
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Brian Welty <brian.welty@intel.com>, kraxel@redhat.com,
        Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
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

On Thu, Jun 27, 2019 at 2:01 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> btw reminds me: I guess it would be good to have a per-type .total
> read-only exposed, so that userspace has an idea of how much there is?
> ttm is trying to be agnostic to the allocator that's used to manage a
> memory type/resource, so doesn't even know that. But I think something we
> need to expose to admins, otherwise they can't meaningfully set limits.

I don't think I understand this bit, do you mean total across multiple
GPU of the same mem type?  Or do you mean the total available per GPU
(or something else?)

Regards,
Kenny
