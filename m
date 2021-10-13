Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0325D42C83E
	for <lists+cgroups@lfdr.de>; Wed, 13 Oct 2021 20:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbhJMSDg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Oct 2021 14:03:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54630 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238202AbhJMSDf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Oct 2021 14:03:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8381920240;
        Wed, 13 Oct 2021 18:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634148091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bnGWW8txEiGiwfqJHyEBYUwfb5etYjAXJP0AbtxNWE0=;
        b=PRCA6mW40Xj9Xc312LnvvnDJ6HOaWqe1Gh/O1mgyfxcbtckTD1MXC4JkbNTLPidMAV33zL
        9O2ZgrWeLF/cs8gPkqOfNTx2lLX1UkIapks1huu23KL9Aw+JEdyyx82RbnQT0mYl4jo2ln
        NZH1Lrb38EY1aKBLkY0PiX0VdchuvEY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A73D13D10;
        Wed, 13 Oct 2021 18:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8et4GfseZ2HFPQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 13 Oct 2021 18:01:31 +0000
Date:   Wed, 13 Oct 2021 20:01:30 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] memcg: flush stats only if updated
Message-ID: <20211013180130.GB22036@blackbody.suse.cz>
References: <20211001190040.48086-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211001190040.48086-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Oct 01, 2021 at 12:00:39PM -0700, Shakeel Butt <shakeelb@google.com> wrote:
> In this patch we kept the stats update codepath very minimal and let the
> stats reader side to flush the stats only when the updates are over a
> specific threshold.  For now the threshold is (nr_cpus * CHARGE_BATCH).

BTW, a noob question -- are the updates always single page sized?

This is motivated by apples vs oranges comparison since the
	nr_cpus * MEMCG_CHARGE_BATCH 
suggests what could the expected error be in pages (bytes). But it's mostly
wrong since: a) uncertain single-page updates, b) various counter
updates summed together. I wonder whether the formula can serve to
provide at least some (upper) estimate.


> +static inline void memcg_rstat_updated(struct mem_cgroup *memcg)
> +{
> +	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
> +	if (!(__this_cpu_inc_return(stats_updates) % MEMCG_CHARGE_BATCH))
> +		atomic_inc(&stats_flush_threshold);
> +}

Neat trick! (I guess there are no benchmarks complaining about this
(yet)).

Overall,

Reviewed-by: Michal Koutný <mkoutny@suse.com>

