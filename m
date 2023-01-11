Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5290C665D93
	for <lists+cgroups@lfdr.de>; Wed, 11 Jan 2023 15:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjAKOTs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Jan 2023 09:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbjAKOTd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Jan 2023 09:19:33 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5396167
        for <cgroups@vger.kernel.org>; Wed, 11 Jan 2023 06:19:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9A73817BA9;
        Wed, 11 Jan 2023 14:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673446770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aKKeQDX5M27cS/Y9GBuMn/99ULlrTykEwpfkno661Kc=;
        b=to8kz4beF0J5+Jua7QNB8vFl6GUJjWv2r5Gk4VJFgzU5OoWyXI6qVdVJVqfLsAHAwBIpd+
        JcW/8PLRwK64v0/VdyJlj2HPas1hD2siFx/d3EnLP/Rsu3Zr5OxTrjTLp9kkNvY1vFT5Jj
        Psify++zY792qbyISArVvzllMunvKnM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6905313591;
        Wed, 11 Jan 2023 14:19:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id giKtGHLFvmPKCwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 11 Jan 2023 14:19:30 +0000
Date:   Wed, 11 Jan 2023 15:19:29 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm: multi-gen LRU: cgroup working set stats
Message-ID: <20230111141929.GB14685@blackbody.suse.cz>
References: <20221214225123.2770216-1-yuanchu@google.com>
 <20221214225123.2770216-3-yuanchu@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <20221214225123.2770216-3-yuanchu@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 14, 2022 at 02:51:23PM -0800, Yuanchu Xie <yuanchu@google.com> wrote:
> +static int memory_page_idle_age_format(struct mem_cgroup *root,
> +				       struct seq_file *m)
> +{
> +	struct mem_cgroup *memcg;
> +	unsigned long *table;
[...]
> +	table = kmalloc_array(PAGE_IDLE_AGE_NR_RANGES * nr_node_ids *
> +				      ANON_AND_FILE,
> +			      sizeof(*table), __GFP_ZERO | GFP_KERNEL);
> +
[...]
> +	memory_page_idle_age_print(m, table);
> +	return 0;

FTR, the table seems leaked here.


Michal

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY77FbgAKCRAkDQmsBEOq
uYurAP9JGeUGRS6AfrMninhvfGTvmei8qAImveRp13FIRINKGwEAlYRvprpP/hbL
IvrnjwZQ0UVS9+oYjQTsbbZbJVGfhgE=
=qQ2L
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
