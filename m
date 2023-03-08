Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456CC6B02CA
	for <lists+cgroups@lfdr.de>; Wed,  8 Mar 2023 10:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCHJYW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Mar 2023 04:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjCHJYL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Mar 2023 04:24:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70686A1FD7;
        Wed,  8 Mar 2023 01:24:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED8ED61709;
        Wed,  8 Mar 2023 09:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DEEC433D2;
        Wed,  8 Mar 2023 09:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678267439;
        bh=18GSiD8dZEkkLpIuRHOIMVhuJHmIcKeYx02x8hjIYPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bS9mbeaMxFembCuwEUxj/0X38+AT4DfIn8MmYSZCnEi/IDmiEgVTa9Irqz3Ed+ftw
         MuAfDTr1S/vJyPLKhTkA0sg5zkhFaJaccKV83kxwcWx574XTcc2V+MKB1H5Qbdft1q
         uI7PsyOxJXWpRgmA/WhPLlakZjUi4rewZ/QMK7nUj/cGTjN2X4uRdGrxSpi7CFy8yM
         5HWHllWIsdxyZ4+uqvdQpyI4KeMGGcreKJnoiPFCeORO3M4gPGB5rx2leLsQZid0IQ
         xa726yOZapZfTH967/wf8n/Q1p9uhHXm0TZ4oLWmTdef27WbMLMvu0agNJJmpMNftX
         FjIs+cTI3ay3Q==
Date:   Wed, 8 Mar 2023 10:23:53 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: bpf: use cgroup_lock()/cgroup_unlock() wrappers
Message-ID: <20230308092353.xpaa6syh4yteg57c@wittgenstein>
References: <20230303095310.238553-1-kamalesh.babulal@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230303095310.238553-1-kamalesh.babulal@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 03, 2023 at 03:23:10PM +0530, Kamalesh Babulal wrote:
> Replace mutex_[un]lock() with cgroup_[un]lock() wrappers to stay
> consistent across cgroup core and other subsystem code, while
> operating on the cgroup_mutex.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
