Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437244AC743
	for <lists+cgroups@lfdr.de>; Mon,  7 Feb 2022 18:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbiBGR02 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Feb 2022 12:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiBGRUM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Feb 2022 12:20:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0284EC0401D5;
        Mon,  7 Feb 2022 09:20:11 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6403E21106;
        Mon,  7 Feb 2022 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644254409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WgeOunKZPWr1u7CmKBkIn3aI6IvIjxAaiaRIxKsTWU4=;
        b=oJXyY0lg033cJKb3vjdcvI1hPZc0gH3NGf+1IsuEJ2ysu4j/U4GQMpA/uH+PHT9ObqH4c3
        /ifMCTOMsZOAoJluh2kAlCYa+QIjE9Jlssbw6yrsZiFNwdqn5cHqm8RNt6f4GoH3hPvEjk
        GOdslupORGgeUQ8/DjTm1kwISSSRba0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 234B7A3B84;
        Mon,  7 Feb 2022 17:20:08 +0000 (UTC)
Date:   Mon, 7 Feb 2022 18:20:04 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>, Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v4 3/4] mm/page_owner: Print memcg information
Message-ID: <YgFUxFI5bMbc42j4@dhcp22.suse.cz>
References: <20220131192308.608837-5-longman@redhat.com>
 <20220202203036.744010-4-longman@redhat.com>
 <YfvOp5VXrxy9IW1w@dhcp22.suse.cz>
 <3f042edb-3769-afea-17a7-899578cd5c69@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f042edb-3769-afea-17a7-899578cd5c69@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 03-02-22 14:03:58, Waiman Long wrote:
> On 2/3/22 07:46, Michal Hocko wrote:
> > On Wed 02-02-22 15:30:35, Waiman Long wrote:
> > [...]
> > > +#ifdef CONFIG_MEMCG
> > > +	unsigned long memcg_data;
> > > +	struct mem_cgroup *memcg;
> > > +	bool online;
> > > +	char name[80];
> > > +
> > > +	rcu_read_lock();
> > > +	memcg_data = READ_ONCE(page->memcg_data);
> > > +	if (!memcg_data)
> > > +		goto out_unlock;
> > > +
> > > +	if (memcg_data & MEMCG_DATA_OBJCGS)
> > > +		ret += scnprintf(kbuf + ret, count - ret,
> > > +				"Slab cache page\n");
> > > +
> > > +	memcg = page_memcg_check(page);
> > > +	if (!memcg)
> > > +		goto out_unlock;
> > > +
> > > +	online = (memcg->css.flags & CSS_ONLINE);
> > > +	cgroup_name(memcg->css.cgroup, name, sizeof(name));
> > Is there any specific reason to use another buffer allocated on the
> > stack? Also 80B seems too short to cover NAME_MAX.
> > 
> > Nothing else jumped at me.
> 
> I suppose we can print directly into kbuf with cgroup_name(), but using a
> separate buffer is easier to read and understand. 79 characters should be
> enough for most cgroup names. Some auto-generated names with some kind of
> embedded uuids may be longer than that, but the random sequence of hex
> digits that may be missing do not convey much information for identification
> purpose. We can always increase the buffer length later if it turns out to
> be an issue.

Cutting a name short sounds like a source of confusion and there doesn't
seem to be any good reason for that.
-- 
Michal Hocko
SUSE Labs
