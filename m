Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76766CFD58
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 09:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjC3Hut (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 03:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjC3Hug (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 03:50:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CF7729F;
        Thu, 30 Mar 2023 00:50:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30E7521B0B;
        Thu, 30 Mar 2023 07:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680162633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oGBp2CerBGhZkbj2lQ/nRIhr24DsF/TKy5SuxGUse2s=;
        b=b3sVl6y3RurKw8ub7GVYytEfZjv5e7tMzMkxjEqStKlRW0eN196yPTxmsd1WQnppK3lR2a
        3NkEc1GikBqDkQ15fxo+RIJ32ywlsW/Ov47iO6zepuLhLcfl+ULGBtWgO2G+gx33rfB5vD
        g8jsOgtw5SluPqSGCIX1kHrMPP4REtI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D874138FF;
        Thu, 30 Mar 2023 07:50:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IdIAAUk/JWRYAwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 30 Mar 2023 07:50:33 +0000
Date:   Thu, 30 Mar 2023 09:50:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 7/9] workingset: memcg: sleep when flushing stats in
 workingset_refault()
Message-ID: <ZCU/SMr5gC9C0U+R@dhcp22.suse.cz>
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-8-yosryahmed@google.com>
 <ZCU8tjqzg8cDbobQ@dhcp22.suse.cz>
 <CAJD7tkZLBs=A8m5u=9jGtMeD0ptOgtCTYUoh2r4Ex+fCkvwAXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZLBs=A8m5u=9jGtMeD0ptOgtCTYUoh2r4Ex+fCkvwAXg@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 30-03-23 00:42:36, Yosry Ahmed wrote:
> On Thu, Mar 30, 2023 at 12:39 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 28-03-23 22:16:42, Yosry Ahmed wrote:
> > > In workingset_refault(), we call
> > > mem_cgroup_flush_stats_atomic_ratelimited() to flush stats within an
> > > RCU read section and with sleeping disallowed. Move the call above
> > > the RCU read section and allow sleeping to avoid unnecessarily
> > > performing a lot of work without sleeping.
> >
> > Could you say few words why the flushing is done before counters are
> > updated rather than after (the RCU section)?
> 
> It's not about the counters that are updated, it's about the counters
> that we read. Stats readers do a flush first to read accurate stats.
> We flush before a read, not after an update.

Right you are, my bad I have misread the intention here.

Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs
