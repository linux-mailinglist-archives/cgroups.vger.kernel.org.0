Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2442044C4D1
	for <lists+cgroups@lfdr.de>; Wed, 10 Nov 2021 17:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhKJQK0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Nov 2021 11:10:26 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58912 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhKJQKZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Nov 2021 11:10:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BCB8A1FD33;
        Wed, 10 Nov 2021 16:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636560456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PPgM0a73dB6hv2TqWrr8loL+EBdXIVciUhuFI52YlVU=;
        b=iAOf10MqrIm8dgZM+vuAFKIjE3oK2/QoiLcGdc5XsjLsd4nz8xO8J3zbfu2E/jgvxLp4Na
        fkkVU4S1ihq0NU4n+RuuXoQQESskzFXJO/ooXfJMCuUnaThzsMy0/xnmrGMVEtbjvOGkNS
        eEOpjh+6wc74ogI0ZHE4HCbjrSrH/NU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 20C27A3B81;
        Wed, 10 Nov 2021 16:07:36 +0000 (UTC)
Date:   Wed, 10 Nov 2021 17:07:33 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     hannes@cmpxchg.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vdavydov.dev@gmail.com, tj@kernel.org,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, djakov@kernel.org
Subject: Re: [RFC] psi: Add additional PSI counters for each type of memory
 pressure
Message-ID: <YYvuRUqcxW0Vu9vp@dhcp22.suse.cz>
References: <1636558597-248294-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636558597-248294-1-git-send-email-quic_c_gdjako@quicinc.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 10-11-21 07:36:37, Georgi Djakov wrote:
> From: Carlos Ramirez <carlrami@codeaurora.org>
> 
> Calculates psi totals for memory pressure subevents:
> compaction, thrashing, direct compaction, direct reclaim, and kswapd0.
> Uses upper 16 bits of psi_flags to track memory subevents.

Could you elaborate on the definition of those events please? That
should also go to Documentation (Documentation/accounting/psi.rst)
-- 
Michal Hocko
SUSE Labs
