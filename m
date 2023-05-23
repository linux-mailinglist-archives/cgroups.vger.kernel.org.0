Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF81970D9B6
	for <lists+cgroups@lfdr.de>; Tue, 23 May 2023 11:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbjEWJ6v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 May 2023 05:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbjEWJ6o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 May 2023 05:58:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BC5188;
        Tue, 23 May 2023 02:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18EA162FCB;
        Tue, 23 May 2023 09:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60ECC433EF;
        Tue, 23 May 2023 09:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684835920;
        bh=tC/uWnb4vQv4X17V3g3ZMLWyWgfw32VJp0SADGWiBNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=do66W86rFkN3BQI1XPoprnXAQHmdGnIbxZvhY+YezuN0GoRrzGsoGbtynVrtSBxm7
         eWZaGniVXJdqt3Q37uFc89xhtbdRmsME+y4CvVIBaCSqbQnI+Hqk/ZTHq8vBuY+eiY
         G1eulwBQbYKOp7ZxV/7qzY2dTd7l17xod7WjEMZYqXKi7mFAUNFpnN/EKtgwoykWOM
         2saLgTyannYGaVal4xoDmSclmiZLZyc8RW6Qvp+xgMMUH7aWmoSmtdVfR4q09LRqzd
         aVP8Enusnvu/YLWUitwcrCA+c4Zug52dSCEWKenTOTUCArUFT65L574ZbFHxOaIpLq
         4iiKAUyLma5AQ==
Date:   Tue, 23 May 2023 11:58:35 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     John Sperbeck <jsperbeck@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: always put cset in cgroup_css_set_put_fork
Message-ID: <20230523-aphorismen-erzwingen-ae57f4fd33f2@brauner>
References: <20230521192953.229715-1-jsperbeck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230521192953.229715-1-jsperbeck@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, May 21, 2023 at 07:29:53PM +0000, John Sperbeck wrote:
> A successful call to cgroup_css_set_fork() will always have taken
> a ref on kargs->cset (regardless of CLONE_INTO_CGROUP), so always
> do a corresponding put in cgroup_css_set_put_fork().
> 
> Without this, a cset and its contained css structures will be
> leaked for some fork failures.  The following script reproduces
> the leak for a fork failure due to exceeding pids.max in the
> pids controller.  A similar thing can happen if we jump to the
> bad_fork_cancel_cgroup label in copy_process().
> 
> [ -z "$1" ] && echo "Usage $0 pids-root" && exit 1
> PID_ROOT=$1
> CGROUP=$PID_ROOT/foo
> 
> [ -e $CGROUP ] && rmdir -f $CGROUP
> mkdir $CGROUP
> echo 5 > $CGROUP/pids.max
> echo $$ > $CGROUP/cgroup.procs
> 
> fork_bomb()
> {
> 	set -e
> 	for i in $(seq 10); do
> 		/bin/sleep 3600 &
> 	done
> }
> 
> (fork_bomb) &
> wait
> echo $$ > $PID_ROOT/cgroup.procs
> kill $(cat $CGROUP/cgroup.procs)
> rmdir $CGROUP
> 
> Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
> Signed-off-by: John Sperbeck <jsperbeck@google.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
