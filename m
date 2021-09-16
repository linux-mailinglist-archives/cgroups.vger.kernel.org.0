Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D2240E987
	for <lists+cgroups@lfdr.de>; Thu, 16 Sep 2021 20:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbhIPSBF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Sep 2021 14:01:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41494 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245747AbhIPR6f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Sep 2021 13:58:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EDD021FF07;
        Thu, 16 Sep 2021 17:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631815032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbJGgwQpdImuKGYvZ0hVx47RK9ar0QLFewfGibiPGXE=;
        b=IUjJu8eXSDOvstCBzNqJfVDXURIGXW++ljRJE7t4Ed/NWRYOrUX0uf0TeY0spExSVB/OIJ
        K5+Iokl4j6nB+4uI34smI8VlI2T28kH8QyaG7RJnoTkoSGejLv/EPnIKYJRMmMZgaHxE+K
        Iyiy/HI5tEorxpOyFkuznNjT9XPUGW0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD48013D5A;
        Thu, 16 Sep 2021 17:57:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yfQTMXiFQ2HWcQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 16 Sep 2021 17:57:12 +0000
Date:   Thu, 16 Sep 2021 19:57:11 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        vipinsh@google.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/3] misc_cgroup: remove error log to avoid log flood
Message-ID: <20210916175711.GA12643@blackbody.suse.cz>
References: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631671936.git.brookxu@tencent.com>
 <a960cd793f649bd944127fe5e5e3f4d8bb9040a4.1631671936.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a960cd793f649bd944127fe5e5e3f4d8bb9040a4.1631671936.git.brookxu@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 15, 2021 at 10:18:50AM +0800, brookxu <brookxu.cn@gmail.com> wrote:
> In scenarios where containers are frequently created and deleted,
> a large number of error logs maybe generated. This log provides
> less information, we can get more detailed info from misc.events.

IIUC, the log provides equal information (with persistence), no?

> diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
> index 4b2b492..fe3e8a0 100644
> --- a/kernel/cgroup/misc.c
> +++ b/kernel/cgroup/misc.c
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

As I argued previously, reporting this as "in" `i` cgroup instead
of `cg` is not that useful and equivalent to the misc.events:*.max now,
so the drop is appropriate.

The change/patch is OK,
Reviewed-by: Michal Koutný <mkoutny@suse.com>

The commit message might be fixed (if you agree with remark).
