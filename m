Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5456405D11
	for <lists+cgroups@lfdr.de>; Thu,  9 Sep 2021 20:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344245AbhIIS53 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Sep 2021 14:57:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45312 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbhIIS53 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Sep 2021 14:57:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 64F872233B;
        Thu,  9 Sep 2021 18:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631213778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7t8ztgYZsndp44kDdVFUqlrz/Zoxo2W/1YXS7ePODV0=;
        b=RhFaxjaP0kRFSHZmQkLTUH3usxdlgA4J91/Herg20j4L7sLvgpQ3JuSnllPZKyRxRfc+GE
        jUQP2aFo5A7rEO5JhhZx+eP5RNM5w37gbXoODJX03b45gvkpVwvKIF75IbQuFknN/IVq0A
        MbKJUW3joiEwGySf/L0DeqEspo5mdYs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F7AE13ACF;
        Thu,  9 Sep 2021 18:56:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8YVSCtJYOmFBLwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 09 Sep 2021 18:56:18 +0000
Date:   Thu, 9 Sep 2021 20:56:16 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     brookxu <brookxu.cn@gmail.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] misc_cgroup: remove error log to avoid log flood
Message-ID: <YTpY0G3+IJYmGbdd@blackbook>
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
 <86e89df640f2b4a65dd77bdbab8152fa8e8f5bf1.1631077837.git.brookxu@tencent.com>
 <20210909143720.GA14709@blackbody.suse.cz>
 <CAHVum0ffLr+MsF0O+yEWKcdpR0J0TQx6GdDxeZFZY7utZT8=KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVum0ffLr+MsF0O+yEWKcdpR0J0TQx6GdDxeZFZY7utZT8=KA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 09, 2021 at 09:49:56AM -0700, Vipin Sharma <vipinsh@google.com> wrote:
> We are adding two files in this patch series, misc.events and
> misc.events.local. I think "fail" should go in misc.events.local and
> its name should be changed to "max".

I consider the max vs fail orthogonal to local vs hierarchical. I.e.
both entries can be in both files:

(1) misc.events.local:max	number of times the cgroup's misc.max was hit
(2) misc.events.local:fail	number of times operation failed in the cgroup
(3) misc.events:max		number of times the cgroup's misc.max was hit in the subtree
(4) misc.events:fail		number of times operation failed in the subtree

Is that too many? Admittedly, I assume (1) and (4) will be the more useful ones.
However, I'm afraid overloading "max" as suggested might be (more)
confusing. ('subtree' above := self or descendant)

Michal
