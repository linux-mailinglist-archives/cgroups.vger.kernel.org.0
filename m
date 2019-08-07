Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B6885483
	for <lists+cgroups@lfdr.de>; Wed,  7 Aug 2019 22:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389424AbfHGUeS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Aug 2019 16:34:18 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34763 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389420AbfHGUeR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Aug 2019 16:34:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id k10so20638986qtq.1;
        Wed, 07 Aug 2019 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IC+13V8Mtk7y8HC7bnHIWtqIcy1I5HJyllIeTOClBTQ=;
        b=gA2Gxo3VVUUiZocJ2EWD7FWO7YBQ8ft67UkLPK3AQg2nN2DoElFq/GksGEaLO+Xxs7
         yBG49lmFjj6YiLTjAaIGIQ41gk0yijO+ArJDE8dr0MOM8hPWXP6zZJu4zTmZ5U0pgrQi
         HknnD6KZRyK/MCSoGtYJTTYotU0YW8UoTRgeuRn+pC5MZtc7pzuYv6kj3xs5K4Iq01gZ
         86PLHXMC6iInXVPSj6NydUiB8ADQvz4JihwAriUqmR/FNZBo1PmtDfw6VQ/NCCRIFgf2
         ZxOvpizlKlGxc62Gw+giLRS40hco+rKNH4/JXvGmrSXjrc5JQOrAHKmp7zbC6NOQ0jDG
         Tr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IC+13V8Mtk7y8HC7bnHIWtqIcy1I5HJyllIeTOClBTQ=;
        b=WErBU2JVTnivnYok6uEqcbprxPiFogqS8RZo0a6+HyUTYt7ZZbdRdp7DjriLbZP9FM
         hTLPCbPlWurgcPH4UQuOQVd2alH63aQta6EdWKthwa2RIhaphAjoRJkpf0RitAeerEu7
         R8FrxQiJAG+JVEsqTEiT4FWHMonNIVX25Kb0S9/tEY3j2XV8pIGgidJzitJ6ON5L/jpH
         2an+loySG7FaJuwm178kc5UC8ikuz9MwTgX2KlIg3W3rUxG9MBiO8ApECiYWNEeEoBQ9
         dccOpuRq7hgYCUicWe5foiDPzzXPOYlaa/nDC/watiAdM65cFzNxh7YQkhBcv7EqTyuX
         zq2Q==
X-Gm-Message-State: APjAAAUW0fFX/ofCROSzuf0qY51pIgPG2w36AH2fe9W72nVeUmLyVeIJ
        biKp/9TJmZm8lmf3W0Q0zO0=
X-Google-Smtp-Source: APXvYqzu1jOsh0kIjF9dIWwpYxRpLf5Yj5gvt8IrWIJbtljX2Px5uBUwWjZwjoub/a03bW3NQndjfA==
X-Received: by 2002:ac8:45d2:: with SMTP id e18mr9931619qto.258.1565210056622;
        Wed, 07 Aug 2019 13:34:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:49ab])
        by smtp.gmail.com with ESMTPSA id t11sm6284977qkt.85.2019.08.07.13.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 13:34:15 -0700 (PDT)
Date:   Wed, 7 Aug 2019 13:34:14 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com
Subject: Re: [PATCH 2/4] bdi: Add bdi->id
Message-ID: <20190807203414.GA554060@devbig004.ftw2.facebook.com>
References: <20190803140155.181190-1-tj@kernel.org>
 <20190803140155.181190-3-tj@kernel.org>
 <20190806160102.11366694af6b56d9c4ca6ea3@linux-foundation.org>
 <20190807183151.GM136335@devbig004.ftw2.facebook.com>
 <20190807120037.72018c136db40e88d89c05d1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807120037.72018c136db40e88d89c05d1@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Aug 07, 2019 at 12:00:37PM -0700, Andrew Morton wrote:
> OK, but why is recycling a problem?  For example, file descriptors
> recycle as aggressively as is possible, and that doesn't cause any
> trouble.  Presumably recycling is a problem with cgroups because of
> some sort of stale reference problem?

Oh, because there are use cases where the consumers are detached from
the lifetime synchronization.  In this example, the benefit of using
IDs is that memcgs don't need to pin foreign bdi_wb's and just look up
and verify when it wants to flush them.  If we use pointers, we have
to pin the objects which then requires either shooting down those
references with timers or somehow doing reverse lookup to shoot them
down when bdi_wb is taken offline.  If we use IDs which can be
recycling aggressively, there can be pathological cases where remote
flushes are issued on the wrong target possibly repeatedly, which may
or may not be a real problem.

For cgroup ID, the problem is more immediate.  We give out the IDs to
userspace and there is no way to shoot those references down when the
cgroup goes away and the ID gets recycled, so when the user comes back
and asks "I want to attach this bpf program to the cgroup identified
with this ID", we can end up attaching it to the wrong cgroup if we
recycle IDs.  cgroup ended up with two separate IDs, which is kinda
dumb.

tl;dr is that it's either cumbersome or impossible to synchronize the
users of these IDs, so if they get recycled, they end up identifying
the wrong thing.

Thanks.

-- 
tejun
