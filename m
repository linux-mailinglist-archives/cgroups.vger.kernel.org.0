Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F1A40166F
	for <lists+cgroups@lfdr.de>; Mon,  6 Sep 2021 08:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbhIFGiP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Sep 2021 02:38:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54940 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhIFGiO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Sep 2021 02:38:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CA74F2007A;
        Mon,  6 Sep 2021 06:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630910225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C18ucwuH+xJ590fcQPWTQo1wKpR5pILZsUHhaeFFJM8=;
        b=NQJNxXbGll03ANbTcVcmNA5GRE1HmZ8q8Gkbt8sMek82fcvVlXMxFNq8skistKpgpjAyFl
        ptCsa57t0u4Izkcuk8A6SGw5VPSP6VR/Cdm6uuxiUnB8PZPvFHFElwZASWjuaWujvQGPD0
        XbzzL0owuRWs7ezDAcoUrEO7IcyHWK8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 02B5DA3B8E;
        Mon,  6 Sep 2021 06:37:04 +0000 (UTC)
Date:   Mon, 6 Sep 2021 08:37:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     yong w <yongw.pur@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, alexs@kernel.org,
        Wei Yang <richard.weiyang@gmail.com>, Hui Su <sh_def@163.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        wang.yong12@zte.com.cn, Cgroups <cgroups@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn
Subject: Re: [PATCH v2] mm: Add configuration to control whether vmpressure
 notifier is enabled
Message-ID: <YTW3EMKU7fLl62bC@dhcp22.suse.cz>
References: <1629417219-74853-1-git-send-email-wang.yong12@zte.com.cn>
 <YR+Rc9HC6OqlEq4I@dhcp22.suse.cz>
 <CAOH5QeCfwF0hX3XpoThEtwnddtOFEU9Jtp0Hoj+Q37D4Q6HC0Q@mail.gmail.com>
 <YR/NRJEhPKRQ1r22@dhcp22.suse.cz>
 <CAOH5QeDUUqrMnuws6cnBDU_oub4cK6KsHeX39p7Eikr4Bcjcnw@mail.gmail.com>
 <YSzh31BasoxUQXAu@dhcp22.suse.cz>
 <CAOH5QeBrxpddmTL40ryajjCJZ4WHJsaubYKBvaeikikn1JmJ9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOH5QeBrxpddmTL40ryajjCJZ4WHJsaubYKBvaeikikn1JmJ9Q@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 04-09-21 18:41:00, yong w wrote:
[..]
> > It is not in conflict but runtime overhead reduction without more burden
> > on the configurability is usually a preferred approach.
> I agree with you.I had an idea that we use global variables to identify whether
> there is event registration,however, global variables need to be
> protected with locks.

Have a look at static keys which are usual tool to provide effectivelly
zero overhead disabled branch.
-- 
Michal Hocko
SUSE Labs
