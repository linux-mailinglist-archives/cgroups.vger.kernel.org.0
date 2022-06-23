Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD174557FFE
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 18:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiFWQhI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 12:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiFWQhG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 12:37:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D5345AFA;
        Thu, 23 Jun 2022 09:37:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 404BF1F38C;
        Thu, 23 Jun 2022 16:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656002224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xjy8SPQ+d5ER4berxN3l8OR04THIzep3YipbQ/OBM0g=;
        b=Ew+9Nb9MszfcKz8/CBOy/vbT3LdyWXYXJmxRGKgwX44dyVrdqLUM2gHRY/sEx6UyjnRIDM
        XzKj749fNM/8KrvLqqDkVWcOjsXB8hvCCVPr2RXCWZIpa/zrlE67nFC15urvWI1xAa1OjU
        AnLic47l3onMcYVNv9L25O3PWNX0d3c=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6AD542C197;
        Thu, 23 Jun 2022 16:37:03 +0000 (UTC)
Date:   Thu, 23 Jun 2022 18:37:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: vmpressure: don't count userspace-induced reclaim as
 memory pressure
Message-ID: <YrSWruhPlJV1X9kp@dhcp22.suse.cz>
References: <20220623000530.1194226-1-yosryahmed@google.com>
 <YrQe5A+FXnbgOR1f@dhcp22.suse.cz>
 <CAJD7tkanavKpKrQr8-jA8pukgD7OY4eOwJRZufJ2NoThD12G+Q@mail.gmail.com>
 <YrQ1o3CeaZWhm+h4@dhcp22.suse.cz>
 <CAJD7tkadsLOV7GMFAm+naX4Y1WpZ-4=NkAhAMxNw60iaRPWx=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkadsLOV7GMFAm+naX4Y1WpZ-4=NkAhAMxNw60iaRPWx=w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 23-06-22 09:22:35, Yosry Ahmed wrote:
> On Thu, Jun 23, 2022 at 2:43 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 23-06-22 01:35:59, Yosry Ahmed wrote:
[...]
> > > In our internal version of memory.reclaim that we recently upstreamed,
> > > we do not account vmpressure during proactive reclaim (similar to how
> > > psi is handled upstream). We want to make sure this behavior also
> > > exists in the upstream version so that consolidating them does not
> > > break our users who rely on vmpressure and will start seeing increased
> > > pressure due to proactive reclaim.
> >
> > These are good reasons to have this patch in your tree. But why is this
> > patch benefitial for the upstream kernel? It clearly adds some code and
> > some special casing which will add a maintenance overhead.
> 
> It is not just Google, any existing vmpressure users will start seeing
> false pressure notifications with memory.reclaim. The main goal of the
> patch is to make sure memory.reclaim does not break pre-existing users
> of vmpressure, and doing it in a way that is consistent with psi makes
> sense.

memory.reclaim is v2 only feature which doesn't have vmpressure
interface. So I do not see how pre-existing users of the upstream kernel
can see any breakage.

-- 
Michal Hocko
SUSE Labs
