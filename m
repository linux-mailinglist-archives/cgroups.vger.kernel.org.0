Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47785782A76
	for <lists+cgroups@lfdr.de>; Mon, 21 Aug 2023 15:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbjHUN0J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Aug 2023 09:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbjHUN0I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Aug 2023 09:26:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4249EB1;
        Mon, 21 Aug 2023 06:26:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D473561E94;
        Mon, 21 Aug 2023 13:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B89C433C7;
        Mon, 21 Aug 2023 13:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692624366;
        bh=wo0AEq7EVLKcJNozUw706Dbt/mblagvb19WS0DocC+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V/U5FQXfP7owWoyl3u1JxwD1cHjEUFKG09746gRFkXDP1fKWXpzqEutKp5T+YVlIw
         6D6CY94Zcc1Emt2MBjamEHENJfOnn/7+afTAltLYm3pkNlcrocUDqmGateOT0InCAn
         AUxwehIro76XKzfZ3YhS8n84UtJuLMwwG0dhQEG0=
Date:   Mon, 21 Aug 2023 15:26:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     stable@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Backport rework of deadline bandwidth restoration
 for 6.1.y
Message-ID: <2023082140-dreaded-hemstitch-84b9@gregkh>
References: <20230820152417.518806-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820152417.518806-1-qyousef@layalina.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Aug 20, 2023 at 04:24:11PM +0100, Qais Yousef wrote:
> This is a backport of the series that fixes the way deadline bandwidth
> restoration is done which is causing noticeable delay on resume path. It also
> converts the cpuset lock back into a mutex which some users on Android too.
> I lack the details but AFAIU the read/write semaphore was slower on high
> contention.
> 
> Compile tested against some randconfig for different archs and tested against
> android14-6.1 GKI kernel.
> 
> My testing is limited to resume path only; and general phone usage to make sure
> nothing falls apart. Would be good to have some deadline specific testing done
> too.
> 
> Based on v6.1.46

I can't take these for only some branches, as you know.  Any reason why
you didn't also do 6.4.y?

thanks,

greg k-h
