Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28627485945
	for <lists+cgroups@lfdr.de>; Wed,  5 Jan 2022 20:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243606AbiAETfJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jan 2022 14:35:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38402 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243596AbiAETfH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jan 2022 14:35:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3ED4221114;
        Wed,  5 Jan 2022 19:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641411306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Z17oxaYwg5r8TgwQI6BE8dbSIQZLwXeeFGf1aSsvug=;
        b=OTCOfH2WPAMMQkt+3TAEX6ZBUT4c3ABmrKzqMqxC6D8ToDb3RnKstrASy4k4jbK4CKpo7q
        84oc9WI1Niako3lRlOmch5jo8RO49ySl0GN58qxBvDiBXrWqTOCM8nW99zMX0CImTDJIU3
        EEmTSpun/SYKq2KK4Ey2GZVzufXrHUo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DF9D13C09;
        Wed,  5 Jan 2022 19:35:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v+JHBury1WHQVgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 05 Jan 2022 19:35:06 +0000
Date:   Wed, 5 Jan 2022 20:35:04 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cgroup/rstat: check updated_next only for root
Message-ID: <20220105193504.GD6464@blackbody.suse.cz>
References: <20211225000932.7253-1-richard.weiyang@gmail.com>
 <20211225000932.7253-2-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211225000932.7253-2-richard.weiyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Dec 25, 2021 at 12:09:32AM +0000, Wei Yang <richard.weiyang@gmail.com> wrote:
> This means we can remove the check on ->updated_next, if we make sure
> the subtree from @root is on list, which could be done by checking
> updated_next for root.

Nice refactoring.

> @@ -96,9 +97,12 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
>  	 * We're gonna walk down to the first leaf and visit/remove it.  We
>  	 * can pick whatever unvisited node as the starting point.
>  	 */
> -	if (!pos)
> +	if (!pos) {
>  		pos = root;
> -	else
> +		// return NULL if this subtree is not on-list
> +		if (!cgroup_rstat_cpu(pos, cpu)->updated_next)
> +			return NULL;
> +	} else
+		/* return NULL if this subtree is not on-list */

Just a coding style nitpick.

The patch is otherwise
Reviewed-by: Michal Koutný <mkoutny@suse.com>

