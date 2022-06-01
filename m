Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E029153ACD9
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 20:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiFASd7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 14:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiFASd6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 14:33:58 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C74AFAC5;
        Wed,  1 Jun 2022 11:33:56 -0700 (PDT)
Date:   Wed, 1 Jun 2022 11:33:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654108434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3KXe7JyS/4SiYSTcpgOTrPkJ9VUQGQph5wJDhLq1PkU=;
        b=DQ8Mzwg5sWQebSxothCauYo0hX22gELn6PYnLRWohwSwso3mkoAi+6Eqf8yU60WzZIvpoq
        7JA+jXgqBdR5ChOWnOD2G77XAHvgdMXfyGAwWd/TCPcZPqYQAecPj9aDhzScPFSGKTzNWd
        YgHzVCljqv4x3G7uwNjg9P/3YjJOfNs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, shakeelb@google.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v5 03/11] mm: memcontrol: prepare objcg API for non-kmem
 usage
Message-ID: <YpexCpVBW76GCN2X@carbon>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <20220530074919.46352-4-songmuchun@bytedance.com>
 <20220601173434.GB16134@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601173434.GB16134@blackbody.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 01, 2022 at 07:34:34PM +0200, Michal Koutny wrote:
> Hello.
> 
> On Mon, May 30, 2022 at 03:49:11PM +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> > So we also allocate an object cgroup for the root_mem_cgroup.
> 
> This change made me wary that this patch also kmem charging in the
> root_mem_cgroup. Fortunately, get_obj_cgroup_from_current won't return
> this objcg so all is fine.

Yes, I had the same experience here :)

Overall I feel like the handling of the root memcg and objcg are begging
for a cleanup, but it's really far from being trivial.

Maybe starting with documenting how it works now is a good idea...
