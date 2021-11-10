Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A30344C548
	for <lists+cgroups@lfdr.de>; Wed, 10 Nov 2021 17:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhKJQsf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Nov 2021 11:48:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhKJQsf (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 10 Nov 2021 11:48:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57CB561211;
        Wed, 10 Nov 2021 16:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636562747;
        bh=xlkB95ToDfNFK3ZQFZjXgqhWgeGXsZ9Ex+mqLFkoUZA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oSBv2WWsd4g9W37TSSmpqIDHVuXxBQhCqTuiLwd8G/ADIkmgKnSJJdjeixcAXi8RK
         dsn3kPtPGRiX2t3DUE+hquZJ+HAUOXChdvHv9AwsKCLaccPFIl+mB7obUaPJ72x7M1
         pTy//hJYYs0cUcvoevPxmns8J1wJze5Xv0+K4Am24fPbdMtsCAWorU7TEjC5X6WBzu
         /27bJDhZXNguinMyor/kkyhN+SDE2FR2HNvP4ITQvhEMxzn5P5o03hxBDXTzmafM5t
         HuRUTUTpSDTiSMLJvOswc357gL2X23oyyT/+36VlvJZLTGNAfXkza8kQzccjJqaXLj
         7CyIh7fn44p8g==
Message-ID: <91db431e-d5db-be5c-b0d2-382e45786886@kernel.org>
Date:   Wed, 10 Nov 2021 18:45:38 +0200
MIME-Version: 1.0
Subject: Re: [RFC] psi: Add additional PSI counters for each type of memory
 pressure
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     hannes@cmpxchg.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vdavydov.dev@gmail.com, tj@kernel.org,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1636558597-248294-1-git-send-email-quic_c_gdjako@quicinc.com>
 <YYvuRUqcxW0Vu9vp@dhcp22.suse.cz>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <YYvuRUqcxW0Vu9vp@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 10.11.21 18:07, Michal Hocko wrote:
> On Wed 10-11-21 07:36:37, Georgi Djakov wrote:
>> From: Carlos Ramirez <carlrami@codeaurora.org>
>>
>> Calculates psi totals for memory pressure subevents:
>> compaction, thrashing, direct compaction, direct reclaim, and kswapd0.
>> Uses upper 16 bits of psi_flags to track memory subevents.
> 
> Could you elaborate on the definition of those events please? That
> should also go to Documentation (Documentation/accounting/psi.rst)

Sure, will add them to the Documentation! The idea is to add some 
statistics for the memory pressure subevents that helps to figure
out the sources of the pressure. This is just an RFC to gather
initial feedback if such approach would be acceptable.

Thanks!
Georgi
