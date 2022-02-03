Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E174A9111
	for <lists+cgroups@lfdr.de>; Fri,  4 Feb 2022 00:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiBCXTO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Feb 2022 18:19:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43540 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiBCXTO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Feb 2022 18:19:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C87C561842;
        Thu,  3 Feb 2022 23:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4669C340E8;
        Thu,  3 Feb 2022 23:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643930353;
        bh=QAHuBZ+lX2RUpSHwgEocw6rmoaPtXDKxXRloyq8ZEec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CjspKTS1bIPfibcKITrREBKeKQlZmkOykOg6E5BXy0zEwtnZIRsD4PFTz6byuzX9r
         +lFOI56eEYmixY6vm3Qq137KAT2W9/9MD417k/Q5JaOKMvDs+3P27ZGynHSXbyEx35
         c/dnEzqXOQRUU29oM0utwLQvmRN+owV/pen03xtc=
Date:   Thu, 3 Feb 2022 15:19:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        <cgroups@vger.kernel.org>
Subject: Re: [PATCH RESEND] mm: memcg: synchronize objcg lists with a
 dedicated spinlock
Message-Id: <20220203151912.87d47b82c1bc3f0d56be0e3a@linux-foundation.org>
In-Reply-To: <Yfm1IHmoGdyUR81T@carbon.dhcp.thefacebook.com>
References: <Yfm1IHmoGdyUR81T@carbon.dhcp.thefacebook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 1 Feb 2022 14:33:04 -0800 Roman Gushchin <guro@fb.com> wrote:

> Alexander reported a circular lock dependency revealed by the mmap1
> ltp test:
>   LOCKDEP_CIRCULAR (suite: ltp, case: mtest06 (mmap1))
> 
> ...
>
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")

I'm thinking it needs cc:stable.  It sounds unlikely that we'll hit it
in real life, but lockdep splats are concerning and I expect downstream
kernel consumers will end up merging this anyway, for this reason.

