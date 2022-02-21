Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B6F4BE29B
	for <lists+cgroups@lfdr.de>; Mon, 21 Feb 2022 18:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381668AbiBURZx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Feb 2022 12:25:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbiBURZk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Feb 2022 12:25:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12043AE68
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 09:25:16 -0800 (PST)
Date:   Mon, 21 Feb 2022 18:25:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645464314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QNtNFdJSacVr39E6Cf/B3S4hi9OzOvHCrXZBSJUBNek=;
        b=job64lGFLs88tgOC58oUnEjLgmTTN/A9J2cmQ5n3f8mbEc1EDx5jPctWkm4a6GYNgpaesK
        q2f73rvblIG506aBx6r+RteEm500eFneFthRRXuneboc+NtM+DbzrViKnc/aRpTwoqVQFX
        3h93qN07kfg6iqj2bw7BDieWZy2VjChQp5/OlFZZ5DiQgUBHcOU4apyzZ0E9r8QCcfcp/v
        DRwo1t8PVH+WGk5TcPOYpXRPx8mi4CsfU3KobPXDQ8nS4/ARZwSj4Ogb7aG97Qx9ysrCYl
        c73RrA3JxZrUx2PWrpm0AyjE1uCIjgvnp6obFNDBmDOa/P0Zj4CX0ISHmGAepQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645464314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QNtNFdJSacVr39E6Cf/B3S4hi9OzOvHCrXZBSJUBNek=;
        b=kvY/S3SYQUccFr25pdL1pEqU7UlLkvE9bEmvzwN5lEqUVOSwODkgGYnINgGgTZCzfw9FtH
        9j6IFmyjlNHdBpAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v3 5/5] mm/memcg: Protect memcg_stock with a local_lock_t
Message-ID: <YhPK+Ht4I4MTFI+m@linutronix.de>
References: <20220217094802.3644569-1-bigeasy@linutronix.de>
 <20220217094802.3644569-6-bigeasy@linutronix.de>
 <YhOlxsLOOU/OVSzu@dhcp22.suse.cz>
 <YhOtmPQUcqZCKodH@linutronix.de>
 <YhO8yQrdVX04T8/n@dhcp22.suse.cz>
 <YhPBXUmIIHeXI/Gz@linutronix.de>
 <YhPJM4RjqklanVLE@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhPJM4RjqklanVLE@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-02-21 18:17:39 [+0100], Michal Hocko wrote:
> > What about if replace get_cpu() with migrate_disable()? 
> 
> Yeah, that would be a better option. I am just not used to think in RT
> so migrate_disable didn't really come to my mind.

Good.
Let me rebase accordingly, new version is coming soon.

Side note: migrate_disable() is by now implemented in !RT and used in
highmem for instance (kmap_atomic()).

Sebastian
