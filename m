Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4729449CEF7
	for <lists+cgroups@lfdr.de>; Wed, 26 Jan 2022 16:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiAZPyk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jan 2022 10:54:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41640 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiAZPyj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jan 2022 10:54:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6B0EF1F3AF;
        Wed, 26 Jan 2022 15:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643212478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JhMXk/ivkidpxAK5AccyfBh1ZU8l7X1indTMMcc/0QM=;
        b=EK4opr1HdQbMlUngugC9CHY4DDnOmc7BYv0V+FHex/muEUvopf0YP9cdoY7OID6sO8UPQY
        oQK1xmn5BTnjXTulR0Ig6qcO1re1Ui3R2+3xtSRsj9LI8WX98qYrgzs3HjRD4Kl4n7JrOo
        AmjkXticwheVEG3Ek/p0CCdHartfmDw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5313F13E1A;
        Wed, 26 Jan 2022 15:54:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FbG7E75u8WH/LwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 26 Jan 2022 15:54:38 +0000
Date:   Wed, 26 Jan 2022 16:54:37 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup: minor optimization around the usage of
 cur_tasks_head
Message-ID: <20220126155437.GD2516@blackbody.suse.cz>
References: <20220126141705.6497-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126141705.6497-1-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Yafang.

On Wed, Jan 26, 2022 at 02:17:05PM +0000, Yafang Shao <laoar.shao@gmail.com> wrote:
> As the usage of cur_tasks_head is within the function
> css_task_iter_advance(), we can make it as a local variable. That could
> make it more clear and easier to understand. Another benefit is we don't
> need to carry it in css_task_iter.

It looks correct. When refactoring in the sake of understandibility
(disputable :), wouldn't it be better to avoid the double-pointer arg
passed into css_task_iter_advance_css_set() and just return the new
cur_tasks_head (the input value doesn't seem relevant)?

Thanks,
Michal
