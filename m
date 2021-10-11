Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C637E42950C
	for <lists+cgroups@lfdr.de>; Mon, 11 Oct 2021 19:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhJKRCY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Oct 2021 13:02:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53186 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhJKRCY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Oct 2021 13:02:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E08D21FFC;
        Mon, 11 Oct 2021 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633971623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aLHDu14dPkuXVPX0xo7np8SfCtAB89ZamcliK/6Zp4c=;
        b=TbwvUEE27w8fWTwyAdkBa3iSJCSHgH/lCnJSRE/f4xpYZI/5rJTWeoFVWWrM+abDdSd9Q+
        vMYfLlmpgA/Ie86xuV+ubP/XBviW55t/7QYj+8Ku5wy/OCZgecaDZt8QZHOFSmfU0NYTvz
        QvNUTSKUro8xYCLtWG6eR/U4yE3okIY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0566013BCE;
        Mon, 11 Oct 2021 17:00:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5uCnAKdtZGFMfgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 11 Oct 2021 17:00:23 +0000
Date:   Mon, 11 Oct 2021 19:00:21 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Hans-Jacob Enemark <hjenemark@gmail.com>
Cc:     cgroups@vger.kernel.org
Subject: Re: pthread_setschedparam returns 1 (Operation Not Permitted) after
 including docker in yocto build
Message-ID: <20211011170021.GD61605@blackbody.suse.cz>
References: <CAFx0Op3b7KeAT0_Dd_eAMKh85=6qY_X6-BHGJdS2TN8UtJMytg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFx0Op3b7KeAT0_Dd_eAMKh85=6qY_X6-BHGJdS2TN8UtJMytg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello.

On Sat, Sep 25, 2021 at 10:45:43PM +0200, Hans-Jacob Enemark <hjenemark@gmail.com> wrote:
> For some reason it is no longer possible to set the priority and the
> scheduling policy of a running pthread inside the thread function
> itself - even with the app running as root..
> #define POLICY SCHED_FIFO

You use an RT scheduling policy.

It's not in your diff dump but my bet is on CONFIG_RT_GROUP_SCHED.
The non-root RT groups have zero RT runtime allocation by default,
therefore sched_setpriority would fail in such a cgroup.

(The changes in your setup might have modified whether any CPU cgroups
are created or only root cpu cgroup is present.)

HTH,
Michal
