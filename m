Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681824C695D
	for <lists+cgroups@lfdr.de>; Mon, 28 Feb 2022 12:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiB1LJZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Feb 2022 06:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiB1LJY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Feb 2022 06:09:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DE63701D
        for <cgroups@vger.kernel.org>; Mon, 28 Feb 2022 03:08:43 -0800 (PST)
Date:   Mon, 28 Feb 2022 12:08:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646046521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mnquIb5GSTn+DLQ3cN/hm1a1j7DJpMevzJiSlMx6tcs=;
        b=WysKBJ9IkEvnBYFFSQ0+2L3p3tRyVyTwRhP6bOG1UgOvwRUZLIXng9nE+McGX2jnrVCIVN
        +Q3RyRL/+zwL3QpXWF9rUifwBbrXJdav9I2pJLLggORAJqRnsQ7cpl4LRmSNeyv6W1jtd2
        vhVhhE/QnDDGatySQs6sj+1BjqPw1G+MiFvZi8QGij/jE5xdNf4iDdNjJySd2J5A+YGtAl
        NrMP6411jsvyhrJQTIx6M0IXWHfpOO0cKZh4rmugZec5j6bE6lKeLgxwzHdNuolu+WHxqH
        KqoZkdm/8Ew6gxGghv25swpDTOVVrrjNtWKTRO6I0/gJI4jT/d2i4njP/b0YNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646046521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mnquIb5GSTn+DLQ3cN/hm1a1j7DJpMevzJiSlMx6tcs=;
        b=lxhZsiARSZXEKvThVxCqZ4Ip9YPS/onIOC4WRpn/SuPwr03p1aB4YQJG2JKj8+3aqTk1TV
        S18EBJ4A1gsYqAAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v5 3/6] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT where needed.
Message-ID: <YhytODB1IQFLfx4h@linutronix.de>
References: <20220226204144.1008339-1-bigeasy@linutronix.de>
 <20220226204144.1008339-4-bigeasy@linutronix.de>
 <YhyCWQYL8vxRSLrd@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhyCWQYL8vxRSLrd@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-02-28 09:05:45 [+0100], Michal Hocko wrote:
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> TBH I am not a fan of the counter special casing for the debugging
> enabled warnings but I do not feel strong enough to push you trhough an
> additional version round.

do you want to get rid of the warnings completely? Since we had the
check in memcg_stats_lock() it kinda felt useful to add something in
__memcg_stats_lock() case, too.

> Thanks!

Sebastian
