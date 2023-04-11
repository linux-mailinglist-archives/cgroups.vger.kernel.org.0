Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97F26DDAB0
	for <lists+cgroups@lfdr.de>; Tue, 11 Apr 2023 14:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDKMXh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Apr 2023 08:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDKMXg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Apr 2023 08:23:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4411707;
        Tue, 11 Apr 2023 05:23:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E87821FD6A;
        Tue, 11 Apr 2023 12:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681215813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zrc6f9m1IkUZIG9FYgI96c26lt3qznrpmnR3S4+Pvz4=;
        b=o5SNl5syy5B3mqUwrBXxNR3RlyJ3lv8VJ8lbtzjQNV89dP9dYeYcXXmgAu1mxnhXVTwLIt
        rvIkhS+3q5Ug7+SqqD6O1Egypv7DaxkYs0k9n7e8qv8nfHzgvqXz9Q1Jh+XtkMXBYoLTwY
        YFcJ92qLpealU/gNva2WG24Psf7WfDg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD9EA13638;
        Tue, 11 Apr 2023 12:23:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l21LLUVRNWSoDwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 11 Apr 2023 12:23:33 +0000
Date:   Tue, 11 Apr 2023 14:23:32 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Waiman Long <longman@redhat.com>, Michal Hocko <mhocko@suse.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com,
        Zefan Li <lizefan.x@bytedance.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm: oom: introduce cpuset oom
Message-ID: <3myr57cw3qepul7igpifypxx4xd2buo2y453xlqhdw4xgjokc4@vi3odjfo3ahc>
References: <20230411065816.9798-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qy2a2rv2poa26h7t"
Content-Disposition: inline
In-Reply-To: <20230411065816.9798-1-ligang.bdlg@bytedance.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--qy2a2rv2poa26h7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Tue, Apr 11, 2023 at 02:58:15PM +0800, Gang Li <ligang.bdlg@bytedance.com> wrote:
> +int cpuset_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg)
> +{
> +	int ret = 0;
> +	struct css_task_iter it;
> +	struct task_struct *task;
> +	struct cpuset *cs;
> +	struct cgroup_subsys_state *pos_css;
> +
> +	/*
> +	 * Situation gets complex with overlapping nodemasks in different cpusets.
> +	 * TODO: Maybe we should calculate the "distance" between different mems_allowed.
> +	 *
> +	 * But for now, let's make it simple. Just iterate through all cpusets
> +	 * with the same mems_allowed as the current cpuset.
> +	 */
> +	cpuset_read_lock();
> +	rcu_read_lock();
> +	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
> +		if (nodes_equal(cs->mems_allowed, task_cs(current)->mems_allowed)) {
> +			css_task_iter_start(&(cs->css), CSS_TASK_ITER_PROCS, &it);
> +			while (!ret && (task = css_task_iter_next(&it)))
> +				ret = fn(task, arg);
> +			css_task_iter_end(&it);
> +		}
> +	}
> +	rcu_read_unlock();
> +	cpuset_read_unlock();
> +	return ret;
> +}

I see this traverses all cpusets without the hierarchy actually
mattering that much. Wouldn't the CONSTRAINT_CPUSET better achieved by
globally (or per-memcg) scanning all processes and filtering with:
	nodes_intersect(current->mems_allowed, p->mems_allowed)
(`current` triggers the OOM, `p` is the iterated task)
?

Thanks,
Michal

--qy2a2rv2poa26h7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZDVRPwAKCRAkDQmsBEOq
uVVFAP965wOBxTUUG+YbMpda2aYpjr/QsqcnSO6eT4AgpmO90gD+OHV1fcIafZ+J
+SF+dtNZgMgKmvwZY6aKbUZOmnn7ewk=
=h0ch
-----END PGP SIGNATURE-----

--qy2a2rv2poa26h7t--
