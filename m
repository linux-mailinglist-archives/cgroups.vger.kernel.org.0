Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95A576F049
	for <lists+cgroups@lfdr.de>; Thu,  3 Aug 2023 19:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjHCRFh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Aug 2023 13:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjHCRFg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Aug 2023 13:05:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDB5DA;
        Thu,  3 Aug 2023 10:05:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F349C61E46;
        Thu,  3 Aug 2023 17:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058D5C433C7;
        Thu,  3 Aug 2023 17:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691082334;
        bh=mKXYwoVy5HfvYiKywnPPMjvSi6Q9LzPXn0QPxBh7klc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sR/84AOqkNrlcyI3Mg///cmnKs9K7ETOFfWUvoe1dfQx5DKvUhLK0PQV/VfacxYKJ
         c9FskuPuzEyD0/Tut7Eg8+l/huwAJp84RU/+2om1L2s6CgrKvpPktF5KRDDNtb/hjd
         y3DtIqnBfSiziLpvk1Mk36RNcIEzzVBWcY1gLVII=
Date:   Thu, 3 Aug 2023 10:05:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, tj@kernel.org,
        lizefan.x@bytedance.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: minor cleanup for cgroup_local_stat_show()
Message-Id: <20230803100533.a9bdac370de2e8e4bee0f33a@linux-foundation.org>
In-Reply-To: <20230803142758.GC219857@cmpxchg.org>
References: <20230803113123.577023-1-linmiaohe@huawei.com>
        <20230803142758.GC219857@cmpxchg.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 3 Aug 2023 10:27:58 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> > @@ -3686,8 +3686,9 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
> >  	return ret;
> >  }
> >  
> > -static int __maybe_unused cgroup_local_stat_show(struct seq_file *seq,
> > -						 struct cgroup *cgrp, int ssid)
> > +#ifdef CONFIG_CGROUP_SCHED
> > +static int cgroup_local_stat_show(struct seq_file *seq,
> > +				  struct cgroup *cgrp, int ssid)
> 
> Andrew, this is based on "sched: add throttled time stat for throttled
> children" in -next (coming in from -tip). Hence the routing through
> you rather than the cgroup tree.

Since switching to the more gitty workflow I have lost the power to
carry patches against -next.  I could regain that power I guess, but
this is the first time the requirement has come up.

So for now I'll save this patch away for the next -rc cycle.
