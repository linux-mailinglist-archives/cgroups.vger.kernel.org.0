Return-Path: <cgroups+bounces-1299-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36E4845A49
	for <lists+cgroups@lfdr.de>; Thu,  1 Feb 2024 15:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0D62962A5
	for <lists+cgroups@lfdr.de>; Thu,  1 Feb 2024 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB46B5D49F;
	Thu,  1 Feb 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BZE8WImv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BZE8WImv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3405D480;
	Thu,  1 Feb 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797577; cv=none; b=FkxGFciU0GNY1Mb/dK0iren7cM3dqcDrtul9hsXtfx/94nnBCYrRThm08VZrtBwHROqh/N8SZMJbTMnZN/7WIp5WPFFKnwMje8ew0fxD50XpaCzmMLb2OOqxiu+Azk88ymsshD30G80CGUoOst9/KMiImkLiU9eSB0ghrV/U6Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797577; c=relaxed/simple;
	bh=M1DtNkvYenLawxtAmGCAN8VzLDHXlKpepP9pC/hiZto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuk9thVkN6+FI7h5NvLwBZUd5s64jTadSds0LSbVOrYxnQwZPMETg+MmRbt01DNTY4sAjTgF5KSvQ7U0KV/efSQSm3ffHLCKnirmaBiaO6fr+K0RAJCCpNiOPnVNaPyWluzXQpZMu+vsn0HsqRPQmS9Qh0ay8r3uXvJvZA0hnX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BZE8WImv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BZE8WImv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from blackpad (unknown [10.100.12.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 947D922104;
	Thu,  1 Feb 2024 14:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706797573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jACJ8DHpCku0mqvIQWcAOIXi+dC3Hwufj+6uYVkQ35M=;
	b=BZE8WImvnWarQOZqnaPgDyZG4Wr3WEl9ZmKx7bGI35vk6cBK74br0DE4nEdR6+0Vns1qq5
	Zn3HNoP60dzOmhlc27B6C+e55ywxp/Riiw9E87gelyMpltob2SuyAjmRumEeBii1Use0He
	IhTnplmtKdtuquFdwhOx0ABWij61a5o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706797573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jACJ8DHpCku0mqvIQWcAOIXi+dC3Hwufj+6uYVkQ35M=;
	b=BZE8WImvnWarQOZqnaPgDyZG4Wr3WEl9ZmKx7bGI35vk6cBK74br0DE4nEdR6+0Vns1qq5
	Zn3HNoP60dzOmhlc27B6C+e55ywxp/Riiw9E87gelyMpltob2SuyAjmRumEeBii1Use0He
	IhTnplmtKdtuquFdwhOx0ABWij61a5o=
Date: Thu, 1 Feb 2024 15:26:12 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com, 
	Minchan Kim <minchan@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: memcg: Don't periodically flush stats when memcg
 is disabled
Message-ID: <ufczw2a3urgi6pi6apzkic5zgquxy2mxls6g2tjfjjkttk3tni@yowqxhlqkz56>
References: <20240126211927.1171338-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wxxx3wtjfattjixo"
Content-Disposition: inline
In-Reply-To: <20240126211927.1171338-1-tjmercier@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.88
X-Spamd-Result: default: False [-2.88 / 50.00];
	 ARC_NA(0.00)[];
	 BAYES_SPAM(0.02)[50.34%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[]
X-Spam-Flag: NO


--wxxx3wtjfattjixo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 26, 2024 at 09:19:25PM +0000, "T.J. Mercier" <tjmercier@google.com> wrote:
> The root memcg is onlined even when memcg is disabled. When it's onlined
> a 2 second periodic stat flush is started, but no stat flushing is
> required when memcg is disabled because there can be no child memcgs.
> Most calls to flush memcg stats are avoided when memcg is disabled as a
> result of the mem_cgroup_disabled check added in 7d7ef0a4686a
> ("mm: memcg: restore subtree stats flushing"), but the periodic flushing
> started in mem_cgroup_css_online is not. Skip it.

Have you tried
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6099,6 +6099,9 @@ int __init cgroup_init(void)
        cgroup_unlock();

        for_each_subsys(ss, ssid) {
+               if (!cgroup_ssid_enabled(ssid))
+                       continue;
+
                if (ss->early_init) {
                        struct cgroup_subsys_state *css =
                                init_css_set.subsys[ss->id];
@@ -6118,9 +6121,6 @@ int __init cgroup_init(void)
                 * disabled flag and cftype registration needs kmalloc,
                 * both of which aren't available during early_init.
                 */
-               if (!cgroup_ssid_enabled(ssid))
-                       continue;
-
                if (cgroup1_ssid_disabled(ssid))
                        pr_info("Disabling %s control group subsystem in v1 mounts\n",
                                ss->legacy_name);
?
I'm asking about a try because I'm not sure whether this does not blow
up due to something missing. But I think disabled controllers would not
need to be (root-)onlined at all.

Thanks,
Michal

--wxxx3wtjfattjixo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZbuqAgAKCRAGvrMr/1gc
jrpxAQDyZRXNtpLF1OlwunwH7s4cGq9S3p4xavcyCbU73SNKTAEA8OT63KKFtzzZ
uYtGruEFhY4GBP430nCIMahipGl+WAc=
=gZrw
-----END PGP SIGNATURE-----

--wxxx3wtjfattjixo--

