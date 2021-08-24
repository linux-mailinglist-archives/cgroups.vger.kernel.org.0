Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECF93F630C
	for <lists+cgroups@lfdr.de>; Tue, 24 Aug 2021 18:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhHXQpK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Aug 2021 12:45:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50060 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhHXQpK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Aug 2021 12:45:10 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 78C621FDB4;
        Tue, 24 Aug 2021 16:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629823464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z2MS98YdJwtJG8FeEq/L2x2vYouQos57GNWyqg6QJyA=;
        b=hglYmTZ0ibs1kipNcDW5ppNCm78oIvq31YUQTGxYE8JL/H3Wp8stjoxc6XSfbVqbCPZWyt
        dASzpF/UoW3GZDFju1KQQEVfGEgc/19+HZjo10yyqbLoV3XhjN/WiOCz7eUY3CydwdrSeP
        hjtEnkPekDuCd/Wzr5eXZa4izsSh76k=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 522C113A5B;
        Tue, 24 Aug 2021 16:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id iTNtE+ghJWG1XQAAGKfGzw
        (envelope-from <mkoutny@suse.com>); Tue, 24 Aug 2021 16:44:24 +0000
Date:   Tue, 24 Aug 2021 18:44:23 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        vipinsh@google.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v2] misc_cgroup: use a counter to count the number of
 failures
Message-ID: <20210824164423.GA11859@blackbody.suse.cz>
References: <a09f381462b1ce9c506a22713b998e21b459f7e9.1628899295.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a09f381462b1ce9c506a22713b998e21b459f7e9.1628899295.git.brookxu@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello.

On Sat, Aug 14, 2021 at 08:15:16AM +0800, brookxu <brookxu.cn@gmail.com> wrote:
> 1. If a large number of containers are created and deleted,
>    there will be a lot of error logs.
> 2. According to an error log, we cannot better understand
>    the actual pressure of resources.
> 
> Therefore, perhaps we should use a failcnt counter to count
> the number of failures, so that we can easily understand the
> actual pressure of resources and avoid too many error log..

This is an understandable use case and generally the implementation via
the counter is good as well.

However, the non-hierarchical failcnt interface looks like v1ism to me
(I think new features should come with v2 first in mind).
What about exposing this in misc.events file with max.$res_name entries? 

Or if the hierarchical reporting is unnecessary now, there can be just
misc.events.local for starters.

(That reminds me the forgotten pids.events[.local] rework [1], oops.)

Michal

https://lore.kernel.org/lkml/20191128172612.10259-1-mkoutny@suse.com/#t

