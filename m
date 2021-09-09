Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92159405932
	for <lists+cgroups@lfdr.de>; Thu,  9 Sep 2021 16:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244375AbhIIOin (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Sep 2021 10:38:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35270 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbhIIOid (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Sep 2021 10:38:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9C727223A4;
        Thu,  9 Sep 2021 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631198241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+IrKyLL/zCoxdFm0CBl46HK6iMLrxJ4/diWExUQinM=;
        b=bzekiy+7VzwGb33GpGxCKJ9ZVvVk7sTX5tGgg3I34wbOEq9faVv4OvGXwPkWEcmuh/VqRo
        01D3BhcaZPTBfTThaRVOkwtb3X74CIKhoS2R8ESgGG/YLwW1yt0w90mRSh8jTjG/ZQ6Zat
        DkQt5n5PgGRIy5gcmVwCtzWqS/k+7xA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C3CD13C53;
        Thu,  9 Sep 2021 14:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PpnPHSEcOmH3OwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 09 Sep 2021 14:37:21 +0000
Date:   Thu, 9 Sep 2021 16:37:20 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        vipinsh@google.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] misc_cgroup: remove error log to avoid log flood
Message-ID: <20210909143720.GA14709@blackbody.suse.cz>
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
 <86e89df640f2b4a65dd77bdbab8152fa8e8f5bf1.1631077837.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86e89df640f2b4a65dd77bdbab8152fa8e8f5bf1.1631077837.git.brookxu@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 08, 2021 at 01:24:36PM +0800, brookxu <brookxu.cn@gmail.com> wrote:
> This log provides less information, we can get more detailed failure
> records through
> misc.events, misc.events.local and misc.failcnt.
> From this, perhaps we can remove it.

I hope: a) it's not used widely, b) no-one relies on parsing the
message so this is an acceptable change.

> @@ -157,13 +157,6 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
>  		new_usage = atomic_long_add_return(amount, &res->usage);
>  		if (new_usage > READ_ONCE(res->max) ||
>  		    new_usage > READ_ONCE(misc_res_capacity[type])) {
> -			if (!res->failed) {
> -				pr_info("cgroup: charge rejected by the misc controller for %s resource in ",
> -					misc_res_name[type]);
> -				pr_cont_cgroup_path(i->css.cgroup);
> -				pr_cont("\n");
> -				res->failed = true;
> -			}

`i` is the misc_cg whose limit was hit. In a sense, I think the current
implementation of the log message (before your patch) is not as useful
as it could be. The logged message here should not refer to `i` but `cg`
(i.e. the cgroup where the actual chargee resides). It's basically the
idea from [1].

So there could be two type of events (not referring to the v1-specific
failcnt):
- max - number of times the cgroup's misc.max was hit,
- fail - number of times operation failed (rejected) in the cgroup.

The former would tell you which limit is probably set too low, the
latter would capture which cgroup workload is affected. (The difference
would become apparent with >1 level deep hierarchies.)

Regards,
Michal

[1] https://lore.kernel.org/lkml/20191202191100.GF16681@devbig004.ftw2.facebook.com/

