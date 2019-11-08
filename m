Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85B9AF3E77
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2019 04:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfKHDn4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Nov 2019 22:43:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfKHDn4 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 7 Nov 2019 22:43:56 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C9BD20865;
        Fri,  8 Nov 2019 03:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573184635;
        bh=UyFRcER2CU7b2usXRZ6M6BFrcXtS8XVut2oA/vpT6MI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HgC8I55B+cni+z12bFD6e03F5aFRtA2tUpkdkxKQNIlacFiy9Zp3Qsie5vE9DmM53
         q2IfB5TrMpKZKTjkgDaak4c0JtjtPPwmoAsa814d6y8Sh68Chxg8GcTnxXdg2cwC+p
         mz4fe2CxlG4yNvRG2EpaoQEEUGoLNH9tLeqnBbTs=
Date:   Thu, 7 Nov 2019 19:43:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 01/11] mm: vmscan: move inactive_list_is_low() swap
 check to the caller
Message-Id: <20191107194355.c1a511b6b4da4cbbafbf0188@linux-foundation.org>
In-Reply-To: <CALvZod64t1OGuhrvB1QChUYvUs2yQF-qAi5F=gcntHN84rr=sQ@mail.gmail.com>
References: <20190603210746.15800-1-hannes@cmpxchg.org>
        <20190603210746.15800-2-hannes@cmpxchg.org>
        <CALvZod64t1OGuhrvB1QChUYvUs2yQF-qAi5F=gcntHN84rr=sQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 6 Nov 2019 18:50:37 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> On Mon, Jun 3, 2019 at 3:05 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> ...
>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

hm, you appear to have reviewed a five month old version.  Hoping that
nothing changed too much, I added your review tags to the one week old
version ;)

