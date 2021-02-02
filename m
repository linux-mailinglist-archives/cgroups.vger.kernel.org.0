Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F3B30CEE6
	for <lists+cgroups@lfdr.de>; Tue,  2 Feb 2021 23:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhBBW2c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Feb 2021 17:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbhBBW1P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Feb 2021 17:27:15 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E048AC0613ED
        for <cgroups@vger.kernel.org>; Tue,  2 Feb 2021 14:26:34 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b2so30462744lfq.0
        for <cgroups@vger.kernel.org>; Tue, 02 Feb 2021 14:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDotIy3tcEIJJUi6Xky2qhleZoFwxU7Fh1JVqEU4/ic=;
        b=DWhal97NxQ2UcRObukqIeV8C95ewjDs0qpbMhw0PAmBEJ3xVz68xcmNomNWXA+OJic
         +rIygIVjzV43HN7ioMBwfKyJVQhO9NMVYn1W/9WGwMDdEQx0n+umzXULPrkTJaVyvxyW
         pwgtfY25dcBvIRG2+SgntOFiAi/e+7cOpdNOaU41qnmXgqQTnVFZM1SPbiIQXiOwK+3h
         sTboxTmYqLIVMaT3mXKitQs1ablFfYVbDPpDCLlNnsids3HT3uQifHjR6H/wm2//y/5d
         dY492h/vGDfeQCipU0CkZmnzGYrEoEs0Hia3IDejLkYw16Cn+ZNg9J2G3D0EUmWgllJg
         p5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDotIy3tcEIJJUi6Xky2qhleZoFwxU7Fh1JVqEU4/ic=;
        b=Y7Y0+cCXsX9yn9w7/tEYNEWyoqLzIH7NFT7jpmlW2ONstoAxtgsBWy6/cHGkf/TluG
         /jk1s4AIN8Yg5dPJQShdX+Gka9vIc3j1XTw06grYFOkRnMjTdubjLeu34PaWbIJY/hzT
         twd8Ze8r8oVlFFJsTM5xIFfnf7RsRb69xymzlcFgf1/h4sBN4sAxBSPzrfe2t1SxMciI
         uKVOOv5uDaKnNfeWgQ1H4SVtxWzrP4Rkd56wBcWv2CB3xpZx/9QT9SMelWwrPh03RPR4
         YkT0tHkl1EtlWg56eQ2/SCSDjDZmxg2Wn2VO7AMgU9eTe9f+uztYkL1FxW6VY2xtUXCK
         18ug==
X-Gm-Message-State: AOAM531xYmHWMXkddrsA4kPfEBwOWP/Cm/YgQ9Ig5vaujdky7tm+oTjj
        m1GOHD+tPQM9M9HCaxs3QOlhBTvAWQowOy3RCjS/Kw==
X-Google-Smtp-Source: ABdhPJxYeKpHUbcT97Z6Lsu9PZiyKmkOvnMWDHB0gHxjysvP+NTXtuuTnVoWdHcs1ZKCFXLcIjEZU4VE5KA8iRSdCKY=
X-Received: by 2002:ac2:5a41:: with SMTP id r1mr60968lfn.117.1612304793006;
 Tue, 02 Feb 2021 14:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20210202184746.119084-1-hannes@cmpxchg.org> <20210202184746.119084-4-hannes@cmpxchg.org>
In-Reply-To: <20210202184746.119084-4-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 2 Feb 2021 14:26:21 -0800
Message-ID: <CALvZod6kqzoydroO3E59=hrF+DBV6LwRZ282h2p+xeNKezFAgg@mail.gmail.com>
Subject: Re: [PATCH 3/7] mm: memcontrol: privatize memcg_page_state query functions
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 2, 2021 at 12:45 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> There are no users outside of the memory controller itself. The rest
> of the kernel cares either about node or lruvec stats.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
