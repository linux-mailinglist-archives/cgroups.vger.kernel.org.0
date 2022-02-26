Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7874C5264
	for <lists+cgroups@lfdr.de>; Sat, 26 Feb 2022 01:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbiBZAGP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Feb 2022 19:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238742AbiBZAGO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Feb 2022 19:06:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B301EF350
        for <cgroups@vger.kernel.org>; Fri, 25 Feb 2022 16:05:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BA0361D58
        for <cgroups@vger.kernel.org>; Sat, 26 Feb 2022 00:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58137C340E7;
        Sat, 26 Feb 2022 00:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645833940;
        bh=QnhN6FEIU1CbIXSpB7aRtuB1l8uYNL5aDrMq0ZS9vcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rHkUzOZfWtMXlFqvgGtbLMBBgN6m0LVpS3+miQKtYhFbABnQho0jtStHZuVULnYCi
         hmEsKKmVD2BMrYhSzR5A4UJddq0SztB7RiLUEk5+yDd0rkfo+BbEuTTfdvTp5YrdQl
         AQInCPHyG7Lr8Yrx+D5gfIv4YWPBzVpR6t3grrpo=
Date:   Fri, 25 Feb 2022 16:05:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH] mm/memcg: Only perform the debug checks on !PREEMPT_RT
Message-Id: <20220225160539.22f5613abc0df8b75285f22c@linux-foundation.org>
In-Reply-To: <Yhlf29/HqyNMOvGb@linutronix.de>
References: <20220221182540.380526-1-bigeasy@linutronix.de>
        <20220221182540.380526-4-bigeasy@linutronix.de>
        <CALvZod7DfxHp+_NenW+NY81WN_Li4kEx4rDodb2vKhpC==sd5g@mail.gmail.com>
        <YhjzE/8LgbULbj/C@linutronix.de>
        <CALvZod48Tp7i_BbA4Um57m989iuFU5kSvbzLhSOUt23_CiWmjw@mail.gmail.com>
        <Yhlf29/HqyNMOvGb@linutronix.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, 26 Feb 2022 00:01:47 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> 
> Andrew, if this getting to confused at some point, I can fold it myself
> and repost the whole lot. Whatever works best for your.

I think I have it all but yes please, do send along a v5 series and
I'll double-check.

