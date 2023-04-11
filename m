Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28C16DD64E
	for <lists+cgroups@lfdr.de>; Tue, 11 Apr 2023 11:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjDKJLL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Apr 2023 05:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjDKJKy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Apr 2023 05:10:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B152FE0;
        Tue, 11 Apr 2023 02:10:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2786F21A62;
        Tue, 11 Apr 2023 09:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681204226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J8OA3wgt+Z7nlPBRmZK8bnpZsdI2d7MNXaYAdmJPsgA=;
        b=F/GtwlKhIk6gdskzQIDdvelDeOaGATFGEdUdGAJRZ0+M/AzoL/mXWsiWKdBP7p6hsmGO59
        4HVw0kozzIL26HT6VfwUn7KEKjYxTMUGEEG0uWx0ZnCjvBrslPgt8pu3NYTmEkEhr3XplX
        znbWPl/iaqrIVPxft/0avEwyyDPAoZs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 032A313519;
        Tue, 11 Apr 2023 09:10:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TX0WOgEkNWTPHwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 11 Apr 2023 09:10:25 +0000
Date:   Tue, 11 Apr 2023 11:10:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shaun Tancheff <shaun.tancheff@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shaun Tancheff <shaun.tancheff@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: Default value setting in memcg-v1
Message-ID: <ZDUkAWT59seiD8+8@dhcp22.suse.cz>
References: <20230406091450.167779-1-shaun.tancheff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406091450.167779-1-shaun.tancheff@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 06-04-23 16:14:50, Shaun Tancheff wrote:
> From: Shaun Tancheff <shaun.tancheff@hpe.com>
> 
> Setting min, low and high values with memcg-v1
> provides bennefits for  users that are unable to update
> to memcg-v2.

min, low and high limits are cgroup v2 concepts which are not a fit for
v1 implementation. The primary reason why v2 interface has been created
was that existing v1 interfaces and internal constrains (most
notably soft limit and tasks in inter nodes for memcg) were not
reformable. It is really hard to define a proper semantic for memory
protection when inter node tasks can compete with hierarchy beneath.

> Setting min, low and high can be set in memcg-v1
> to apply enough memory pressure to effective throttle
> filesystem I/O without hitting memcg oom.

This is not a proper way to achieve that. As I've already state in the
previous submission of a similar patch
(20230330202232.355471-1-shaun.tancheff@gmail.com), cgroup v1 dirty data
throttling has some downsides because it cannot effectively throttle
GFP_NOFS allocations. One way around that is to reduce the dirty data
limit to prevent from over dirty memcg LRUs. I would recommend to move
forward to cgroup v2 though.

> This can be enabled by setting the sysctl values:
>   vm.memcg_v1_min_default
>   vm.memcg_v1_low_default
>   vm.memcg_v1_high_default
>
> When a memory control group is newly crated the
> min, low and high values are set to percent of the
> maximum based on the min, low and high default
> values respectively.

This also looks like an anti-pattern in the cgroup world. For two
reasons. First of all min, low (reclaim protection) is hierarchical and
global default value makes a very little sense for anything than flat
hierarchies and even then it makes it really easy to misconfigure system
too easily.
Also percentage is a very suboptimal interface in general as the
granularity is just too coarse for anything than small limits.
 
> This resolves an issue with memory pressure when users
> initiate unbounded I/O on various file systems such as
> ext4, XFS and NFS.

Filesystems should still be controllable by dirty limits. This might
lead to a suboptimal IO throughput but this might be a better workaround
if you cannot afford to move to cgroup v2. V1 interface is considered
legacy and support is limited. New features are only added if there
absolutely is not other way around to keep legacy applications running.

HTH
-- 
Michal Hocko
SUSE Labs
