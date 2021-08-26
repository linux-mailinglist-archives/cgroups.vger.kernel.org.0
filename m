Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F65A3F8685
	for <lists+cgroups@lfdr.de>; Thu, 26 Aug 2021 13:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241905AbhHZLao (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Aug 2021 07:30:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37246 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbhHZLan (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Aug 2021 07:30:43 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CA87020192;
        Thu, 26 Aug 2021 11:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629977395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IN2Dtsa48cpPIFgznxW6CFNis9T0sGloZqOdQstyxAo=;
        b=M+31mAg0zGIMPzDxcdU19Pxt7nwlp+rrH9dYqxplbi8iG3GiPB7PHCSVgk3FfheCJFRxXg
        ulMuwr76znAH/IGQnRHgKr2k5NYpeW4BiHjWEndgG7ZBZl/bbwAi80S00H/GjH7PlxevmC
        /esdDomCduAV0AEL4GdMz040vAT3Fag=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AB94613318;
        Thu, 26 Aug 2021 11:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id y9nSKDN7J2HENwAAGKfGzw
        (envelope-from <mkoutny@suse.com>); Thu, 26 Aug 2021 11:29:55 +0000
Date:   Thu, 26 Aug 2021 13:29:54 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, vipinsh@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] misc_cgroup: use a counter to count the number of
 failures
Message-ID: <20210826112954.GD4520@blackbody.suse.cz>
References: <a09f381462b1ce9c506a22713b998e21b459f7e9.1628899295.git.brookxu@tencent.com>
 <20210824164423.GA11859@blackbody.suse.cz>
 <YSVDwc/1sEmXdOK9@slm.duckdns.org>
 <4ed67493-e595-e002-69f9-1f53662ba189@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ed67493-e595-e002-69f9-1f53662ba189@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 26, 2021 at 09:34:45AM +0800, brookxu <brookxu.cn@gmail.com> wrote:
> The core logic of pids cgroup and misc cgroup is similar.

Yes, the latter is conceptually a generalization of the former and it can
be tempting to use the general form. Beware that pids controller would
need to retain its existing API (and the behavior of being an
independent controller) and that would be IMO exceptions
counterweighting the generalization.

> Is it possible for us to merge pids cgroup into misc cgroup?

Technically it might be possible but I can't see the benefit (but maybe
you envisioned something else where my reasoning won't apply).

Michal
