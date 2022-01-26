Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E7449CDE0
	for <lists+cgroups@lfdr.de>; Wed, 26 Jan 2022 16:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbiAZPVm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jan 2022 10:21:42 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40604 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbiAZPVl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jan 2022 10:21:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CE19B21900;
        Wed, 26 Jan 2022 15:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643210500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sue3kCU/ER/IRMi/KZAJ26mZGkZjDDlVHexxnqqTGg=;
        b=dfLKbiy0WMK2IkpK8jhJ+IeLwjkBdRovBxvwdU1hq0H/lvUXIU92Iaqh36UeOnOZl5Hj9f
        z38jbCewLromjpSf/P2y+iPKzY2uRj5pNMQzEaHGc90LTjtukT252VDBW1MvsjVjwY25xD
        pUttU46/HhTLQDkj11tWZO2E4uWAT8M=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B792DA3B88;
        Wed, 26 Jan 2022 15:21:40 +0000 (UTC)
Date:   Wed, 26 Jan 2022 16:21:40 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/4] mm/memcg: Disable threshold event handlers on
 PREEMPT_RT
Message-ID: <YfFnBBMDVjESaj/y@dhcp22.suse.cz>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-2-bigeasy@linutronix.de>
 <YfFddqkAhd1YKqX9@dhcp22.suse.cz>
 <YfFegDwQSm9v2Qcu@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfFegDwQSm9v2Qcu@linutronix.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 26-01-22 15:45:20, Sebastian Andrzej Siewior wrote:
> On 2022-01-26 15:40:54 [+0100], Michal Hocko wrote:
> > I still support this approach but the patch is much larger than
> > necessary. The code moving shouldn't be really necessary and a simple
> > "do not allow" to set any thresholds or soft limit should be good
> > enough. 
> > 
> > While in general it is better to disable the unreachable code I do not
> > think this is worth the code churn here.
> 
> I got the "defined but not used" warnings by the compiler after I
> disabled the two functions. Then I moved everything to one code block to
> avoid the multiple ifdefs.
> If that is not good, let me think of something else…

If this is really needed then just split the patch into two. First to
add the special RT handling and the other one to move the code without
any other changes.

-- 
Michal Hocko
SUSE Labs
