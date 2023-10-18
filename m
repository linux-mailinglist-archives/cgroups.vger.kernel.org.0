Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C5E7CE7AC
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 21:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjJRT1j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 15:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJRT1j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 15:27:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D330E109;
        Wed, 18 Oct 2023 12:27:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22244C433C8;
        Wed, 18 Oct 2023 19:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697657257;
        bh=1rqOwZjRE1nbagNyIX9i1zuz/F+kupl3lvfqaew4Dl4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C+Tu235fFZ9ShVy1YAybs9EPC7bM8MDFacJsq5th4+oYT8RpPrUNEGKRnllQfBjNd
         tswotbPOIfdrDpHPMfTpCIsSF2Fjzo7dLnS28BR6NqqUjGTNupAWlpBf6EK1oIUAo0
         PnYCoah04uvXQ9UbUW/isQiAsUWKJXjrwFucbmZk=
Date:   Wed, 18 Oct 2023 12:27:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: memcg: refactor page state unit helpers
Message-Id: <20231018122736.9a2b6abd4f0a1112144503ae@linux-foundation.org>
In-Reply-To: <CAJD7tkZaWVhedgVAU+6WUk08V5AW=fmtken5rZJyQm+JhoDs9w@mail.gmail.com>
References: <20230922175741.635002-1-yosryahmed@google.com>
        <20230922175741.635002-2-yosryahmed@google.com>
        <lflzirgjvnodndnuncbulipka6qcif5yijtbqpvbcr3zp3532u@6b37ks523gnt>
        <CAJD7tkbfq8P514-8Y1uZG9E0fMN2HwEaBmxEutBhjVtbtyEdCQ@mail.gmail.com>
        <vet5qmfj5xwge4ebznzihknxvpmrmkg6rndhani3fk75oo2rdm@lk3krzcresap>
        <20231004183619.GB39112@cmpxchg.org>
        <542ggmgjc27yoosxg466c6n4mzcad2z63t3wdbzevzm43g7xlt@5l7qaepzbth6>
        <CAJD7tkbaTRu838U=e_A+89PY1t4K+t_G1qkYq84BSDO7wAEtEg@mail.gmail.com>
        <4h5uae72ti6jyiibcyfg2bytooy6d6ggtkrgod5a6rmpateyra@4setu5jmd5kn>
        <CAJD7tkZaWVhedgVAU+6WUk08V5AW=fmtken5rZJyQm+JhoDs9w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 5 Oct 2023 10:30:36 -0700 Yosry Ahmed <yosryahmed@google.com> wrote:

> On Thu, Oct 5, 2023 at 9:30 AM Michal Koutný <mkoutny@suse.com> wrote:
> >
> > On Thu, Oct 05, 2023 at 02:31:03AM -0700, Yosry Ahmed <yosryahmed@google.com> wrote:
> > > I am not really sure what you mean here.
> >
> > My "vision" is to treat WORKINGSET_ entries as events.
> > That would mean implementing per-node tracking for vm_event_item
> > (costlier?).
> > That would mean node_stat_item and vm_event_item being effectively
> > equal, so they could be merged in one.
> > That would be situation to come up with new classification based on use
> > cases (e.g. precision/timeliness requirements, state vs change
> > semantics).
> >
> > (Do not take this as blocker of the patch 1/2, I rather used the
> > opportunity to discuss a greater possible cleanup.)
> 
> Yeah ideally we can clean this up separately. I would be careful about
> userspace exposure though. It seems like CONFIG_VM_EVENT_COUNTERS is
> used to control tracking events and displaying them in vmstat, so
> moving items between node_stat_item and vm_event_item (or merging
> them) won't be easy.

I like the word "separately".  This series has been in mm-unstable for
nearly a month, so I'll move it into mm-stable as-is,

