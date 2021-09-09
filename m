Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7580B4059F9
	for <lists+cgroups@lfdr.de>; Thu,  9 Sep 2021 17:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbhIIPC6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Sep 2021 11:02:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41744 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbhIIPC6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Sep 2021 11:02:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D088922334;
        Thu,  9 Sep 2021 15:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631199707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7YDXHPzZgNhxK+JqlG9HXkSUyEV8IJc2b4TuXsz5yH0=;
        b=kRRhZmQ3mqVSek9+0O4cHQ+rYzMVNOxaruVMvb1v75PP9GurRgzsXJuC+mknsmdvE8YkvW
        Zb3LnQ3XGdB56U8spoEpjD4a2QLYTxaQiq0o27yIjFzfZdz3biJUxxSO3DHXksyCYs62PA
        HwqjlBP1xSO36QTsp9qKWvwqz6leJmo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B427213C53;
        Thu,  9 Sep 2021 15:01:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F1QlK9shOmFYSAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 09 Sep 2021 15:01:47 +0000
Date:   Thu, 9 Sep 2021 17:01:46 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, vipinsh@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] misc_cgroup: use a counter to count the number of
 failures
Message-ID: <20210909150146.GA18171@blackbody.suse.cz>
References: <a09f381462b1ce9c506a22713b998e21b459f7e9.1628899295.git.brookxu@tencent.com>
 <20210824164423.GA11859@blackbody.suse.cz>
 <YSVDwc/1sEmXdOK9@slm.duckdns.org>
 <4ed67493-e595-e002-69f9-1f53662ba189@gmail.com>
 <20210826112954.GD4520@blackbody.suse.cz>
 <49057879-92a9-958a-ac30-057ceabd1b7f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49057879-92a9-958a-ac30-057ceabd1b7f@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi.

On Wed, Sep 08, 2021 at 01:29:18PM +0800, brookxu <brookxu.cn@gmail.com> wrote:
> I have sentout misc_cgroup events and events.local related patches.
> I want to make corresponding changes to pids cgroup by the way. Do
> you think it is ok?

The pids controller is longer out there, so some changes should be more
careful (e.g. I wouldn't drop the log message).

Also, you can base it on [1] (there should be just missing the
.local/hierarchical event files separation).

HTH,
Michal

[1] https://lore.kernel.org/lkml/20200205134426.10570-1-mkoutny@suse.com/
