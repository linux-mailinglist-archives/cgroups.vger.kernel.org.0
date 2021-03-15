Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6530033C0B0
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 17:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhCOQAe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 12:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhCOQAC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Mar 2021 12:00:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9B9C06174A
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 09:00:02 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07860038c86f91a939db76.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:8600:38c8:6f91:a939:db76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B96DE1EC0288;
        Mon, 15 Mar 2021 17:00:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615824000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UQyudUKROkDbmPUGp2F469Qw909qU2BXgba4Lf8+Rbg=;
        b=lAuVjuSQt7FfMhcsmV9hb4GxqYSIK2AZRTB1qZtn/llQxanjeQQyy7OLI+P2d3OSM2XlAO
        r3yluYprLAXbsxZJX0Ug2qUcLxXRlu7X29/lTuno/uaYmIg1k7uCY3JmtBxr6MLV+xV6DA
        glLhN1+8nGcWQuoFWhe+Oo2s9PiErBY=
Date:   Mon, 15 Mar 2021 16:59:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Subject: Re: [PATCH v2 8/8] memcg: accounting for ldt_struct objects
Message-ID: <20210315155955.GD20497@zn.tnic>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
 <360b4c94-8713-f621-1049-6bc0865c1867@virtuozzo.com>
 <20210315132740.GB20497@zn.tnic>
 <CALvZod7aT7t_Yp67CaECbCSzk8CuqBRMUBccthLCpz4osqDLKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALvZod7aT7t_Yp67CaECbCSzk8CuqBRMUBccthLCpz4osqDLKw@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 15, 2021 at 08:48:26AM -0700, Shakeel Butt wrote:
> Let me try to provide the reasoning at least from my perspective.
> There are legitimate workloads with hundreds of processes and there
> can be hundreds of workloads running on large machines. The
> unaccounted memory can cause isolation issues between the workloads
> particularly on highly utilized machines.

Good enough for me, as long as that is part of the commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
