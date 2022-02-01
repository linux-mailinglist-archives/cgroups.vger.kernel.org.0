Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82034A5A7A
	for <lists+cgroups@lfdr.de>; Tue,  1 Feb 2022 11:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbiBAKtO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Feb 2022 05:49:14 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46652 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiBAKtN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Feb 2022 05:49:13 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 320331F397;
        Tue,  1 Feb 2022 10:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643712552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6Bn0nz2rnpcXkXYw/gRthu/0RqSHCGbN5yIH2/zMno=;
        b=LsrFLxhXhW9MQ5itj+U/rbYQQCU2+RZgxSgqRPFPCH62iHD/1uuU1u+XTeTmuwRN7c3vBl
        7xp0WzHh84RoSxn0EONv306e8MJ1H89YhCsuKp+FnGzVoE92rGb1n/4pI20rWUQi1J/SmO
        giL7UgDUxBg/dDgNhnO46MAaplPB8qo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C1067A3B84;
        Tue,  1 Feb 2022 10:49:11 +0000 (UTC)
Date:   Tue, 1 Feb 2022 11:49:11 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 3/3] mm/page_owner: Dump memcg information
Message-ID: <YfkQJ4QhfY0dICB9@dhcp22.suse.cz>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-4-longman@redhat.com>
 <YfeuK5j7cbgM+Oo+@dhcp22.suse.cz>
 <YfgT/9tEREQNiiAN@cmpxchg.org>
 <YfgnUZQBRkqhrEIb@carbon.dhcp.thefacebook.com>
 <Yfgpknwr1tMnPkqh@dhcp22.suse.cz>
 <12686956-612d-d89b-5641-470d5e913090@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12686956-612d-d89b-5641-470d5e913090@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 31-01-22 13:38:28, Waiman Long wrote:
[...]
> Of course, it is also possible to have a debugfs interface to list those
> dead memcg information, displaying more information about the page that pins
> the memcg will be hard without using the page owner tool.

Yes, you will need page owner or hook into the kernel by other means
(like already mentioned drgn). The question is whether scanning all
existing pages to get that information is the best we can offer.

> Keeping track of
> the list of dead memcg's may also have some runtime overhead.

Could you be more specific? Offlined memcgs are still part of the
hierarchy IIRC. So it shouldn't be much more than iterating the whole
cgroup tree and collect interesting data about dead cgroups.

-- 
Michal Hocko
SUSE Labs
