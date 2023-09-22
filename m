Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B89A7AB6D2
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 19:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjIVRDT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 13:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjIVRDS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 13:03:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C39C194;
        Fri, 22 Sep 2023 10:03:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E909C433C8;
        Fri, 22 Sep 2023 17:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695402192;
        bh=qa/QJ12DIUWvIeySIX2g6kqd2yUHHXJ+BRw50a4IKNU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uZWF7kJrm5w73mco/RN5kh0tFZqol/wzUHts2vidpRz38ZzJryh0F8Jo8FNJ1KjRS
         fvytGPaP6DT92lWdNVq/FOf7os8h8kRVgIb6Q+blcoSlcD8L3qWYBYT5RU0unpOhYv
         ZQz8Myb6yh3K4y1JaIiCCoPWXMFcaasTV8Kdbmps=
Date:   Fri, 22 Sep 2023 10:03:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        =?ISO-8859-1?Q? "Michal_Koutn=FD" ?= <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: memcg: fix tracking of pending stats updates
 values
Message-Id: <20230922100310.102aa12ac2bdf0568e6e7432@linux-foundation.org>
In-Reply-To: <20230922082542.466579-1-yosryahmed@google.com>
References: <20230922082542.466579-1-yosryahmed@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 22 Sep 2023 08:25:40 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:

> While working on adjacent code [1], I realized that the values passed
> into memcg_rstat_updated() to keep track of the magnitude of pending
> updates is consistent. It is mostly in pages, but sometimes it can be in
> bytes or KBs. Fix that.

Clashes with "memcg: remove unused do_memsw_account in
memcg1_stat_format", and maybe other things.  Can you please redo
against mm-unsstable or linux-next?
