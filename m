Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3D15B2968
	for <lists+cgroups@lfdr.de>; Fri,  9 Sep 2022 00:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIHWhg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Sep 2022 18:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiIHWhf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Sep 2022 18:37:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F5D5071E;
        Thu,  8 Sep 2022 15:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68DB961E57;
        Thu,  8 Sep 2022 22:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79958C433D7;
        Thu,  8 Sep 2022 22:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662676652;
        bh=RXI/S2LYORA9kdbqhda/3YzOj4NudTqOLXCZh8OTpgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kEGJQpMHSP1rHh5cA53z/rhx151d3iEmV8c26u8Jrn1nf4Kgqkaa6XyFChHpEBi1o
         d43NY62xfwL1k6fVhmHe4a2c33akdSyIzFagezUlm27G68VxZa5J3sRBmijWQ2aOQb
         khq3koVe/u7B5k3QTDiG97mC9VF1/RwV+PrikHkA=
Date:   Thu, 8 Sep 2022 15:37:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] memcg: reduce size of memcg vmstats structures
Message-Id: <20220908153731.d6ec2095c9d1f42ff5e8ec5c@linux-foundation.org>
In-Reply-To: <CALvZod70Mvxr+Nzb6k0yiU2RFYjTD=0NFhKK-Eyp+5ejd1PSFw@mail.gmail.com>
References: <20220907043537.3457014-1-shakeelb@google.com>
        <20220907043537.3457014-4-shakeelb@google.com>
        <CALvZod70Mvxr+Nzb6k0yiU2RFYjTD=0NFhKK-Eyp+5ejd1PSFw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 7 Sep 2022 19:35:10 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Tue, Sep 6, 2022 at 9:36 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> [...]
> >
> >  static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
> >  {
> >         long x = 0;
> >         int cpu;
> > +       int index = memcg_events_index(event);
> > +
> > +       if (index < 0)
> > +               return 0;
> >
> >         for_each_possible_cpu(cpu)
> >                 x += per_cpu(memcg->vmstats_percpu->events[event], cpu);
> 
> Andrew, can you please replace 'event' in the above line with 'index'?
> I had this correct in the original single patch but messed up while
> breaking up that patch into three patches for easier review.

No probs.

From: Andrew Morton <akpm@linux-foundation.org>
Subject: memcg-reduce-size-of-memcg-vmstats-structures-fix
Date: Thu Sep  8 03:35:53 PM PDT 2022

fix memcg_events_local() array index, per Shakeel

Link: https://lkml.kernel.org/r/CALvZod70Mvxr+Nzb6k0yiU2RFYjTD=0NFhKK-Eyp+5ejd1PSFw@mail.gmail.com
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memcontrol.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memcontrol.c~memcg-reduce-size-of-memcg-vmstats-structures-fix
+++ a/mm/memcontrol.c
@@ -921,7 +921,7 @@ static unsigned long memcg_events_local(
 		return 0;
 
 	for_each_possible_cpu(cpu)
-		x += per_cpu(memcg->vmstats_percpu->events[event], cpu);
+		x += per_cpu(memcg->vmstats_percpu->events[index], cpu);
 	return x;
 }
 
_

