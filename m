Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BBE49CC9B
	for <lists+cgroups@lfdr.de>; Wed, 26 Jan 2022 15:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242297AbiAZOpY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jan 2022 09:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiAZOpY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jan 2022 09:45:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC15C06161C
        for <cgroups@vger.kernel.org>; Wed, 26 Jan 2022 06:45:24 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:45:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643208321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHTX2+frIu1UrhvB+dpyRcYGwmhZVbTk9VdBIsf28C0=;
        b=KHbir9cR5tJpv8jOUgX7x/r5Tk/L0cuWYWeeFytmAi8psS1tmbSxE081S2e8Y3KGsCU3gQ
        cv6mX9dMpwrZw3wwI3IsNghlLDfYdk5nvE6kAVIPY8XRMuVclHzgf+JDasZFIrYcs2sH+4
        NMc0ms8jS23QybtGd1JsDzEQ2HIxQFVnQTfUxa7ptOUbzKLd9SO7krduTma0OjkEsKB0Mq
        WkAwfysMe5xjx8AhWcQg1Iy7MBzheZgwqF08O6UD7hLH/G7g6DKHoHqJUYqPrj1m6Tv1ak
        ntOysuqxSe15Us1UATkiclte65DG8Vkk8Kewp+/rJ1MlF6hircPCtOoQsJKYKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643208321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHTX2+frIu1UrhvB+dpyRcYGwmhZVbTk9VdBIsf28C0=;
        b=+KcseHn/VigDpGR4syaqZQM7QlhQHbLoVsEP/sUWC4bNzMjC4P3GLRl4HEmFgbocdgG1BK
        rqMKQ+qvjPpsfgBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/4] mm/memcg: Disable threshold event handlers on
 PREEMPT_RT
Message-ID: <YfFegDwQSm9v2Qcu@linutronix.de>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-2-bigeasy@linutronix.de>
 <YfFddqkAhd1YKqX9@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YfFddqkAhd1YKqX9@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-01-26 15:40:54 [+0100], Michal Hocko wrote:
> I still support this approach but the patch is much larger than
> necessary. The code moving shouldn't be really necessary and a simple
> "do not allow" to set any thresholds or soft limit should be good
> enough.=20
>=20
> While in general it is better to disable the unreachable code I do not
> think this is worth the code churn here.

I got the "defined but not used" warnings by the compiler after I
disabled the two functions. Then I moved everything to one code block to
avoid the multiple ifdefs.
If that is not good, let me think of something else=E2=80=A6

Sebastian
