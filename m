Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7233274D999
	for <lists+cgroups@lfdr.de>; Mon, 10 Jul 2023 17:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjGJPLE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jul 2023 11:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjGJPLE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jul 2023 11:11:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D63CD7;
        Mon, 10 Jul 2023 08:11:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B29711FE71;
        Mon, 10 Jul 2023 15:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689001861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rkUXmWpxeLcY3C4VqE8e9jGWUdpB7/rw2YJ/efYsPnI=;
        b=A2Od0yPESfj/f18OkDF90aWDUxuPe6t9a/F/84rsRj/MFEm6f1GhmCeXtQs3fhBMEj0riI
        RdbqK1JMnI0lTsgJbSOPkoMHMaYF/cMoiWjsdv4qHTLhsQg2Bk/yJygE+4V9YAQFonpfPk
        f5yW5KuJGyn8x4F8h65PbiaeOsf/ZzM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9560F13A05;
        Mon, 10 Jul 2023 15:11:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gxjMI4UfrGT9WQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 10 Jul 2023 15:11:01 +0000
Date:   Mon, 10 Jul 2023 17:11:00 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
        lizefan.x@bytedance.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: update parent subparts cpumask while
 holding css refcnt
Message-ID: <fbabnjfly5w6fxrhe3eu6ebspngz2hd3tqs6rrbropcdvylnhs@ayjdpq73kwui>
References: <20230701065049.1758266-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6khoq6gsqetlysp"
Content-Disposition: inline
In-Reply-To: <20230701065049.1758266-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--d6khoq6gsqetlysp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Sat, Jul 01, 2023 at 02:50:49PM +0800, Miaohe Lin <linmiaohe@huawei.com> wrote:
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1806,9 +1806,12 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>  		cpuset_for_each_child(cp, css, parent)
>  			if (is_partition_valid(cp) &&
>  			    cpumask_intersects(trialcs->cpus_allowed, cp->cpus_allowed)) {
> +				if (!css_tryget_online(&cp->css))
> +					continue;
>  				rcu_read_unlock();
>  				update_parent_subparts_cpumask(cp, partcmd_invalidate, NULL, &tmp);
>  				rcu_read_lock();
> +				css_put(&cp->css);

Apologies for a possibly noob question -- why is RCU read lock
temporarily dropped within the loop?
(Is it only because of callback_lock or cgroup_file_kn_lock (via
notify_partition_change()) on PREEMPT_RT?)



[
OT question:
	cpuset_for_each_child(cp, css, parent)				(1)
		if (is_partition_valid(cp) &&
		    cpumask_intersects(trialcs->cpus_allowed, cp->cpus_allowed)) {
			if (!css_tryget_online(&cp->css))
				continue;
			rcu_read_unlock();
			update_parent_subparts_cpumask(cp, partcmd_invalidate, NULL, &tmp);
			  ...
			  update_tasks_cpumask(cp->parent)
			    ...
			    css_task_iter_start(&cp->parent->css, 0, &it);	(2)
			      ...
			rcu_read_lock();
			css_put(&cp->css);
		}

May this touch each task same number of times as its depth within
herarchy?
]

Thanks,
Michal

--d6khoq6gsqetlysp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZKwfggAKCRAGvrMr/1gc
jkMlAP9dEydUm7AhSZFcAIT4PTIji4ci5SpJhYNxQ3uGcnS5kAEAxCGW5mr/WjYb
84481ELcrOzaow28yYL3f1t6KUsnxQU=
=7XOZ
-----END PGP SIGNATURE-----

--d6khoq6gsqetlysp--
