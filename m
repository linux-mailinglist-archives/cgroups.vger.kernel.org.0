Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDA74ADC67
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 16:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351658AbiBHPUu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 10:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379465AbiBHPPI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 10:15:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA6EC061577;
        Tue,  8 Feb 2022 07:15:07 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 423561F383;
        Tue,  8 Feb 2022 15:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644333306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iIBn4Rav1LBR3y1c5hDMynQtqqgJZkX7I4kc9wq3uRs=;
        b=GsdnHU3cwdGn8OVGCJqWUbt20HF/QLQRsCFXZSmYmHY+SdULFqDf9IupBsQHpwsFqVyVQN
        Gf+fXxoyvKtpXIKaNdc14frKvMo3qSkwkkXPgfEDDToghZmni984WZ8/2vUDKVj61efMNJ
        iq6cAZzQVWGnl0xMx12l/0sRp5UgpnA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CEED9A3B92;
        Tue,  8 Feb 2022 15:15:05 +0000 (UTC)
Date:   Tue, 8 Feb 2022 16:15:05 +0100
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
        Roman Gushchin <guro@fb.com>,
        Rafael Aquini <aquini@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v5 3/4] mm/page_owner: Print memcg information
Message-ID: <YgKI+Y1/AKgJbpem@dhcp22.suse.cz>
References: <20220208000532.1054311-1-longman@redhat.com>
 <20220208000532.1054311-4-longman@redhat.com>
 <YgJeWth50eP9L0PK@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgJeWth50eP9L0PK@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 08-02-22 13:13:15, Michal Hocko wrote:
> On Mon 07-02-22 19:05:31, Waiman Long wrote:
[...]
> > +	ret += scnprintf(kbuf + ret, count - ret, "\n");
> 
> I do not see any overflow prevention here. I believe you really need to
> check ret >= count after each scnprintf/cgroup_name.

OK, I have only now realized that scnprintf would return size - 1 on
overflow so explicitly checking for the overlow shouldn't be reallu
necessary.
-- 
Michal Hocko
SUSE Labs
