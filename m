Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684B63F7AF8
	for <lists+cgroups@lfdr.de>; Wed, 25 Aug 2021 18:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242089AbhHYQyH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Aug 2021 12:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhHYQyG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Aug 2021 12:54:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B0FC061757;
        Wed, 25 Aug 2021 09:53:21 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h1so239234pjs.2;
        Wed, 25 Aug 2021 09:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=srVnwyk0M43QpIH9IWOJ5w3oSSwwz3TSpreIbqK83Xs=;
        b=lT5qxDybPBPTxb0wcojuyHLh0Egws6+mz9Hc2y2CD7S75wniTMbgVo4hdCWeNFWzh8
         30PWMBRHvgxzpl5/EruxpGhrFnrXY9fEgoD/4zolXt0ETXXGvzFa56n/TYR5ilttSAMW
         /dg9Uy3C373fE6mP6FUWYyYfyD+7z6+P2paYqoIcjvFvoVe3XpLqJq2CuJP7EPHJ5AVv
         yUn7xnnVPIgzDRw/wt2WokHM4ujxNpAp35gjoMKQrlH86vcZXFKs+0Z6PcTBUCbWfBAm
         ZxGda03WTfTYUZxY2VGmQ89MYV+4ntgrDN8KmGUy1ni7qvq41hr6dxCdTGaQb1T4Fo72
         8sVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=srVnwyk0M43QpIH9IWOJ5w3oSSwwz3TSpreIbqK83Xs=;
        b=IacbZJ+xAg7gy66Li7BiBGZQTn0BDPMoh9MaUlZTAxc4t12Lct1HfwyHnt2IRQUXvq
         SMLByhcdDpmdqmv8uVDZtSscnLA8sAvTdlJj0kZirbHZe0N+3wR3ISMaXVOB8o3LZ2Pc
         xOgs8+NSBHY331cmDJwf8llNMMTHHY+0fmLVC1z+R47vK3cTePQVU8qj91XTy5oDYgRX
         ab2/EuTHuxaZOi9A534ccQBef9cf+qDhRD1bZ9Z0Dinl8Taov+A6vaa0PUGTdbndSHCd
         OosYltmC74+PsFd5VNilnkmPAjNJzbOgzvEEyA33jvKlJenPXOuMK6/s7U7MbsVQ9MUI
         Z5MA==
X-Gm-Message-State: AOAM532fDV933+VOlljJu1/26NVVKdDXv/AIbJGFkUJhFOnVX7f6ri6H
        PyIJt2lhWgfdmHdkmrVkV5c=
X-Google-Smtp-Source: ABdhPJxlE+C6o5cx9XTu3XNSKtB7Lvg7BRypv/VZVaqmnRibukGG91s0ihV6Djz0n4I5UstS6sl0Vg==
X-Received: by 2002:a17:90a:bb13:: with SMTP id u19mr11448156pjr.42.1629910400422;
        Wed, 25 Aug 2021 09:53:20 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id i14sm309217pfd.112.2021.08.25.09.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:53:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Aug 2021 06:53:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mtosatti@redhat.com,
        nilal@redhat.com, frederic@kernel.org, longman@redhat.com
Subject: Re: [PATCH] cgroup/cpuset: Avoid memory migration when nodemasks
 match
Message-ID: <YSZ1fgJgJfWmvaC4@slm.duckdns.org>
References: <20210825105415.1365360-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825105415.1365360-1-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 25, 2021 at 12:54:15PM +0200, Nicolas Saenz Julienne wrote:
> With the introduction of ee9707e8593d ("cgroup/cpuset: Enable memory
> migration for cpuset v2") attaching a process to a different cgroup will
> trigger a memory migration regardless of whether it's really needed.
> Memory migration is an expensive operation, so bypass it if the
> nodemasks passed to cpuset_migrate_mm() are equal.
> 
> Note that we're not only avoiding the migration work itself, but also a
> call to lru_cache_disable(), which triggers and flushes an LRU drain
> work on every online CPU.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Applied to cgroup/for-5.15.

Thanks.

-- 
tejun
