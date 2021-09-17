Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED39940FEBE
	for <lists+cgroups@lfdr.de>; Fri, 17 Sep 2021 19:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhIQRmd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Sep 2021 13:42:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48676 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbhIQRm1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Sep 2021 13:42:27 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 60A3021A8D;
        Fri, 17 Sep 2021 17:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631900464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yGdnRQChmmfug9TJwp/GqG9nQH+or3zg5tguY5oo+D4=;
        b=cMHI6XJFM9M0KRsFulwCJSBaxKY+SGgZU1ShmWu4BBWJgJXWUslymcRIbNBgnGVyfc2xZF
        I+qnQnhzLxFMwiYPjH9sGL51bd1pzspozV/uMy7gb8qemsd7KaVa5X8ON5xYzK50nwQLcg
        jTtHsbjzv3skwLtVW2LjumGvwEwlHcY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44CF613B0C;
        Fri, 17 Sep 2021 17:41:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dVM0EDDTRGHBbwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 17 Sep 2021 17:41:04 +0000
Date:   Fri, 17 Sep 2021 19:41:03 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [RFC PATCH] blk-throttle: enable io throttle for root in cgroup
 v2
Message-ID: <20210917174103.GC13346@blackbody.suse.cz>
References: <20210909140815.2600858-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909140815.2600858-1-yukuai3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Yu.

On Thu, Sep 09, 2021 at 10:08:15PM +0800, Yu Kuai <yukuai3@huawei.com> wrote:
> I'm not sure why this feature is disabled in the first place, is
> there any problem or design constraint?

The idea for v2 is that in the root cgroup remain only kernel threads that
provide "global" services and any user workload that should be
constrained is put into non-root cgroups. Additionally, if kernel
threads carry out work associated with a cgroup they can charge it to
the respective cgroup.

[snip]
> We want to limit the overall iops/bps of the device in cgroup v2,

Cui bono? (I mean what is the reason for throttling on the global level
when there's no other entity utiliting the residual?
<joke>Your drives are too fast?</joke>)

Michal
