Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B188B62E1F6
	for <lists+cgroups@lfdr.de>; Thu, 17 Nov 2022 17:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbiKQQds (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Nov 2022 11:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240462AbiKQQdX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Nov 2022 11:33:23 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7741C7FF3C
        for <cgroups@vger.kernel.org>; Thu, 17 Nov 2022 08:30:44 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id k4so1523703qkj.8
        for <cgroups@vger.kernel.org>; Thu, 17 Nov 2022 08:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1OZMheGA35bNHdC4rcQaw04gRFU5dhh6+LoysxwctI=;
        b=gBPgguogHnCs8qLFkHLovKhea+586FfigjxG2lZ/MaE9Nuf1D5ynr4EW8NuCB8Jttx
         g5dBrHk6MPtfBHgO5CGcxi48rGJ1AWA1RMFPyFq2Yv/PQzPmMQHGUojHrn/FcFOscZeV
         Cq2PpVSekSv9XdkK8Kx8IW8kJJXDl54YyobmXFWMWwS16b5C3foi2dFjudvmSGlLT9DJ
         Kg1Nz/FjWkQX8t98kBdKZTHvbOUJ1XXd0X4gGOpBOl3tzqnJ8mhW7HO7/PkGUq+jHbbT
         73u7ktxf1LpggHcxU8C8Vb6YWPFZfyNiu9/T3r0AkcjSVHf13bhsL55hymIVfB5AdpBR
         MzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1OZMheGA35bNHdC4rcQaw04gRFU5dhh6+LoysxwctI=;
        b=ATsX3mncqQpX2bGphMVqylcB+0MJ7g6q2H8YGTRasRaIb15yD7gRqVBBOH+AlLpoBZ
         V02H4N6STSzXMK7afMfrPVjWuYCZJRkdvluR2FqXHy4yxizAuDDHK1JZAzaVlkqBy5rm
         7Ob0NAUnzZXxZ/48jABYq1DzA6SIw+G3GqmZQ/SeDKnTLsR93jcHW6J4KcaAAwbPNHTb
         eV7aJyDV6v7jA8w09x5hxU0eRb1mrVWck7iH2E7nTlCoyDrRBeltCKjFjwM/z1OgikOY
         wCRSoKD5nViwPQY7MJFF180DUcvW8xcV5j8k7aLSWgnC3O5y05on6KelWYGPSK4AAHPO
         F67g==
X-Gm-Message-State: ANoB5pm7YPOJy2sH7nVoZhCBG9HhitTVGspQtBv1XZ0+JKm0aszQyK52
        4Bmpi6Mwedj/ifKyD20CurbQaA==
X-Google-Smtp-Source: AA0mqf4aiEkB54XukqvUTKw26Xwty0EMrW3pMhd9Nh30V/h2TpR5xoOVt2zIw/fQB2E8tkHtTP98wA==
X-Received: by 2002:a37:de09:0:b0:6f6:8c12:e12c with SMTP id h9-20020a37de09000000b006f68c12e12cmr2350158qkj.396.1668702643568;
        Thu, 17 Nov 2022 08:30:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id ed13-20020a05620a490d00b006eeae49537bsm681054qkb.98.2022.11.17.08.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:30:42 -0800 (PST)
Date:   Thu, 17 Nov 2022 11:31:05 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        cgroups@vger.kernel.org
Subject: Re: cgroup v1 and balance_dirty_pages
Message-ID: <Y3ZhyfROmGKn/jfr@cmpxchg.org>
References: <87wn7uf4ve.fsf@linux.ibm.com>
 <Y3ZPZyaX1WN3tad4@cmpxchg.org>
 <697e50fd-1954-4642-9f61-1afad0ebf8c6@linux.ibm.com>
 <9fb5941b-2c74-87af-a476-ce94b43bb542@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fb5941b-2c74-87af-a476-ce94b43bb542@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 17, 2022 at 09:21:10PM +0530, Aneesh Kumar K V wrote:
> On 11/17/22 9:12 PM, Aneesh Kumar K V wrote:
> > On 11/17/22 8:42 PM, Johannes Weiner wrote:
> >> Hi Aneesh,
> >>
> >> On Thu, Nov 17, 2022 at 12:24:13PM +0530, Aneesh Kumar K.V wrote:
> >>> Currently, we don't pause in balance_dirty_pages with cgroup v1 when we
> >>> have task dirtying too many pages w.r.t to memory limit in the memcg.
> >>> This is because with cgroup v1 all the limits are checked against global
> >>> available resources. So on a system with a large amount of memory, a
> >>> cgroup with a smaller limit can easily hit OOM if the task within the
> >>> cgroup continuously dirty pages.
> >>
> >> Page reclaim has special writeback throttling for cgroup1, see the
> >> folio_wait_writeback() in shrink_folio_list(). It's not as smooth as
> >> proper dirty throttling, but it should prevent OOMs.
> >>
> >> Is this not working anymore?
> > 
> > The test is a simple dd test on on a 256GB system.
> > 
> > root@lp2:/sys/fs/cgroup/memory# mkdir test
> > root@lp2:/sys/fs/cgroup/memory# cd test/
> > root@lp2:/sys/fs/cgroup/memory/test# echo 120M > memory.limit_in_bytes 
> > root@lp2:/sys/fs/cgroup/memory/test# echo $$ > tasks 
> > root@lp2:/sys/fs/cgroup/memory/test# dd if=/dev/zero of=/home/kvaneesh/test bs=1M 
> > Killed
> > 
> > 
> > Will it hit the folio_wait_writeback, because it is sequential i/o and none of the folio
> > we are writing will be in writeback?
> 
> Other way to look at this is, if the writeback is never started via balance_dirty_pages,
> will we be finding folios in shrink_folio_list that is in writeback? 

The flushers are started from reclaim if necessary. See this code from
shrink_inactive_list():

	/*
	 * If dirty folios are scanned that are not queued for IO, it
	 * implies that flushers are not doing their job. This can
	 * happen when memory pressure pushes dirty folios to the end of
	 * the LRU before the dirty limits are breached and the dirty
	 * data has expired. It can also happen when the proportion of
	 * dirty folios grows not through writes but through memory
	 * pressure reclaiming all the clean cache. And in some cases,
	 * the flushers simply cannot keep up with the allocation
	 * rate. Nudge the flusher threads in case they are asleep.
	 */
	if (stat.nr_unqueued_dirty == nr_taken)
		wakeup_flusher_threads(WB_REASON_VMSCAN);

It sounds like there isn't enough time for writeback to commence
before the memcg already declares OOM.

If you place a reclaim_throttle(VMSCAN_THROTTLE_WRITEBACK) after that
wakeup, does that fix the issue?
